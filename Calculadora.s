/* Universidad del Valle de Guatemala
   Organización de Computadoras y Assembler
   Alejandro Jose Gomez Hernandez 20347
   Gabriela Paola Contreras Guerra 20213*/
   
.global main
.type main,%function

main:
	stmfd sp!,{lr} 	/*Inicio del programa */
	
	/*Bienvenida*/
		ldr r0,=stringwelcome
		bl printf
		
	/* Se define para el menu el ingreso */
	Menu:
		ldr r0,=stringmenu
		bl puts
		ldr r0,=stringIngreso
		bl puts
		ldr r0,= opcion
		ldr r1,=comando
		bl scanf
		
	/* Funciona como ciclo de comprobacion,
		cada comparacion tira a una opcion */
	OpcionesMenu:
		ldr r4,=comando 
		ldrb r4,[r4]
		
		cmp r4, #'+'  // suma
		beq Calculo1
		
		cmp r4, #'*'  // multiplicacion 
		beq Calculo2
		
		cmp r4,#'P'  // potencia
		beq Calculo3
		
		cmp r4, #'M'  // Modulo 
		beq Calculo4
		
		cmp r4, #'=' // Resultado 
		beq Mostrar
		
		cmp r4, #'1'	// Ingresar 1 cadena 
		beq Operacion1c
		
		cmp r4, #'2'  // Ingresar 2 cadena 
		beq Operacion2c
		
		cmp r4, #'C' 	// Juntar cadenas 
		beq Concatenar
		
		cmp r4, #'q'	// salir programa 
		beq Fin
		bne ErrorCar
	
	/****************************** ETIQUETAS QUE REALIZAN LOS CALCULOS ***********************************/
	/* Se realiza el proceso de suma */
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
		
		/* Se realiza el proceso de multiplicacion */
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
		
		/* Se realiza el proceso de potencia */
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
		bl printf
		b Menu

	/* Se realiza el proceso de modulo */
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
		bl modulo   // llamado a subrutina 
		mov r1,r0
		
		//Guarda valor
		Mov r1,r2 
		ldr r0,= resultado 
		//bl printf
		b Menu
	
		/* Se muestra resultado */
	Mostrar:
		ldr r0,= resultado 
		ldr r1,=dato2 // carga resultado a r1
		ldr r1,[r1] 
		bl printf 
		bl getchar
		b Menu
		
			/* Se ingresa el primer string */
	Operacion1c:
	/*Ingresar datos el usuario */
        ldr r0,=ingreso_da
        bl puts

        ldr r0, =cadena
        ldr r1,=cadIng
        bl scanf
        bl getchar
	/* Cargar y guardar string  */
        ldr r1,=cadIng
        ldr r1,[r1]

        //Mov r6,r1
        b Menu

/* Se ingresa el segundo string */
    Operacion2c:
		/*Ingresar datos el usuario */
        ldr r0,=ingreso_da
        bl puts
        ldr r0, =cadena
        ldr r1,=cadIng2
        bl scanf
        bl getchar
	/* Cargar y guardar string  */
        ldr r7,=cadIng2
        ldr r7,[r7]
        
		//Mov r7,r1
        b Menu

/* Se concatena los strings */
    Concatenar:
	// movimiento de registros 
        mov r6, r0
        mov r7, r1
    // carga de datos
	    ldr r0,= cadIng
        mov r1, r6
	// impresion 
        bl printf
        bl getchar
	// carga de datos 
        ldr r0,= cadIng2
        mov r1,r7
	// impresion 
        bl printf
        bl getchar

        b Menu
		
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

/********* Datos que almacenan un valor */
datoI:				.word	0 /*Dato ingresado por el usuario*/
cadIng:				.asciz "                           " // cadena 1
cadIng2:			.asciz "                           " // cadena 2 
dato2:				.word	0 /*Almacena Resultado*/

/************************ FORMATOS *****************************/
FormatoIng:			.asciz	"%d"
comando:			.byte 0
opcion:				.asciz "%c" /*Opciones del menu*/
cadena:				.asciz "%s"
cadena2:			.asciz "%s\n"


/**************** Messages that are showed to the user ***************/
stringwelcome:	.asciz "-------Bienvenido a la calculadora------\n"
stringmenu:		.asciz "\n + Suma\n * Multiplicación\n M Módulo\n P Potencia\n = Mostrar Resultado \n 1 Ingresar una cadena \n 2 Ingresar segunda cadena \n C Concatenar cadenas \n q Salir \n"
stringIngreso:	.asciz	"Ingrese una opcion: "
resultado: 		.asciz "La respuesta es: %d\n"
ingreso_op: 	.asciz "Ingrese un número: " 
ingreso_da: 	.asciz "Ingrese un dato: "
error:			.asciz	"Error, intente nuevamente."
salida:			.asciz	"Gracias por utilizar este programa. Pase feliz dia"
