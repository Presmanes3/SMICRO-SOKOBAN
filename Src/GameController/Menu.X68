*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $100000
MUSICAL 
  MOVE.B #70, D0
  MOVE.L #MUSICA, A1
  TRAP #15    
  RTS 
  
  ORG $70000
INTERFAZ
 MOVE.L #95,D0
    MOVE.L #MENSAJE10,A1
    MOVE.L #10,D1
    MOVE.L #10,D2
    TRAP #15
 MOVE.L #95,D0
    MOVE.L #MENSAJE11,A1
    MOVE.L #10,D1
    MOVE.L #40,D2
    TRAP #15
    
 MOVE.L #95,D0
    MOVE.L #MENSAJE12,A1
    MOVE.L #10,D1
    MOVE.L #465,D2
    TRAP #15
   
 RTS









MENSAJE10 DC.B 'Sokoban is copyright � 1989 � 2021',0
MENSAJE11 DC.B 'Time:',0
MENSAJE12 DC.B 'Hecho por : Javier Presmanes y Samuel Garc�a',0
MUSICA DC.B 'Humble-Match.wav',0


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
