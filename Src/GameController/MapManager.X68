*-----------------------------------------------------------
* Title      :
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       :
* Description:
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------

	
	PAGE
	ORG $20000
MAP_MANAGER:

CURRENT_MAP DC.L 1



* @brief function for cleaning all memory related to map
CLEAR_CURRENT_MAP

	* Delete map
	FOR.L D6 = #0 TO #MAP_WIDTH DO.L
		FOR.L D7 = #0 TO #MAP_HEIGHT DO.L
			MOVE.B D6, D0
			MOVE.B D7, D1
			
			JSR GET_MAP_ADDRESS
			
			MOVE.L D2, A0
			MOVE.B #$FF, (A0)
		
		ENDF
	ENDF
	
	* Clear box array
	MOVE.L #BOX_START_X_ARRAY, A0
	MOVE.L #BOX_START_Y_ARRAY, A1
	MOVE.L #TOTAL_BOXES, D7
	SUB.L #1, D7
	
	FOR.B D6 = #0 TO D7 DO.S
		MOVE.L #$FFFFFFFF, (A0)+
		MOVE.L #$FFFFFFFF, (A1)+
	
	ENDF
	
	* Clear check point array
	MOVE.L #CHECK_POINT_X_ARRAY, A0
	MOVE.L #CHECK_POINT_y_ARRAY, A1
	MOVE.L #TOTAL_CHECK_POINTS, D7
	SUB.L #1, D7
	
	FOR.B D6 = #0 TO D7 DO.S
		MOVE.L #$FFFFFFFF, (A0)+
		MOVE.L #$FFFFFFFF, (A1)+
	
	ENDF

	RTS
	
	
* ===== CHARGE MAPS ===== *
CHARGE_MAP_1
	* Update Boxes
	MOVE.L #TOTAL_BOXES_1, LEVEL_TOTAL_BOXES
	MOVE.L #TOTAL_BOXES_1, D0
	SUB.B #1, D0
	
	MOVE.L #BOX_START_X_ARRAY_1, A0
	MOVE.L #BOX_START_Y_ARRAY_1, A1
	MOVE.L #BOX_CURRENT_X_ARRAY, A2
	MOVE.L #BOX_CURRENT_Y_ARRAY, A3

	FOR.L D1 = #0 TO D0 DO.S
								; Copy array for coordinates
		MOVE.L (A0)+, (A2)		; Copy value from (A0) to (A2)
		ADD.L #4, A2			; Move to next address
		
		MOVE.L (A1)+, (A3)		; Copy value from (A1) to (A3)
		ADD.L #4, A3			; Move to next address
	ENDF
	
	* Update Check Points 
	MOVE.L #TOTAL_CHECK_POINTS_1, LEVEL_TOTAL_CHECK_POINTS
	MOVE.L #TOTAL_CHECK_POINTS_1, D0
	SUB.B #1, D0
	
	MOVE.L #CHECK_POINT_X_ARRAY_1, A0
	MOVE.L #CHECK_POINT_Y_ARRAY_1, A1
	MOVE.L #CHECK_POINT_CURRENT_X_ARRAY, A2
	MOVE.L #CHECK_POINT_CURRENT_Y_ARRAY, A3

	FOR.L D1 = #0 TO D0 DO.S
								; Copy array for coordinates
		MOVE.L (A0)+, (A2)		; Copy value from (A0) to (A2)
		ADD.L #4, A2			; Move to next address
		
		MOVE.L (A1)+, (A3)		; Copy value from (A1) to (A3)
		ADD.L #4, A3			; Move to next address
	ENDF
	
	* Update map dimensions
	MOVE.L #MAP_1_WIDTH, LEVEL_MAP_WIDTH
	MOVE.L #MAP_1_HEIGHT, LEVEL_MAP_HEIGHT
	
	* Update map address
	MOVE.L #MAP_1, LEVEL_MAP_ADDRESS
	
	* Update player variables
	MOVE.L #PLAYER_1_START_X, PLAYER_CURRENT_X
	MOVE.L #PLAYER_1_START_Y, PLAYER_CURRENT_Y
	
	RTS
	
	
CHARGE_MAP_2
	* Update Boxes
	MOVE.L #TOTAL_BOXES_2, LEVEL_TOTAL_BOXES
	MOVE.L #TOTAL_BOXES_2, D0
	SUB.B #1, D0
	
	MOVE.L #BOX_START_X_ARRAY_2, A0
	MOVE.L #BOX_START_Y_ARRAY_2, A1
	MOVE.L #BOX_CURRENT_X_ARRAY, A2
	MOVE.L #BOX_CURRENT_Y_ARRAY, A3

	FOR.L D1 = #0 TO D0 DO.S
								; Copy array for coordinates
		MOVE.L (A0)+, (A2)		; Copy value from (A0) to (A2)
		ADD.L #4, A2			; Move to next address
		
		MOVE.L (A1)+, (A3)		; Copy value from (A1) to (A3)
		ADD.L #4, A3			; Move to next address
	ENDF
	
	* Update Check Points 
	MOVE.L #TOTAL_CHECK_POINTS_2, LEVEL_TOTAL_CHECK_POINTS
	MOVE.L #TOTAL_CHECK_POINTS_2, D0
	SUB.B #1, D0
	
	MOVE.L #CHECK_POINT_X_ARRAY_2, A0
	MOVE.L #CHECK_POINT_Y_ARRAY_2, A1
	MOVE.L #CHECK_POINT_CURRENT_X_ARRAY, A2
	MOVE.L #CHECK_POINT_CURRENT_Y_ARRAY, A3

	FOR.L D1 = #0 TO D0 DO.S
								; Copy array for coordinates
		MOVE.L (A0)+, (A2)		; Copy value from (A0) to (A2)
		ADD.L #4, A2			; Move to next address
		
		MOVE.L (A1)+, (A3)		; Copy value from (A1) to (A3)
		ADD.L #4, A3			; Move to next address
	ENDF
	
	* Update map dimensions
	MOVE.L #MAP_2_WIDTH, LEVEL_MAP_WIDTH
	MOVE.L #MAP_2_HEIGHT, LEVEL_MAP_HEIGHT
	
	* Update map address
	MOVE.L #MAP_2, LEVEL_MAP_ADDRESS
	
	* Update player variables
	MOVE.L #PLAYER_2_START_X, PLAYER_CURRENT_X
	MOVE.L #PLAYER_2_START_Y, PLAYER_CURRENT_Y
	

	RTS
	
CHARGE_MAP_3
	* Update Boxes
	MOVE.L #TOTAL_BOXES_3, LEVEL_TOTAL_BOXES
	MOVE.L #TOTAL_BOXES_3, D0
	SUB.B #1, D0
	
	MOVE.L #BOX_START_X_ARRAY_3, A0
	MOVE.L #BOX_START_Y_ARRAY_3, A1
	MOVE.L #BOX_CURRENT_X_ARRAY, A2
	MOVE.L #BOX_CURRENT_Y_ARRAY, A3

	FOR.L D1 = #0 TO D0 DO.S
								; Copy array for coordinates
		MOVE.L (A0)+, (A2)		; Copy value from (A0) to (A2)
		ADD.L #4, A2			; Move to next address
		
		MOVE.L (A1)+, (A3)		; Copy value from (A1) to (A3)
		ADD.L #4, A3			; Move to next address
	ENDF
	
	* Update Check Points 
	MOVE.L #TOTAL_CHECK_POINTS_3, LEVEL_TOTAL_CHECK_POINTS
	MOVE.L #TOTAL_CHECK_POINTS_3, D0
	SUB.B #1, D0
	
	MOVE.L #CHECK_POINT_X_ARRAY_3, A0
	MOVE.L #CHECK_POINT_Y_ARRAY_3, A1
	MOVE.L #CHECK_POINT_CURRENT_X_ARRAY, A2
	MOVE.L #CHECK_POINT_CURRENT_Y_ARRAY, A3

	FOR.L D1 = #0 TO D0 DO.S
								; Copy array for coordinates
		MOVE.L (A0)+, (A2)		; Copy value from (A0) to (A2)
		ADD.L #4, A2			; Move to next address
		
		MOVE.L (A1)+, (A3)		; Copy value from (A1) to (A3)
		ADD.L #4, A3			; Move to next address
	ENDF
	
	* Update map dimensions
	MOVE.L #MAP_3_WIDTH, LEVEL_MAP_WIDTH
	MOVE.L #MAP_3_HEIGHT, LEVEL_MAP_HEIGHT
	
	* Update map address
	MOVE.L #MAP_3, LEVEL_MAP_ADDRESS
	
	* Update player variables
	MOVE.L #PLAYER_3_START_X, PLAYER_CURRENT_X
	MOVE.L #PLAYER_3_START_Y, PLAYER_CURRENT_Y
	

	RTS













	* Include access to different maps
	INCLUDE "./GameController/Maps/Mapa1.x68"
	INCLUDE "./GameController/Maps/Mapa2.x68"
	INCLUDE "./GameController/Maps/Mapa3.x68"
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
