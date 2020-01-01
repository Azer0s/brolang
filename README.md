## brolang - the brogramming language for real bros

This meme went way too far.

### Why???

Idk. I need help. It is January 1st. What am I doing with my life?

![](https://i.redd.it/1zrqq62xu5r21.jpg)

### Hello world

```bro
bro bro Bro bro bro Bro bro bro Bro bro bro Bro bro bro bro Bro bro bro Bro bro 
bro Bro bro bro bro bro bro bro bro Bro bro Bro bro Bro bro Bro bro bro bro bro 
bro bro bro bro Bro bro bro bro bro Bro bro bro bro bro bro bro bro Bro bro bro 
Bro bro bro bro bro bro bro Bro bro bro Bro bro bro Bro bro bro Bro bro bro Bro 
bro bro Bro bro bro Bro bro bro Bro bro bro Bro bro bro Bro bro bro Bro bro bro 
bro bro bro bro Bro bro bro bro Bro bro bro Bro bro bro Bro bro bro Bro bro bro 
bro bro bro bro bro Bro bro Bro bro bro bro bro bro bro bro bro Bro bro bro bro 
bro Bro bro bro bro bro bro bro bro Bro bro bro Bro bro bro Bro bro bro Bro bro 
bro Bro bro bro Bro bro bro bro bro bro bro Bro bro bro bro Bro bro bro Bro bro 
bro bro bro bro bro bro Bro bro Bro bro Bro bro Bro bro bro bro bro bro bro bro 
bro Bro bro bro bro bro Bro bro bro bro bro bro bro bro Bro bro Bro bro Bro bro 
bro bro bro bro bro Bro bro bro bro Bro bro bro Bro bro bro Bro bro bro Bro bro 
bro bro bro bro bro bro Bro bro Bro bro bro bro bro bro bro bro bro Bro bro bro 
bro bro Bro bro bro bro bro bro bro bro Bro bro bro Bro bro bro Bro bro bro Bro 
bro bro Bro bro bro bro bro bro bro Bro bro bro Bro bro bro Bro bro bro Bro bro 
bro bro bro bro bro Bro 
```

### Commands

Every .bro file needs a trailing \n

| Command                               | Meaning                                                      |
| :------------------------------------ | :----------------------------------------------------------- |
| `bro Bro`                             | increment the byte at the current pointer                    |
| `bro bro Bro`                         | decrement the byte at the current pointer                    |
| `bro bro bro Bro`                     | if the byte at the current pointer is zero, then instead of moving the ip forward to the next command, jump it forward to the command after the matching `bro bro bro bro Bro` command |
| `bro bro bro bro Bro`                 | if the byte at the current pointer is nonzero, then instead of moving the ip forward to the next command, jump it back to the command after the matching `bro bro bro Bro` command |
| `bro bro bro bro bro Bro`             | accept one byte of input, storing its value in the byte at the current pointer |
| `bro bro bro bro bro bro Bro`         | output the byte at the current pointer                       |
| `bro bro bro bro bro bro bro Bro`     | increment the current pointer                                |
| `bro bro bro bro bro bro bro bro Bro` | decrement the current pointer                                |

### Run a bro file

```bash
./run path/to/brofile
```

### Examples

`hello.bro` - Hello world

`mandelbro.bro` - Mandelbrot set

`fibonacci.bro` - Fibonacci sequence
