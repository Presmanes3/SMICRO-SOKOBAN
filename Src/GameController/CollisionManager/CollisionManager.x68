*-----------------------------------------------------------
* Title      : Collision Manager
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       : 07/05/2021
* Description:
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------


	PAGE
	

	ORG $13000
COLLISION_MANAGER:


HAS_PLAYER_FOUND_BOX			DS.B 1
HAS_PLAYER_FOUND_WALL			DS.B 1

HAS_BOX_FOUND_BOX				DS.B 1
HAS_BOX_FOUND_WALL				DS.B 1



* ===== PLAYER ARROUND ===== *
GET_PLAYER_UP_ADDRESS
	JSR MOVE_PLAYER_UP
	
	MOVE.L PLAYER_CURRENT_X, D0		; Move current player X coordinate to D0
	MOVE.L PLAYER_CURRENT_Y, D1		; Move current player Y coordinate to D1
	
	JSR GET_MAP_ADDRESS				; Compute player current memory address
	
	JSR MOVE_PLAYER_DOWN
	
	RTS
	
GET_PLAYER_DOWN_ADDRESS
	JSR MOVE_PLAYER_DOWN
	
	MOVE.L PLAYER_CURRENT_X, D0		; Move current player X coordinate to D0
	MOVE.L PLAYER_CURRENT_Y, D1		; Move current player Y coordinate to D1
	
	JSR GET_MAP_ADDRESS				; Compute player current memory address
	
	JSR MOVE_PLAYER_UP
	RTS
	
GET_PLAYER_LEFT_ADDRESS
	JSR MOVE_PLAYER_LEFT
	
	MOVE.L PLAYER_CURRENT_X, D0		; Move current player X coordinate to D0
	MOVE.L PLAYER_CURRENT_Y, D1		; Move current player Y coordinate to D1
	
	JSR GET_MAP_ADDRESS				; Compute player current memory address
	
	JSR MOVE_PLAYER_RIGHT
	RTS
	
GET_PLAYER_RIGHT_ADDRESS
	JSR MOVE_PLAYER_RIGHT
	
	MOVE.L PLAYER_CURRENT_X, D0		; Move current player X coordinate to D0
	MOVE.L PLAYER_CURRENT_Y, D1		; Move current player Y coordinate to D1
	
	JSR GET_MAP_ADDRESS				; Compute player current memory address
	
	JSR MOVE_PLAYER_LEFT
	RTS
	
* ===== PLAYER COLLISIONS ===== *
CHECK_PLAYER_UP_COLLISION
	JSR GET_PLAYER_UP_ADDRESS
	JSR CHECK_PLAYER_COLLISION_D2
	
	RTS
	
CHECK_PLAYER_DOWN_COLLISION

	JSR GET_PLAYER_DOWN_ADDRESS
	JSR CHECK_PLAYER_COLLISION_D2

	RTS
	
CHECK_PLAYER_LEFT_COLLISION

	JSR GET_PLAYER_LEFT_ADDRESS
	JSR CHECK_PLAYER_COLLISION_D2

	RTS
	
CHECK_PLAYER_RIGHT_COLLISION

	JSR GET_PLAYER_RIGHT_ADDRESS
	JSR CHECK_PLAYER_COLLISION_D2
	RTS


* Check player collision based on address saved in D2
CHECK_PLAYER_COLLISION_D2

	MOVE.L D2, A0
	
	IF.B (A0) <EQ> #WALL_CHAR THEN.S
	
		JSR PLAYER_FOUND_WALL
	
	ENDI 
	IF.B (A0) <EQ> #BOX_CHAR THEN.S
		
		JSR PLAYER_FOUND_BOX
		
	ENDI
	RTS


* ===== BOX COLLISIONS ===== *
CHECK_BOX_UP_COLLISION
	JSR MOVE_BOX_UP				; Move box up
	
	
	MOVE.L #BOX_CURRENT_X_ARRAY, A0 	; Move box X coordinates array to D0
	MOVE.L #BOX_CURRENT_Y_ARRAY, A1 	; Move box Y coordinates array to D1
	MOVE.L BOX_TO_OPERATE, D7			; Move box to operate to D7
	
	MULU #4, D7							; Multiply D7 by 4 in order to compuse offset of the box to operate
	
	ADD.L D7, A0				; Add offset to A0
	ADD.L D7, A1				; Add offset to A1
	
	MOVE.L (A0), D0			
	MOVE.L (A1), D1
	
	JSR  GET_MAP_ADDRESS		; Compute Address of box and save it to D2
	
	JSR CHECK_BOX_COLLISION_D2	; Check collisions for box with address saved in D2
	
	JSR MOVE_BOX_DOWN			; Move box down
 
	RTS
	
CHECK_BOX_DOWN_COLLISION
	JSR MOVE_BOX_DOWN				; Move box up
	
	
	MOVE.L #BOX_CURRENT_X_ARRAY, A0 	; Move box X coordinates array to D0
	MOVE.L #BOX_CURRENT_Y_ARRAY, A1 	; Move box Y coordinates array to D1
	MOVE.L BOX_TO_OPERATE, D7			; Move box to operate to D7
	
	MULU #4, D7							; Multiply D7 by 4 in order to compuse offset of the box to operate
	
	ADD.L D7, A0				; Add offset to A0
	ADD.L D7, A1				; Add offset to A1
	
	MOVE.L (A0), D0			
	MOVE.L (A1), D1
	
	JSR  GET_MAP_ADDRESS		; Compute Address of box and save it to D2
	
	JSR CHECK_BOX_COLLISION_D2	; Check collisions for box with address saved in D2
	
	JSR MOVE_BOX_UP			; Move box down
 
	RTS

CHECK_BOX_LEFT_COLLISION
	JSR MOVE_BOX_LEFT				; Move box up
	
	
	MOVE.L #BOX_CURRENT_X_ARRAY, A0 	; Move box X coordinates array to D0
	MOVE.L #BOX_CURRENT_Y_ARRAY, A1 	; Move box Y coordinates array to D1
	MOVE.L BOX_TO_OPERATE, D7			; Move box to operate to D7
	
	MULU #4, D7							; Multiply D7 by 4 in order to compuse offset of the box to operate
	
	ADD.L D7, A0				; Add offset to A0
	ADD.L D7, A1				; Add offset to A1
	
	MOVE.L (A0), D0			
	MOVE.L (A1), D1
	
	JSR  GET_MAP_ADDRESS		; Compute Address of box and save it to D2
	
	JSR CHECK_BOX_COLLISION_D2	; Check collisions for box with address saved in D2
	
	JSR MOVE_BOX_RIGHT			; Move box down
 
	RTS
	
CHECK_BOX_RIGHT_COLLISION
	JSR MOVE_BOX_RIGHT				; Move box up
	
	
	MOVE.L #BOX_CURRENT_X_ARRAY, A0 	; Move box X coordinates array to D0
	MOVE.L #BOX_CURRENT_Y_ARRAY, A1 	; Move box Y coordinates array to D1
	MOVE.L BOX_TO_OPERATE, D7			; Move box to operate to D7
	
	MULU #4, D7							; Multiply D7 by 4 in order to compuse offset of the box to operate
	
	ADD.L D7, A0				; Add offset to A0
	ADD.L D7, A1				; Add offset to A1
	
	MOVE.L (A0), D0			
	MOVE.L (A1), D1
	
	JSR  GET_MAP_ADDRESS		; Compute Address of box and save it to D2
	
	JSR CHECK_BOX_COLLISION_D2	; Check collisions for box with address saved in D2
	
	JSR MOVE_BOX_LEFT			; Move box down
 
	RTS


* Check box collision based on address saved in D2
CHECK_BOX_COLLISION_D2

	MOVE.L D2, A0
	
	IF.B (A0) <EQ> #WALL_CHAR THEN.S
	
		JSR BOX_FOUND_WALL
	
	ENDI 
	IF.B (A0) <EQ> #BOX_CHAR THEN.S
		
		JSR BOX_FOUND_BOX
		
	ENDI
	RTS


	



* ===== SETTERS AND GETTERS ===== *

PLAYER_FOUND_BOX
	MOVE.B #1, HAS_PLAYER_FOUND_BOX
	RTS
	
PLAYER_FOUND_WALL
	MOVE.B #1, HAS_PLAYER_FOUND_WALL
	RTS
	
BOX_FOUND_BOX
	MOVE.B #1, HAS_BOX_FOUND_BOX
	RTS
	
BOX_FOUND_WALL
	MOVE.B #1, HAS_BOX_FOUND_WALL
	RTS
	
RESET_COLLISIONS_FLAGS
	MOVE.B #0, HAS_PLAYER_FOUND_BOX
	MOVE.B #0, HAS_PLAYER_FOUND_WALL
	MOVE.B #0, HAS_BOX_FOUND_BOX
	MOVE.B #0, HAS_BOX_FOUND_WALL
	RTS
	
INIT_COLLISION_MANAGER
	JSR RESET_COLLISIONS_FLAGS
	RTS
















	





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
