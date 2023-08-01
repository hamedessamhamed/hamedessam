
_trap:

;MyProject1.c,3 :: 		void trap (int time, int port){
;MyProject1.c,4 :: 		portb = port;
	MOVF       FARG_trap_port+0, 0
	MOVWF      PORTB+0
;MyProject1.c,5 :: 		for (i = time ; i>= 0; i--){
	MOVF       FARG_trap_time+0, 0
	MOVWF      _i+0
	MOVF       FARG_trap_time+1, 0
	MOVWF      _i+1
L_trap0:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__trap39
	MOVLW      0
	SUBWF      _i+0, 0
L__trap39:
	BTFSS      STATUS+0, 0
	GOTO       L_trap1
;MyProject1.c,6 :: 		if(portd.b0 == 0){
	BTFSC      PORTD+0, 0
	GOTO       L_trap3
;MyProject1.c,7 :: 		return;
	GOTO       L_end_trap
;MyProject1.c,8 :: 		}
L_trap3:
;MyProject1.c,9 :: 		portc = segment[i];
	MOVF       _i+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject1.c,10 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_trap4:
	DECFSZ     R13+0, 1
	GOTO       L_trap4
	DECFSZ     R12+0, 1
	GOTO       L_trap4
	DECFSZ     R11+0, 1
	GOTO       L_trap4
	NOP
	NOP
;MyProject1.c,11 :: 		if(i <= 4 && portb.b4 == 0){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__trap40
	MOVF       _i+0, 0
	SUBLW      4
L__trap40:
	BTFSS      STATUS+0, 0
	GOTO       L_trap7
	BTFSC      PORTB+0, 4
	GOTO       L_trap7
L__trap35:
;MyProject1.c,12 :: 		portb.b4 = 1;
	BSF        PORTB+0, 4
;MyProject1.c,13 :: 		portb.b5 = 0;
	BCF        PORTB+0, 5
;MyProject1.c,14 :: 		}
L_trap7:
;MyProject1.c,15 :: 		if(i <= 4 && portb.b1 == 0){
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__trap41
	MOVF       _i+0, 0
	SUBLW      4
L__trap41:
	BTFSS      STATUS+0, 0
	GOTO       L_trap10
	BTFSC      PORTB+0, 1
	GOTO       L_trap10
L__trap34:
;MyProject1.c,16 :: 		portb.b1 = 1;
	BSF        PORTB+0, 1
;MyProject1.c,17 :: 		portb.b2 = 0;
	BCF        PORTB+0, 2
;MyProject1.c,18 :: 		}
L_trap10:
;MyProject1.c,5 :: 		for (i = time ; i>= 0; i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;MyProject1.c,19 :: 		}
	GOTO       L_trap0
L_trap1:
;MyProject1.c,20 :: 		portb.b2 = 1;
	BSF        PORTB+0, 2
;MyProject1.c,21 :: 		portb.b5 = 1;
	BSF        PORTB+0, 5
;MyProject1.c,22 :: 		}
L_end_trap:
	RETURN
; end of _trap

_main:

;MyProject1.c,23 :: 		void main() {
;MyProject1.c,24 :: 		trisb = 0;trisa = 0; trisc = 0,trisd = 255;
	CLRF       TRISB+0
	CLRF       TRISA+0
	CLRF       TRISC+0
	MOVLW      255
	MOVWF      TRISD+0
;MyProject1.c,25 :: 		porta.b0 = 1;
	BSF        PORTA+0, 0
;MyProject1.c,26 :: 		while(1){
L_main11:
;MyProject1.c,27 :: 		if (portd.b0 == 1){
	BTFSS      PORTD+0, 0
	GOTO       L_main13
;MyProject1.c,28 :: 		trap (23,0b11100111);
	MOVLW      23
	MOVWF      FARG_trap_time+0
	MOVLW      0
	MOVWF      FARG_trap_time+1
	MOVLW      231
	MOVWF      FARG_trap_port+0
	CLRF       FARG_trap_port+1
	CALL       _trap+0
;MyProject1.c,29 :: 		trap (15,0b10111101);
	MOVLW      15
	MOVWF      FARG_trap_time+0
	MOVLW      0
	MOVWF      FARG_trap_time+1
	MOVLW      189
	MOVWF      FARG_trap_port+0
	CLRF       FARG_trap_port+1
	CALL       _trap+0
;MyProject1.c,30 :: 		}
	GOTO       L_main14
L_main13:
;MyProject1.c,32 :: 		porta.b0 = 0;
	BCF        PORTA+0, 0
;MyProject1.c,33 :: 		porta.b0 = 1;
	BSF        PORTA+0, 0
;MyProject1.c,34 :: 		portc = segment[0];
	MOVF       _segment+0, 0
	MOVWF      PORTC+0
;MyProject1.c,35 :: 		portb = 0b10111101;
	MOVLW      189
	MOVWF      PORTB+0
;MyProject1.c,36 :: 		while(portd.B0 == 0){
L_main15:
	BTFSC      PORTD+0, 0
	GOTO       L_main16
;MyProject1.c,37 :: 		if (portd.b1 == 1 && portb == 0b10111101 ){
	BTFSS      PORTD+0, 1
	GOTO       L_main19
	MOVF       PORTB+0, 0
	XORLW      189
	BTFSS      STATUS+0, 2
	GOTO       L_main19
L__main37:
;MyProject1.c,38 :: 		if(portd.b0 == 1){
	BTFSS      PORTD+0, 0
	GOTO       L_main20
;MyProject1.c,39 :: 		trap (23,0b10111101);
	MOVLW      23
	MOVWF      FARG_trap_time+0
	MOVLW      0
	MOVWF      FARG_trap_time+1
	MOVLW      189
	MOVWF      FARG_trap_port+0
	CLRF       FARG_trap_port+1
	CALL       _trap+0
;MyProject1.c,40 :: 		}
L_main20:
;MyProject1.c,41 :: 		for (i = 3; i>= 0; i--){
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main21:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main43
	MOVLW      0
	SUBWF      _i+0, 0
L__main43:
	BTFSS      STATUS+0, 0
	GOTO       L_main22
;MyProject1.c,42 :: 		portb.b2 = 0;
	BCF        PORTB+0, 2
;MyProject1.c,43 :: 		portb.b1 = 1;
	BSF        PORTB+0, 1
;MyProject1.c,44 :: 		portc = segment[i];
	MOVF       _i+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject1.c,45 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main24:
	DECFSZ     R13+0, 1
	GOTO       L_main24
	DECFSZ     R12+0, 1
	GOTO       L_main24
	DECFSZ     R11+0, 1
	GOTO       L_main24
	NOP
	NOP
;MyProject1.c,41 :: 		for (i = 3; i>= 0; i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;MyProject1.c,46 :: 		}
	GOTO       L_main21
L_main22:
;MyProject1.c,47 :: 		portb = 0b11100111;
	MOVLW      231
	MOVWF      PORTB+0
;MyProject1.c,49 :: 		}
	GOTO       L_main25
L_main19:
;MyProject1.c,50 :: 		else if( portd.b1 == 0 && portb == 0b11100111){
	BTFSC      PORTD+0, 1
	GOTO       L_main28
	MOVF       PORTB+0, 0
	XORLW      231
	BTFSS      STATUS+0, 2
	GOTO       L_main28
L__main36:
;MyProject1.c,51 :: 		if(portd.b0 == 1){
	BTFSS      PORTD+0, 0
	GOTO       L_main29
;MyProject1.c,52 :: 		trap (15,0b11100111);
	MOVLW      15
	MOVWF      FARG_trap_time+0
	MOVLW      0
	MOVWF      FARG_trap_time+1
	MOVLW      231
	MOVWF      FARG_trap_port+0
	CLRF       FARG_trap_port+1
	CALL       _trap+0
;MyProject1.c,53 :: 		}
L_main29:
;MyProject1.c,54 :: 		for (i = 3; i>= 0; i--){
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main30:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main44
	MOVLW      0
	SUBWF      _i+0, 0
L__main44:
	BTFSS      STATUS+0, 0
	GOTO       L_main31
;MyProject1.c,55 :: 		portb.b5 = 0;
	BCF        PORTB+0, 5
;MyProject1.c,56 :: 		portb.b4 = 1;
	BSF        PORTB+0, 4
;MyProject1.c,57 :: 		portc = segment[i];
	MOVF       _i+0, 0
	ADDLW      _segment+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject1.c,58 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main33:
	DECFSZ     R13+0, 1
	GOTO       L_main33
	DECFSZ     R12+0, 1
	GOTO       L_main33
	DECFSZ     R11+0, 1
	GOTO       L_main33
	NOP
	NOP
;MyProject1.c,54 :: 		for (i = 3; i>= 0; i--){
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;MyProject1.c,59 :: 		}
	GOTO       L_main30
L_main31:
;MyProject1.c,60 :: 		portb = 0b10111101;
	MOVLW      189
	MOVWF      PORTB+0
;MyProject1.c,61 :: 		}
L_main28:
L_main25:
;MyProject1.c,62 :: 		}
	GOTO       L_main15
L_main16:
;MyProject1.c,63 :: 		}
L_main14:
;MyProject1.c,64 :: 		}
	GOTO       L_main11
;MyProject1.c,65 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
