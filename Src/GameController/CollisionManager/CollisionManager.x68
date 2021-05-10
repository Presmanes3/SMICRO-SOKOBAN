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


* ===== PLAYER COLLISIONS ===== *
CHECK_PLAYER_UP_COLLISION
	JSR MOVE_PLAYER_UP			; Move player up
	
	MOVE.L PLAYER_CURRENT_X, D0
	MOVE.L PLAYER_CURRENT_Y, D1
	
	JSR  GET_MAP_ADDRESS		; Compute Address of player and save it to D2
	
	JSR CHECK_PLAYER_COLLISION_D2
	
	JSR MOVE_PLAYER_DOWN			; Move player down
	
 
	RTS
	
CHECK_PLAYER_DOWN_COLLISION

	JSR MOVE_PLAYER_DOWN			; Move player up
	
	MOVE.L PLAYER_CURRENT_X, D0
	MOVE.L PLAYER_CURRENT_Y, D1
	
	JSR  GET_MAP_ADDRESS		; Compute Address of player and save it to D2
	
	JSR CHECK_PLAYER_COLLISION_D2
	
	JSR MOVE_PLAYER_UP			; Move player down

	RTS
	
CHECK_PLAYER_LEFT_COLLISION

	JSR MOVE_PLAYER_LEFT			; Move player up
	
	MOVE.L PLAYER_CURRENT_X, D0
	MOVE.L PLAYER_CURRENT_Y, D1
	
	JSR  GET_MAP_ADDRESS		; Compute Address of player and save it to D2
	
	JSR CHECK_PLAYER_COLLISION_D2
	
	JSR MOVE_PLAYER_RIGHT			; Move player down

	RTS
	
CHECK_PLAYER_RIGHT_COLLISION

	JSR MOVE_PLAYER_RIGHT			; Move player up
	
	MOVE.L PLAYER_CURRENT_X, D0
	MOVE.L PLAYER_CURRENT_Y, D1
	
	JSR  GET_MAP_ADDRESS		; Compute Address of player and save it to D2
	
	JSR CHECK_PLAYER_COLLISION_D2
	
	JSR MOVE_PLAYER_LEFT			; Move player down

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
