;nasm -f win64 -o ej.o ej.asm -l ej.lst && gcc -o ej ej.o && cls && ej

extern printf, scanf

segment .data
txtn        db      "Ingresar numero de elementos del arreglo: ", 0
arreglo     db      10, 6, -5, 100, 1
fmt         db      "%d", 0
txtprom        db      "Promedio del arreglo:  %d", 0

segment .bss
n           resb    1
promedio    resb    1

segment .text
global main
main:

; Ingresar n
sub rsp, 0x20
    mov rcx, txtn
    call printf
add rsp, 0x20
sub rsp, 0x20
    mov rcx, fmt
    mov rdx, n
    call scanf
add rsp, 0x20

xor rcx, rcx
mov cl, [n]
mov rdx, arreglo
call CalcPromedio

mov [promedio], al

; Mostrar promedio
sub rsp, 0x20
    mov rcx, txtprom
    mov rdx, [promedio]
    call printf
add rsp, 0x20

ret



; -------------------------- subrutinas ------------------------
CalcPromedio:
    mov rbx, rdx
    xor rax, rax
    xor rsi, rsi
    xor rdi, rdi
    ciclo:
        cmp rdi, 0
        je es_par
        es_impar:
            mov rdi, 0
            mov dl, [rbx]
            cmp dl, 5
            jle sgt
            cmp dl, 100
            jg sgt
            ; Cumple
                add al, dl
                inc ah
                jmp sgt
        es_par:
            mov rdi, 1
        sgt:
            inc rbx
    loop ciclo
    mov bl, ah
    cbw
    idiv bl
ret
