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

BOX_TO_OPERATE		DS.L 1				; Variable that indicates which box must be used for computation

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



* ===== PLAYER MOVEMENTS ===== *
* Substitute player icon with an space
DELETE_PLAYER_MEM
	MOVE.L PLAYER_CURRENT_X, D0	; Move current player X coordinate to D0
	MOVE.L PLAYER_CURRENT_Y, D1	; Move current player Y coordinate to D1
	
	JSR GET_MAP_ADDRESS				; Compute player current memory address
	
	MOVE.L D2, A0					; Move result to A0
	
	MOVE.B #BLANK_CHAR, (A0)		; Move balnk char to pointer pointe by A0
	
	RTS

* Write player icon in current X,Y coordinates
WRITE_PLAYER_MEM
	MOVE.L PLAYER_CURRENT_X, D0		; Move current player X coordinate to D0
	MOVE.L PLAYER_CURRENT_Y, D1		; Move current player Y coordinate to D1
	
	JSR GET_MAP_ADDRESS				; Compute player current memory address
	
	MOVE.L D2, A0					; Move result to A0
	
	MOVE.B #PLAYER_CHAR, (A0)		; Move balnk char to pointer pointe by A0

	RTS

MOVE_PLAYER_RIGHT
	ADD.L #1, PLAYER_CURRENT_X
	RTS
	
MOVE_PLAYER_LEFT
	SUB.L #1, PLAYER_CURRENT_X
	RTS
	
MOVE_PLAYER_UP
	SUB.L #1, PLAYER_CURRENT_Y
	RTS
	
MOVE_PLAYER_DOWN
	ADD.L #1, PLAYER_CURRENT_Y
	RTS
	
* ===== BOX MOVEMENTS ===== *
* Delete box selected by index saved at D2
DELETE_BOX_MEM

	MOVE.L #BOX_CURRENT_X_ARRAY, A0 	; Move box X coordinates array to D0
	MOVE.L #BOX_CURRENT_Y_ARRAY, A1 	; Move box Y coordinates array to D1
	MOVE.B BOX_TO_OPERATE, D2
	
	MULU   #4, D2
	
	ADD.L  D2, A0						; Get box Address by index saved at D2
	ADD.L  D2, A1						; Get box Address by index saved at D2
	
	MOVE.L (A0), D0
	MOVE.L (A1), D1
	
	JSR GET_MAP_ADDRESS					; Compute box current memory address
	
	MOVE.L D2, A0						; Move result to A0
	
	MOVE.B #BLANK_CHAR, (A0)			; Move blank char to pointer pointe by A0
	
	RTS

* Write player icon in current X,Y coordinates
WRITE_BOX_MEM
	MOVE.L #BOX_CURRENT_X_ARRAY, A0 	; Move box X coordinates array to D0
	MOVE.L #BOX_CURRENT_Y_ARRAY, A1 	; Move box Y coordinates array to D1
	MOVE.B BOX_TO_OPERATE, D2
	
	MULU   #4, D2
	
	ADD.L  D2, A0						; Get box Address by index saved at D2
	ADD.L  D2, A1						; Get box Address by index saved at D2
	
	MOVE.L (A0), D0
	MOVE.L (A1), D1
	
	JSR GET_MAP_ADDRESS					; Compute box current memory address
	
	MOVE.L D2, A0						; Move result to A0
	
	MOVE.B #BOX_CHAR, (A0)			; Move box char to pointer pointe by A0

	RTS

MOVE_BOX_RIGHT
	MOVE.B BOX_TO_OPERATE, D2
	MULU   #4, D2
	
	MOVE.L #BOX_CURRENT_X_ARRAY, A0
	
	ADD.L D2, A0
	
	ADD.L #1, (A0)

	RTS
	
MOVE_BOX_LEFT
	MOVE.B BOX_TO_OPERATE, D2
	MULU   #4, D2
	
	MOVE.L #BOX_CURRENT_X_ARRAY, A0
	
	ADD.L D2, A0
	
	SUB.L #1, (A0)
	RTS
	
MOVE_BOX_UP
	MOVE.B BOX_TO_OPERATE, D2
	MULU   #4, D2
	
	MOVE.L #BOX_CURRENT_Y_ARRAY, A0
	
	ADD.L D2, A0
	
	SUB.L #1, (A0)
	RTS
	
MOVE_BOX_DOWN
	MOVE.B BOX_TO_OPERATE, D2
	MULU   #4, D2
	
	MOVE.L #BOX_CURRENT_Y_ARRAY, A0
	
	ADD.L D2, A0
	
	ADD.L #1, (A0)
	RTS
	


UPLOAD_MAP

	* ----- UPLOAD BOXES ----- *
	MOVE.L #TOTAL_BOXES, D0
	SUB.B #1, D0
	
	MOVE.L #BOX_START_X_ARRAY, A0
	MOVE.L #BOX_START_Y_ARRAY, A1
	MOVE.L #BOX_CURRENT_X_ARRAY, A2
	MOVE.L #BOX_CURRENT_Y_ARRAY, A3
	
	FOR.L D1 = #0 TO D0 DO.S
								; Copy array for coordinates
		MOVE.L (A0)+, (A2)		; Copy value from (A0) to (A2)
		ADD.L #4, A2			; Move to next address
		
		MOVE.L (A1)+, (A3)		; Copy value from (A1) to (A3)
		ADD.L #4, A3			; Move to next address
		
	ENDF
	
	MOVE.L #0, D0
	MOVE.L #0, A0
	MOVE.L #0, A1
	MOVE.L #0, A2
	MOVE.L #0, A3
	
	* ----- UPLOAD PLAYER ----- *
	MOVE.L #PLAYER_START_X, PLAYER_CURRENT_X
	MOVE.L #PLAYER_START_Y, PLAYER_CURRENT_Y
	
	RTS

	INCLUDE "./GameController/Maps/TestingMap.x68"





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
