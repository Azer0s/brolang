module brolang;

import std.algorithm : group, map;
import std.range : repeat, chain;
import std.string : join;
import std.conv : to;
import std.stdio;
import std.array;
import std.string;

private string bfToD(string code) {
    return "import std; void main() { ubyte[30000] field; size_t ptr;"
        ~ code
            .group
            .map!((g) {
                    const dchar token = g[0];
                    size_t count = g[1];
                    switch(token) {
                    case '+': return "field[ptr]+=" ~ count.to!string ~ ";";
                    case '-': return "field[ptr]-=" ~ count.to!string ~ ";";
                    case '[': return "while(field[ptr]){".repeat(count).join;
                    case ']': return "}".repeat(count).join;
                    case ',': return "field[ptr]=stdin.byChunk(1).front[0];".repeat(count).join;
                    case '.': return "write(cast(char)field[ptr]);".repeat(count).join;
                    case '>': return "ptr+=" ~ count.to!string ~ ";";
                    case '<': return "ptr-=" ~ count.to!string ~ ";";
                    default : return "";
                    }})
            .join('\n')
        ~ `writeln("");}`;
}

private string broToBf(string code) {
    const string[] tokens = code.split(" ");
    int buffer = 0;
    string output = "";

    foreach(string t; tokens) {
        switch(t) {
            case "bro": buffer++; break;
            case "Bro":
                switch(buffer) {
                    case 1:
                    output ~= "+";
                    break;
                    case 2:
                    output ~="-";
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
                    default: throw new StringException("Unexpected bro, bro!");
                }
                buffer = 0;
            break;
            case "": break;
            case " ": break;
            case "\n": break;
            case "\t": break;
            case "\r": break;
            default: writeln(t); throw new StringException("Invalid command " ~ t ~ ", bro!");
        }
    }

    return output;
}

void main() {
    const string code = stdin.readln();
    writeln(bfToD(broToBf(code)));
}