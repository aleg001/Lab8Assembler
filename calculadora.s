/* Universidad del Valle de Guatemala
   Organización de Computadoras y Assembler
   Alejandro Jose Gomez Hernandez 20347*
   Gabriela Paola Contreras Guerra 20213*/
   
.global main
.type main,%function

main:
	stmfd sp!,{lr}
	/*Ingreso de un numero por el usuario*/
	ingresoDatos:
		ldr r0,=stringIngreso
		bl puts
		ldr r0,=formatos
		ldr r1,=datoIng
		bl scanf
			
	/*Ingreso de la opcion del menu */
	opcionMenu:
		ldr r0,=stringmenu
		bl puts
		ldr r0,=formatos
		ldr r1,=opcion
		bl scanf
		
	/*Programacion defensiva
	Revisa que el numero ingresado sea correcto*/
	//Store 
	ldr r5,=opcion
	ldrb r5,[r2]
	bne escoger
	bl getchar	/*para que el programa lea <enter> para continuar*/
	b opcionMenu
	
	escoger:
	
	/* Se utiliza cmp para la comparacion de lo ingresado con coincidencias en registros */
	/* Suma */
	cmp r2,#'+'
	beq calculo1
	
	/* Multiplicacion */
	cmp r2,#'*'
	beq calculo2
	
	/* Modulo division */
	cmp r2,#'M'
	beq calculo3
	
	/* Potencia de un numero */
	cmp r2,#'P'
	beq calculo4
	
	/* Mostrar resultado */
	cmp r2,#'='
	beq mostrar
	
	/* Cadena #1 */
	cmp r2,#1
	beq calculocad1
	
	/* Cadena #2 */
	cmp r2,#2
	beq calculocad2
	
	/* Concatenar */
	cmp r2,#'C'
	beq calculocon
	
	/* Salir del programa */
	cmp r2,#'q'
	b fin

	
	calculo1:
	/* Se realiza proceso de suma */
		ldr r0,=datoIng
		ldr r0,[r0]  //empuja parametro a r0
		ldr r1,=resultado 
		ldr r1,[r1]
		bl suma
		mov r1,r0
	
		b opcionMenu 
		
	calculo2:
	/* Se realiza proceso de mutltiplicacion */
		ldr r0,=datoIng
		ldr r0,[r0]  //empuja parametro a r0
		ldr r1,=resultado
		ldr r1,[r1]
		bl multiplicacion
		mov r1,r0
		
	calculo3:
		/* Se realiza proceso de divison para modulo */
		ldr r0,=datoIng
		ldr r0,[r0]  //empuja parametro a r0
		ldr r1,=resultado
		ldr r1,[r1]
		bl modulo
		mov r1,r0
	
	calculo4:
		ldr r0,=datoIng
		ldr r0,[r0]  //empuja parametro a r0
		ldr r1,=resultado
		ldr r1,[r1]
		bl potencia
		mov r1,r0
	
	mostrar:
		ldr r0,=formato	// formato cuadrado  
		bl printf
		
	calculocad1:
		/*Lectura y carga de nombre*/
		ldr r0,=stringConc
		bl puts

		ldr r0,= formato2
		ldr r1,=cadena_1
		bl scanf

		ldr r4,=cadena_1
		ldr r4,[r4]
		
	calculocad2:
		ldr r0,=stringConc
		bl puts

		ldr r0,= formato2
		ldr r1,=cadena_2
		bl scanf

		ldr r5,=cadena_2
		ldr r5,[r5]
		
	calculocon:
		add r0,r5,r4
	
	fin:
		mov r3,#0
		mov r0,#0
		ldmfd sp!,{lr}
		bx lr
	
		
	
	
	
		
.data
.align 2
datoPromedio:	.word	0 /*Almacena el promedio de los dos numeros*/
formato:		.asciz "El resultado de la operacion solicitada es: %d  \n"
formato2: 		.asciz "%s"

datoIng:		.word	0 /*Dato ingresado por el usuario*/
resultado:		.word	0

/*Seleccionar opcion del menu*/
opcion:			.byte 	0

formatos:		.asciz	"%d"
stringmenu:		.asciz "-------Bienvenido a la calculadora------\n + Suma\n * Multiplicación\n M Módulo\n P Potencia\n = Mostrar Resultado \n 1 Ingresar una cadena \n 2 Ingresar segunda cadena \n C Concatenar cadenas \n q Salir \n"
stringIngreso:	.asciz	"Ingrese un numero: "
stringConc:		.asciz "Ingrese la cadena de texto"
cadena_1:
	.asciz "          "
cadena_2:
	.asciz "          "
error:			.asciz	"Error, el dato ingresado es incorrecto. Intente nuevamente."
salida:			.asciz	"Gracias por utilizar este programa. Pase feliz dia"