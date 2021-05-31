DRKGRAY EQU $404040
RED    EQU $0000FF
YELLOW EQU $0000FFFF 
BLACK  EQU $00000000
PURPLE EQU $00800080
GREEN EQU  $00008000
BLUE EQU   $00800000
ORIX EQU 100
ORIY EQU 100
SIZE EQU 40
*GAP  EQU 10
 
    ORG    $50000

PINTAMAPA	    	
    MOVEM.L A1/D0-D2,-(A7)
    MOVE.L #MAP,A1
    MOVE.L #ORIX,D1
    MOVE.L #ORIY,D2     *X e Y en D1 y D2 
    
BUCLE 
    MOVE.B (A1)+,D0
    CMP.B #0,D0
    BEQ NUEVAFILA
    CMP.B #WALL_CHAR,D0
    BNE PJNORMAL
    JSR GRIS
    JSR PINTAMURO
PJNORMAL  
    CMP.B #PLAYER_CHAR,D0   ; PINTAMOS EL PJ
    BNE PJCHECK
    JSR NEGRO
    JSR PINTAESPACIO
    JSR ROJO
    JSR PINTAMOZO
PJCHECK
   CMP.B #PLAYER_ON_CHECK_POINT_CHAR,D0          ; PINTAMOS EL PJ EN CHECKPOINT
    BNE CAJANORMAL
    JSR NEGRO
    JSR PINTAESPACIO
    JSR VERDE
    JSR PINTAMOZO
CAJANORMAL                    ; PINTAMOS LA CAJA NORMAL 
   CMP.B #BOX_CHAR,D0
    BNE CHECKPOINT
    JSR NEGRO
    JSR PINTAESPACIO
    JSR AZUL
    JSR PINTAMURO 
 
CHECKPOINT                     ; PINTAMOS EL CHECKPOINT
 CMP.B #CHECK_POINT_CHAR,D0
 BNE CAJACHECK
 JSR NEGRO
 JSR PINTAESPACIO
 JSR MORADO
 JSR PINTACHECK
CAJACHECK
 CMP.B #BOX_ON_CHECK_POINT_CHAR,D0
 BNE ESPACIO
 JSR NEGRO
 JSR PINTAESPACIO
 JSR AMARILLO
 JSR PINTAMURO
ESPACIO
   CMP.B #BLANK_CHAR,D0
   BNE NOPERS4
   JSR NEGRO
   JSR PINTAESPACIO
NOPERS4
   *Aqui se pueden comprobar las demás cosas
   
    ADD.L #SIZE,D1  *Avanzamos coordenada X
    JMP BUCLE

       
NUEVAFILA
    
    ADD.L #SIZE,D2  *Avanzo coordenada Y (nueva fila)
    MOVE.L #ORIX,D1 *Repongo coordenada X inicial
   
    CMP.B #0,(A1)
    BNE BUCLE
    MOVEM.L (A7)+,A1/D0-D2   
    RTS
    
PINTAMURO  *Pinta un cuadrado de muro en X,Y indicado por D1 y D2
    MOVEM.L D0-D4,-(A7)
    MOVE.L D1,D3
    MOVE.L D2,D4
    ADD.L #SIZE,D3
    ADD.L #SIZE,D4
    MOVE.L #87,D0   *cuadrado
    TRAP #15
    MOVE.L #84,D0   *linea cruzada
    TRAP #15
    MOVEM.L (A7)+,D0-D4
    RTS
PINTACHECK
    MOVEM.L D0-D4,-(A7)
    ADD.L #SIZE/4,D1         *mitad tamaño que el muro
    ADD.L #SIZE/4,D2        *quitamos 1/8 de cada lado
    MOVE.L D1,D3
    MOVE.L D2,D4
    ADD.L #SIZE/2,D3
    ADD.L #SIZE/2,D4
    MOVE.L #88,D0       *círculo
    TRAP #15
    MOVEM.L (A7)+,D0-D4
    RTS    
    
PINTAESPACIO
   MOVEM.L D0-D4,-(A7)
    MOVE.L D1,D3
    MOVE.L D2,D4
    ADD.L #SIZE,D3
    ADD.L #SIZE,D4
    MOVE.L #87,D0   *cuadrado
    TRAP #15
    MOVEM.L (A7)+,D0-D4
    RTS     
PINTAMOZO
    MOVEM.L D0-D4,-(A7)
    ADD.L #SIZE/4,D1         *mitad tamaño que el muro
    ADD.L #SIZE/4,D2        *quitamos 1/4 de cada lado
    MOVE.L D1,D3
    MOVE.L D2,D4
    ADD.L #SIZE/2,D3
    ADD.L #SIZE/2,D4
    MOVE.L #88,D0       *círculo
    TRAP #15
    MOVEM.L (A7)+,D0-D4
    RTS    
GRIS
   MOVEM.L D0-D1,-(A7)
    MOVE.L #81,D0
    MOVE.L #DRKGRAY,D1
    TRAP #15
    MOVEM.L (A7)+,D0-D1
    RTS
   
ROJO
   MOVEM.L D0-D1,-(A7)
    MOVE.L #81,D0
    MOVE.L #RED,D1
    TRAP #15
    MOVEM.L (A7)+,D0-D1
    RTS
  
AMARILLO   
    MOVEM.L D0-D1,-(A7)
    MOVE.L #81,D0
    MOVE.L #YELLOW,D1
    TRAP #15
    MOVEM.L (A7)+,D0-D1
    RTS
NEGRO 
   MOVEM.L D0-D1,-(A7)
    MOVE.L #81,D0
    MOVE.L #BLACK,D1
    TRAP #15
    MOVE.L #80,D0
    MOVE.L #BLACK,D1
    TRAP #15
    MOVEM.L (A7)+,D0-D1
    RTS
MORADO   
    MOVEM.L D0-D1,-(A7)
    MOVE.L #81,D0
    MOVE.L #PURPLE,D1
    TRAP #15
    MOVEM.L (A7)+,D0-D1
    RTS
VERDE   
    MOVEM.L D0-D1,-(A7)
    MOVE.L #81,D0
    MOVE.L #GREEN,D1
    TRAP #15
    MOVEM.L (A7)+,D0-D1
    RTS
AZUL
    MOVEM.L D0-D1,-(A7)
    MOVE.L #81,D0
    MOVE.L #BLUE,D1
    TRAP #15
    MOVEM.L (A7)+,D0-D1
    RTS        
    
    

  















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
