
_distance:

;MyProject.c,1 :: 		int distance(int b)
;MyProject.c,3 :: 		TMR1H=TMR1L=0;
	CLRF       TMR1L+0
	MOVF       TMR1L+0, 0
	MOVWF      TMR1H+0
;MyProject.c,5 :: 		if (b==1) //front sensor
	MOVLW      0
	XORWF      FARG_distance_b+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__distance117
	MOVLW      1
	XORWF      FARG_distance_b+0, 0
L__distance117:
	BTFSS      STATUS+0, 2
	GOTO       L_distance0
;MyProject.c,7 :: 		PORTD.F0=1;
	BSF        PORTD+0, 0
;MyProject.c,8 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_distance1:
	DECFSZ     R13+0, 1
	GOTO       L_distance1
;MyProject.c,9 :: 		PORTD.F0=0;
	BCF        PORTD+0, 0
;MyProject.c,10 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_distance2:
	DECFSZ     R13+0, 1
	GOTO       L_distance2
;MyProject.c,11 :: 		while(PORTc.F7==0); // wait for echo to go high
L_distance3:
	BTFSC      PORTC+0, 7
	GOTO       L_distance4
	GOTO       L_distance3
L_distance4:
;MyProject.c,12 :: 		T1CON.F0=1; //start timer
	BSF        T1CON+0, 0
;MyProject.c,13 :: 		while(PORTc.F7==1);//wait for echo to go low
L_distance5:
	BTFSS      PORTC+0, 7
	GOTO       L_distance6
	GOTO       L_distance5
L_distance6:
;MyProject.c,14 :: 		T1CON.F0=0; //stop timer and calculate distance
	BCF        T1CON+0, 0
;MyProject.c,15 :: 		a = (TMR1L | (TMR1H<<8));
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      distance_a_L0+0
	MOVF       R0+1, 0
	MOVWF      distance_a_L0+1
;MyProject.c,16 :: 		a = a/117.64;
	CALL       _Int2Double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      distance_a_L0+0
	MOVF       R0+1, 0
	MOVWF      distance_a_L0+1
;MyProject.c,17 :: 		if(a>=0 && a<=250)
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__distance118
	MOVLW      0
	SUBWF      R0+0, 0
L__distance118:
	BTFSS      STATUS+0, 0
	GOTO       L_distance9
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      distance_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__distance119
	MOVF       distance_a_L0+0, 0
	SUBLW      250
L__distance119:
	BTFSS      STATUS+0, 0
	GOTO       L_distance9
L__distance104:
;MyProject.c,18 :: 		return a;
	MOVF       distance_a_L0+0, 0
	MOVWF      R0+0
	MOVF       distance_a_L0+1, 0
	MOVWF      R0+1
	GOTO       L_end_distance
L_distance9:
;MyProject.c,20 :: 		return -1;
	MOVLW      255
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R0+1
	GOTO       L_end_distance
;MyProject.c,21 :: 		}
L_distance0:
;MyProject.c,22 :: 		else   if (b==2) //left sensor
	MOVLW      0
	XORWF      FARG_distance_b+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__distance120
	MOVLW      2
	XORWF      FARG_distance_b+0, 0
L__distance120:
	BTFSS      STATUS+0, 2
	GOTO       L_distance12
;MyProject.c,24 :: 		PORTD.F2=1;
	BSF        PORTD+0, 2
;MyProject.c,25 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_distance13:
	DECFSZ     R13+0, 1
	GOTO       L_distance13
;MyProject.c,26 :: 		PORTD.F2=0;
	BCF        PORTD+0, 2
;MyProject.c,27 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_distance14:
	DECFSZ     R13+0, 1
	GOTO       L_distance14
;MyProject.c,29 :: 		while(PORTc.F6==0); // wait for echo to go high
L_distance15:
	BTFSC      PORTC+0, 6
	GOTO       L_distance16
	GOTO       L_distance15
L_distance16:
;MyProject.c,30 :: 		T1CON.F0=1; //start timer
	BSF        T1CON+0, 0
;MyProject.c,31 :: 		while(PORTc.F6==1);//wait for echo to go low
L_distance17:
	BTFSS      PORTC+0, 6
	GOTO       L_distance18
	GOTO       L_distance17
L_distance18:
;MyProject.c,32 :: 		T1CON.F0=0; //stop timer and calculate distance
	BCF        T1CON+0, 0
;MyProject.c,33 :: 		a = (TMR1L | (TMR1H<<8));
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      distance_a_L0+0
	MOVF       R0+1, 0
	MOVWF      distance_a_L0+1
;MyProject.c,34 :: 		a = a/117.64;
	CALL       _Int2Double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      distance_a_L0+0
	MOVF       R0+1, 0
	MOVWF      distance_a_L0+1
;MyProject.c,35 :: 		if(a>=0 && a<=250)
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__distance121
	MOVLW      0
	SUBWF      R0+0, 0
L__distance121:
	BTFSS      STATUS+0, 0
	GOTO       L_distance21
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      distance_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__distance122
	MOVF       distance_a_L0+0, 0
	SUBLW      250
L__distance122:
	BTFSS      STATUS+0, 0
	GOTO       L_distance21
L__distance103:
;MyProject.c,36 :: 		return a;
	MOVF       distance_a_L0+0, 0
	MOVWF      R0+0
	MOVF       distance_a_L0+1, 0
	MOVWF      R0+1
	GOTO       L_end_distance
L_distance21:
;MyProject.c,38 :: 		return -1;
	MOVLW      255
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R0+1
	GOTO       L_end_distance
;MyProject.c,39 :: 		}
L_distance12:
;MyProject.c,40 :: 		else if (b==3) //right sensor
	MOVLW      0
	XORWF      FARG_distance_b+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__distance123
	MOVLW      3
	XORWF      FARG_distance_b+0, 0
L__distance123:
	BTFSS      STATUS+0, 2
	GOTO       L_distance24
;MyProject.c,42 :: 		PORTD.F1=1;
	BSF        PORTD+0, 1
;MyProject.c,43 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_distance25:
	DECFSZ     R13+0, 1
	GOTO       L_distance25
;MyProject.c,44 :: 		PORTD.F1=0;
	BCF        PORTD+0, 1
;MyProject.c,45 :: 		delay_us(50);
	MOVLW      33
	MOVWF      R13+0
L_distance26:
	DECFSZ     R13+0, 1
	GOTO       L_distance26
;MyProject.c,46 :: 		while(PORTc.F4==0); // wait for echo to go high
L_distance27:
	BTFSC      PORTC+0, 4
	GOTO       L_distance28
	GOTO       L_distance27
L_distance28:
;MyProject.c,47 :: 		T1CON.F0=1; //start timer
	BSF        T1CON+0, 0
;MyProject.c,48 :: 		while(PORTc.F4==1);//wait for echo to go low
L_distance29:
	BTFSS      PORTC+0, 4
	GOTO       L_distance30
	GOTO       L_distance29
L_distance30:
;MyProject.c,49 :: 		T1CON.F0=0; //stop timer and calculate distance
	BCF        T1CON+0, 0
;MyProject.c,50 :: 		a = (TMR1L | (TMR1H<<8));
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      distance_a_L0+0
	MOVF       R0+1, 0
	MOVWF      distance_a_L0+1
;MyProject.c,51 :: 		a = a/117.64;
	CALL       _Int2Double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      distance_a_L0+0
	MOVF       R0+1, 0
	MOVWF      distance_a_L0+1
;MyProject.c,52 :: 		if(a>=0 && a<=250)
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__distance124
	MOVLW      0
	SUBWF      R0+0, 0
L__distance124:
	BTFSS      STATUS+0, 0
	GOTO       L_distance33
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      distance_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__distance125
	MOVF       distance_a_L0+0, 0
	SUBLW      250
L__distance125:
	BTFSS      STATUS+0, 0
	GOTO       L_distance33
L__distance102:
;MyProject.c,53 :: 		return a;
	MOVF       distance_a_L0+0, 0
	MOVWF      R0+0
	MOVF       distance_a_L0+1, 0
	MOVWF      R0+1
	GOTO       L_end_distance
L_distance33:
;MyProject.c,55 :: 		return -1;
	MOVLW      255
	MOVWF      R0+0
	MOVLW      255
	MOVWF      R0+1
	GOTO       L_end_distance
;MyProject.c,56 :: 		}
L_distance24:
;MyProject.c,58 :: 		}         //157         //150
L_end_distance:
	RETURN
; end of _distance

_pwm:

;MyProject.c,59 :: 		void pwm(int left ,int right){
;MyProject.c,60 :: 		PWM1_Init(8000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;MyProject.c,61 :: 		PWM2_Init(8000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM2_Init+0
;MyProject.c,62 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,63 :: 		PWM2_Set_Duty(0);
	CLRF       FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;MyProject.c,64 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;MyProject.c,65 :: 		PWM2_Start();
	CALL       _PWM2_Start+0
;MyProject.c,66 :: 		PWM1_Set_Duty(left);
	MOVF       FARG_pwm_left+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;MyProject.c,67 :: 		PWM2_Set_Duty(right);
	MOVF       FARG_pwm_right+0, 0
	MOVWF      FARG_PWM2_Set_Duty_new_duty+0
	CALL       _PWM2_Set_Duty+0
;MyProject.c,68 :: 		}
L_end_pwm:
	RETURN
; end of _pwm

_rotate:

;MyProject.c,71 :: 		void rotate(int a){
;MyProject.c,73 :: 		if(a==1)
	MOVLW      0
	XORWF      FARG_rotate_a+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotate128
	MOVLW      1
	XORWF      FARG_rotate_a+0, 0
L__rotate128:
	BTFSS      STATUS+0, 2
	GOTO       L_rotate35
;MyProject.c,75 :: 		pwm(165,160);
	MOVLW      165
	MOVWF      FARG_pwm_left+0
	CLRF       FARG_pwm_left+1
	MOVLW      160
	MOVWF      FARG_pwm_right+0
	CLRF       FARG_pwm_right+1
	CALL       _pwm+0
;MyProject.c,76 :: 		portb=0b00001000;
	MOVLW      8
	MOVWF      PORTB+0
;MyProject.c,77 :: 		delay_ms(1300);
	MOVLW      14
	MOVWF      R11+0
	MOVLW      49
	MOVWF      R12+0
	MOVLW      148
	MOVWF      R13+0
L_rotate36:
	DECFSZ     R13+0, 1
	GOTO       L_rotate36
	DECFSZ     R12+0, 1
	GOTO       L_rotate36
	DECFSZ     R11+0, 1
	GOTO       L_rotate36
	NOP
;MyProject.c,78 :: 		portb=0x00;
	CLRF       PORTB+0
;MyProject.c,79 :: 		pwm(165,155);
	MOVLW      165
	MOVWF      FARG_pwm_left+0
	CLRF       FARG_pwm_left+1
	MOVLW      155
	MOVWF      FARG_pwm_right+0
	CLRF       FARG_pwm_right+1
	CALL       _pwm+0
;MyProject.c,81 :: 		}
L_rotate35:
;MyProject.c,83 :: 		if(a==2)
	MOVLW      0
	XORWF      FARG_rotate_a+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotate129
	MOVLW      2
	XORWF      FARG_rotate_a+0, 0
L__rotate129:
	BTFSS      STATUS+0, 2
	GOTO       L_rotate37
;MyProject.c,85 :: 		pwm(165,160);
	MOVLW      165
	MOVWF      FARG_pwm_left+0
	CLRF       FARG_pwm_left+1
	MOVLW      160
	MOVWF      FARG_pwm_right+0
	CLRF       FARG_pwm_right+1
	CALL       _pwm+0
;MyProject.c,86 :: 		portb=0b00000010;
	MOVLW      2
	MOVWF      PORTB+0
;MyProject.c,87 :: 		delay_ms(1300);
	MOVLW      14
	MOVWF      R11+0
	MOVLW      49
	MOVWF      R12+0
	MOVLW      148
	MOVWF      R13+0
L_rotate38:
	DECFSZ     R13+0, 1
	GOTO       L_rotate38
	DECFSZ     R12+0, 1
	GOTO       L_rotate38
	DECFSZ     R11+0, 1
	GOTO       L_rotate38
	NOP
;MyProject.c,88 :: 		portb=0x00;
	CLRF       PORTB+0
;MyProject.c,89 :: 		pwm(165,155);
	MOVLW      165
	MOVWF      FARG_pwm_left+0
	CLRF       FARG_pwm_left+1
	MOVLW      155
	MOVWF      FARG_pwm_right+0
	CLRF       FARG_pwm_right+1
	CALL       _pwm+0
;MyProject.c,91 :: 		}
L_rotate37:
;MyProject.c,92 :: 		if (a==3) //right 180
	MOVLW      0
	XORWF      FARG_rotate_a+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotate130
	MOVLW      3
	XORWF      FARG_rotate_a+0, 0
L__rotate130:
	BTFSS      STATUS+0, 2
	GOTO       L_rotate39
;MyProject.c,94 :: 		pwm(165,160);
	MOVLW      165
	MOVWF      FARG_pwm_left+0
	CLRF       FARG_pwm_left+1
	MOVLW      160
	MOVWF      FARG_pwm_right+0
	CLRF       FARG_pwm_right+1
	CALL       _pwm+0
;MyProject.c,95 :: 		portb=0b00001001;
	MOVLW      9
	MOVWF      PORTB+0
;MyProject.c,96 :: 		delay_ms(1250);
	MOVLW      13
	MOVWF      R11+0
	MOVLW      175
	MOVWF      R12+0
	MOVLW      182
	MOVWF      R13+0
L_rotate40:
	DECFSZ     R13+0, 1
	GOTO       L_rotate40
	DECFSZ     R12+0, 1
	GOTO       L_rotate40
	DECFSZ     R11+0, 1
	GOTO       L_rotate40
	NOP
;MyProject.c,97 :: 		portb=0x00;
	CLRF       PORTB+0
;MyProject.c,98 :: 		pwm(165,155);
	MOVLW      165
	MOVWF      FARG_pwm_left+0
	CLRF       FARG_pwm_left+1
	MOVLW      155
	MOVWF      FARG_pwm_right+0
	CLRF       FARG_pwm_right+1
	CALL       _pwm+0
;MyProject.c,99 :: 		}
L_rotate39:
;MyProject.c,100 :: 		if (a==4)//left 180
	MOVLW      0
	XORWF      FARG_rotate_a+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotate131
	MOVLW      4
	XORWF      FARG_rotate_a+0, 0
L__rotate131:
	BTFSS      STATUS+0, 2
	GOTO       L_rotate41
;MyProject.c,102 :: 		pwm(165,160);
	MOVLW      165
	MOVWF      FARG_pwm_left+0
	CLRF       FARG_pwm_left+1
	MOVLW      160
	MOVWF      FARG_pwm_right+0
	CLRF       FARG_pwm_right+1
	CALL       _pwm+0
;MyProject.c,103 :: 		portb=0b00000110;
	MOVLW      6
	MOVWF      PORTB+0
;MyProject.c,104 :: 		delay_ms(1180);
	MOVLW      12
	MOVWF      R11+0
	MOVLW      249
	MOVWF      R12+0
	MOVLW      229
	MOVWF      R13+0
L_rotate42:
	DECFSZ     R13+0, 1
	GOTO       L_rotate42
	DECFSZ     R12+0, 1
	GOTO       L_rotate42
	DECFSZ     R11+0, 1
	GOTO       L_rotate42
	NOP
	NOP
;MyProject.c,105 :: 		portb=0x00;
	CLRF       PORTB+0
;MyProject.c,106 :: 		pwm(165,155);
	MOVLW      165
	MOVWF      FARG_pwm_left+0
	CLRF       FARG_pwm_left+1
	MOVLW      155
	MOVWF      FARG_pwm_right+0
	CLRF       FARG_pwm_right+1
	CALL       _pwm+0
;MyProject.c,107 :: 		}
L_rotate41:
;MyProject.c,109 :: 		}
L_end_rotate:
	RETURN
; end of _rotate

_main:

;MyProject.c,110 :: 		void main()
;MyProject.c,112 :: 		int front=0 ,left=0, right=0, calibration=0, sum=0, a ,lm=160,rl=0 , rm=150,flag_loop=0,flag_cross=1;
	CLRF       main_front_L0+0
	CLRF       main_front_L0+1
	CLRF       main_left_L0+0
	CLRF       main_left_L0+1
	CLRF       main_right_L0+0
	CLRF       main_right_L0+1
	CLRF       main_sum_L0+0
	CLRF       main_sum_L0+1
	MOVLW      160
	MOVWF      main_lm_L0+0
	MOVLW      0
	MOVWF      main_lm_L0+1
	MOVLW      150
	MOVWF      main_rm_L0+0
	MOVLW      0
	MOVWF      main_rm_L0+1
	CLRF       main_flag_loop_L0+0
	CLRF       main_flag_loop_L0+1
	MOVLW      1
	MOVWF      main_flag_cross_L0+0
	MOVLW      0
	MOVWF      main_flag_cross_L0+1
;MyProject.c,113 :: 		trisc=0xF0;portc=0x00;
	MOVLW      240
	MOVWF      TRISC+0
	CLRF       PORTC+0
;MyProject.c,114 :: 		trisd=0xf0;
	MOVLW      240
	MOVWF      TRISD+0
;MyProject.c,115 :: 		trisb=0x00;portb=0b00000000;pwm(lm,rm);
	CLRF       TRISB+0
	CLRF       PORTB+0
	MOVF       main_lm_L0+0, 0
	MOVWF      FARG_pwm_left+0
	MOVF       main_lm_L0+1, 0
	MOVWF      FARG_pwm_left+1
	MOVF       main_rm_L0+0, 0
	MOVWF      FARG_pwm_right+0
	MOVF       main_rm_L0+1, 0
	MOVWF      FARG_pwm_right+1
	CALL       _pwm+0
;MyProject.c,116 :: 		T1CON=0X00;
	CLRF       T1CON+0
;MyProject.c,118 :: 		trisa=0x00;
	CLRF       TRISA+0
;MyProject.c,119 :: 		porta=0xff;
	MOVLW      255
	MOVWF      PORTA+0
;MyProject.c,120 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	DECFSZ     R11+0, 1
	GOTO       L_main43
	NOP
	NOP
;MyProject.c,121 :: 		while(1)
L_main44:
;MyProject.c,126 :: 		if (portd.f5 && portd.f6 && portd.f7 )
	BTFSS      PORTD+0, 5
	GOTO       L_main48
	BTFSS      PORTD+0, 6
	GOTO       L_main48
	BTFSS      PORTD+0, 7
	GOTO       L_main48
L__main115:
;MyProject.c,128 :: 		flag_cross=1;
	MOVLW      1
	MOVWF      main_flag_cross_L0+0
	MOVLW      0
	MOVWF      main_flag_cross_L0+1
;MyProject.c,129 :: 		while(portd.f5&& portd.f6 && portd.f7)
L_main49:
	BTFSS      PORTD+0, 5
	GOTO       L_main50
	BTFSS      PORTD+0, 6
	GOTO       L_main50
	BTFSS      PORTD+0, 7
	GOTO       L_main50
L__main114:
;MyProject.c,130 :: 		portb=0b00000101;
	MOVLW      5
	MOVWF      PORTB+0
	GOTO       L_main49
L_main50:
;MyProject.c,132 :: 		portb=0x00;
	CLRF       PORTB+0
;MyProject.c,133 :: 		}
	GOTO       L_main53
L_main48:
;MyProject.c,134 :: 		else if (portd.f5==0 && portd.f6==0 && portd.f7==0 && flag_cross)
	BTFSC      PORTD+0, 5
	GOTO       L_main56
	BTFSC      PORTD+0, 6
	GOTO       L_main56
	BTFSC      PORTD+0, 7
	GOTO       L_main56
	MOVF       main_flag_cross_L0+0, 0
	IORWF      main_flag_cross_L0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main56
L__main113:
;MyProject.c,137 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main57:
	DECFSZ     R13+0, 1
	GOTO       L_main57
	DECFSZ     R12+0, 1
	GOTO       L_main57
	DECFSZ     R11+0, 1
	GOTO       L_main57
	NOP
;MyProject.c,138 :: 		portb=0x00;
	CLRF       PORTB+0
;MyProject.c,139 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main58:
	DECFSZ     R13+0, 1
	GOTO       L_main58
	DECFSZ     R12+0, 1
	GOTO       L_main58
	DECFSZ     R11+0, 1
	GOTO       L_main58
	NOP
	NOP
;MyProject.c,140 :: 		flag_cross=0;
	CLRF       main_flag_cross_L0+0
	CLRF       main_flag_cross_L0+1
;MyProject.c,142 :: 		sum=0;
	CLRF       main_sum_L0+0
	CLRF       main_sum_L0+1
;MyProject.c,143 :: 		for(a=1; a<=20; a++){
	MOVLW      1
	MOVWF      main_a_L0+0
	MOVLW      0
	MOVWF      main_a_L0+1
L_main59:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main133
	MOVF       main_a_L0+0, 0
	SUBLW      20
L__main133:
	BTFSS      STATUS+0, 0
	GOTO       L_main60
;MyProject.c,144 :: 		right=distance(3);
	MOVLW      3
	MOVWF      FARG_distance_b+0
	MOVLW      0
	MOVWF      FARG_distance_b+1
	CALL       _distance+0
	MOVF       R0+0, 0
	MOVWF      main_right_L0+0
	MOVF       R0+1, 0
	MOVWF      main_right_L0+1
;MyProject.c,145 :: 		if(right==-1)
	MOVLW      255
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main134
	MOVLW      255
	XORWF      R0+0, 0
L__main134:
	BTFSS      STATUS+0, 2
	GOTO       L_main62
;MyProject.c,146 :: 		right=40;
	MOVLW      40
	MOVWF      main_right_L0+0
	MOVLW      0
	MOVWF      main_right_L0+1
L_main62:
;MyProject.c,147 :: 		sum=sum+right;
	MOVF       main_right_L0+0, 0
	ADDWF      main_sum_L0+0, 1
	MOVF       main_right_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_sum_L0+1, 1
;MyProject.c,143 :: 		for(a=1; a<=20; a++){
	INCF       main_a_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_a_L0+1, 1
;MyProject.c,148 :: 		}
	GOTO       L_main59
L_main60:
;MyProject.c,149 :: 		right=sum/20;
	MOVLW      20
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_sum_L0+0, 0
	MOVWF      R0+0
	MOVF       main_sum_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_right_L0+0
	MOVF       R0+1, 0
	MOVWF      main_right_L0+1
;MyProject.c,150 :: 		if (right>45 && flag_loop<=3)
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main135
	MOVF       R0+0, 0
	SUBLW      45
L__main135:
	BTFSC      STATUS+0, 0
	GOTO       L_main65
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_flag_loop_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main136
	MOVF       main_flag_loop_L0+0, 0
	SUBLW      3
L__main136:
	BTFSS      STATUS+0, 0
	GOTO       L_main65
L__main112:
;MyProject.c,152 :: 		rotate(1);
	MOVLW      1
	MOVWF      FARG_rotate_a+0
	MOVLW      0
	MOVWF      FARG_rotate_a+1
	CALL       _rotate+0
;MyProject.c,153 :: 		flag_loop+=1;
	INCF       main_flag_loop_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_flag_loop_L0+1, 1
;MyProject.c,154 :: 		continue;
	GOTO       L_main44
;MyProject.c,155 :: 		}
L_main65:
;MyProject.c,156 :: 		if (flag_loop==4){
	MOVLW      0
	XORWF      main_flag_loop_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main137
	MOVLW      4
	XORWF      main_flag_loop_L0+0, 0
L__main137:
	BTFSS      STATUS+0, 2
	GOTO       L_main66
;MyProject.c,157 :: 		flag_loop=0;
	CLRF       main_flag_loop_L0+0
	CLRF       main_flag_loop_L0+1
;MyProject.c,158 :: 		if (left < right )
	MOVLW      128
	XORWF      main_left_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_right_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main138
	MOVF       main_right_L0+0, 0
	SUBWF      main_left_L0+0, 0
L__main138:
	BTFSC      STATUS+0, 0
	GOTO       L_main67
;MyProject.c,159 :: 		rotate(3);
	MOVLW      3
	MOVWF      FARG_rotate_a+0
	MOVLW      0
	MOVWF      FARG_rotate_a+1
	CALL       _rotate+0
	GOTO       L_main68
L_main67:
;MyProject.c,161 :: 		rotate(4);
	MOVLW      4
	MOVWF      FARG_rotate_a+0
	MOVLW      0
	MOVWF      FARG_rotate_a+1
	CALL       _rotate+0
L_main68:
;MyProject.c,162 :: 		continue;
	GOTO       L_main44
;MyProject.c,163 :: 		}
L_main66:
;MyProject.c,164 :: 		flag_loop=0;
	CLRF       main_flag_loop_L0+0
	CLRF       main_flag_loop_L0+1
;MyProject.c,166 :: 		sum=0;
	CLRF       main_sum_L0+0
	CLRF       main_sum_L0+1
;MyProject.c,167 :: 		for(a=1; a<=20; a++){
	MOVLW      1
	MOVWF      main_a_L0+0
	MOVLW      0
	MOVWF      main_a_L0+1
L_main69:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main139
	MOVF       main_a_L0+0, 0
	SUBLW      20
L__main139:
	BTFSS      STATUS+0, 0
	GOTO       L_main70
;MyProject.c,168 :: 		front=distance(1);
	MOVLW      1
	MOVWF      FARG_distance_b+0
	MOVLW      0
	MOVWF      FARG_distance_b+1
	CALL       _distance+0
	MOVF       R0+0, 0
	MOVWF      main_front_L0+0
	MOVF       R0+1, 0
	MOVWF      main_front_L0+1
;MyProject.c,169 :: 		if(front==-1)
	MOVLW      255
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main140
	MOVLW      255
	XORWF      R0+0, 0
L__main140:
	BTFSS      STATUS+0, 2
	GOTO       L_main72
;MyProject.c,170 :: 		front=40;
	MOVLW      40
	MOVWF      main_front_L0+0
	MOVLW      0
	MOVWF      main_front_L0+1
L_main72:
;MyProject.c,171 :: 		sum=sum+front;
	MOVF       main_front_L0+0, 0
	ADDWF      main_sum_L0+0, 1
	MOVF       main_front_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_sum_L0+1, 1
;MyProject.c,167 :: 		for(a=1; a<=20; a++){
	INCF       main_a_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_a_L0+1, 1
;MyProject.c,172 :: 		}
	GOTO       L_main69
L_main70:
;MyProject.c,173 :: 		front=sum/20;
	MOVLW      20
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_sum_L0+0, 0
	MOVWF      R0+0
	MOVF       main_sum_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_front_L0+0
	MOVF       R0+1, 0
	MOVWF      main_front_L0+1
;MyProject.c,174 :: 		if (front>25){
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main141
	MOVF       R0+0, 0
	SUBLW      25
L__main141:
	BTFSC      STATUS+0, 0
	GOTO       L_main73
;MyProject.c,175 :: 		portb=0b00001010;
	MOVLW      10
	MOVWF      PORTB+0
;MyProject.c,176 :: 		continue;
	GOTO       L_main44
;MyProject.c,177 :: 		}
L_main73:
;MyProject.c,179 :: 		sum=0;
	CLRF       main_sum_L0+0
	CLRF       main_sum_L0+1
;MyProject.c,180 :: 		for( a=1; a<=20; a++){
	MOVLW      1
	MOVWF      main_a_L0+0
	MOVLW      0
	MOVWF      main_a_L0+1
L_main74:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main142
	MOVF       main_a_L0+0, 0
	SUBLW      20
L__main142:
	BTFSS      STATUS+0, 0
	GOTO       L_main75
;MyProject.c,181 :: 		left=distance(2);
	MOVLW      2
	MOVWF      FARG_distance_b+0
	MOVLW      0
	MOVWF      FARG_distance_b+1
	CALL       _distance+0
	MOVF       R0+0, 0
	MOVWF      main_left_L0+0
	MOVF       R0+1, 0
	MOVWF      main_left_L0+1
;MyProject.c,182 :: 		if(left==-1)
	MOVLW      255
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main143
	MOVLW      255
	XORWF      R0+0, 0
L__main143:
	BTFSS      STATUS+0, 2
	GOTO       L_main77
;MyProject.c,183 :: 		left=40;
	MOVLW      40
	MOVWF      main_left_L0+0
	MOVLW      0
	MOVWF      main_left_L0+1
L_main77:
;MyProject.c,184 :: 		sum=sum+left;
	MOVF       main_left_L0+0, 0
	ADDWF      main_sum_L0+0, 1
	MOVF       main_left_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_sum_L0+1, 1
;MyProject.c,180 :: 		for( a=1; a<=20; a++){
	INCF       main_a_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_a_L0+1, 1
;MyProject.c,185 :: 		}
	GOTO       L_main74
L_main75:
;MyProject.c,186 :: 		left=sum/20;
	MOVLW      20
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_sum_L0+0, 0
	MOVWF      R0+0
	MOVF       main_sum_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_left_L0+0
	MOVF       R0+1, 0
	MOVWF      main_left_L0+1
;MyProject.c,187 :: 		if (left>35)
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main144
	MOVF       R0+0, 0
	SUBLW      35
L__main144:
	BTFSC      STATUS+0, 0
	GOTO       L_main78
;MyProject.c,188 :: 		rotate(2);
	MOVLW      2
	MOVWF      FARG_rotate_a+0
	MOVLW      0
	MOVWF      FARG_rotate_a+1
	CALL       _rotate+0
	GOTO       L_main79
L_main78:
;MyProject.c,189 :: 		else if (left < right )
	MOVLW      128
	XORWF      main_left_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_right_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main145
	MOVF       main_right_L0+0, 0
	SUBWF      main_left_L0+0, 0
L__main145:
	BTFSC      STATUS+0, 0
	GOTO       L_main80
;MyProject.c,190 :: 		rotate(3);
	MOVLW      3
	MOVWF      FARG_rotate_a+0
	MOVLW      0
	MOVWF      FARG_rotate_a+1
	CALL       _rotate+0
	GOTO       L_main81
L_main80:
;MyProject.c,192 :: 		rotate(4);
	MOVLW      4
	MOVWF      FARG_rotate_a+0
	MOVLW      0
	MOVWF      FARG_rotate_a+1
	CALL       _rotate+0
L_main81:
L_main79:
;MyProject.c,193 :: 		}
	GOTO       L_main82
L_main56:
;MyProject.c,194 :: 		else if ((portd.f5==0 && portd.f6==0 && portd.f7==1) || (portd.f5==0 && portd.f6==1 && portd.f7==1))
	BTFSC      PORTD+0, 5
	GOTO       L__main111
	BTFSC      PORTD+0, 6
	GOTO       L__main111
	BTFSS      PORTD+0, 7
	GOTO       L__main111
	GOTO       L__main109
L__main111:
	BTFSC      PORTD+0, 5
	GOTO       L__main110
	BTFSS      PORTD+0, 6
	GOTO       L__main110
	BTFSS      PORTD+0, 7
	GOTO       L__main110
	GOTO       L__main109
L__main110:
	GOTO       L_main89
L__main109:
;MyProject.c,196 :: 		flag_cross=1;
	MOVLW      1
	MOVWF      main_flag_cross_L0+0
	MOVLW      0
	MOVWF      main_flag_cross_L0+1
;MyProject.c,198 :: 		portb=0b00000110;
	MOVLW      6
	MOVWF      PORTB+0
;MyProject.c,199 :: 		}
	GOTO       L_main90
L_main89:
;MyProject.c,200 :: 		else if ((portd.f5==1 && portd.f6==1 && portd.f7==0) || (portd.f5==1 && portd.f6==0 && portd.f7==0))
	BTFSS      PORTD+0, 5
	GOTO       L__main108
	BTFSS      PORTD+0, 6
	GOTO       L__main108
	BTFSC      PORTD+0, 7
	GOTO       L__main108
	GOTO       L__main106
L__main108:
	BTFSS      PORTD+0, 5
	GOTO       L__main107
	BTFSC      PORTD+0, 6
	GOTO       L__main107
	BTFSC      PORTD+0, 7
	GOTO       L__main107
	GOTO       L__main106
L__main107:
	GOTO       L_main97
L__main106:
;MyProject.c,201 :: 		{    flag_cross=1;
	MOVLW      1
	MOVWF      main_flag_cross_L0+0
	MOVLW      0
	MOVWF      main_flag_cross_L0+1
;MyProject.c,203 :: 		portb=0b00001001;
	MOVLW      9
	MOVWF      PORTB+0
;MyProject.c,204 :: 		}
	GOTO       L_main98
L_main97:
;MyProject.c,205 :: 		else if (portd.f5==1 && portd.f6==0 && portd.f7==1)
	BTFSS      PORTD+0, 5
	GOTO       L_main101
	BTFSC      PORTD+0, 6
	GOTO       L_main101
	BTFSS      PORTD+0, 7
	GOTO       L_main101
L__main105:
;MyProject.c,207 :: 		flag_cross=1;
	MOVLW      1
	MOVWF      main_flag_cross_L0+0
	MOVLW      0
	MOVWF      main_flag_cross_L0+1
;MyProject.c,209 :: 		portb=0b00001010;
	MOVLW      10
	MOVWF      PORTB+0
;MyProject.c,210 :: 		}
L_main101:
L_main98:
L_main90:
L_main82:
L_main53:
;MyProject.c,212 :: 		}}
	GOTO       L_main44
L_end_main:
	GOTO       $+0
; end of _main
