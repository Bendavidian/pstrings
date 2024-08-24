/* Ben Davidian id - 206844045 */

# Compile with:
# gcc -g -c main.c
# gcc -g -c func_select.s
# gcc -g -c pstring.s
# gcc -g main.o func_select.o pstring.o -o pstrings -no-pie

# Run with: ./pstrings

.section .rodata
format1: .string "invalid input!\n"

.section .text
    .globl pstrlen 
    .type pstrlen, @function

pstrlen:
    movzbl (%rdi), %eax       # move pstring's value to return register
    ret

    .globl swapCase
    .type swapCase, @function

swapCase:
    # pstring in %rdi
    xorl %edx, %edx           # int i = 0 
    movq %rdi, %rax           # keep the pstring
    movzbq (%rdi), %rdi       # keep the len of the pstring
    jmp .L5                   # jump to check the condition

.L4:
    # do pstr -> str[i] = pstr -> str[i] + 32
    addl $32, %ecx           # ecx keep the new char
    movb %cl, 1(%rax, %rdx)  # change the pstr[i]
    
.L3:
    # while loop (if i < len(pstr))
    addq $1, %rdx             # i+1
    cmpq %rdi, %rdx           # compute i:len
    jle .L5                   # if i <= len jump to if condition
    ret


.L5:
    # check if pstr -> str[i] >= 'A' and pstr -> str[i] <= 'Z'
    # 'A' = 65, 'Z' = 90
    movzbl 1(%rax, %rdx), %ecx       # save the pstr[i]
    leal -65(%rcx), %esi            # pstr[i] - 65
    cmpb $25, %sil                  # compute pstr[i] - 65 with 25
    jbe .L4                         # if %sil is big letter

    # check else if pstr -> str[i] >= 'a' and pstr -> str[i] <= 'z'
    leal -97(%rcx), %esi            # pstr[i] - 97
    cmpb $25, %sil                  # compute pstr[i] - 97 with 25
    ja .L3                          # if %sil is small letter

    subl $32, %ecx                  # do pstr -> str[i] = pstr -> str[i] - 32
    movb %cl, 1(%rax, %rdx)         # move new char to the place in the pstring
    jmp .L3                         # go to while loop

    .globl pstrijcpy
    .type pstrijcpy, @function
pstrijcpy:
    # dst in %rdi, src in %rsi, i in %rdx, j in %rcx
    pushq %rbp
    movq %rsp, %rbp
    push %r12
    push %r13
    push %r14
    push %r15

    movq %rdx, %r12                 # %r12 = i
    movq %rcx, %r13                 # %r13 = j
    movq %rdi, %r14                 # %r14 = pstring1
    movq %rsi, %r15                 # %r15 = pstring2

    movzbq (%r14), %r8              # get len of pstring1
    cmpq %r13, %r8                  # check if len(psring1) < j
    jl .Fail1

    movzbq (%r15), %r8              # get len of pstring2
    cmpq %r13, %r8                  # check if len(psring2) < j
    jl .Fail1

    addq $1, %r14                   # move address to start of string without len
    addq $1, %r15                   # move address to start of string without len
    addq %rdx, %r14                 # move address to index i
    addq %rdx, %r15                 # move address to index i

    # check indexs i and j 
    cmp %r13, %r12                  #check if i > j
    jg .Fail2
    jmp .L6

.L6:
    # dst -> str[i] = src -> str[i]
    movzbq (%r15), %rax
    movb %al, (%r14)
    addq $1, %r12                   # i++
    incq %r15                       # move address by one
    incq %r14                       # move address by one

    # while (i <= j)
    cmp %r12, %r13                  # computr i:j
    jge .L6                         #if i <= j goto
    jmp .FINISH

.Fail1:
    movq $format1, %rdi             # sent format1 as first param
    xorq %rax, %rax                     
    call printf

    movq %r14, %rax                 #send the orignal string as return value

    popq %r15
    popq %r14
    popq %r13
    popq %r12
    movq %rbp, %rsp
    popq %rbp
    ret

.Fail2:
    subq %rdx, %r14                 #return the string to the orignal place
    subq $1, %r14

    movq $format1, %rdi             # sent format1 as first param
    xorq %rax, %rax 
    call printf

    movq %r14, %rax                 # send the orignal string as return value

    # pop all callee registers
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    movq %rbp, %rsp
    pop %rbp
    ret

.FINISH:
    subq %r12, %r14                # go back to the start of the string
    subq $1, %r14                  # go back to point in the string with the len
    movq %r14, %rax                # return pointer to dst

    # pop all callee registers
    pop %r15
    pop %r14
    pop %r13
    pop %r12
    movq %rbp, %rsp
    pop %rbp
    ret


    