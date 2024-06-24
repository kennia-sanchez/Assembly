//
// Practica_9 Ejercicio_1.asm
// Escribe un programa que te permita contar eventos externos utilizado interrupciones por medio de
// INT0. Al inicio del programa (estado inicial), los LEDs deben mostrar una secuencia como se muestra
// en la siguiente imagen (cambiando cada 1 seg).
// Kennia J. S·nchez Castillo 
//
    Radix	Dec		    // Selecionar decimal como base numerica
    Processor	18F45K50	    // Selecionar procesador a utilizar
    #include	"pic18f45k50.inc"   // Incluir librerias de PIC18F45K50
    
//
//  Memory Allocation
//
    PSECT resetVec, class=CODE, reloc=2, abs
    org	0			    
//
// Reset Vector
//
resetVec:
    org		0		    
    goto Start			    
    
    org		8
    goto Interrupcion

Start:
    Led		equ 1
    Contador	equ 2
    Cambio	equ 3 
    VARA	equ 4		    // Variable delay 
    VARB	equ 5		    // Variable delay
   
    clrf Contador,A
    clrf Cambio,A
    
    movlb 15 
    clrf ANSELD,A		    // Puerto para Leds
    clrf ANSELB,A		    // Puerto para boton
    clrf TRISD,A		  
    clrf LATD,A
    
    movlw 0b00000001
    movwf TRISB,A
    clrf LATB,A
    clrf Led,A
    bsf Led,0,A
    
    
ConfigINT0:
    bsf INTCON2,6,A		    // INTCON2 ; Bit 6 = Ascendente
    bsf INTCON,7,A		    // INTCON ;  Bit 7 = Habilita la interrupcion
    bcf INTCON,1,A		    // INTCON ;  Bit 1 = Limpia bandera
    bsf INTCON,4,A		    // INTCON ;  Bit 4 = Habilita el INT0

    
Timer_1s:
    movlw 0b00000001		    // Pre-escalador de 4
    movwf T0CON,A
    movlw 0b11011100		    // TMR0L = 11011100
    movwf TMR0L,A
    movlw 0b00001011		    // TMR0H = 00001011
    movwf TMR0H,A
    nop
    bsf T0CON,7,A		    // Enciende el Timer
    
    
Checa_Botones:
    btfss Contador,1,A			    // Contador = 1
	goto Registro_Contador
	btfss Contador,0,A		    // Contador = 2
	    goto Registro_Contador
	    btfss Contador,0,A		    // Contador = 3
		goto Registro_Contador
		btg Cambio,0,A		    // Invierte la direccion de los bits
		clrf Contador,A
    
    
Registro_Contador:
    btfss INTCON,2,A
	bra Registro_Contador
	btfsc Cambio,0,A
	    rlncf Led,F,A		    
	    btfss Cambio,0,A
		rrncf Led,F,A
		movff Led,LATD		    // El valor del led se pasa a LATD para desplegarlo
		bcf T0CON,7,A		    // Apaga el Timer
		bcf INTCON,2,A		    // Apaga la bandera
		goto Timer_1s
    
    
Interrupcion:
    call Delay_1s
    btfsc INTCON,1,A		    // Checa desbordamiento
	incf Contador,A		    // Incrementa el contador
	bcf INTCON,1,A		    // Apaga la bandera
	retfie


Delay_1s:			    // Delay para los botones
    movlw 255
    movwf VARA, 0 
    movwf VARB, 0
Loop_1:
    decfsz VARB,1,0
    goto Loop_1
    decfsz VARA,1,0
    goto Loop_1
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


