/* Universidad del Valle de Guatemala
   Organización de Computadoras y Assembler
   Alejandro Jose Gomez Hernandez 20347*
   Gabriela Paola Contreras Guerra 20213*/
   
/**********************************************************************/
@Parametros de entrada:
@r0: numero 1
@r1: numero 2
@Parametros de salida
@r0: resultado
/**********************************************************************/


.global suma

/* Se define la subrutina correspondiente al proceso de suma */
suma:

	add r4,r1,r0
	mov r0,r4
	mov pc,lr


/* Se define la subrutina correspondiente al proceso de multiplicacion */

.global multiplicacion
multiplicacion:
	mul r4,r1,r0
	mov r0,r4
	mov pc,lr


	
/* Se define la subrutina correspondiente al proceso de modulo*/
.global modulo
modulo:
		mov r7,#0 /*contador*/
		mov r8,r0
	division:
		cmp r0,r1
		bgt salirDiv
		sub r1,r0
		add r7,#1
		b division

	salirDiv:
		mul r0,r0,r7
		mov r6,r8
		sub r6,r1
		mov r0,r6

	
/* Se define la subrutina correspondiente al proceso de potenciar */

.global potencia
potencia:
	eleva:
		mul r1,r1,r1
		sub r0,#1
		cmp r0,#0 
		bge saleleva

	saleleva: 
		mov r0,r1
		mov pc,lr
