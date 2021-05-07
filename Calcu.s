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
		
		cmp r4, #'*'
		beq Calculo2
		
		cmp r4,#'P'
		beq Calculo3
		
		cmp r4, #'M'
		beq Calculo4
		
		cmp r4, #'='
		beq Mostrar
		
		cmp r4, #'1'
		beq Operacion1c
		
		cmp r4, #'2'
		beq Operacion2c
		
		cmp r4, #'C'
		beq Concatenar
		
		cmp r4, #'q'
		beq Fin
		bne ErrorCar
	
	
	Calculo1:
		/*Ingreso de un numero por el usuario*/
		ldr r0,=ingreso_op 
		bl puts
		ldr r0, =FormatoIng
		ldr r1,=datoI 
		bl scanf
		
		// Validación 
		cmp r0,#0
		beq Error
		bl getchar
		
		//Carga de datos 
		ldr r0,=datoI
		ldr r0,[r0]
		ldr r1,=dato2
		ldr r1,[r1]
		
		//Operacion
		bl suma 
		mov r1,r0
		
		@guarda valor
		ldr r0,= resultado 
		ldr r2,= dato2 
		str r1,[r2]
		//bl printf
		b Menu
		
	Calculo2:
		/*Ingreso de un numero por el usuario*/
		ldr r0,=ingreso_op 
		bl puts
		ldr r0, =FormatoIng
		ldr r1,=datoI 
		bl scanf
		
		// Validación 
		cmp r0,#0
		beq Error
		bl getchar
		
		//Carga de datos 
		ldr r0,=datoI
		ldr r0,[r0]
		ldr r1,=dato2
		ldr r1,[r1]
		
		//Operacion
		bl multiplicacion 
		mov r1,r0
		
		@guarda valor
		ldr r0,= resultado 
		ldr r2,= dato2 
		str r1,[r2]
		//bl printf
		b Menu
		
	Calculo3:
			/*Ingreso de un numero por el usuario*/
		ldr r0,=ingreso_op 
		bl puts
		ldr r0, =FormatoIng
		ldr r1,=datoI 
		bl scanf
		
		// Validación 
		cmp r0,#0
		beq Error
		bl getchar
		
		//Carga de datos 
		ldr r0,=datoI
		ldr r0,[r0]
		ldr r1,=dato2
		ldr r1,[r1]
		
		//Operacion
		bl potencia 
		mov r1,r0
		
		@guarda valor
		ldr r0,= resultado 
		ldr r2,= dato2 
		str r1,[r2]
		//bl printf
		b Menu

Calculo4:
			/*Ingreso de un numero por el usuario*/
		ldr r0,=ingreso_op 
		bl puts
		ldr r0, =FormatoIng
		ldr r1,=datoI 
		bl scanf
		
		// Validación 
		cmp r0,#0
		beq Error
		bl getchar
		
		//Carga de datos 
		ldr r0,=datoI
		ldr r0,[r0]
		ldr r1,=dato2
		ldr r1,[r1]
		
		//Operacion
		bl modulo  
		mov r1,r0
		
		//Guarda valor
		Mov r1,r2 
		ldr r0,= resultado 
		//bl printf
		b Menu
	
	Mostrar:
		ldr r0,= resultado 
		ldr r1,=dato2
		ldr r1,[r1]
		bl printf
		bl getchar
		b Menu
		
	Operacion1c:
		ldr r0,=ingreso_da	
		bl puts
		
		ldr r0, =cadena
		ldr r1,=cadIng
		bl scanf
		bl getchar
		
		ldr r1,=cadIng
		ldr r1,[r1]

		//Mov r6,r1
		b Menu



	Operacion2c:
		ldr r0,=ingreso_da	
		bl puts
		ldr r0, =cadena
		ldr r1,=cadIng
		bl scanf
		bl getchar
		
		ldr r7,=cadIng
		ldr r7,[r7]
		//Mov r7,r1
		b Menu
		
	Concatenar:
		ldr r0,= cadena
		ldr r1,[r6]
		bl printf
		ldr r0,=cadena2
		ldr r1,[r7]
		bl printf
		
/************************ PROGRA DEFENSIVA ****************************/
	
	/*Error de ingreso si el caracter ingresado no es valido*/
	ErrorCar:
		ldr r0,=error
		bl puts
		bl getchar
		b Menu

	
	/*Error de ingreso si el dato ingresado no es valido*/
	Error:
		ldr r0,=error
		bl puts
		bl getchar
		b Menu
		
/********************* SALIDA DEL PROGRAMA *****************************/
	Fin:
		ldr r0,=salida
		bl puts
		mov r0, #0
		mov r3, #0
		ldmfd sp!, {lr}
		bx lr

/******************************* DATOS*********************************/

.data
.align 2

datoI:				.word	0 /*Dato ingresado por el usuario*/
cadIng:				.asciz "                           "
dato2:				.word	0 /*Almacena Resultado*/


FormatoIng:			.asciz	"%d"
comando:			.byte 0
opcion:				.asciz "%c" /*Opciones del menu*/
cadena:				.asciz "%s"
cadena2:			.asciz "%s\n"


				/*Messages that are showed to the user*/
stringwelcome:	.asciz "-------Bienvenido a la calculadora------\n"
stringmenu:		.asciz "\n + Suma\n * Multiplicación\n M Módulo\n P Potencia\n = Mostrar Resultado \n 1 Ingresar una cadena \n 2 Ingresar segunda cadena \n C Concatenar cadenas \n q Salir \n"
stringIngreso:	.asciz	"Ingrese una opcion: "
resultado: 		.asciz "La respuesta es: %d\n"
ingreso_op: 	.asciz "Ingrese un número: "
ingreso_da: 	.asciz "Ingrese un dato: "
error:			.asciz	"Error, intente nuevamente."
salida:			.asciz	"Gracias por utilizar este programa. Pase feliz dia"
