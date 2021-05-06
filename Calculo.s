/* Universidad del Valle de Guatemala
   Organización de Computadoras y Assembler
   Alejandro Jose Gomez Hernandez 20347
   Gabriela Paola Contreras Guerra 20213*/
   
.global main
.type main,%function

main:
	stmfd sp!,{lr}
	
	/*Bienvenida*/
		ldr r0,=stringwelcome
		bl printf
	Menu:
		ldr r0,=stringmenu
		bl puts
		ldr r0,=stringIngreso
		bl puts
		ldr r0,= opcion
		ldr r1,=comando
		bl scanf
		
	OpcionesMenu:
		ldr r4,=comando
		ldrb r4,[r4]
		
		cmp r4, #'+'
		beq Calculo1
		
		cmpne r4, #'*'
		beq Calculo2
		
		cmpne r4, #'='
		beq Res
		
		cmpne r4, #'1'
		beq Operacion1c
		
		cmpne r4, #'2'
		beq Operacion2c
		
		cmpne r4, #'C'
		beq Concatenar
		
		cmpne r4, #'q'
		beq Fin
	
	
	Calculo1:
		/*Ingreso de un numero por el usuario 
		ldr r0,=ingreso_op 	
		bl puts
		ldr r0, =formatos
		ldr r1,=datoIng
		bl scanf*/
		
		//validacion
		cmp r0,#0
		beq Error
		
		//Operacion
		bl suma 
		
		@guarda valor
		ldr r0,= resultado 
		str r1,[r0]
		ldr r1,=dato2
		ldr r1,[r1]
	
		b Menu
	
	Calculo2:
		@ingreso
		/*ldr r0,=ingreso_op
		bl puts
		bl scanf
		ldr r0, =formatos
		ldr r1,=op2
		bl scanf*/
		
		@validacion
		cmp r0,#0
		beq Error
		
		@calculo
		bl multiplicacion
		
		@guarda y regresa
		str r8,[r6]
		ldr r0,=resultado
		ldr r1,=op1
		ldr r1,[r1]
		bl printf
		b Menu
		
	Operacion1c:
		ldr r0,=ingreso_da	
		bl puts
		ldr r0, =cadena
		ldr r1,=cadIng
		bl scanf
		ldr r6,=cadIng
		ldr r6,[r6]
		//Mov r6,r1
		b Menu

	Operacion2c:
		ldr r0,=ingreso_da	
		bl puts
		ldr r0, =cadena2
		ldr r1,=cadIng
		bl scanf
		ldr r7,=cadIng
		ldr r7,[r7]
		//Mov r7,r1
		b Menu
		
	Concatenar:
		ldr r1,[r6]
		ldr r0,= cadena
		bl printf
		ldr r1,[r7]
		ldr r0,=cadena2
		bl printf
		
	Res:
		/*carga, muestra y regresa*/
		ldr r0,=resultado
		ldr r1,=dato2
		ldr r1,[r1]
		bl printf
		b Menu
	
	/*salto para error de num*/
	Error:
		ldr r0,=error
		bl puts
		bl getchar
		b OpcionesMenu
	
	Fin:
		ldr r0,=salida
		bl puts
		mov r0, #0
		mov r3, #0
		ldmfd sp!, {lr}
		bx lr





.data
.align 2

formato_final:		.asciz "El resultado de la opcion selecionada es: %d\n"
datoIng:			.word	0 /*Dato ingresado por el usuario*/
cadIng:				.asciz "                           "
dato2:				.word	0 /*Almacena Resultado*/


formatos:			.asciz	"%d"
comando:			.byte 	0
op1: 				.word 0
op2: 				.word 0
opcion:				.asciz "%c" /*Opciones del menu*/
cadena:				.asciz "%s"
cadena2:			.asciz "%s\n"


				/*Messages that are showed to the user*/
stringwelcome:	.asciz "-------Bienvenido a la calculadora------\n"
stringmenu:		.asciz " + Suma\n * Multiplicación\n M Módulo\n P Potencia\n = Mostrar Resultado \n 1 Ingresar una cadena \n 2 Ingresar segunda cadena \n C Concatenar cadenas \n q Salir \n"
stringIngreso:	.asciz	"Ingrese una opcion: "
resultado: 		.asciz "La respuesta es: %d\n"
ingreso_op: 	.asciz "Ingrese un valor: "
ingreso_da: 	.asciz "Ingrese un dato: "
error:			.asciz	"Error, intente nuevamente."
salida:			.asciz	"Gracias por utilizar este programa. Pase feliz dia"