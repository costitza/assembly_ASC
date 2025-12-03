/*
Introducere in arhitectura RISC-v

cisc = instr mai complexe + instr au o codificare de lungime variabila
risc = instr mai simple + mai eficient

CISC

Avem 8 registrii de baza
- fiecare registru avand partii mai mici


RISC (RV32)

Toate instructiunile se codifica pe 32b(4B) -> toti registrii au 32 de biti
Semnificativ mai multi registrii (si mai simplii)

In cauza avem 32 de registrii 

Este arhitectura de tip load & store

LOAD + STORE pentru a lua din memorie si a baga inapoi



Registrii din RISC-V

x0 -> x31

x0 - zero -> are mereu valoare 0
x1 - ra -> return address
x2 - sp -> stack pointer
x3 - gp -> global pointer; este un pointer la sectiunea .data
x4 - tp -> thread pointer 


Exista 3 clase de registrii
t -> reg temporari
s -> reg salvati
a -> reg argumente
    a7 - registru pentru apelul de sistem
    a0->a6 arg


Registrii sunt:
x5 -> x7 sunt t0 -> t2 (registrii temporari)

x8, x9 sunt s0/fp, s1 (registrii salvati)
    s0/fp (frame pointer) = ebp

x10 -> x17 sunt a0 -> a7

mai sunt:

x18 -> x27 sunt s2 -> s11
x28 -> x32 sunt t3 -> t6



Tipuri de date:

1B -> .byte
2B -> .halfword
4B -> .word
8B -> .doubleword

+ 

.ascii
.asciz
.space

x: .word 15

Instructiunile load and store (se sufixeaza cu tipul de data)
LOAD: lw, lb, lh + la (load address) + li (load immediate)
STORE: sw, sb, sh

lw reg, memo
reg <- memo

sw reg, memo
reg -> memo

Exemplu: 
.data 
    x: .word 15
    v: .word 3, 5, 2, 19
    t: .byte 'b'
    z: .halfword 25
    p: .word 19

x -> 0(gp) 
v[0] -> 4(gp)
v[1] -> 8(gp)
v[2] -> 12(gp)
v[3] -> 16(gp)
t -> 20(gp)
z -> 21(gp)
p -> 23(gp)

Instructiunii ale arhitecturii:

add rd, rs1, rs2 - rd = rs1 + rs2
sub rd, rs1, rs2 
mul rd, rs1, rs2
div rd, rs1, rs2
rem rd, rs1, rs2 - modulo

rd, rs1, rs2 - sunt doar registrii

lw t0, x
lw t1, y
add t2, t0, t1
sub t3, t0, t1
mul t4, t0, t1
...

Exista si prefixarea:
addi rd, rs, imm - rd = rs + imm (ne lasa ca argumentul din dreapta sa fie constanta)
addi t2, t2, 1 (t2++)

sll rd, rs1, rs2 -> rd = rs1 << rs2 == rs1 * rs2
slr rd, rs1, rs2 -> impartire
slli rd, rs1, imm -> rd = rs << imm
lui rd, imm (load upper immediate) -> rd = imm << 12
auipc rd, imm (add upper immediate to program counter) -> pc + (imm << 12)

unde pc - %eip
_________________

Exemplu: 

Fie pc = 0x1000
Sa se det val din a0 dupa executarea instr:
auipc a0, 0x03


a0 = 0x1000 + (0x03 << 12)
    = 0x1000 + 0x3000 = 0x4000
__________________

Reprezentarea instructiunilor in cod masina

In RISC-V instructiunile au unul din urmatoarele formate:
R - formatul instructiunilor pentru care stim rd, rs1, rs2 (add, sub, div, mul, rem)
I - formatul instructiunilor pentru care avem un immediate value (addi, slli) + l, s
B - formatul instructiunilor branch (b label, salturrile conditionate)
U - formatul instructiunilor care opereaza pe upper (lui, auipc)
J - formatul instructiunilor jump (j et, call de proceduri)

Formatul R:
Sunt pe 32b

31 -> 0
primii 7b = func7
apoi 5b = rs1
apoi 5b = rb
     3b = func3
     5b = rd
     7b = op code

func7 x func3 x opcode => identifica in mod unic instructiunea (sunt date)

Exemplu:
Sa se reprezinte instructiunea add a0, a1, a2

pt add: 
    func7 = 0
    func3 = 0
    opcode = 0x33

solutie:
func7 = 0000 000
rs2 = a2 = 12 = 01100
rs1 = a1 = 11 = 01011
func3 = 000
rd = a0 = 10 = 01010
opcode = 011 0011

Reprezentarea finala -> 0000 0000 1100 0101 1000 0101 0011 0011
Reprezentare in hex = 0x00C58533

Apelurile de sistem
EXIT - 93
WRITE - 4

li a7, 93
li a0, 0 
ecall - pt EXIT

li a7, 4
li a0, str
ecall - pt WRITE


Formatul I - formatul pt immediate values

tot pe 32b - de la 31 pana la 0

imm - 12b
rs - 5b
func3 - 3b
rd - 5b
opcode - 7b

Exemplu: addi a0, a1, 15

func3 = 0
opcode = 0x13

imm = 0000 0000 1111
rs = a1 = 11 = 01011
func3 = 000
rd = a0 = 10 = 01010
opcode = 001 0011

Concatenate = 0000 0000 1111 0101 1000 0101 0001 0011
In hex = 0x00F58513

_______________


Salturi

-neconditionat -> j et
-conditionate 
    <, <=, >, >=, ==, !=
    blt, ble, bgt, bge, beq, bne
toate primesc r1, r2, label

bgt t3, t5, et
    daca t3 > t5 se duce la eticheta
    altfel continua


________________

Stadii de executare, hazarduri

Procesorul RV32 are 5 stadii de executare:

Fetch - se preia codificare instructiunii in cod masina, folosind pc (0x00F58513)
Decode - se decodifica instr (addi, a0, a1, 15)
Execute - se executa instr folosind UAL
Memory - se apeleaza optional memoria principala
WriteBack - rezultatul instructiunii se stocheaza in registru sau memorie pentru a putea fii preluat
            de o alta instr

cazul ideal de paralelizare
instr1  F D E M W
instr2    F D E M W
instr3      F D E M W
instr4        F D E M W

In realiate apar hazarduri
- structurale (hardware)
- control (apar cand avem branch-uri): predictive branching
- de date (apar in situatia cand o instructiune depinde de decodificare alteia nefinalizata)
    I - folosim valori/info partiale
    II - stalling: astept inainte de E, in instructiunea dependenta ca dependinta sa finalizeze WriteBack

Exemplu: 
Sa se determine numarul de ciclii necesari executarii urm instr:

lw a0, 0(gp)
add a1, a0, a2
sw a1, 4(gp)

F D E M W
  F D S S E M W
    F D S S S S E M W



Pentru testul de activitate

1. Reprezentare format .single (semn + exponent + mantisa)
2. auipc (auipc a0, 0x3)
3. codificare R/I
4. Exercitiu cu hazard de date si determinare numar de ciclii pt rulare

Materiale dar nu online

*/