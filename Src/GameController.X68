*-----------------------------------------------------------
* Title      : Game controller
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       : 03/05/2021
* Description: 
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------

	PAGE
	

	ORG $12000
GAME_CONTROLLER:
	
* ===== 	GAME CONTROLLER VARIABLES 	===== *	
PLAYER_CURRENT_X	DS.L 1				; Current X coordinate of player
PLAYER_CURRENT_Y	DS.L 1				; Current Y coordinate of player

MAX_GAME_BOXES		EQU	 10

BOX_CURRENT_X_ARRAY	DS.L MAX_GAME_BOXES	; Array that indicates current X coordinate of boxes
BOX_CURRENT_Y_ARRAY	DS.L MAX_GAME_BOXES ; Array that indicates current Y coordinate of boxes

* ===== GAME SYMBOLS ===== *
BLANK_CHAR			EQU ' '
PLAYER_CHAR			EQU '@'
WALL_CHAR 			EQU '#'
BOX_CHAR 			EQU '$'
CHECK_POINT_CHAR	EQU '.'


* ===== 	GAME CONTROLLER FUNCTIONS	===== *

* Get the address of the map memory based on X and Y position
* D0.L = X > Column
* D1.L = Y > Row
* Address will be stored and returned in D2
GET_MAP_ADDRESS
	MOVE.L #MAP, D2			; Move map address to D2 to make computations
	MOVE.L #MAP_WIDTH, D3	; Move map width to D3 to make computations
	
	MULU.W D1, D3			; Multiplay Row with map width
	
	ADD.L  D3, D2			; Add result to D2 (map address)
	ADD.L  D0, D2			; Add colum to D2 (map address)
	RTS
	

	INCLUDE "./GameController/Maps/TestingMap.x68"


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
