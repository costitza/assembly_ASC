# Laborator 4

# Recap: lab 3

/*
Instruciuni aritmetice (inmultire si impartire)


Structuri repetitive -> simulare pentru while
                     -> loop

MUL:

mull op     (are ca efect)
edx+eax = eax * op

obs: in urma aplicarii mull edx si eax isi pierd vechile valori

DIV:

divl op     (are ca efect)
edx+eax / op -> rest in edx
             -> cat in eax

obs: daca rezultatul impartirii NU este reprezentabil pe 32 de biti, 
atunci obtinem o exceptie aritmetica

In cazul impartirii pe nr mici, consideram ca sursa este exclusiv eax (eax / op)
In acest caz nu uita sa pui in edx = 0

*/



# Tablouri unidimensionale de date
# array-uri de elemente de tip .long

/*

Array-urile sunt zone continue de memorie (accesare in O(1))
Listele NU sunt liniare in memorie (pt fiecare element detinem si o adresa pt NEXT) (accesare O(n))


Declarare & initializare
.data
    v: .long 10, 20, 30, 40, 50
    n: .long 5 

Declarare (doar)
.data
    v: .space 400   (4B x 100 = 400B)
    n: .space 4


(in cazul nostru)
&10 = $v
&20 = $v + 4B
&30 = $v + 8B
&40 = $v + 12B

deci formula generala: $v + i * 4B

a(b,c,d) -> continutul de memorie de la o adresa
ne da valoarea continua la adresa de memorie: a + b + c * d
cand a lipseste, avem: b  + c * d
                       $v + i * 4B
b = adresa array-ului
c = indexul curent
d = dimensiunea unui element

Obs: in aceasta scriere constantele nu se prefixeaza
d -> constanta
b, c -> registrii
a -> constanta / variabila din mem


.data
    v: .long 10, 20, 30, 40, 50
    n: .long 5
.text
.global main

main: 
    mov $v,%edi
   #lea v, %edi (load effective address)
    mov $0,%ecx

while:
    cmp n,%ecx
    je while_exit

    #(%edi, %ecx, 4) -> v[i]
    movl (%edi, %ecx, 4), %ebx 

    inc %ecx
    jmp while
    

*/


# Siruri de caractere

/*

Sunt elemente de 1B fiecare

.data
    str: .asciz "Sir de caractere\n"

.text
.global main
main: 
    movl $0,%ecx
    movl $str,%edi

while:
    movb (%edi, %ecx, 1), %ah
    cmpb $0,%ah
    je while_exit

    # prelucrez elementul

    inc %ecx
    jmp while


while_exit:
 ....


Problema:
    numarati cate vocale sunt intr-un sir

*/