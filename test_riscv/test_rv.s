.global _start
.text
_start:
test_1:
# Suma moviendo valores
li a1, 0x00000003
li a2, 0x00000007
add a3, a1, a2
# Suma cargando valores desde memoria
addi sp, sp, -56
sw a2, 0(sp)
lw a5, 0(sp)
add a6, a1, a5
bne x30, x29, fail
pass:
li a0, 42
li a7, 93
ecall
fail:
li a0, 0
li a7, 93
ecall
