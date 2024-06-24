//
//  Practica_7 / Ejercicio_1.asm
//  Conecta la pantalla LCD a tu programa para mostrar el mensaje que tu quieras. El mensaje debe
//  escribirse en los dos renglones, letra por letra, al terminar debe borrarse y volver a iniciar a escribir
//  todo de nuevo. 
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
    #define RS	    LATC,0,A
    #define Rw	    LATC,1,A
    #define EN	    LATC,2,A
    #define dataLCD LATD,A
    VARA	equ 1		    // Variable Contador
    VARB	equ 2		    // Variable Contador
    goto    Start		    // Saltar a seccion de Start

Start:
    movlb 15
    clrf ANSELC,A
    bcf ANSELC,2,A		    // Clrf ANSELC Manualmente 
    clrf ANSELD,A
    
    clrf TRISC,A
    clrf TRISD,A
    clrf TRISA,A
    
    clrf LATD,A
    clrf LATC,A
    clrf LATA,A

// CONFIGURACIONES LCD
    
    movlw 0b00111000		    // 8 bits 
    call Configuracion
    movlw 0b00001111		    // Display On
    call Configuracion
    movlw 0b00000110		    // Cursor 
    call Configuracion
    movlw 0b00000001		    // Clear Display
    call Configuracion
    goto LCD
    
Configuracion:			    // Configuraciones de la LCD
    bcf RS
    bcf Rw
    bsf EN
    movwf LATD,A
    nop
    bcf EN
    call Debounce_20ms
    return
    
Escribir:			    // Configuraciones para escribir en la LCD
    bsf RS
    bcf Rw
    bsf EN
    movwf LATD,A
    nop
    bcf EN
    call Delay_1s
    return
    
LCD:
    movlw 72			    // 'H'
    call Escribir
    movlw 111			    // 'o'
    call Escribir
    movlw 108			    // 'l'
    call Escribir
    movlw 97			    // 'a'
    call Escribir
    movlw 0b11000000		    // Configuracion para escribir en el segundo renglon 
    call Configuracion
    movlw 58			    // ':'
    call Escribir
    movlw 41			    // ')'
    call Escribir
    movlw 0b00000001		    // Clear Display
    call Configuracion
    bra LCD			    // Loop
    
    
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





