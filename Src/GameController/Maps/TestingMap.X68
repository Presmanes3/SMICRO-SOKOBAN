*-----------------------------------------------------------
* Title      : Testing map
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       : 02/05/2021
* Description: Map designed for testing purpouses
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------
	ORG $10000
MAP: 	DC.B '#######',0
		DC.B '#@    #',0
		DC.B '# $$  #',0
		DC.B '# #. .#',0
		DC.B '#     #',0
		DC.B '#######',0
	
	ORG $10070
MAP_INFORMATION:
* ===== MAP INFORMATION ===== *
MAP_WIDTH  EQU 8
MAP_HEIGHT EQU 5

* ===== PLAYER INFORMATION ===== *
PLAYER_START_X		EQU 1				; Starting X coordinate of player
PLAYER_START_Y		EQU 1				; Starting Y coordinate of player

* ===== BOXES INFORMATION ===== *
	ORG $10080
TOTAL_BOXES			EQU 2				; Total boxes in the game

BOX_START_X_ARRAY 	DC.L 2,3			; Array that indicates starting X coordinate of boxes
BOX_START_Y_ARRAY 	DC.L 2,2			; Array that indicated starting Y coordinate of boxes

* ===== CHECK POINTS INFORMATION ===== *
	ORG $100A0
TOTAL_CHECK_POINTS	EQU TOTAL_BOXES		; Total check points based on total boxes

CHECK_POINT_X_ARRAY	DC.L 3,5			; Array that indicates X coordinate of check points
CHECK_POINT_Y_ARRAY	DC.L 3,3			; Array that indicated Y coordinate of check points

	ORG $100B0
MAP_BACKUP: 	DC.B '#######',0
				DC.B '#@    #',0
				DC.B '# $$  #',0
				DC.B '# #. .#',0
				DC.B '#     #',0
				DC.B '#######',0
	
	



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
