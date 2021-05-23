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

PLAYER_CAN_MOVE_UP		DS.B 1			; Signal that indicates if player can move up 
PLAYER_CAN_MOVE_DOWN	DS.B 1			; Signal that indicates if player can move down
PLAYER_CAN_MOVE_LEFT	DS.B 1			; Signal that indicates if player can move left
PLAYER_CAN_MOVE_RIGHT	DS.B 1			; Signal that indicates if player can move right

MAX_GAME_BOXES		EQU	 10

BOX_CURRENT_X_ARRAY	DS.L MAX_GAME_BOXES	; Array that indicates current X coordinate of boxes
BOX_CURRENT_Y_ARRAY	DS.L MAX_GAME_BOXES ; Array that indicates current Y coordinate of boxes

BOX_TO_OPERATE		DS.L 1				; Variable that indicates which box must be used for computation

BOX_CAN_MOVE_UP		DS.B 1				; Signal that indicates if box can move up
BOX_CAN_MOVE_DOWN	DS.B 1				; Signal that indicates if box can move down
BOX_CAN_MOVE_LEFT	DS.B 1				; Signal that indicates if box can move left
BOX_CAN_MOVE_RIGHT	DS.B 1				; Signal that indicates if box can move right

* ===== GAME SYMBOLS ===== *
BLANK_CHAR					EQU ' '
PLAYER_CHAR					EQU '@'
WALL_CHAR 					EQU '#'
BOX_CHAR 					EQU '$'
CHECK_POINT_CHAR			EQU '.'
BOX_ON_CHECK_POINT_CHAR		EQU '*'
PLAYER_ON_CHECK_POINT_CHAR 	EQU '+'


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

HANDLE_PLAYER_MOVEMENT

* ======================= UP MOVEMENT ==================================== *
	IF.B UP_MOVEMENT_DETECTED <EQ> #1 THEN.L
	
		* CHECK PLAYER UP COLLISIONS *
		JSR CHECK_PLAYER_UP_COLLISION
		
		* IF PLAYER HAS FOUND A BOX THEN CHECK BOX FOR UP COLLSION
		IF.B HAS_PLAYER_FOUND_BOX <EQ> #1 THEN.L
			JSR RESET_PLAYER_MOVE_UP_FLAG
			
			JSR GET_PLAYER_UP_ADDRESS
			
			JSR IDENTIFY_BOX_AT_D2
			
			JSR CHECK_BOX_UP_COLLISION
			
			* IF BOX HAS FOUND WALL
			IF.B HAS_BOX_FOUND_WALL <EQ> #1 THEN.L
				JSR RESET_BOX_MOVE_UP_FLAG			; Dont allow movement
			ELSE
			* IF BOX HAS FOUND BOX
				IF.B HAS_BOX_FOUND_BOX <EQ> #1 THEN.L
					JSR RESET_BOX_MOVE_UP_FLAG		; Dont allow movement
				ELSE
					JSR ALLOW_BOX_MOVE_UP			; Allow movement
				ENDI
			ENDI
		ELSE
		
			* IF PLAYER HAS FOUND A WALL THEN DONT ALLOW MOVEMENT
			IF.B HAS_PLAYER_FOUND_WALL <EQ> #1 THEN.S
				JSR RESET_PLAYER_MOVE_UP_FLAG
			ELSE
			
			* ALLOW MOVEMENT
				JSR ALLOW_PLAYER_MOVE_UP
			ENDI
		ENDI
		
		* IF BOX CAN MOVE UP, MOVE IT UP
		IF.B BOX_CAN_MOVE_UP <EQ> #1 THEN.S
			JSR RESET_BOX_MOVE_UP_FLAG
			
			JSR MOVE_BOX_UP_ROUTINE
		ENDI

		* IF PLAYER CAN MOVE UP MOVE IT UP	
		IF.B PLAYER_CAN_MOVE_UP <EQ> #1 THEN.S
			JSR RESET_UP_MOVEMENT_FLAG
			JSR RESET_PLAYER_MOVE_UP_FLAG
		
			JSR MOVE_PLAYER_UP_ROUTINE
		ENDI
	ENDI 

* ============================= DOWN MOVEMENT ==========================*
	IF.B DOWN_MOVEMENT_DETECTED <EQ> #1 THEN.L
		
		* CHECK PLAYER DOWN COLLISIONS
		JSR CHECK_PLAYER_DOWN_COLLISION
		
		* IF PLAYER HAS FOUND A BOX, THEN CHECK BOX DOWN COLLISION
		IF.B HAS_PLAYER_FOUND_BOX <EQ> #1 THEN.S
			JSR RESET_PLAYER_MOVE_DOWN_FLAG

			JSR GET_PLAYER_DOWN_ADDRESS
			
			JSR IDENTIFY_BOX_AT_D2
			
			JSR CHECK_BOX_DOWN_COLLISION
			
			* IF BOX HAS FOUND WALL
			IF.B HAS_BOX_FOUND_WALL <EQ> #1 THEN.L
				JSR RESET_BOX_MOVE_DOWN_FLAG			; Dont allow movement
			ELSE
			* IF BOX HAS FOUND BOX
				IF.B HAS_BOX_FOUND_BOX <EQ> #1 THEN.L
					JSR RESET_BOX_MOVE_DOWN_FLAG		; Dont allow movement
				ELSE
					JSR ALLOW_BOX_MOVE_DOWN			; Allow movement
				ENDI
			ENDI

		ELSE
		
		* IF PLAYER HAS FOUND A WALL, DONT ALLOW MOVEMENT
			IF.B HAS_PLAYER_FOUND_WALL <EQ> #1 THEN.S
				JSR RESET_PLAYER_MOVE_DOWN_FLAG
			ELSE
				
		* ALLOW MOVEMENT
				JSR ALLOW_PLAYER_MOVE_DOWN
			ENDI
		ENDI
		
		* IF BOX CAN MOVE DOWN, MOVE IT UP
		IF.B BOX_CAN_MOVE_DOWN <EQ> #1 THEN.S
			JSR RESET_BOX_MOVE_DOWN_FLAG
			
			JSR MOVE_BOX_DOWN_ROUTINE
		ENDI
		
		* IF PLAYER CAN MOVE, MOVE IT DOWN
		IF.B PLAYER_CAN_MOVE_DOWN <EQ> #1 THEN.S
			JSR RESET_DOWN_MOVEMENT_FLAG	
	
			JSR MOVE_PLAYER_DOWN_ROUTINE
		ENDI
	ENDI
	
* ==================== LEFT MOVEMENT =================================== *
	IF.B LEFT_MOVEMENT_DETECTED <EQ> #1 THEN.L
	
		* CHECK PLAYER LEFT COLLISIONS
		JSR CHECK_PLAYER_LEFT_COLLISION
		
		* IF PLAYER HAS FOUND A BOX, THEN CHECK BOX LEFT COLLISION
		IF.B HAS_PLAYER_FOUND_BOX <EQ> #1 THEN.S
			JSR RESET_PLAYER_MOVE_LEFT_FLAG

			JSR GET_PLAYER_LEFT_ADDRESS
			
			JSR IDENTIFY_BOX_AT_D2
			
			JSR CHECK_BOX_LEFT_COLLISION
			
			* IF BOX HAS FOUND WALL
			IF.B HAS_BOX_FOUND_WALL <EQ> #1 THEN.L
				JSR RESET_BOX_MOVE_LEFT_FLAG			; Dont allow movement
			ELSE
			* IF BOX HAS FOUND BOX
				IF.B HAS_BOX_FOUND_BOX <EQ> #1 THEN.L
					JSR RESET_BOX_MOVE_LEFT_FLAG		; Dont allow movement
				ELSE
					JSR ALLOW_BOX_MOVE_LEFT			; Allow movement
				ENDI
			ENDI
		
		ELSE
		
		* IF PLAYER HAS FOUND A WALL, DONT ALLOW MOVEMENT
			IF.B HAS_PLAYER_FOUND_WALL <EQ> #1 THEN.S
				JSR RESET_PLAYER_MOVE_LEFT_FLAG
			ELSE
				
		* ALLOW MOVEMENT
				JSR ALLOW_PLAYER_MOVE_LEFT
			ENDI
		ENDI
		
		* IF BOX CAN MOVE LEFT, MOVE IT UP
		IF.B BOX_CAN_MOVE_LEFT <EQ> #1 THEN.S
			JSR RESET_BOX_MOVE_LEFT_FLAG
			
			JSR MOVE_BOX_LEFT_ROUTINE
		ENDI

		* IF PLAYER CAN MOVE, MOVE IT LEFT		
		IF.B PLAYER_CAN_MOVE_LEFT <EQ> #1 THEN.S
			JSR RESET_LEFT_MOVEMENT_FLAG
		
			JSR MOVE_PLAYER_LEFT_ROUTINE
		ENDI
	ENDI 

* ================== RIGHT MOVEMENT ======================== *
	IF.B RIGHT_MOVEMENT_DETECTED <EQ> #1 THEN.L

		* CHECK PLAYER RIGHT COLLISIONS
		JSR CHECK_PLAYER_RIGHT_COLLISION
		
		* IF PLAYER HAS FOUND A BOX, THEN CHECK BOX LEFT COLLISION
		IF.B HAS_PLAYER_FOUND_BOX <EQ> #1 THEN.S
			JSR RESET_PLAYER_MOVE_RIGHT_FLAG

			JSR GET_PLAYER_RIGHT_ADDRESS
			
			JSR IDENTIFY_BOX_AT_D2
			
			JSR CHECK_BOX_RIGHT_COLLISION
			
			* IF BOX HAS FOUND WALL
			IF.B HAS_BOX_FOUND_WALL <EQ> #1 THEN.L
				JSR RESET_BOX_MOVE_RIGHT_FLAG			; Dont allow movement
			ELSE
			* IF BOX HAS FOUND BOX
				IF.B HAS_BOX_FOUND_BOX <EQ> #1 THEN.L
					JSR RESET_BOX_MOVE_RIGHT_FLAG		; Dont allow movement
				ELSE
					JSR ALLOW_BOX_MOVE_RIGHT			; Allow movement
				ENDI
			ENDI
			
		ELSE
		
			* IF PLAYER HAS FOUND A WALL, DONT ALLOW MOVEMENT
			IF.B HAS_PLAYER_FOUND_WALL <EQ> #1 THEN.S
				JSR RESET_PLAYER_MOVE_RIGHT_FLAG
			ELSE
				
			* ALLOW MOVEMENT
				JSR ALLOW_PLAYER_MOVE_RIGHT
			ENDI
		ENDI
		
		* IF BOX CAN MOVE RIGHT, MOVE IT UP
		IF.B BOX_CAN_MOVE_RIGHT <EQ> #1 THEN.S
			JSR RESET_BOX_MOVE_RIGHT_FLAG
			
			JSR MOVE_BOX_RIGHT_ROUTINE
		ENDI
		
		* IF PLAYER CAN MOVE, THEN MOVE IT RIGHT
		IF.B PLAYER_CAN_MOVE_RIGHT <EQ> #1 THEN.S 
			JSR RESET_RIGHT_MOVEMENT_FLAG	
			JSR MOVE_PLAYER_RIGHT_ROUTINE
		ENDI
	ENDI
	
	
	
	JSR RESET_COLLISIONS_FLAGS	
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
	
MOVE_PLAYER_UP_ROUTINE
	JSR DELETE_PLAYER_MEM
	JSR MOVE_PLAYER_UP
	JSR WRITE_PLAYER_MEM
	RTS
	
MOVE_PLAYER_DOWN_ROUTINE
	JSR DELETE_PLAYER_MEM
	JSR MOVE_PLAYER_DOWN
	JSR WRITE_PLAYER_MEM
	RTS
	
MOVE_PLAYER_LEFT_ROUTINE
	JSR DELETE_PLAYER_MEM
	JSR MOVE_PLAYER_LEFT
	JSR WRITE_PLAYER_MEM
	RTS
	
MOVE_PLAYER_RIGHT_ROUTINE
	JSR DELETE_PLAYER_MEM
	JSR MOVE_PLAYER_RIGHT
	JSR WRITE_PLAYER_MEM
	RTS
	
* ===== BOX MOVEMENTS ===== *
* Delete box selected by index saved at D2
DELETE_BOX_MEM

	MOVE.L #BOX_CURRENT_X_ARRAY, A0 	; Move box X coordinates array to D0
	MOVE.L #BOX_CURRENT_Y_ARRAY, A1 	; Move box Y coordinates array to D1
	MOVE.L BOX_TO_OPERATE, D2
	
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
	MOVE.L BOX_TO_OPERATE, D2
	
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
	MOVE.L BOX_TO_OPERATE, D2	
	MULU   #4, D2				; Compute offset for selecting box in array
	
	MOVE.L #BOX_CURRENT_X_ARRAY, A0
	
	ADD.L D2, A0
	
	ADD.L #1, (A0)

	RTS
	
MOVE_BOX_LEFT
	MOVE.L BOX_TO_OPERATE, D2
	MULU   #4, D2				; Compute offset for selecting box in array
	
	MOVE.L #BOX_CURRENT_X_ARRAY, A0
	
	ADD.L D2, A0
	
	SUB.L #1, (A0)
	RTS
	
MOVE_BOX_UP
	MOVE.L BOX_TO_OPERATE, D2
	MULU   #4, D2				; Compute offset for selecting box in array
	
	MOVE.L #BOX_CURRENT_Y_ARRAY, A1
	
	ADD.L D2, A1
	
	SUB.L #1, (A1)
	RTS
	
MOVE_BOX_DOWN
	MOVE.L BOX_TO_OPERATE, D2
	MULU   #4, D2				; Compute offset for selecting box in array

	MOVE.L #BOX_CURRENT_Y_ARRAY, A1
	
	ADD.L D2, A1
	
	ADD.L #1, (A1)
	RTS
	
* @brief Complete move the box up
* @param Box must be set in BOX_TO_OPERATE
MOVE_BOX_UP_ROUTINE
	JSR DELETE_BOX_MEM
	JSR MOVE_BOX_UP
	JSR WRITE_BOX_MEM
	RTS

* @brief Complete move the box down
* @param Box must be set in BOX_TO_OPERATE
MOVE_BOX_DOWN_ROUTINE
	JSR DELETE_BOX_MEM
	JSR MOVE_BOX_DOWN
	JSR WRITE_BOX_MEM
	RTS

* @brief Complete move the box left
* @param Box must be set in BOX_TO_OPERATE
MOVE_BOX_LEFT_ROUTINE
	JSR DELETE_BOX_MEM
	JSR MOVE_BOX_LEFT
	JSR WRITE_BOX_MEM
	RTS

* @brief Complete move the box right
* @param Box must be set in BOX_TO_OPERATE
MOVE_BOX_RIGHT_ROUTINE
	JSR DELETE_BOX_MEM
	JSR MOVE_BOX_RIGHT
	JSR WRITE_BOX_MEM
	RTS
	

* @brief Get index of box in the box index
* @param Box address in D2
* @return Box index in BOX_TO_OPERATE
IDENTIFY_BOX_AT_D2
	MOVE.L D2, D7			; Move address to D7 as backup
	MOVE.L #TOTAL_BOXES, D6	; Save TOTAL BOXES to D6 to operate
	SUB.B #1, D6			; Substract 1 in order to avoid overflow
	
	MOVE.L #BOX_CURRENT_X_ARRAY, A0 	; Move box X coordinates array to D0
	MOVE.L #BOX_CURRENT_Y_ARRAY, A1 	; Move box Y coordinates array to D1
	
	FOR.L D5 = #0 TO D6 DO.S	; For every box
		MOVE.L (A0)+, D0		; Get box X coordinate
		MOVE.L (A1)+, D1		; Get box Y coordinate
		
		JSR GET_MAP_ADDRESS		; Compute map address
		
		IF.L D2 <EQ> D7 THEN.S
		
			MOVE.L D5, BOX_TO_OPERATE
			
			MOVE.L D6, D5		; End FOR by setting D5 to max (D6)
		ENDI
	ENDF 

	RTS
	
* ===== CHECK POINT PRINTER ===== *
PRINT_CHECKPOINTS
	MOVE.L #TOTAL_CHECK_POINTS, D7
	SUB.B #1, D7
	
	MOVE.L #CHECK_POINT_X_ARRAY, A0
	MOVE.L #CHECK_POINT_Y_ARRAY, A1
	
	FOR.L D6 = #0 TO D7 DO.S
		MOVE.L (A0)+, D0
		MOVE.L (A1)+, D1
		
		JSR GET_MAP_ADDRESS
		
		MOVE.L D2, A2
		MOVE.B #CHECK_POINT_CHAR, (A2)
		
	ENDF
	
	RTS

UPLOAD_MAP

	* TODO : ADD BINARY FILE BASED ON MAP SELECTOR *

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
ENABLEBUFFER
  MOVE.b	#92,d0
  MOVE.b	#17,d1				  
  TRAP		#15	
  RTS	

	
* ===== SETTERS AND GETTERS ===== *
* ===== PLAYER ===== *
ALLOW_PLAYER_MOVE_UP
	MOVE.B #1, PLAYER_CAN_MOVE_UP
	RTS
	
ALLOW_PLAYER_MOVE_DOWN
	MOVE.B #1, PLAYER_CAN_MOVE_DOWN
	RTS
	
ALLOW_PLAYER_MOVE_LEFT
	MOVE.B #1, PLAYER_CAN_MOVE_LEFT
	RTS
	
ALLOW_PLAYER_MOVE_RIGHT
	MOVE.B #1, PLAYER_CAN_MOVE_RIGHT
	RTS
	
RESET_PLAYER_MOVE_UP_FLAG
	MOVE.B #0, PLAYER_CAN_MOVE_UP
	RTS
	
RESET_PLAYER_MOVE_DOWN_FLAG
	MOVE.B #0, PLAYER_CAN_MOVE_DOWN
	RTS
	
RESET_PLAYER_MOVE_LEFT_FLAG
	MOVE.B #0, PLAYER_CAN_MOVE_LEFT
	RTS
	
RESET_PLAYER_MOVE_RIGHT_FLAG
	MOVE.B #0, PLAYER_CAN_MOVE_RIGHT
	RTS

* ===== BOXES ===== *
ALLOW_BOX_MOVE_UP
	MOVE.B #1, BOX_CAN_MOVE_UP
	RTS
	
ALLOW_BOX_MOVE_DOWN
	MOVE.B #1, BOX_CAN_MOVE_DOWN
	RTS
	
ALLOW_BOX_MOVE_LEFT
	MOVE.B #1, BOX_CAN_MOVE_LEFT
	RTS
	
ALLOW_BOX_MOVE_RIGHT
	MOVE.B #1, BOX_CAN_MOVE_RIGHT
	RTS
	
RESET_BOX_MOVE_UP_FLAG
	MOVE.B #0, BOX_CAN_MOVE_UP
	RTS
	
RESET_BOX_MOVE_DOWN_FLAG
	MOVE.B #0, BOX_CAN_MOVE_DOWN
	RTS
	
RESET_BOX_MOVE_LEFT_FLAG
	MOVE.B #0, BOX_CAN_MOVE_LEFT
	RTS
	
RESET_BOX_MOVE_RIGHT_FLAG
	MOVE.B #0, BOX_CAN_MOVE_RIGHT
	RTS

	INCLUDE "./GameController/CollisionManager/CollisionManager.x68"
	INCLUDE "./GameController/Maps/TestingMap.x68"








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
