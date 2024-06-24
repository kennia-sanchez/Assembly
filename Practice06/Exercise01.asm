//
// Ejercicio_1.asm
// Elabora un programa que te permita utilizar un teclado matricial 4x4 para leer un botÛn presionado
// en dicho teclado y mostrar en binario el botÛn que se presionÛ.
// Kennia J. S·nchez Castillo 
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
    org	    32			    // Guardar programa desde el espacio de memoria 0020
    VARA    equ	1		    // Variable Contador
    VARB    equ	2		    // Variable Contador
    goto    Start		    // Saltar a seccion de Start

Start:
    movlb 15
    clrf TRISB,A		    // Teclado Matricial
    clrf TRISD,A		    // Leds
    clrf LATD,A
    clrf LATA,A
    
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
	return
    
Boton_2:
    call Delay_1s
    btfss PORTB,0,A			    // Checa si sigue presionado el boton
	bra Boton_2
	
	movlw 2				    // Manda 2 a los leds
	movwf LATD,A
	return
	
Boton_3:
    call Delay_1s
    btfss PORTB,0,A			    // Checa si sigue presionado el boton
	bra Boton_3
	
	movlw 3				    // Manda 3 a los leds
	movwf LATD,A
	return
    
Boton_4:
    call Delay_1s
    btfss PORTB,1,A			    // Checa si sigue presionado el boton
	bra Boton_4
	
	movlw 4				    // Manda 4 a los leds
	movwf LATD,A
	return
	
Boton_5:
    call Delay_1s
    btfss PORTB,1,A			    // Checa si sigue presionado el boton
	bra Boton_5
	
	movlw 5				    // Manda 5 a los leds
	movwf LATD,A
	return
	
Boton_6:
    call Delay_1s
    btfss PORTB,1,A			    // Checa si sigue presionado el boton
	bra Boton_6
	
	movlw 6				    // Manda 6 a los leds
	movwf LATD,A
	return
	
Boton_7:
    call Delay_1s
    btfss PORTB,2,A			    // Checa si sigue presionado el boton
	bra Boton_7
	
	movlw 7				    // Manda 7 a los leds
	movwf LATD,A
	return
	
Boton_8:
    call Delay_1s
    btfss PORTB,2,A			    // Checa si sigue presionado el boton
	bra Boton_8
	
	movlw 8				    // Manda 8 a los leds
	movwf LATD,A
	return
	
Boton_9:
    call Delay_1s
    btfss PORTB,2,A			    // Checa si sigue presionado el boton
	bra Boton_9
	
	movlw 9				    // Manda 9 a los leds
	movwf LATD,A
	return
	
Boton_0:
    call Delay_1s
    btfss PORTB,3,A			    // Checa si sigue presionado el boton
	bra Boton_0
	
	movlw 0				    // Manda 0 a los leds
	movwf LATD,A
	return
	
Boton_A:
    call Delay_1s
    btfss PORTB,0,A			    // Checa si sigue presionado el boton
	bra Boton_A
	
	movlw 10			    // Manda 10 a los leds
	movwf LATD,A
	return
	
Boton_B:
    call Delay_1s
    btfss PORTB,1,A			    // Checa si sigue presionado el boton
	bra Boton_B
	
	movlw 11			    // Manda 11 a los leds
	movwf LATD,A
	return
	
Boton_C:
    call Delay_1s
    btfss PORTB,2,A			    // Checa si sigue presionado el boton
	bra Boton_C
	
	movlw 12			    // Manda 12 a los leds
	movwf LATD,A
	return
	
Boton_D:
    call Delay_1s
    btfss PORTB,3,A			    // Checa si sigue presionado el boton
	bra Boton_D
	
	movlw 13			    // Manda 13 a los leds
	movwf LATD,A
	return
	
Boton_E:				    // Boton *
    call Delay_1s
    btfss PORTB,3,A			    // Checa si sigue presionado el boton
	bra Boton_E
	
	movlw 14			    // Manda 14 a los leds
	movwf LATD,A
	return
	
Boton_F:				    // Boton #
    call Delay_1s
    btfss PORTB,3,A			    // Checa si sigue presionado el boton
	bra Boton_F
	
	movlw 15			    // Manda 15 a los leds
	movwf LATD,A
	return
	
	
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



