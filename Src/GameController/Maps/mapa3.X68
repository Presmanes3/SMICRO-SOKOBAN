*-----------------------------------------------------------
* Title      : Testing map
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       : 02/05/2021
* Description: Map designed for testing purpouses
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------
	ORG $10300
MAP_3: 	DC.B ' ####   ',0
		DC.B ' #  ### ',0
		DC.B ' #@$  # ',0
		DC.B '### # ##',0
		DC.B '#.# #  #',0
		DC.B '#.$  # #',0
		DC.B '#.   $ #',0
		DC.B '########',0
MAP_3_INFORMATION:

* ===== MAP INFORMATION ===== *
MAP_3_WIDTH  EQU 9
MAP_3_HEIGHT EQU 8

* ===== PLAYER INFORMATION ===== *
PLAYER_3_START_X		EQU 2				; Starting X coordinate of player
PLAYER_3_START_Y		EQU 2				; Starting Y coordinate of player

* ===== BOXES INFORMATION ===== *
	ORG $10370
TOTAL_BOXES_3		EQU 3				; Total boxes in the game

BOX_START_X_ARRAY_3 	DC.L 3,2,5	   ;Array that indicates starting X coordinate of boxes
BOX_START_Y_ARRAY_3 	DC.L 2,5,6		; Array that indicated starting Y coordinate of boxes

* ===== CHECK POINTS INFORMATION ===== *
	ORG $103A0
TOTAL_CHECK_POINTS_3	EQU TOTAL_BOXES_3		; Total check points based on total boxes

CHECK_POINT_X_ARRAY_3	DC.L 1,1,1			; Array that indicates X coordinate of check points
CHECK_POINT_Y_ARRAY_3	DC.L 4,5,6			; Array that indicated Y coordinate of check points






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
