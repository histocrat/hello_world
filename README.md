*hello, world!* is a programming language with single-character instructions. It uses two global variables, an "accumulator" integer that is useful for loops, and an array we refer to as the "stack", even though we frequently inspect the bottom element as well as pushing to and popping from the top.

The only legal way to end a *hello, world!* program is with the `!` command, which pops two arguments from the stack, prints the first, and then checks the second to determine whether to continue.

Characters that are not in the command set below are ignored.


# Commands

(space): Compare the bottom element of the stack to the accumulator. If equal, exit the current loop.

! (print result): Pop x,y. Print x. If y is 0, end program.

, (increment): Increment the accumulator (starts at 1) and push the result.

. (decrement): Decrement the accumulator and push the result.

c (**c**haracter): Pop a numeric value and push it interpreted as an ASCII character. If the stack is empty, push an empty string.

d (**d**ecide): Pop x, if it's 0 push "false" otherwise push "true". Appends a trailing newline.

0-9: If the top of the stack is a non-zero number, multiply it by 10 and add the digit. Otherwise, push the digit.

e (**e**valuate): Pop the stack, convert it to an integer, push the result.

h (**h**elp): Read a string from STDIN.

l (**l**ast): Push a copy of the last (bottom) element of the stack.

m (**m**odulus): Pop x,y, and push x mod y.

o (l**oo**p): Pop x, if zero jump to next o if exists, otherwise push the bottom element of the stack and jump back to previous o if exists.

r (**r**everse): Pop x, if it's 0 push 1, otherwise push 0.

w (upside down **m**odulus): Pop x,y and push y mod x.

# Sample Programs

##Count

    hel.ol,! ow10c!
 
 `he` reads a number from input. `l` puts it onto the stack a second time, which is necessary since entering a loop consumes one value from the stack. `.` decrements the accumulator so that we start at 0 instead of 1. Then we have the `o`-delimited loop `ol,! o`. Each time through the loop, we increment, then print the accumulator, while keeping the input number on the bottom of the stack. Once the accumulator reaches the input number, the space character exits the loop. So if the user entered `9`, we've now printed `123456789`. To be polite, let's end our output with a newline, the ASCII 10 character. The final `!` wants a 0 to be second-to-top on the stack, and right now we have two equal non-zero characters, so we can use `w` to convert them to a 0. Now we need to push a 10 on top of that. First we push a `1`. Now since the top of the stack is a non-zero number, the `0` command instead of pushing a 0 to the stack multiples it by 10 and adds 0, resulting a 10. We cast this to a newline character with `c`, then `!` prints the newline and pops the 0, ending the program successfully.
 
## Prime test

    hello, world!
    
Here the double `l` is necessary since we will be operating on the input character inside the loop. The loop has two ways of exiting: if `w` ever produces a `0` (we've found a factor), the final `o` will exit the loop, leaving the number being tested on the stack. If the accumulator reaches the input value without this happening, we exit via the space character, leaving the zero produced by the final modulus unconsumed. `r` and `d` convert the zero to the string "true" or a nonzero to the string "false", while `l` furnishes a 0 for the `!`. The result is "true" for a prime number and "false" for a composite one.

## Hello, World!

    c72c!c101c!c108c!c108c!c111c!c44c!c32c!c87c!c111c!c114c!c108c!c100c!c33c!010c!
    
To hardcode a string we simply push the ASCII values for each character, delimited by empty strings, with a zero to denote the last character.

# Reference Implementation

The reference implementation is written in Ruby 2.