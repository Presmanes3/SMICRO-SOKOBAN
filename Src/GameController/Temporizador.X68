*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
     ORG $80000
             
PRINT_TIME 
  MOVE.L #0,D5
 IF.L CLK_TIMER_FLAG <EQ> #1 THEN.L
    JSR RESET_CLK_TIMER_FLAG
    JSR PRINT_SEC
    JSR ADD_SECOND
   
    IF.L DIBUJO <EQ> #1 THEN.L
        MOVE.L #0,DIBUJO
        JSR LIMPIARSEG
        JSR LIMPIARMIN
    ELSE 
        MOVE.L #1,DIBUJO
       
    ENDI
     JSR PRINT_SEC 
     JSR PRINT_MIN                
 ENDI 
 RTS
LIMPIARSEG
  MOVE.L #95,D0
 MOVE.L #LIMPIASEG,A1
 MOVE.L #70,D1
 MOVE.L #40,D2
 TRAP #15 
 RTS 
PRINT_SEC
 MOVE.L #95,D0
 MOVE.L #SEGUNDOS,A1
 MOVE.L #70,D1
 MOVE.L #40,D2
 TRAP #15
 RTS
PRINT_MIN
 MOVE.L #95,D0
 MOVE.L #MINUTOS,A1
 MOVE.L #50,D1
 MOVE.L #40,D2
 TRAP #15
 RTS   
LIMPIARMIN
 MOVE.L #95,D0
 MOVE.L #LIMPIAMIN,A1
 MOVE.L #50,D1
 MOVE.L #40,D2
 TRAP #15 
 RTS  
        
ADD_MINUTO
 MOVE.W MINUTOS,D4
 ADD.B #1,D4
 MOVE.B D4,D1
 IF.B D1 <HI> #$39 THEN.L
 MOVE.B #$30,D1
 MOVE.B D1,D4
 ADD.L #$100,D4 
 ENDI
 MOVE.W D4,MINUTOS
 RTS
ADD_SECOND
 MOVE.W SEGUNDOS,D0
 ADD.B #1,D0
 MOVE.B D0,D1
 IF.B D1 <HI> #$39 THEN.L
 MOVE.B #$30,D1
 MOVE.B D1,D0
 ADD.L #$100,D0 
 ENDI
 IF.L D0 <EQ> #$3630 THEN.L
 MOVE.L #$3030,D0
 JSR ADD_MINUTO
 ENDI
 MOVE.W D0,SEGUNDOS
 RTS
SEGUNDOS DC.W '00',0
MINUTOS DC.W '00',0
LIMPIASEG DC.W '  ',0    
LIMPIAMIN  DC.W '  ',0 
DIBUJO DS.L 1 










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
