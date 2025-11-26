/*
Implementarea procedurilor in limbajele de asm
1. Argumentel procedurilor se incarca pe stiva in ordine inversa
2. Apelul se face prin call, iar revenirea din apel prin ret
3. Registrii eax, ecx si edx sunt utilizati pentru returnarea valorilor si nu trebuie restaurati
4. Ebx, edi, esi si ebp trebuie restaurati
5. Registrul ebp este utilizat pentru accesarea constanta a elementelor in cadrul de apel

*/

# Sa se scrie o procedura lenght, care primeste adresa unui sir de carctere si returneaza lungimea acestuia

/*
Apeluri imbricate 

f(x) = 2g(x)
g(x) = x + 1

g: 
    push %ebp
    mov %esp, %ebp
    mov 8(%ebp), %eax
    incl %eax

    pop %ebp
    ret

f:
    push %ebp
    mov %esp, %ebp

    mov 8(%ebp), %eax
    push %eax
    call g

    add $4, %esp
    mov $2, %edx
    mull %edx   # eax contine 2f(x)
    
    pop %ebp
    ret

main:
    push x
    call f
    add $4, %esp

*/


/*
Floating point. Reprezentare pe formatul single + Instructiuni in assembly

Reprezentarea pe format single, respecta standardul IEEE754F8
single -> 32b(4B) -> 1 bit de semn + 8 exponent + 23 mantisa

-2075,3125

partea intreaga - 2075 = 2048 + 16 + 8 + 2 + 1 = 2^11 + 2^4 + 2^3 + 2 + 1
                - 100000011011
parte fractionara - 0,3125 * 2 = 0,625
                    0,625 * 2 = 1,25
                    0,25 * 2 = 0,5
                    0,5 * 2 = 1

numarul -> 100000011011,0101 = 1,000000110110101 * 2^11
semn = 1
exponent = 127 + 11 = 138 = 128 + 8 + 2 -> 10001010
mantisa = 000000110110101 + "00000000"
deci numarul in single va fi = 1100 0101 0000 0001 1011 0101 0000 0000 = 0xC501B500

Floating point in assembly

I. Floating point unit - FPU - stack
Varianta invechita, dar inca utilizata pentru ca tot mathlibb este scris cu FPU

II. Single instruction multi-data - SIMD
-> Registrii speciali %xmm0 -> %xmm7 pe 128b
    Ii utilizam pentru a stoca (tot) un  singur scalar
-> Instr speciale SIMD
    add, mov, sub, mul, div - sufixate cu ss
    OBS: sursa si destinatia sunt pe format single
    + sqrtss, maxss, minss

    cvtsi2ss src, dest (conversie)
    src este long
    dest single

.data
    x: .float -2075,3125

Pentru floating point, printf poate manipula doar formatul double
single - 32
double - 64

Din aceasta cauza cand punem numarul pe stiva acesta va ocupa 2 spatii nu unul

cvtss2sd src, dest
movsd src, dest

*/

/*
Mathlib + FPU - stack

fpu stack este o stiva care contine 8 spatii

%st(0), ...., %st(7)
varf

In conventiile de apel din mathlib, returnarea valorilor se face prin vf stivei

flds op (float load single - push)
fstbs op (float store and pop single - pop)

op - este memorie RAM

pentru a linkui mathlib se adauga -lm la flaguri cand compilam

logf


*/