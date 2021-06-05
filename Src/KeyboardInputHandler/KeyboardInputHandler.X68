*-----------------------------------------------------------
* Title      :	Keyboard Input Handler
* Written by : 	Javier Presmanes Cardama & Samuel Garcia Such
* Date       :	28/04/2021
* Description:	The aim of this file is to isolate functions and variables used for detecting and modify keyboard inputs
* Repository : 	https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------

	PAGE

KEYBOARD:	ORG $6000

* =====		DECLARE VARIABLES	 ===== *
UP_MOVEMENT_DETECTED		DS.L 1
DOWN_MOVEMENT_DETECTED		DS.L 1
LEFT_MOVEMENT_DETECTED		DS.L 1
RIGHT_MOVEMENT_DETECTED		DS.L 1
RESTART_MAP_DETECTED		DS.L 1



* ===== LIBRARY SUBROUTINES ===== *
READ_KEYBOARD_SUBROUTINE

	JSR UPDATE_KEYBOARD_TIMER	; Compute time that has past and update timer flag if needed
	
	IF.L  KEYBOARD_TIMER_FLAG <EQ> #1 THEN.S
	
		JSR RESET_KEYBOARD_TIMER_FLAG
	
		JSR INIT_KEYBOARD_INPUT_HANDLER		; Clear all flags
		
		
		JSR READ_KEYBOARD					; Read in any interrupt has been detected
		
		; JSR DEACTIVATE_KEYBOARD_INTERRUPTS	; 
		
	ENDI
	RTS
	
READ_KEYBOARD

	MOVE.B #19, D0								; Move task 19 (return current state of keys) to D0
	MOVE.L #'A'<<24+'S'<<16+'D'<<8+'W', D1		; Check for keys A S D W
	TRAP #15
    
   
	
	BTST.L #24, D1	; Check if A has been pressed 
	IF <NE> THEN	
		JSR SET_LEFT_MOVEMENT_FLAG
	ENDI
	
	BTST.L #16, D1	; Check if S has been pressed
	IF <NE> THEN
		JSR SET_DOWN_MOVEMENT_FLAG
	ENDI

	BTST.L #8, D1	; Check if D has been pressed
	IF <NE> THEN
		JSR SET_RIGHT_MOVEMENT_FLAG
	ENDI
	
	BTST.L #0, D1	; Check if W has been pressed
	IF <NE> THEN
		JSR SET_UP_MOVEMENT_FLAG
	ENDI
	
    MOVE.B #19, D0								; Move task 19 (return current state of keys) to D0
	MOVE.L #'Z'<<24, D1		                ; Check for keys Z
	TRAP #15
	
    BTST.L #0, D1	; Check if Z has been pressed
	IF <NE> THEN
		JSR SET_RESTART_FLAG
	ENDI
	
	RTS

* ===== SETTERS AND RESETS FOR FLAGS ===== *	
SET_UP_MOVEMENT_FLAG
	MOVE.B #1, UP_MOVEMENT_DETECTED
	RTS

SET_DOWN_MOVEMENT_FLAG
	MOVE.B #1, DOWN_MOVEMENT_DETECTED
	RTS

SET_LEFT_MOVEMENT_FLAG
	MOVE.B #1, LEFT_MOVEMENT_DETECTED
	RTS

SET_RIGHT_MOVEMENT_FLAG
	MOVE.B #1, RIGHT_MOVEMENT_DETECTED
	RTS
	
SET_RESTART_FLAG
    MOVE.B #1,RESTART_MAP_DETECTED
    RTS

RESET_UP_MOVEMENT_FLAG
	MOVE.B #0, UP_MOVEMENT_DETECTED
	RTS

RESET_DOWN_MOVEMENT_FLAG
	MOVE.B #0, DOWN_MOVEMENT_DETECTED
	RTS

RESET_LEFT_MOVEMENT_FLAG
	MOVE.B #0, LEFT_MOVEMENT_DETECTED
	RTS

RESET_RIGHT_MOVEMENT_FLAG
	MOVE.B #0, RIGHT_MOVEMENT_DETECTED
	RTS
RESET_RESTART_FLAG
    MOVE.B #0, RESTART_MAP_DETECTED
    RTS	
INIT_KEYBOARD_INPUT_HANDLER
	JSR RESET_UP_MOVEMENT_FLAG
	JSR RESET_DOWN_MOVEMENT_FLAG
	JSR RESET_LEFT_MOVEMENT_FLAG
	JSR RESET_RIGHT_MOVEMENT_FLAG
	JSR RESET_RESTART_FLAG
	RTS



















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
