#line 1 "C:/Users/Admin/Desktop/Maze Solver Robot/MyProject.c"
int distance(int b)
{ int a;
 TMR1H=TMR1L=0;

 if (b==1)
 {
 PORTD.F0=1;
 delay_us(50);
 PORTD.F0=0;
 delay_us(50);
 while(PORTc.F7==0);
 T1CON.F0=1;
 while(PORTc.F7==1);
 T1CON.F0=0;
 a = (TMR1L | (TMR1H<<8));
 a = a/117.64;
 if(a>=0 && a<=250)
 return a;
 else
 return -1;
 }
else if (b==2)
 {
 PORTD.F2=1;
 delay_us(50);
 PORTD.F2=0;
 delay_us(50);

 while(PORTc.F6==0);
 T1CON.F0=1;
 while(PORTc.F6==1);
 T1CON.F0=0;
 a = (TMR1L | (TMR1H<<8));
 a = a/117.64;
 if(a>=0 && a<=250)
 return a;
 else
 return -1;
 }
else if (b==3)
 {
 PORTD.F1=1;
 delay_us(50);
 PORTD.F1=0;
 delay_us(50);
 while(PORTc.F4==0);
 T1CON.F0=1;
 while(PORTc.F4==1);
 T1CON.F0=0;
 a = (TMR1L | (TMR1H<<8));
 a = a/117.64;
 if(a>=0 && a<=250)
 return a;
 else
 return -1;
 }

}
void pwm(int left ,int right){
 PWM1_Init(8000);
 PWM2_Init(8000);
 PWM1_Set_Duty(0);
 PWM2_Set_Duty(0);
 PWM1_Start();
 PWM2_Start();
 PWM1_Set_Duty(left);
 PWM2_Set_Duty(right);
}


void rotate(int a){

if(a==1)
 {
 pwm(165,160);
 portb=0b00001000;
 delay_ms(1300);
 portb=0x00;
 pwm(165,155);

 }

if(a==2)
 {
 pwm(165,160);
 portb=0b00000010;
 delay_ms(1300);
 portb=0x00;
 pwm(165,155);

 }
if (a==3)
{
 pwm(165,160);
 portb=0b00001001;
 delay_ms(1250);
 portb=0x00;
 pwm(165,155);
}
if (a==4)
{
 pwm(165,160);
 portb=0b00000110;
 delay_ms(1180);
 portb=0x00;
 pwm(165,155);
}

}
void main()
{
int front=0 ,left=0, right=0, calibration=0, sum=0, a ,lm=160,rl=0 , rm=150,flag_loop=0,flag_cross=1;
trisc=0xF0;portc=0x00;
trisd=0xf0;
trisb=0x00;portb=0b00000000;pwm(lm,rm);
T1CON=0X00;

trisa=0x00;
porta=0xff;
delay_ms(1000);
while(1)
 {



 if (portd.f5 && portd.f6 && portd.f7 )
{
 flag_cross=1;
 while(portd.f5&& portd.f6 && portd.f7)
 portb=0b00000101;

 portb=0x00;
}
else if (portd.f5==0 && portd.f6==0 && portd.f7==0 && flag_cross)
 {

 delay_ms(100);
 portb=0x00;
 delay_ms(500);
 flag_cross=0;

 sum=0;
 for(a=1; a<=20; a++){
 right=distance(3);
 if(right==-1)
 right=40;
 sum=sum+right;
 }
 right=sum/20;
 if (right>45 && flag_loop<=3)
 {
 rotate(1);
 flag_loop+=1;
 continue;
 }
 if (flag_loop==4){
 flag_loop=0;
 if (left < right )
 rotate(3);
 else
 rotate(4);
 continue;
 }
 flag_loop=0;

 sum=0;
 for(a=1; a<=20; a++){
 front=distance(1);
 if(front==-1)
 front=40;
 sum=sum+front;
 }
 front=sum/20;
 if (front>25){
 portb=0b00001010;
 continue;
 }

 sum=0;
 for( a=1; a<=20; a++){
 left=distance(2);
 if(left==-1)
 left=40;
 sum=sum+left;
 }
 left=sum/20;
 if (left>35)
 rotate(2);
 else if (left < right )
 rotate(3);
 else
 rotate(4);
 }
else if ((portd.f5==0 && portd.f6==0 && portd.f7==1) || (portd.f5==0 && portd.f6==1 && portd.f7==1))
{
 flag_cross=1;

 portb=0b00000110;
}
else if ((portd.f5==1 && portd.f6==1 && portd.f7==0) || (portd.f5==1 && portd.f6==0 && portd.f7==0))
{ flag_cross=1;

 portb=0b00001001;
}
else if (portd.f5==1 && portd.f6==0 && portd.f7==1)
{
 flag_cross=1;

 portb=0b00001010;
}

 }}
