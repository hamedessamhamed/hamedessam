#line 1 "E:/embeded/MyProject1.c"
char segment[] = {0,1,2,3,4,5,6,7,8,9,16,17,18,19,20,21,22,23,24,25,32,33,34,35};
int i;
void trap (int time, int port){
 portb = port;
 for (i = time ; i>= 0; i--){
 if(portd.b0 == 0){
 return;
 }
 portc = segment[i];
 delay_ms(1000);
 if(i <= 4 && portb.b4 == 0){
 portb.b4 = 1;
 portb.b5 = 0;
 }
 if(i <= 4 && portb.b1 == 0){
 portb.b1 = 1;
 portb.b2 = 0;
 }
 }
 portb.b2 = 1;
 portb.b5 = 1;
}
void main() {
 trisb = 0;trisa = 0; trisc = 0,trisd = 255;
 porta.b0 = 1;
 while(1){
 if (portd.b0 == 1){
 trap (23,0b11100111);
 trap (15,0b10111101);
 }
 else {
 porta.b0 = 0;
 porta.b0 = 1;
 portc = segment[0];
 portb = 0b10111101;
 while(portd.B0 == 0){
 if (portd.b1 == 1 && portb == 0b10111101 ){
 if(portd.b0 == 1){
 trap (23,0b10111101);
 }
 for (i = 3; i>= 0; i--){
 portb.b2 = 0;
 portb.b1 = 1;
 portc = segment[i];
 delay_ms(1000);
 }
 portb = 0b11100111;

 }
 else if( portd.b1 == 0 && portb == 0b11100111){
 if(portd.b0 == 1){
 trap (15,0b11100111);
 }
 for (i = 3; i>= 0; i--){
 portb.b5 = 0;
 portb.b4 = 1;
 portc = segment[i];
 delay_ms(1000);
 }
 portb = 0b10111101;
 }
 }
}
}
}
