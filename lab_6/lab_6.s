/*
Partea 0x01 -> proceduri
            -> SIMD+FPU (floating points)

1. Proceduri
Apeluri de proceduri (din C)
I - printf
push y
push x
push $formatPrint
pop %ebx
pop %ebx
pop %ebx

Recap : 
1. argumentele se incarca pe stiva in ordine inversa
2. apelul se face cu instructiunea call
3. pt fiecare push facut, avem un pop corespunzator

Obs: registrii eax, ecx, edx isi pierd valoarea in urma apelului

II - scanf - procedura pentru citirea valorilor de la STDIN

scanf("%d", &x)  ===  cin >> x

push $x
push $formatScanf
call scanf
pop %ebx
pop %ebx


Implementarea de proceduri

Stiva

obs: stiva creste spre adrese mici si scade spre adrese mari
%esp -> stack pointer
     -> registrul care stocheaza varful stivei si este modificat la fiecare operatie

Fiind arhitectura de 32b +> stiva va fi aliniata la 32b (4B)

push op = sub $4, %esp
          mov op, 0(%esp)

obs: %esp -> adresa vf stivei
     (%esp) / 0(%esp) -> continutul vf stivei

pop op = mov 0(%esp), op
         add $4, %esp
pop    = add $4, %esp

!!
%eip = instruction pointer

call f == push %eip
          jmp f
ret  == sare la adresa din vf stivei
        add $4, %esp
        jmp -4(%esp)


main:
.
.
.
    push y
    push x
    call f
->  *

f:
.
.
.
    ret

Pentru a rezolva accesarea neconstanta pe care o avem relativ la %esp
fixam un alt pointer in cadrul de apel -> %ebp

f:
    push %ebp # pentru ai face o copie
    mov %esp, %ebp
    .
    .
    .
    pop %ebp
    ret

Reguli (conventii) de implementare a procedurilor

1. argumentele se incarca pe stiva, in ordine inversa
2. apelul se face prin call, revenirea se face prin ret
3. registrii %ebx, %edi, %esi, %ebp TREBUIE RESTAURATI in urma apelului
4. registrii %eax, %ecx, %edx sunt utilizati pentru returnarea valorilor
5. in cadrul procedurilor folosim registrul %ebp pentru accesarea constanta a cadrului de apel

Suma a doua numere 

main: 
    push y
    push x
    call sum
    add $8, %esp
    # %eax este rezultatul

sum: 
    push %ebp
    mov %esp, %ebp
    mov 8(%ebp), %eax
    push %ebx
    mov 12(%ebp), %ebx
    add %ebx, %eax
    
    pop %ebx
    pop %ebp
    ret

*/