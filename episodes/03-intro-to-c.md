# Introduction to C

## 1. What is C?     
 
- Developed by Dennis Ritchie at Bell Labs
- First public released in 1972. 
- **The** book: *The C programming languange" by Dennis M. Ritchie and Brian W. Kernighan. 
Prentice Hall 1988. 


## 2. How to learn C (now that you already know Java)?     
 
- [C for Java programmers](https://www.cs.rochester.edu/u/ferguson/csc/c/c-for-java-programmers.pdf)
- [C programming vs. Java programming](https://introcs.cs.princeton.edu/java/faq/c2java.html)


## 3. Scary stuff ahead ...     
 
- C is much less supportive for programmers than Java.
- (Much) easier to make mistake, and (much) harder to fix. 


## 4. But it is exciting ...     
 
- C requires less memory resources than Java.
- C, in many instances, runs faster than Java. 
- Knowing C will make you a better programmer overall. 


## 5. Similarities (or mostly similar) between C and Java     
 
- Values, types, literals, expressions
- Variables
- Control flow (if, switch, while, for, do-while)
- Call-return: parameters, arguments, return values
- Arrays (mostly)
- Primitive and reference types
- Type casting. 
- Library usage. 


## 6. Differences between C and Java     
 
- C has no classes or objects (but something similar)
- C is not object-oriented. 
- C arrays are simpler:
  - No boundary checking. 
  - No knowledge of array's own size. 
- String operations are limited. 
- No collections, exceptions, or generics. 
- No automatic memory management. 
- **Pointers!!!**


## 7. How Java programs run

<img src="../fig/02-c/java.png" alt="Java programs" style="height:400px">


## 8. How C programs run

<img src="../fig/02-c/c.png" alt="C programs" style="height:400px">



## 9. Hands-on: Getting started

- SSH to `molly`. Refer to the Setup page if you need a refresher on how to 
do so.
- Change into `csc231` from inside your home directory. 
  - Your home directory is represented by the `~` sign. 
- Create a directory named `intro-c` inside `csc231`, 
then change into that directory.

~~~
$ cd ~/csc231
$ pwd
$ mkdir intro-c
$ ls
$ cd intro-c
$ pwd
~~~


<img src="../fig/02-c/02.png" alt="create intro-c directory" style="height:250px">




## 10. Hands-on: Create hello.c

- Inside the terminal, make sure that you are still inside
`intro-c`, then use `nano` to create `hello.c`with the source code below. 

~~~
$ pwd
$ nano -l hello.c
~~~


<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=hello.c"></script>


- Once finished editing in `nano`:
  - first hit `Ctrl-X` (same for both Windows and Mac). 
  - Next hit `Y` to save modified buffer (new contents). 
  - Hit `Enter` to save to the same file name as what you opened with. 
- **Memorize your key-combos!**.

<img src="../fig/02-c/03.png" alt="Creating hello.c using nano" style="height:550px">

### What's in the code?
>
- Line 1: Standard C library for I/O, similar to Java's `import`.
- Line 2-4: Function declaration/definition for `main`:
  - Line 2: 
    - return type: `int`
    - function name: `main`
    - parameter list: 
       - `argc`: number of command line arguments.
       - `*argv[]`: pointers to array of command line argument strings. 
   - Line 3: Invoke builtin function `printf` to print out  string `Hello world!`
   with an end-of-line character `\n`. This is similar to `System.out.printf`.
   - Line 4: Exit a successfully executed program with a return value of 0. 







## 11. Hands-on: Simple compile and run

- Similar to `javac`, we use `gcc` to compile C code. 
- Before compile, make sure that you are still inside `intro-c` in the terminal. 

~~~
$ ls
$ pwd
$ gcc -o hello hello.c
$ ls
$ ./hello
~~~


<img src="../fig/02-c/04.png" alt="Creating hello.c using nano" style="height:350px">




## 12. Hands-on: Compile and show everything

- There are a number of steps from C codes to executable binaries.  

~~~
$ ls -l
$ gcc -save-temps -o hello2 hello.c
$ ls -l
$ ./hello2
~~~


<img src="../fig/02-c/05.png" alt="compile and run hello.c, keeping intermediate files" style="height:400px">




## 13. What are those?

- `hello.i`: generated by pre-processor
- `hello.s`: generated by compiler.
- `hello.o`: generated by assembler.
- `hello` (or `hello2`): executable, generated by linker.

<img src="../fig/02-c/06.png" alt="hello.c compilation process" style="height:700px">




## 14. Hands-on: View files

- For `hello.i` and `hello.s`, they can be view on the editor. 
- Run the following command to view `hello.i`

~~~
$ cat -n hello.i
~~~


- Run the following command to view `hello.s`

~~~
$ cat -n hello.s
~~~


- For `hello.o` and `hello`, we need to dump the binary contents first. 

~~~
$ xxd -b hello.o hello.o.txt
$ xxd -b hello hello.txt
$ ls -l
~~~


- 
<img src="../fig/02-c/07.png" alt="hexdumping hello.o and hello" style="height:300px">
>
- Run the following command to view `hello.o.txt`

~~~
$ cat -n hello.o.txt
~~~


- Run the following command to view `hello.txt`

~~~
$ cat -n hello.txt
~~~





## 15. Challenge: 

The usage of C's `printf` is similar to Java's `System.out.printf`. Find out how to 
modify `hello.c` so that the program prints out `Hello Golden Rams!` with each word
on a single line. The program should use exactly one `printf` statement. 

## Answer
    
<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=hello-3.c"></script

{: .solution}
{: .challenge}


## 16. Variables, Addresses, and Pointers
>
- In Java, you can manipulate the value of a variable via the program but not directly 
in memory (inside the JVM). 
- In C, you can retrieve the address of the location in memory where the variable is 
stored. 
- The operator `&` (reference of) represents the memory address of a variable.



## 17. Hands-on: Pointer

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `pointer-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=pointer-1.c"></script>

- `%p` is an output conversion syntax (similar to Java specifiers) for displaying memory 
address in hex format. See [Other Output Conversions](https://www.gnu.org/software/libc/manual/html_node/Other-Output-Conversions.html#Other-Output-Conversions) for more 
details.
- Compile and run `pointer-1.c`

~~~
$ ls
$ gcc -o pointer-1 pointer-1.c
$ ./pointer-1
~~~


<img src="../fig/02-c/08.png" alt="Compile and run pointer-1.c" style="height:400px">




## 18. Pointer Definition

- Pointer is a variable that points to a memory location (contains a memory location).  
  - We can them *pointer variables*. 
- A pointer is denoted by a `*` character. 
- The type of pointer must be the same as that of the value being stored in 
the memory location (that the pointer points to).
- If a pointer points to a memory location, how do we get these locations?
  - An `&` character in front of a variable (includes pointer variables) denotes that
  variable's address location. 


## 19. Hands-on: Pointer and Variable's Addresses

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `pointer-2.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=pointer-2.c"></script>

- Since `p_i` is a pointer variable, `p_i` contains a memory address (hence `%p`).
- Then, `*p_i` will point to **the value in the memory address contained in p_i**. 
  - This is referred to as *de-referencing*. 
  - This is also why the type of a pointer variable must match the type of data stored
  in the memory address the pointer variable contains. 
- Compile and run `pointer-2.c`

<img src="../fig/02-c/09.png" alt="Compile and run pointer-2.c" style="height:150px">



## 20. Pass by Value and Pass by Reference

- Parameters are passed to functions. 
- Parameters can be value variables or pointer variables. 
- What is the difference?  


## 21. Hands-on: Pass by value

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `pointer-3.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=pointer-3.c"></script>

- Compile and run `pointer-3.c`

<img src="../fig/02-c/10.png" alt="Compile and run pointer-3.c" style="height:150px">




## 22. Hands-on: Pass by reference

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `pointer-4.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=pointer-4.c"></script>

- Compile and run `pointer-4.c`

<img src="../fig/02-c/11.png" alt="Compile and run pointer-4.c" style="height:450px">



## 23. Question

In Java, do you pass by value or pass by reference?

## Answer     
- Primitives are passed by value. 
- Objects are passed by reference. 

{: .solution}
{: .challenge}


## 24. Pointers and memory allocation

- How does C request dynamic memory when you don't know at 
compile-time exactly what you will need?
- How does C allocate memory?
  - Automatic: compile arranges for memory to be allocated 
  and initialized for local variables when it is in scope.
  - Static: memory for static variables are allocated once 
  when program starts.
  - Dynamic: memory is allocated on the fly as needed.



## 25. Dynamic memory allocation

- Unlike Java, you have to do everything!
  - Ask for memory.
  - Return memory when you are done (garbage collection!).
- C function: [`malloc`](https://linux.die.net/man/3/malloc)
  - `void *malloc(size_t size);`
  - The `malloc()` function allocates `size` bytes and returns 
  a pointer to the allocated memory. The memory is **not initialized**. 
  If size is 0, then `malloc()` returns either `NULL`, or a unique 
  pointer value that can later be successfully passed to `free()`.
- C function: [`free`](https://linux.die.net/man/3/free)
  - void free(void *ptr);
  - The `free()` function frees the memory space pointed to by ptr, 
  which must have been returned by a previous call to `malloc()`, 
  `calloc()` or `realloc()`. Otherwise, or if `free(ptr)` has already 
  been called before, undefined behavior occurs. If `ptr` is `NULL`, 
  no operation is performed.



## 26. Void pointer

- When `malloc` allocates memory, it returns a sequence of bytes, with
no predefined types. 
- A pointer that points to this sequence of bytes (the address of the 
starting byte), is called a **void pointer**.  
- A void pointer will then be typecast to an appropriate type. 



## 27. Hands-on: malloc and type cast

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `malloc-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=malloc-1.c"></script>

- What points to where:
  - `void *p = malloc(4);`: allocate 4 contiguous bytes. The address of the
  first byte is returned and assign to pointer variable `p`. `p` has no 
  type, so it is a `void pointer`. 
  - `int *ip = (int *)p;`: The address value *pointed to* by `p` is assigned
  to pointer variable `ip`. The bytes pointed to be `p` are now casted to 
  type `int`. 
- Compile and run `malloc-1.c`

<img src="../fig/02-c/12.png" alt="Compile and run malloc-1.c" style="height:150px">




## 28. Hands-on: malloc and type cast with calculation

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `malloc-2.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=malloc-2.c"></script>


- Only ask for exactly what you need!
- Compile and run `malloc-2.c`

<img src="../fig/02-c/13.png" alt="Compile and run malloc-2.c" style="height:150px">




## 29. Hands-on: Safety

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `malloc-3.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=malloc-3.c"></script>


- Return and free memory after you are done!
- Compile and run `malloc-3.c`

<img src="../fig/02-c/14.png" alt="Compile and run malloc-3.c" style="height:150px">



## 30. Dynamic memory allocation

- Critical to support complex data structures that grow as the 
 program executes. 
- In Java, custom classes such as ArrayList and Vector provide 
such support.
- In C, you have to do it manually: How?
- Let’s start with a simpler problem:
  - How can we dynamically allocate memory to an array 
  whose size is not known until during run time?



## 31. Hands-on: What does an array in C look like?

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `array-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=array-1.c"></script>


- What is the distance between addresses? Why?
- Compile and run `array-1.c`

<img src="../fig/02-c/15.png" alt="Compile and run array-1.c" style="height:250px">




## 32. Exercise

- Create a copy of `array-1.c` called `array-2.c`. 
- Change the type of `numbers` to `double`. 
- What is the address step now?

## Answer    

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=array-2.c"></script>
<img src="../fig/02-c/16.png" alt="Compile and run array-2.c" style="height:250px"

{: .solution}
{: .challenge}


## 33. An array variable

- ... is in fact pointing to an address containing a value. 
- ... without the bracket notation and an index points to the 
corresponding address of the value at the index. 
- ... is quite similar to a pointer!


## 34. Hands-on: Array as pointer (or vice versa ...)

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `array-3.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=array-3.c"></script>

- Compile and run `array-3.c`

<img src="../fig/02-c/17.png" alt="Compile and run array-3.c" style="height:250px">




## 35. Hands-on: Dynamic array creation with command line arguments. 

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `array-4.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=array-4.c"></script>


- In C, the command line arguments **include** the program's name. The
actual arguments start at index position 1 (not 0 like Java).
- Compile and run `array-4.c`

<img src="../fig/02-c/18.png" alt="Compile and run array-4.c" style="height:250px">




## 36. Hands-on: String 

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `string-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=string-1.c"></script>

- Compile and run `string-1.c`

<img src="../fig/02-c/19.png" alt="Compile and run string-1.c" style="height:150px">

- In C, string is considered an array of characters.



## 37. Question

- How many characters were printed out on the second line in the terminal?
- Hint: Can you see all of them?

## Answer     
- 24 

{: .solution}
{: .challenge}

## 38. Hands-on: Array of strings

- Inside the terminal, make sure that you are still inside
`intro-c`, then use `nano` to create `string-2.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=string-2.c"></script>

- Compile and run `string-2.c`

<img src="../fig/02-c/20.png" alt="Compile and run string-2.c" style="height:150px">




## 39. Object in C

- C has no classes or objects. 
- Instead, it has `struct` type (think ancestor of objects) .



## 40. Hands-on: Struct in C

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `struct-1.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=struct-1.c"></script>

- Compile and run `struct-1.c`

<img src="../fig/02-c/21.png" alt="Compile and run struct-1.c" style="height:150px">



## 41. Question

- Modify `struct-1.c` so that it prints out the address of `origin` variable. 
- What do you learn from the printed out addresses?

## Answer     
Insert `printf("The address of the origin is: %p\n", &origin);` between the existing
`printf` calls.  

{: .solution}
{: .challenge}


## 42. Hands-on: Struct of structs in C

- Inside the terminal, make suse that you are still inside
`intro-c`, then use `nano` to create `struct-2.c`with the source code below. 

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=struct-2.c"></script>

- Compile and run `struct-2.c`

<img src="../fig/02-c/22.png" alt="Compile and run struct-2.c" style="height:150px">





## 43. Function in C

- Almost the same as methods in Java, except for one small difference. 
- They need to either be declared, or must be defined prior to being
called (relative to written code position). 



## 44. Hands-on: Functions in C - definition and declaration

- Create three C files, `function-1.c`, `function-2.c`, and `function-3.c`,
with the source codes below:

<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=function-1.c"></script>
<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=function-2.c"></script>
<script src="https://gist.github.com/linhbngo/d1e9336a82632c528ea797210ed0f553.js?file=function-3.c"></script>

- Compile and run these files. 

<img src="../fig/02-c/23.png" alt="Compile and run function-1.c, function-2.c, and function-3.c" style="height:250px">


