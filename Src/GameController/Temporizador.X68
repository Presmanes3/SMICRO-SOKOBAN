*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
 MOVE.L #0 ,D3 ;SEGUNDOS
 MOVE.L #0 ,D4 ;MINUTOS

BUCLETIEMPO 
 
 ADD.L #1,D3
 IF.L D3 <EQ> #60 THEN.L
 JSR MINUTO
 ENDI
 ;MOVE.L D3,SEGUNDOS
 MOVE.L #95,D0
 MOVE.L #SEGUNDOS,A1
 MOVE.L #350,D1
 MOVE.L #75,D2
 TRAP #15
 JSR RETARDO
 JSR LIMPIACION
 JSR RETARDO
 JMP BUCLETIEMPO
 

RETARDO 
     MOVE.L #23,D0
     MOVE.L #100,D1
     TRAP #15
     RTS
LIMPIACION
  MOVE.L #95,D0
 MOVE.L #LIMPIAR,A1
 MOVE.L #350,D1
 MOVE.L #75,D2
 TRAP #15

 RTS         
MINUTO
 ADD.L #1,D4
 MOVE.L #0,D3
 RTS   

SEGUNDOS DC.B 'K',0
LIMPIAR DC.B ' ',0    
 
 END START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
