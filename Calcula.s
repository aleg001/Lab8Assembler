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
	cmp r0,#0
	
	//Store 
	ldr r2,=opcion
	ldr r2,[r2]
	
	bne menu
	bl getchar	/*para que el programa lea <enter> para continuar*/
	ldr r0,=error
	bl puts
	b opcionMenu
	
	
	menu:
		cmp r2,#2
		blt calculo1
		beq calculo2
		bgt mostrar	
		
	
	
	calculo1:
		ldr r0,=datoIng
		ldr r0,[r0]  //empuja parametro a r0
		ldr r1,=dato2
		ldr r1,[r1]
		bl modulo	
		mov r1,r0
	  
		bl opcionMenu
		
	mostrar:
		ldr r0,=formatocua	// formato cuadrado  
		bl printf

		bl random
		mov r1,r0
		ldr r0,=formatos
		
		b opcionMenu
	
	calculo2:
		ldr r0,=datoIng
		ldr r0,[r0]  //empuja parametro a r0
		ldr r1,=dato2
		ldr r1,[r1]
		bl potencia
		mov r1,r0
		ldr r0,=formatomulcua
		bl printf

		bl random
		mov r1,r0
		ldr r0,=formatos
	
		b opcionMenu 

/**** SALIDA DEL PROGRAMA ******/
	fin:
		mov r3,#0
		mov r0,#0
		ldmfd sp!,{lr}
		bx lr
	
.data
.align 2
datoPromedio:	.word	0 /*Almacena el promedio de los dos numeros*/
formatocua:		.asciz "La division de los numeros es: %d  \n"
formatomulcua:		.asciz "La multiplicacion del cuadrado de los numeros es: %d  \n"
datoIng:		.word	0 /*Dato ingresado por el usuario*/
dato2:			.word	3
opcion:			.word 	0

formatos:		.asciz	"%d"
stringmenu:		.asciz " 1. Suma de cuadrados (+)\n 2. Multiplicacion (*)\n 4. Modulo (M)\n 5. Potencia de numero (P)\n 6. Mostrar resultado (=)\n 7. Primer ingreso (1)\n 8. Segundo ingreso (2)\n 9. Concatenar (C)\n 10. Salir (q)\n Ingrese una opcion:\n"
stringIngreso:	.asciz	"Ingrese un comando: "
error:			.asciz	"Error, el dato ingres. Intente nuevamente."
salida:			.asciz	"Gracias por utilizar este programa. Pase feliz dia"