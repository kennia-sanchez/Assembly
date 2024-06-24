//
//  Ejercicio_1.asm
//  DiseÒa un programa que cuando se active, el bit menos significativo (NNNN-NNNX) encienda por 
//  un segundo y luego se apague por otro segundo (el LED debe parpadear). TambiÈn debes programar
//  4 botones.
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
    org	    32			    // Guardar programa desde el espacio de memoria 0020
    VARA    equ	1		    // Variable Contador
    VARB    equ	2		    // Variable Contador
    Rotar   equ	3		    // Variable para no afectar LATB
    goto    Start		    // Saltar a seccion de Start

Start:
    
    movlb 15
    clrf TRISB,A		    // Configuracion de los puertos
    clrf TRISA,A
    setf TRISC,A
    clrf LATB,A
    clrf LATA,A			    // Limpia de Registros
    clrf VARA,A
    clrf VARB,A
    bcf ANSELC,6,1		    // Para tener acceso a esos botones
    bcf ANSELC,7,1
    
    
Loop:
    btfss PORTC,0,A			    // Checar si el PORTC 0 esta presionado
	call Case_A
    btfss PORTC,1,A			    // Checar si el PORTC 1 esta presionado
	call Case_B
    btfss PORTC,6,A			    // Checar si el PORTC 6 esta presionado
	call Case_C
	
    btg LATB,7,A			    // Hace que parpadee el LED
    call Delay_1s
    bra Loop
    
Case_A:
    bsf LATA,7,A
    call Debounce_20ms
    btfss PORTC,0,A			    // Checa si el boton esta presionado, hasta que se deje de presionar pasa a la siguiente instruccion
	bra Case_A
	movlw 1
	movwf Rotar,A
	
Rotar_Derecha:	
    call Delay_1s
    rrncf Rotar,1,0			    // Rota un bit hacia la derecha
    movff Rotar, LATB			    // Mueve el registro Rotar a LATB para que se vea en los leds
    
Pausa2:
    btfss PORTC,7,A			    // Checa si el boton esta presionado
	call Pausa
	
Salida_A:
    btfsc PORTC,0,A			    // Checa si el boton esta presionado
	bra Rotar_Derecha
	clrf LATB,A
	clrf LATA,A
	return				    // Si se presiona se regresa al inicio
	
Case_B:
    bsf LATA,6,A
    call Debounce_20ms
    btfss PORTC,1,A			    // Checa si el boton esta presionado, hasta que se deje de presionar pasa a la siguiente instruccion
	bra Case_B
	movlw 1
	movwf Rotar,A
	
Rotar_Izquierda:	
    call Delay_1s
    rlncf Rotar,1,0
    movff Rotar, LATB			    // Rota a la izquierda
    
Pausa3:
    btfss PORTC,7,A
	call Pausa

Salida_B:
    btfsc PORTC,1,A
	bra Rotar_Izquierda
	clrf LATB,A
	clrf LATA,A
	return
	
Case_C:
    bsf LATA,5,A
    call Debounce_20ms
    btfss PORTC,6,A			    // Checa si el boton esta presionado, hasta que se deje de presionar pasa a la siguiente instruccion
	bra Case_C
	movlw 128
	movwf Rotar,A
	
Checar:
    btg LATA,7,A
    btfss Rotar,0,A
	goto Derecha
	goto Izquierda
	
Derecha:				    // (De derecha a izquierda 0000 0001 <- )
    call Delay_1s
    rrncf Rotar,1,0
    movff Rotar, LATB			    // Rota a la derecha
    
Pausa4:
    btfss PORTC,7,A
	call Pausa
    
    btfsc PORTC,6,A			    // Checar si el bit 7 esta apagado
	goto Salida_Derecha
	clrf LATB,A			    // Si esta en 0
	clrf LATA,A
	return

Salida_Derecha:
    btg LATA,6,A
    btfss Rotar,0,A
	bra Derecha
	goto Checar

Izquierda:				    // (De izquierda a derecha -> 1000 0000 )
    call Delay_1s
    rlncf Rotar,1,0
    movff Rotar, LATB			    // Rota a la izquierda
    
Pausa5:
    btfss PORTC,7,A
	call Pausa
    
    btfsc PORTC,6,A
	goto Salida_Izquierda
	clrf LATB,A
	clrf LATA,A
	return
	
Salida_Izquierda:
    btg LATA,4,A
    btfss Rotar,0,A
	bra Izquierda
	goto Checar
	
Pausa:
    btg LATA,4,A
    call Debounce_20ms
    btfss PORTC,7,A			    // Checa si el boton esta presionado, hasta que se deje de presionar pasa a la siguiente instruccion
	bra Pausa
	
loop:	
    btg LATA,5,A
    call Debounce_20ms
    btfsc PORTC,7,A
	bra loop
	
loop2:
    btg LATA,6,A
    call Debounce_20ms
    btfss PORTC,7,A
	bra loop2
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
