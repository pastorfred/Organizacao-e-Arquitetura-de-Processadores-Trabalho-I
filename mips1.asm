.data
programa:    .asciiz "Programa Ackermann\n"
componentes:    .asciiz "Thiago Zilberknop, Leonardo Chou da Rosa\n"
str_1:        .asciiz "Digite um valor positivo para executar o programa ou um valor negativo para encerrar.\n"
str_2:        .asciiz "A("
str_3:        .asciiz ", "
str_4:        .asciiz ") = "
str_5:        .asciiz    "\n"

.macro    print()
        li    $v0, 4            # Comando de print
        la    $a0, str_2        # print(str_2)
        syscall            
        li    $v0, 1    
        add    $a0, $zero, $t0        # print(m)
        syscall
        li    $v0, 4
        la    $a0, str_3        # print(s
        syscall
        li    $v0, 1
        add    $a0, $zero, $t1
        syscall
        li    $v0, 4
        la    $a0, str_4
        syscall
        li    $v0, 1
        add    $a0, $zero, $t3
        syscall
        li    $v0, 4
        la    $a0, str_5
        syscall
.end_macro
        

.text
    .globl main

main:        li    $v0, 4            # Impressao do titulo, componentes
        la    $a0, programa        
        syscall                
        la    $a0, componentes    
        syscall
                        
inicio:        la    $a0, str_1        
        syscall                
                        
        li    $v0, 5            # Leitura de M
        syscall
        blt    $v0, $zero, end
        move    $t0, $v0
        li    $v0, 5            # Leitura de N
        syscall
        blt    $v0, $zero, end
        move    $t1, $v0
    
        addi    $sp, $sp, -12        # Abre 3 posições na pilha
        sw    $t0, 0($sp)        # Guarda M na pilha
        sw    $t1, 4($sp)        # Guarda N na pilha
        jal    ackermann        # Chamada da func recursiva
        move    $t3, $v0        # Guarda resultado de ackermann em $t3
        print()                # macro de print
        j    inicio            # reinicia o programa
        
end:        li    $v0, 10
        syscall    

# -- Funcao Ackermann --

ackermann:    sw    $ra, 8($sp)        # Guarda o endereço de retorno do jal
        lw    $s0, 0($sp)        # Carrega M em $s0
        lw    $s1, 4($sp)        # Carrega N em $s1
        beq    $s0, $zero, m_zero    # M = 0
        beq    $s1, $zero, n_zero    # M > 0 && N = 0
        j    m_n            # M > 0 && N > 0


m_zero:        addi    $v0, $s1, 1        # retorno = n + 1
        j    retorno    

n_zero:        addi    $s0, $s0, -1        # M - 1
        add    $s1, $zero, 1        # N = 1
        addi    $sp, $sp, -12        # Aloca 3 espaços na pilha
        sw    $s0, 0($sp)        # M
        sw    $s1, 4($sp)        # N
        jal    ackermann        # Chamada recursiva        
        j    retorno
        

m_n:        addi    $s1, $s1, -1        # N - 1
        addi    $sp, $sp, -12        # Abre 3 espaços na pilha
        sw    $s0, 0($sp)        # M
        sw    $s1, 4($sp)        # N
        jal    ackermann        # Chamada recursiva [ A(m, n-1) ]
        lw    $s0, 0($sp)        # Resgata o valor original de M
        addi    $s0, $s0, -1        # M - 1
        addi    $sp, $sp, -12        # Abre 3 espaços na pilha
        sw    $s0, 0($sp)        # M
        sw    $v0, 4($sp)        # N ( resultado da chamada recursiva )
        jal    ackermann        # Chamada recurisva [ A(m-1, A(m, n-1) ]
        j     retorno
        
        
        
        
retorno:    lw    $ra, 8($sp)        # Resgata end. de retorno
        addi    $sp, $sp, 12        # Desaloca a pilha
        jr    $ra            # Retorna
