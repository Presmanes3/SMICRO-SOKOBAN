*-----------------------------------------------------------
* Title      : Testing map
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       : 02/05/2021
* Description: Map designed for testing purpouses
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------
	ORG $10100
MAP_1: 	DC.B '  ##### ',0
		DC.B '###   # ',0
		DC.B '#.@$  # ',0	* 0 > Check point (1,2) || Box (3,2)
		DC.B '### $.# ',0	* 1 > Check point (5,3) || Box (4,3)
		DC.B '#.##$ # ',0	* 2 > Check point (1,4) || Box (4,4)
		DC.B '# # . ##',0	* 3 > Check point (4,5) || Box (1,6)
		DC.B '#$  $$.#',0	* 4 > Check point (6,6) || Box (4,6)
		DC.B '#   .  #',0	* 5 > Check point (4,7) || Box (5,6)
		DC.B '########',0
MAP_1_INFORMATION:
		
* ===== MAP INFORMATION ===== *
MAP_1_WIDTH  EQU 9
MAP_1_HEIGHT EQU 9

* ===== PLAYER INFORMATION ===== *
PLAYER_1_START_X		EQU 2				; Starting X coordinate of player
PLAYER_1_START_Y		EQU 2				; Starting Y coordinate of player

* ===== BOXES INFORMATION ===== *
	ORG $10170
TOTAL_BOXES_1			EQU 6				; Total boxes in the game

							*0,1,2,3,4,5
BOX_START_X_ARRAY_1 	DC.L 3,4,4,1,4,5			; Array that indicates starting X coordinate of boxes
BOX_START_Y_ARRAY_1 	DC.L 2,3,4,6,6,6			; Array that indicated starting Y coordinate of boxes
	
* ===== CHECK POINTS INFORMATION ===== *
	ORG $101B0
TOTAL_CHECK_POINTS_1	EQU TOTAL_BOXES_1		; Total check points based on total boxes

							*0,1,2,3,4,5
CHECK_POINT_X_ARRAY_1	DC.L 1,5,1,4,6,4			; Array that indicates X coordinate of check points
CHECK_POINT_Y_ARRAY_1	DC.L 2,3,4,5,6,7			; Array that indicated Y coordinate of check points




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
