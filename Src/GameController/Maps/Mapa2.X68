*-----------------------------------------------------------
* Title      : Testing map
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       : 02/05/2021
* Description: Map designed for testing purpouses
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------
	ORG $20000
MAP2: 	DC.B '######  ',0
		DC.B '#    ###',0
		DC.B '# ##$$ #',0
		DC.B '# #  # #',0
		DC.B '#    # #',0
		DC.B '#.#    #',0
		DC.B '#. @####',0
		DC.B '#####   ',0
		DC.B '        ',0
 ORG $20050
MAP2_INFORMATION:		
		
* ===== MAP INFORMATION ===== *
MAP_WIDTH  EQU 9
MAP_HEIGHT EQU 9

* ===== PLAYER INFORMATION ===== *
PLAYER_START_X		EQU 3				; Starting X coordinate of player
PLAYER_START_Y		EQU 6				; Starting Y coordinate of player

* ===== BOXES INFORMATION ===== *
TOTAL_BOXES			EQU 2				; Total boxes in the game

BOX_START_X_ARRAY 	DC.L 4,5			; Array that indicates starting X coordinate of boxes
BOX_START_Y_ARRAY 	DC.L 2,2			; Array that indicated starting Y coordinate of boxes

* ===== CHECK POINTS INFORMATION ===== *
TOTAL_CHECK_POINTS	EQU TOTAL_BOXES		; Total check points based on total boxes

CHECK_POINT_X_ARRAY	DC.L 1,1			; Array that indicates X coordinate of check points
CHECK_POINT_Y_ARRAY	DC.L 5,6			; Array that indicated Y coordinate of check points
 
 ORG $21050
BACKUPMAP2: DC.B '######  ',0
		    DC.B '#    ###',0
		    DC.B '# ##$$ #',0
		    DC.B '# #  # #',0
		    DC.B '#    # #',0
		    DC.B '#.#    #',0
		    DC.B '#. @####',0
		    DC.B '#####   ',0
		    DC.B '        ',0







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
