        ;;;;;;;;;;;;;;;;;;;;    MACRO DEFINITIONS   ;;;;;;;;;;;;;;;;;;;;
; A macro with two parameters
; Implements the write system call
    %macro writestring 2
        mov eax, 4  ;sys_write system call number
        mov ebx, 1  ;file descriptor std_out
        mov ecx, %1 ;message to write from parameter 1
        mov edx, %2 ;message length from parameter 2
        int 0x80
    %endmacro

;;;;;;;;;;;;;;;;;;;;    DATA SEGMENT    ;;;;;;;;;;;;;;;;;;;;
section .data
msg1 db 'Before sorting: '
lenmsg1 equ $-msg1
msg2 db 'After sorting: '
lenmsg2 equ $-msg2
asciinums db '7','3','2','1','0','5','6','4','8','9'
lenasciinums equ $-asciinums
crlf db 0x0d, 0x0a
lencrlf equ $ - crlf                

section .text
    global _start
_start:
    writestring msg1, lenmsg1
    writestring asciinums, lenasciinums
    writestring crlf, lencrlf

    ;fill in missing lines of code here
    mov edx, lenasciinums
    mov ecx, 0
    mov esi, asciinums
    mov eax, 1
    
    outerLoop:
      mov ebx, 0
      cmp ecx, edx
      je done

        innerLoop:
            mov dl, [esi+ebx]
            mov dh, [esi+ebx+1]
            cmp dh, dl
            jl swap
            jmp no_swap

            swap:
                mov [esi+ebx], dh
                mov [esi+ebx+1], dl

            no_swap:


           cmp ebx, lenasciinums
           je innerLoopDone
           inc ebx
           jmp innerLoop
		
    innerLoopDone:
        inc ecx
        jmp outerLoop
    done:


    writestring msg2, lenmsg2
    writestring asciinums, lenasciinums
    writestring crlf, lencrlf

    mov eax, 1          ;terminate program
    int 0x80
