//
// Ejercicio_3.asm
// Modifica tu programa para que muestre el resultado en unidades y decenas. Esto quiere decir que
// el resultado en vez de mostrarse de la siguiente forma
//  Kennia J. S·nchez Castillo 
//
    Radix	Dec		    // Selecionar decimal como base numerica
    Processor	18F45K50	    // Selecionar procesador a utilizar
    #include	"pic18f45k50.inc"   // Incluir librerias de PIC18F45K50
    
//
//  Memory Allocation
//
    PSECT resetVec, class=CODE, reloc=2, abs
    org	0			    // Ir al espacio de memoria 0 para comenzar
//
// Reset Vector
//
resetVec:
    org		32		    // Guardar programa desde el espacio de memoria 0020
    VARA	equ 1		    // Variable Contador
    VARB	equ 2		    // Variable Contador
    Num1	equ 3		    // Variable para guardar el primer digito
    Num2	equ 4		    // Variable para guardar el segundo digito
    Aux		equ 5		    // Variable para checar si esta ocupado 
    Aux2	equ 6		    // Variable auxiliar para division
    Resultado   equ 7		    // Variable del resultado de las operaciones
    Decenas	equ 8		    // Variable Decenas
    Unidades	equ 9		    // Varible Centenas
    Diez	equ 10		    // Variable = 10
    Nueve	equ 11		    // Variable = 9
    Aux3	equ 12
    Aux4	equ 13
    goto Start			    // Saltar a seccion de Start

Start:
    movlb 15
    clrf TRISB,A		    // Teclado Matricial
    clrf TRISD,A		    // Leds
    clrf LATD,A
    clrf LATA,A
    movlw 9
    movwf Nueve,A
    movlw 10
    movwf Diez,A
    clrf Aux3,A
    clrf Aux4,A
    
// CONFIGURACIONES PARA UN TECLADO MATRICIAL
    bcf INTCON2,7,A
    movlw 0b00001111
    movwf TRISB,A
    movwf WPUB,A
    
Revisar_Columna_1:
    movlw 0b11101111			    // Carga ese numero para checar la columna 1
    movwf LATB,A
    btfss PORTB,0,A			    // Columna 1, Fila 1
	call Boton_1
	btfss PORTB,1,A			    // Columna 1, Fila 2
	    call Boton_4
	    btfss PORTB,2,A		    // Columna 1, Fila 3
		call Boton_7
		btfss PORTB,3,A		    // Columna 1, Fila 4
		    call Boton_E
  
Revisar_Columna_2:
    movlw 0b11011111			    // Carga ese numero para checar la columna 2
    movwf LATB,A
    btfss PORTB,0,A			    // Columna 2, Fila 1
	call Boton_2
	btfss PORTB,1,A			    // Columna 2, Fila 2
	    call Boton_5
	    btfss PORTB,2,A		    // Columna 2, Fila 3
		call Boton_8
		btfss PORTB,3,A		    // Columna 2, Fila 4
		    call Boton_0
		    
Revisar_Columna_3:
    movlw 0b10111111			    // Carga ese numero para checar la columna 3
    movwf LATB,A
    btfss PORTB,0,A			    // Columna 3, Fila 1
	call Boton_3
	btfss PORTB,1,A			    // Columna 3, Fila 2
	    call Boton_6
	    btfss PORTB,2,A		    // Columna 3, Fila 3
		call Boton_9
		btfss PORTB,3,A		    // Columna 3, Fila 4
		    call Boton_F
		    
Revisar_Columna_4:
    movlw 0b01111111			    // Carga ese numero para checar la columna 4
    movwf LATB,A
    btfss PORTB,0,A			    // Columna 4, Fila 1
	call Boton_A
	btfss PORTB,1,A			    // Columna 4, Fila 2
	    call Boton_B
	    btfss PORTB,2,A		    // Columna 4, Fila 3
		call Boton_C
		btfss PORTB,3,A		    // Columna 4, Fila 4
		    call Boton_D
		    bra Revisar_Columna_1    // Avanza hasta que este presionado un boton
		    
Boton_1:
    call Delay_1s
    btfss PORTB,0,A			    // Checa si sigue presionado el boton
	bra Boton_1
	
	movlw 1				    // Manda 1 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
    
Boton_2:
    call Delay_1s
    btfss PORTB,0,A			    // Checa si sigue presionado el boton
	bra Boton_2
	
	movlw 2				    // Manda 2 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
	
Boton_3:
    call Delay_1s
    btfss PORTB,0,A			    // Checa si sigue presionado el boton
	bra Boton_3
	
	movlw 3				    // Manda 3 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
    
Boton_4:
    call Delay_1s
    btfss PORTB,1,A			    // Checa si sigue presionado el boton
	bra Boton_4
	
	movlw 4				    // Manda 4 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
	
Boton_5:
    call Delay_1s
    btfss PORTB,1,A			    // Checa si sigue presionado el boton
	bra Boton_5
	
	movlw 5				    // Manda 5 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
	
Boton_6:
    call Delay_1s
    btfss PORTB,1,A			    // Checa si sigue presionado el boton
	bra Boton_6
	
	movlw 6				    // Manda 6 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
	
Boton_7:
    call Delay_1s
    btfss PORTB,2,A			    // Checa si sigue presionado el boton
	bra Boton_7
	
	movlw 7				    // Manda 7 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
	
Boton_8:
    call Delay_1s
    btfss PORTB,2,A			    // Checa si sigue presionado el boton
	bra Boton_8
	
	movlw 8				    // Manda 8 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
	
Boton_9:
    call Delay_1s
    btfss PORTB,2,A			    // Checa si sigue presionado el boton
	bra Boton_9
	
	movlw 9				    // Manda 9 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
	
Boton_0:
    call Delay_1s
    btfss PORTB,3,A			    // Checa si sigue presionado el boton
	bra Boton_0
	
	movlw 0				    // Manda 0 a los leds
	movwf LATD,A
	call Guardar_Numero
	return
	
Boton_A:				    // SUMA
    call Delay_1s
    btfss PORTB,0,A			    // Checa si sigue presionado el boton
	bra Boton_A
	
	clrf LATA,A
	bsf LATA,4,A			    // Led para checar que entro a Suma
	bsf Aux,7,A			    // Variable auxiliar para guardar un numero al momento de presionar una operacion
	bsf Aux,0,A			    // Variable auxiliar para checar que operacion se presiono
	
	return
	
Boton_B:
    call Delay_1s
    btfss PORTB,1,A			    // Checa si sigue presionado el boton
	bra Boton_B
	
	clrf LATA,A
	bsf LATA,5,A			    // Led para checar que entro a Suma
	bsf Aux,7,A			    // Variable auxiliar para guardar un numero al momento de presionar una operacion
	bsf Aux,1,A			    // Variable auxiliar para checar que operacion se presiono
	
	return
	
Boton_C:
    call Delay_1s
    btfss PORTB,2,A			    // Checa si sigue presionado el boton
	bra Boton_C
	
	clrf LATA,A
	bsf LATA,6,A			    // Led para checar que entro a Suma
	bsf Aux,7,A			    // Variable auxiliar para guardar un numero al momento de presionar una operacion
	bsf Aux,2,A			    // Variable auxiliar para checar que operacion se presiono
	
	return
	
Boton_D:
    call Delay_1s
    btfss PORTB,3,A			    // Checa si sigue presionado el boton
	bra Boton_D
	
	clrf LATA,A
	bsf LATA,6,A			    // Led para checar que entro a Suma
	bsf Aux,7,A			    // Variable auxiliar para guardar un numero al momento de presionar una operacion
	bsf Aux,3,A			    // Variable auxiliar para checar que operacion se presiono
	
	return
	
Boton_E:				    // Boton * / igual
    call Delay_1s
    btfss PORTB,3,A			    // Checa si sigue presionado el boton
	bra Boton_E
	
	clrf LATA,A
	btfsc Aux,0,A			    // Si el bit 0 de Aux  es 1 se va a Suma
	    call Suma
	    btfsc Aux,1,A		    // Si el bit 1 de Aux  es 1 se va a Resta
		call Resta
		btfsc Aux,2,A		    // Si el bit 2 de Aux  es 1 se va a Multiplicacion
		    call Multiplicacion
		    btfsc Aux,3,A	    // Si el bit 3 de Aux  es 1 se va a Division
			call Division
			bsf LATA,4,A
			
			return
	
Boton_F:				    // Boton # / borrar leds
    call Delay_1s
    btfss PORTB,3,A			    // Checa si sigue presionado el boton
	bra Boton_F
	
	clrf LATA,A
	clrf LATD,A
	clrf Num1,A
	clrf Num2,A			    // Limpia todos los registros
	clrf Aux,A
	clrf Aux2,A
	clrf Aux3,A
	clrf Decenas,A
	clrf Resultado,A
	
	return
	
Suma:
    movf Num1,W,A			    // Num1 -> Wreg
    addwf Num2,W,A			    // Num2 + Wreg = Wreg
    call Total
    return
    
Resta:
    movf Num2,W,A			    // Num2 -> Wreg
    subwf Num1,W,A			    // Num1 - Wreg (Num2) = Wreg
    btfss WREG,7,A			    // Si el bit 7 de Wreg es 1 significa que es negativo
	bra Total			    // Si no es negativo se va a total
	negf WREG,A			    // Cambia a complemento a2, por ser negativo
	bsf WREG,7,A			    // Prende el bit 7 para saber que es negativo el numero
	call Total
	return
	
Multiplicacion:
    movf Num1,W,A			    // Num1 -> Wreg
    mulwf Num2,A			    // Num2 * Wreg (Num1)
    movf PRODH,W,A
    addwf PRODL,W,A			    // Suma los bits mas significativos (PRODH) y los bits menos significativos (PRODL)
    call Total	
    return
    
Division:	
    movlw 0
    subwf Num2,W,A
    tstfsz WREG,A			// Si es 0 brinca
	goto Div
	call PrendeTodo
	return
	
    Div:
	movf Num2,W,A		
	subwf Num1,W,A		// Resta el Num1-Num2
	btfss STATUS,4,A	// Checa si la resta es negativa
	    goto Rest
	    call Cero
	    return
	
	Rest:
	    incf Aux2,A		// Incrementa el registro Aux2
	    movwf Num1,A
	    movf Num2,W,A
	    subwf Num1,W,A	// Resta lo que queda menos lo ingresado en el Num2
	    btfss STATUS,4,A	// Checa si es negativo
		bra Rest
		movf Aux2,W,A	// Envia Aux2 al Wreg 
		call Total	// Llama para desplegar el resultado
		return
		
PrendeTodo:
    setf LATD,A
    return
    
Cero:
    movlw 0
    call Total
    return
   
Total:
    movwf Decenas,A
    movwf Unidades,A
    call Decenas1
    call Unidades1
    iorwf Aux3,W,A			    // Or entre Aux3 y Aux4(Wreg)
    movwf Resultado,A			    // Wreg -> Resultado
    movff Resultado,LATD		    // Resultado -> LATD (leds)
    return
    
    Decenas1:
	movlw 10
	incf Aux3,A			    // Incrementa registro Aux3
	subwf Decenas,W,A		    // R-W -> Wreg
	movwf Decenas,A			    // Wreg -> Decenas
	btfss STATUS,4,A
	    bra Decenas1
	    decf Aux3,A
	    swapf Aux3,F,A		    // Pasan a los 4 bits mas significativos se queda guardado en Aux3
	    return
	    
    Unidades1:
	movff Decenas,Unidades
	movf Unidades,W,A
	btfss STATUS,4,A
	    return
	    addlw 10
	    return
    
Guardar_Numero:
    btfss Aux,7,A			    // Si es 1 significa que el Numero_1 esta ocupado y lo guarda en Numero_2
	goto Numero_1
	goto Numero_2
	
Numero_1:
    movwf Num1,A
    goto Revisar_Columna_1
    
Numero_2:
    movwf Num2,A
    goto Revisar_Columna_1
    
    
Delay_1s:
    movlw 255
    movwf VARA, 0 
    movwf VARB, 0
Loop_1:
    decfsz VARB,1,0
    goto Loop_1
    decfsz VARA,1,0
    goto Loop_1
    return
    
Debounce_20ms:
    movlw 8				// Carga variable con 1111 1111
    movwf VARA,0			// Para iniciar en el mayor valor posible
    movlw 100
    movwf VARB,0
    
Loop_20:
    decfsz VARB,1,0			// Resta 1 a la Variable2 y revisa si es cero
    goto Loop_20			// Regresa a Loop1 hasta que sea 0
    decfsz VARA,1,0			// Resta 1 a la Variable1 y revisa si es cero
    goto Loop_20			// Regresa a Loop1 hasta que sea 0
    return
        
    
//
// CONFIGURATION BITS SETTING, THIS IS REQUIRED TO CONFITURE THE OPERATION OF THE MICROCONTROLLER
// AFTER RESET. ONCE PROGRAMMED IN THIS PRACTICA THIS IS NOT NECESARY TO INCLUDE IN FUTURE PROGRAMS
// IF THIS SETTINGS ARE NOT CHANGED. SEE SECTION 26 OF DATA SHEET. 
//   
// CONFIG1L
    CONFIG  PLLSEL = PLL4X        // PLL Selection (4x clock multiplier)
    CONFIG  CFGPLLEN = OFF        // PLL Enable Configuration bit (PLL Disabled (firmware controlled))
    CONFIG  CPUDIV = NOCLKDIV     // CPU System Clock Postscaler (CPU uses system clock (no divide))
    CONFIG  LS48MHZ = SYS24X4     // Low Speed USB mode with 48 MHz system clock (System clock at 24 MHz, USB clock divider is set to 4)
// CONFIG1H
    CONFIG  FOSC = INTOSCIO       // Oscillator Selection (Internal oscillator) 
    CONFIG  PCLKEN = ON           // Primary Oscillator Shutdown (Primary oscillator enabled)
    CONFIG  FCMEN = OFF           // Fail-Safe Clock Monitor (Fail-Safe Clock Monitor disabled)
    CONFIG  IESO = OFF            // Internal/External Oscillator Switchover (Oscillator Switchover mode disabled)
// CONFIG2L
    CONFIG  nPWRTEN = OFF         // Power-up Timer Enable (Power up timer disabled)
    CONFIG  BOREN = SBORDIS       // Brown-out Reset Enable (BOR enabled in hardware (SBOREN is ignored))
    CONFIG  BORV = 190            // Brown-out Reset Voltage (BOR set to 1.9V nominal)
    CONFIG  nLPBOR = OFF          // Low-Power Brown-out Reset (Low-Power Brown-out Reset disabled)
// CONFIG2H
    CONFIG  WDTEN = OFF           // Watchdog Timer Enable bits (WDT disabled in hardware (SWDTEN ignored))
    CONFIG  WDTPS = 32768         // Watchdog Timer Postscaler (1:32768)
// CONFIG3H
    CONFIG  CCP2MX = RC1          // CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
    CONFIG  PBADEN = OFF          // PORTB A/D Enable bit (PORTB<5:0> pins are configured as analog input channels on Reset)
    CONFIG  T3CMX = RC0           // Timer3 Clock Input MUX bit (T3CKI function is on RC0)
    CONFIG  SDOMX = RB3           // SDO Output MUX bit (SDO function is on RB3)
    CONFIG  MCLRE = ON            // Master Clear Reset Pin Enable (MCLR pin enabled; RE3 input disabled)
// CONFIG4L
    CONFIG  STVREN = ON           // Stack Full/Underflow Reset (Stack full/underflow will cause Reset)
    CONFIG  LVP = ON              // Single-Supply ICSP Enable bit (Single-Supply ICSP enabled if MCLRE is also 1)
    CONFIG  ICPRT = OFF           // Dedicated In-Circuit Debug/Programming Port Enable (ICPORT disabled)
    CONFIG  XINST = OFF           // Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled)
//
// DEFAULT CONFIGURATION FOR THE REST OF THE REGISTERS
//
    CONFIG  CONFIG5L = 0x0F	  // BLOCKS ARE NOT CODE-PROTECTED
    CONFIG  CONFIG5H = 0xC0	  // BOOT BLOCK IS NOT CODE-PROTECTED
    CONFIG  CONFIG6L = 0x0F	  // BLOCKS NOT PROTECTED FROM WRITING
    CONFIG  CONFIG6H = 0xE0	  // CONFIGURATION REGISTERS NOT PROTECTED FROM WRITING
    CONFIG  CONFIG7L = 0x0F	  // BLOCKS NOT PROTECTED FROM TABLE READS
    CONFIG  CONFIG7H = 0x40	  // BOOT BLOCK IS NOT PROTECTED FROM TABLE READS
    
end resetVec

