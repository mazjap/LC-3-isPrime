;  isPrime
;  Jordan Christensen
;  Project 3
;  

			.ORIG x3000		; Main - 5 separate subprocesses
			AND R5, R5, #0
			AND R6, R6, #0
			JSR startFresh
			JSR input
			JSR startFresh
			JSR divideTwo
			JSR prePrime
			JSR testPrime

;
startFresh		AND R0, R0, #0		; Sets R0-4 to 0
			AND R1, R1, #0
			AND R2, R2, #0
			AND R3, R3, #0
			AND R4, R4, #0
			RET
;
input			LEA R0, n100		; Takes user input in the form of 3 digits
			PUTS
			IN
			JSR getDec
			LD R1, val100
			AND R4, R4, #0
			JSR multiplyR1
			ADD R5, R4, #0

			LEA R0, n10
			PUTS
			IN
			JSR getDec
			LD R1, val10
			AND R4, R4, #0
			JSR multiplyR2
			ADD R5, R5, R4

			LEA R0, n1
			PUTS
			IN
			JSR getDec

			ADD R5, R5, R0
			
			AND R7, R7, #0
			LD R7, startReturn
			ADD R7, R7, #4
			JMP R7
;
getDec			LD R4, A		; Changes the user's input from ASCII to decimal
			NOT R4, R4
			ADD R4, R4, #1
                       	ADD R0, R4, R0
                       	RET
;
multiplyR1		ADD R4, R4, R0		; Takes first digit provided and multiplies it by 100 for the 100's place
			ADD R1, R1, #-1
			BRp multiplyR1
			RET
;
multiplyR2		ADD R4, R4, R0		; Takes second digit provided and multiplies it by 10 for the 10's place
			ADD R1, R1, #-1
			BRp multiplyR2
			RET
;
prePrime		AND R1, R1, #0		; Code that prepares the testPrime subprocess
			ADD R1, R1, #-2
			ADD R3, R5, #0
			RET
;
testPrime		ADD R3, R3, R1		; Tests to see if user's number is prime
			BRp testPrime
			BRz notPrime
			JSR incrementPrime
;
incrementPrime		ADD R3, R5, #0 		; Increments the current value being tested
			ADD R1, R1, #-1
			AND R4, R4, #0
			ADD R4, R1, R6
			BRnz isPrime
			JSR testPrime
;
divideTwo		NOT R6, R5		; Finds the user's number divided by two, useful in testPrime
			ADD R6, R6, #1
			AND R3, R3, #0
			ADD R1, R1, #2
			ADD R0, R0, #1
			ADD R3, R6, R1
			BRn divideTwo
			AND R6, R6, #0
			ADD R6, R0, #0
			JSR startFresh
			
			LD R7, startReturn
			ADD R7, R7, #6
			JMP R7
;
notPrime		LEA R0, notP		; Prints out string if testPrime came out false
			PUTS
			HALT
;
isPrime			LEA R0, isP		; Prints out string if testPrime came out true
			PUTS
			HALT
;
A			.FILL #48
startReturn		.FILL x3000
val100			.FILL #100
val10			.FILL #10
n100			.STRINGZ "Enter Hundreds Place Digit (If none, press enter):\n"
n10			.STRINGZ "\nEnter Tens Place Digit (If none, press enter):\n"
n1			.STRINGZ "\nEnter Ones Place Digit (If none, press enter):\n"
notP			.STRINGZ "\nThis number is not prime :(\n"
isP			.STRINGZ "\nThis number is prime!\n"
;
			.END