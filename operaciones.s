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
	
.global modulo
modulo:
	mov r2,#0
	cmp r1,r0
	sub r1,r0
	add r2,#1
	mov pc, lr
	b modulo
	
.global potencia

/* Se define la subrutina correspondiente al proceso de potenciar */
potencia:
	mul r4,r0,r0
	mul r5,r1,r1
	add r0,r4,r5
	mov pc,lr


.global concatenar
concatenar: