BITS 32

global _start

section .data
    data db "1337" ; initialisation chaine de caractère

section .text

loop_atoi:
    mov eax, [esi] ; on met l'adresse qui pointe vers le caractère dans EAX
    imul ecx, 0xa ; on multiplie la valeur de ECX par 10
    and eax, 0xf ; operateur and de 15 du caractère
    add ecx, eax ; puis on additionne nos deux registre
    inc esi ; Incrémentation du pointeur
    mov edx, [esi] ; stock l'adresse du caractère dans edx
    cmp edx, 0x0 ; Compare le caractère à Null-Byte
    jne loop_atoi ; edx != 0 { jump au début de la loop }
    jmp suite_atoi ; jump vers la fin de la fonction

atoi:
    push ebp ; on pousse l'anciene base pointeur sur la stack
    mov ebp, esp ; attribution de la nouvelle base pointeur
    mov ecx, 0x0 ; valeur de retour
    mov esi, [esp+0x8] ; chaine de caractere "1337"
    jmp loop_atoi ; boucle
    

suite_atoi:
    mov eax, ecx ; on met ecx dans eax pour la valeur de retour
    xor ecx, ecx ; on remet a 0 ecx
    leave ; on pop ebp & mov esp, ebp
    ret ; retourne vers l'adresse du call (_start)

_start:
    mov esi, data ; stock la chaine dans esi
    push esi ; pousse ESI dans la base pointer
    call atoi ; call atoi fonction
    