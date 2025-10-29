# Partial numai din partea 0x00 !!!!!!
# pt ex testele 2.1 2.2 2.3 3.1 3.2 4.1 4.2. 4.3

/*

Recapitulare 

Array-uri -> .long
          -> .byte (siruri de caractere)

Array de tip .long:
v <- numele
n <- numarul de elem
dimensiunea pe care o ocupa fiecare elem

Deferentiere: (b, c, d) -> continutul de la adresa b + c * d
-spre ex: ($v, 2, 4) <- v[2]
v = adresa
2 = pozitia
4 = dimensiunea unui elem in B (.long are 4B)


! b, c - mereu registru -> %edi, %ecx !

EX: 

movl $v, %edi
movl $2, %ecx
movl (%edi, %ecx, 4), %ebx

*/


# Partea 0x01 !

/*

Constructia cadrelor de apel + (floating points)


Apelul functiilor din C (stdlib = stdio.h + string.h)

printf = functia de scriere la standard output
    - functie cu numar variabil de argumente
    - primul argument este un format string
%d -> simbol pt intregi
%f -> floating point
%s -> pt siruri

printf("Nr este: %d\n", x) ----> Nr este: x
printf("(%d, %d)\n", a, b)

call printf (pt a chema in assembly)

pt a face un call trebuie sa incaracam pe stiva mai intai argumentele:
push y
push x
push $format - stringul de afisat
call printf
pop %ebx
pop %ebx
pop %ebx

!!!!!
In urma apelurilor, registrii eax, ecx, edx isi pierd valoarea
pe care o aveau inaintea apelului
!!!!!

*/