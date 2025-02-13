.data
	start: .asciiz "\nPlease input an integer value greater than or equal to 0:"
	error1: .asciiz "The value you entered is less than zero. This program only works with values greater than or equal to zero."
	out1: .asciiz "Your Input:"
	out2: .asciiz "\nThe factorial is:"
	repeat: .asciiz "\nWould you like to do this again (Y/N):"

.text
.globl main
	main:
		li $v0, 4 #System call for printing
		la $a0, start #load address of starting prompt
		syscall
		
		li $v0, 5 #System call for reading integers
		syscall
		move $t0, $v0
		
		bltz $t0, error #Exit if value less than 0
		
		move $a0, $t0 #move input value to a0 register
		jal factorial
		move $t1, $v0 #save factorial 
		
		li $v0, 4 #system call for print string
		la $a0, out1 #load address of first output prompt
		syscall
		
		li $v0, 1 #system call to print integers
		move $a0, $t0 #load input value to print
		syscall
		
		li $v0, 4  #system call to print string
		la $a0, out2  #load the address of the second output prompt
		syscall
		
		li $v0, 1 #system call to print integers
		move $a0, $t1 #load the result to print
		syscall
		
		li $v0, 4 #system call to print string
		la $a0, repeat #load prompt for repeating
		syscall
		
		li $v0, 12 #read single character from the user
		syscall
		move $t1, $v0
		
		beq $t1, 89, main #reloop through the code if input is 'Y'
		
		li $v0, 10 #program termination
		syscall
		
	error:
		li $v0, 4 #system call for printing
		la $a0, error1 #load address of error message 
		syscall
		
		li $v0, 10 #system call for termination
		syscall
	
	factorial:
		#Base Case
		li $v0, 1
		beqz $a0, exit_fac 
		
		subi $sp, $sp, 8 #make space on stack
		sw $ra, 4($sp) #save return address on stack
		sw $a0, 0($sp)
		
		subi $a0, $a0, 1 #decrement input by 1 for the recursive call
		jal factorial
		
		lw $ra, 4($sp) #restore the return address
		lw $a0, 0($sp)
		addi $sp, $sp, 8 #restore the stack pointer
		

		mul $v0, $a0, $v0 #multiply recursive call result by initial input
		
		
	
	exit_fac:
		jr $ra #jump back to calling function				