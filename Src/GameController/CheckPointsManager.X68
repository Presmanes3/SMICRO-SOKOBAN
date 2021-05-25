*-----------------------------------------------------------
* Title      : Check pointer manager
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       :
* Description:
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------
		
	PAGE
	
	ORG $14000
	
CHECK_POINTS_MANAGER:

* ===== VARIABLES ===== *
IS_BOX_OVER_CHECK_POINT 	DS.L 1		; Flag that indicates if box is on a checkpoint

IS_PLAYER_OVER_CHECK_POINT	DS.L 1		; Flag that indicates if player is on a checkpoint


* ===== FUNCTIONS ===== *

* @brief Check if box to operate is over a check point or not
* @return Set is box over check point flag if conditions 	
CHECK_BOX_OVER_CHECK_POINT
	MOVE.L #TOTAL_BOXES, D7	; Save TOTAL BOXES to D6 to operate
	MOVE.L #0, D6
	SUB.B #1, D7			; Substract 1 in order to avoid overflow
	
	MOVE.L #CHECK_POINT_X_ARRAY, A2		; Move checkpoint X coordinte array to A2
	MOVE.L #CHECK_POINT_Y_ARRAY, A3		; Move checkpoint X coordinte array to A3
	
	JSR GET_BOX_TO_OPERATE_D0_D1		; Get box X and Y position to D0 and D1
	
	FOR.L D6 = 0 TO D7 DO.S
		MOVE.L (A2)+, D2		; Get checkpoint X coordinate
		MOVE.L (A3)+, D3		; Get checkpoint Y coordinate
		
		IF.L D0 <EQ> D2 THEN.L		; If X coordinates are equal
		
			IF.L D1 <EQ> D3 THEN.L	; And if Y coordinates are equal				
				JSR SET_BOX_OVER_CHECK_POINT	; Box is over check point
				
				RTS								; End function
			ENDI	
		ENDI
	ENDF
	
	JSR RESET_BOX_OVER_CHECK_POINT

	RTS

* @brief Check if player is over a check point
* @return Set is player over check point if conditions
CHECK_PLAYER_ON_CHECK_POINT
	MOVE.L #TOTAL_CHECK_POINTS, D7		; Save TOTAL BOXES to D6 to operate
	MOVE.L #0, D6
	SUB.B #1, D7						; Substract 1 in order to avoid overflow
	
	MOVE.L #PLAYER_CURRENT_X, A0 		; Move player X coordinate to A0
	MOVE.L #PLAYER_CURRENT_Y, A1 		; Move player Y coordinate to A1
	MOVE.L #CHECK_POINT_X_ARRAY, A2		; Move checkpoint X coordinate array to A2
	MOVE.L #CHECK_POINT_Y_ARRAY, A3		; Move checkpoint Y coordinate array to A3
	
	MOVE.L (A0), D0				; Move player X position to D0
	MOVE.L (A1), D1				; Move player Y position to D1
	
	FOR.L D6 = 0 TO D7 DO.S
		MOVE.L (A2)+, D2		; Get checkpoint X coordinate
		MOVE.L (A3)+, D3		; Get checkpoint Y coordinate
		
		IF.L D0 <EQ> D2 THEN.L		; If X coordinates are equal
			IF.L D1 <EQ> D3 THEN.L	; And if Y coordinates are equal
				JSR SET_PLAYER_OVER_CHECK_POINT		; Player is over check point
				
				RTS									; End function
			ENDI			
		ENDI
	ENDF
	
	JSR RESET_PLAYER_OVER_CHECK_POINT	; Player is not over check point
	
	RTS	
	
* ===== SETTERS AND GETTERS ===== *
SET_PLAYER_OVER_CHECK_POINT
	MOVE.L #1, IS_PLAYER_OVER_CHECK_POINT
	RTS
	
RESET_PLAYER_OVER_CHECK_POINT
	MOVE.L #0, IS_PLAYER_OVER_CHECK_POINT
	RTS	
	
SET_BOX_OVER_CHECK_POINT
	MOVE.L #1, IS_BOX_OVER_CHECK_POINT
	RTS
	
RESET_BOX_OVER_CHECK_POINT
	MOVE.L #0, IS_BOX_OVER_CHECK_POINT
	RTS
	
RESET_CHECK_POINT_MANAGER
	MOVE.L #0, IS_BOX_OVER_CHECK_POINT
	MOVE.L #0, IS_PLAYER_OVER_CHECK_POINT
	RTS








	


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
