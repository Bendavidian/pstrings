/* Ben Davidian id - 206844045 */

.extern printf
.extern scanf

.section .rodata
format1: .string "first pstring length: %d, second pstring length: %d\n"
format2: .string "length: %d, string: %s\n"
int_format: .string "%d"
invalid_format: .string "invalid option!\n"

.section .text

    .globl run_func
    .type run_func, @function

run_func:
    # pstring1 in %rsi, pstring2 in %rdx
    xorq %r8, %r8        # Clear the %r8 register
    leaq (%rdi), %r8     # Load the value of %rdi (the choice integer) into %r8
    cmpq $31, %r8        # Compare the choice with 31
    je .pstrlen_func     # If choice is 31, jump to the .pstrlen_func label
    jb .default          # If the choice is less than 31, jump to the .default label
    cmpq $33, %r8        # Compare the choice with 33
    je .swapCase_func    # If choice is 33, jump to the .swapCase label
    cmpq $34, %r8        # Compare the choice with 34
    je .pstrijcpy_func   # If choice is 34, jump to the .pstrijcpy label
    ja .default          # If the choice is greater than 34, jump to the .default label
    cmpq $32, %r8        # Check if choice is 32
    je .default    # invalid hole in between 31-34

#choice 31:
.pstrlen_func:
    push %rbp           # backup rbp
    movq %rsi, %rdi     # move pstring1 to the first parmeter
    call pstrlen        # call pstrlien with psring1
    movl %eax, %r9d     # move len of pstring1 to a temp register

    movq %rdx, %rdi     # move pstring2 to the first parmeter
    call pstrlen        # call pstrlien with psring2
    movl %eax, %r10d    # move len of pstring2 to a temp register

    movq $format1, %rdi # move formet1 to the first parameter
    movq %r9, %rsi     # move len of pstring1 to the second parameter
    movq %r10, %rdx    # move len of pstring1 to the third parameter
    xorq %rax, %rax     # return val = 0
    call printf         # calling printf
    popq %rbp           # returning the function how call us
    ret

# choice 33
.swapCase_func:
    # pstring1 in %rsi, psring2 in %rdx
    pushq %rbp         #backup rbp
    movq %rsp, %rbp 

    # creating the new frame pointer. saving callee - save registers if needed
    push %r12
    push %r13

    leaq (%rsi), %r13   # keep pstring1 in a temp register
    leaq (%rdx), %r12   # keep pstring2 in a temp register

    leaq (%r13), %rdi   # move pstring1 in to first paramter
    call pstrlen        # call pstrlen with pstring1
    movq %rax, %r8      # keep len1 in a temp register

    movq %r13, %rdi     # send pstring1 as first param
    call swapCase

    movq $format2, %rdi # send format2 as first param
    movq %r8, %rsi      # send len1 as second param
    leaq 1(%rax), %rdx  # send pstrinf1 after swap as third param
    xorq %rax, %rax     # Clear the RAX register
    call printf

    movq %r12, %rdi     # move pstring2 in to first param
    call pstrlen        # call pstrlen with pstring2
    movq %rax, %r9      # keep len2 in a temp register

    movq %r12, %rdi     # send pstring2 as first param
    call swapCase

    movq $format2, %rdi # send format2 as first param
    movq %r9, %rsi      # send len2 as second param
    leaq 1(%rax), %rdx  # send pstrinf2 after swap as third param
    xorq %rax, %rax     # Clear the RAX register
    call printf

    popq %r13           # Restore the r12 register
    popq %r12           # Restore the r11 register
    popq %rbp           # Restore the base pointer
    ret

# choice 34
.pstrijcpy_func:
    # pstring1 in %rsi, psring2 in %rdx
    pushq %rbp              #backup rbp
    movq %rsp, %rbp         # creating the new frame pointer. saving callee-save registers if needed
    push %r12
    push %rbx
    push %r13
    push %r14
    push %r15
    subq $24, %rsp          # allocate space in memory

    leaq (%rsi), %rdi       # move pstring1 in to first parameter
    call pstrlen            # call pstrlen with pstring1
    movq %rax, %rbx         # keep len1 in temp register rbx

    movq %rdx, %rdi         # move pstring2 in to first parameter
    call pstrlen            # call pstrlen with pstring2
    movq %rax, %r12         # keep len2 in temp register r12

    movq %rsi, %r14         # keep pstring1 in temp register r14
    movq %rdx, %r15         # keep pstring2 in temp register r15

    movq $int_format, %rdi  # move format to first parameter
    leaq (%rsp), %rsi       # set storage to local variable
    xorq %rax, %rax         # return value = 0
    call scanf
    xorq %r13, %r13         # return value = 0
    movq %rsi, %r13         # move i to temp register rdx

    movq $int_format, %rdi  # move format to first parameter
    leaq 8(%rsp), %rsi      # set storage to local variable
    xorq %rax, %rax         # return value = 0
    call scanf
    xorq %r9, %r9           # return value = 0
    movq %rsi, %r9          # move i to temp register rdx

    movq %r14, %rdi         # send pstring1 as first parameter
    movq %r15, %rsi         # send pstring2 as second parameter
    movq %r13, %rdx         # send index i as third param
    movq %r9, %rcx          # send index j as forth param
    call pstrijcpy

    movq $format2, %rdi     # send format2 as first param
    movq %rbx, %rsi         # send len1 as second param
    leaq 1(%rax), %rdx      # send new pstring1 as third param
    call printf

    movq $format2, %rdi     # send format2 as first param
    movq %r12, %rsi         # send len2 as second param
    leaq 1(%r15), %rdx      # send pstring2 as third 
    call printf

    popq %r15               # Restore the r15 register
    popq %r14               # Restore the r14 register
    popq %r13               # Restore the r13 register
    popq %rbx               # Restore the rbx register
    popq %r12               # Restore the r12 register
    addq $24, %rsp          # Deallocate space on the stack
    movq %rbp, %rsp         # restoring the old stack pointer.
    popq %rbp               # restoring the old frame pointer.
    ret

# while choice any other number
.default:
    push %rbp                   # alignment reasons
    movq %rsp, %rbp             
    movq $invalid_format, %rdi
    xorq %rax, %rax             # Clear the RAX register
    call printf

    xorq %rax, %rax             # Clear the RAX register
    movq %rbp, %rsp             
    popq %rbp
    ret


