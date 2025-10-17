# Laborator 3
# exista inc si dec (trebuie neaparat mentionat tipul sufixat)

# incl / decl -> long
# incw / decw -> word s.a.m.d


# Instructiunea MUL (mul)

# mul op    (op poate fi exclusiv registru)

# are ca efect:
# %eax se inmulteste cu operandul (tot registru si el)
# se stocheaza rezultatul in %eax (daca incape pe 32b)
# daca nu incape se adauga cu %edx
# rez: EDX+EAX 

# mai exista si mull    (direct sufixat ca sa poti folosi si x)


# Instructiunea de impartire (DIV / div)

# div op    (doar registru - op)
# divl op   (si locatie din memorie -> x / y)

# are ca efect:
# sursa implicita este edx+eax / op
# ramanem cu rest -> stocat in EDX
#            cat  -> stocat in EAX

# OBS: cand lucram cu numere mici (sub 2^32)
# este suficient sa facem edx = 0 !!!

# OBS: daca in urma impatirii, catul depaseste reprezentarea pe 32b, 
# atunci se obitine EXCEPTION


# SIMULAREA STRUCTURILOR REPETITIVE

# simulam FOR / WHILE
