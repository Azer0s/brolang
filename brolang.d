module brolang;

import std.algorithm : group, map;
import std.range : repeat, chain;
import std.string : join;
import std.conv : to;
import std.stdio;
import std.array;
import std.string;
import std.regex;
import std.conv;
import std.range;

private string bfToD(string code)
{
    return "import std; void main() { ubyte[30000] field; size_t ptr;" ~ code.group.map!((g) {
        const dchar token = g[0];
        size_t count = g[1];
        switch (token)
        {
        case '+':
            return "field[ptr]+=" ~ count.to!string ~ ";";
        case '-':
            return "field[ptr]-=" ~ count.to!string ~ ";";
        case '[':
            return "while(field[ptr]){".repeat(count).join;
        case ']':
            return "}".repeat(count).join;
        case ',':
            return "field[ptr]=stdin.byChunk(1).front[0];".repeat(count).join;
        case '.':
            return "write(cast(char)field[ptr]);".repeat(count).join;
        case '>':
            return "ptr+=" ~ count.to!string ~ ";";
        case '<':
            return "ptr-=" ~ count.to!string ~ ";";
        default:
            return "";
        }
    }).join('\n') ~ `writeln("");}`;
}

private string bfToPsph(string code)
{
    int i = 0;
    int inc = 0;
    int labelCount = 0;
    int[] labelStack;
    string psph = 
"v_ptr d_ptr
v_int32 count
v_uint8 d0
ldptr d0
store d_ptr
ldptrv d_ptr
store count
";

    for(int c = 1; c < 30_000; c++){
        psph ~= "
v_uint8 d" ~ to!string(c);
    }

    foreach (token; code.stride(1))
    {
        switch (token)
        {
        case '+':
            psph ~= "
ldu8v [d_ptr]
inc
store [d_ptr]";
            break;
        case '-':
            inc++;
            psph ~= "
ldu8v [d_ptr]
dec
store [d_ptr]";
            break;
        case '[':

            psph ~= "
golbl_" ~ to!string(labelCount) ~ ":";
            labelStack ~= labelCount;
            labelCount++;
            break;
        case ']':
            const int labelNum = labelStack.back;
            labelStack.popBack();
            psph ~= "
ldu8v [d_ptr]
jmpt golbl_" ~ to!string(labelNum);
            break;
        case ',':
            psph ~= "
syscall 0x02
store [d_ptr]";
            break;
        case '.':
            psph ~= "
ldsav [d_ptr]
syscall 0x01";
            break;
        case '<':
            psph ~= "
ldptrv d_ptr
dec
store d_ptr";
            break;
        case '>':
            i++;
            psph ~= "
ldptrv d_ptr
inc
store d_ptr";
            break;
        default:
            psph ~= "";
        }
    }

    return psph;
}

private string broToBf(string code)
{
    auto re = regex(r"\n|\t|\r", "g");
    code = replaceAll(code, re, "");
    const string[] tokens = code.split(" ");
    int buffer = 0;
    string output = "";

    foreach (string t; tokens)
    {
        switch (t)
        {
        case "bro":
            buffer++;
            break;
        case "Bro":
            switch (buffer)
            {
            case 1:
                output ~= "+";
                break;
            case 2:
                output ~= "-";
                break;
            case 3:
                output ~= "[";
                break;
            case 4:
                output ~= "]";
                break;
            case 5:
                output ~= ",";
                break;
            case 6:
                output ~= ".";
                break;
            case 7:
                output ~= ">";
                break;
            case 8:
                output ~= "<";
                break;
            default:
                throw new StringException("Unexpected bro, bro!");
            }
            buffer = 0;
            break;
        case "":
            break;
        case " ":
            break;
        default:
            throw new StringException("Invalid command " ~ t ~ ", bro!");
        }
    }

    return output;
}

void main(string[] args)
{
    string code = "";
    string lastIn = "";

    auto ctr = ctRegex!(r"bro|Bro|\+|-|\[|\]|>|<|\.|,");

    do
    {
        lastIn = stdin.readln();
        code ~= lastIn;
    }
    while (!matchFirst(lastIn, ctr).empty);

    if(args[1] == "d") {
        writeln(bfToD(broToBf(code)));
    } else if(args[1] == "psph") {
        writeln(bfToPsph(broToBf(code)));
    } else if(args[1] == "bf2psph") {
        writeln(bfToPsph(code));
    }
}