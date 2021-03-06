*-----------------------------------------------------------
* Title      : Testing map
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       : 02/05/2021
* Description: Map designed for testing purpouses
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------
	ORG $10300
MAP_2: 	DC.B '######  ',0
		DC.B '#    ###',0
		DC.B '# # $$ #',0 * 0 > Box (4,2) || 1 > Box (5,2)
		DC.B '# #  # #',0
		DC.B '#    # #',0
		DC.B '#.     #',0 * 0 > Check Point (1,5) 
		DC.B '#. @####',0 * 0 > Check Point (1,6)  
		DC.B '#####   ',0
		DC.B '        ',0
MAP_2_INFORMATION:
* ===== MAP INFORMATION ===== *
MAP_2_WIDTH  EQU 9
MAP_2_HEIGHT EQU 9

* ===== PLAYER INFORMATION ===== *
PLAYER_2_START_X		EQU 3				; Starting X coordinate of player
PLAYER_2_START_Y		EQU 6				; Starting Y coordinate of player

* ===== BOXES INFORMATION ===== *
	ORG $10370
TOTAL_BOXES_2			EQU 2				; Total boxes in the game

BOX_START_X_ARRAY_2 	DC.L 4,5			; Array that indicates starting X coordinate of boxes
BOX_START_Y_ARRAY_2 	DC.L 2,2			; Array that indicated starting Y coordinate of boxes

* ===== CHECK POINTS INFORMATION ===== *
	ORG $103B0
TOTAL_CHECK_POINTS_2	EQU TOTAL_BOXES_2		; Total check points based on total boxes

CHECK_POINT_X_ARRAY_2	DC.L 1,1			; Array that indicates X coordinate of check points
CHECK_POINT_Y_ARRAY_2	DC.L 5,6			; Array that indicated Y coordinate of check points

 	ORG $10400
MAP_2_BACKUP: 	DC.B '######  ',0
		    	DC.B '#    ###',0
		    	DC.B '# # $$ #',0
		    	DC.B '# #  # #',0
		    	DC.B '#    # #',0
		    	DC.B '#.     #',0
		    	DC.B '#. @####',0
		    	DC.B '#####   ',0
		    	DC.B '        ',0









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
