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
UP_MOVEMENT_DETECTED		DS.B 1
DOWN_MOVEMENT_DETECTED		DS.B 1
LEFT_MOVEMENT_DETECTED		DS.B 1
RIGHT_MOVEMENT_DETECTED		DS.B 1



* ===== LIBRARY SUBROUTINES ===== *
READ_KEYBOARD_SUBROUTINE

	JSR UPDATE_KEYBOARD_TIMER	; Compute time that has past and update timer flag if needed
	
	IF.B  KEYBOARD_TIMER_FLAG <EQ> #1 THEN.S
	
		JSR INIT_KEYBOARD_INPUT_HANDLER		; Clear all flags
	
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
	
INIT_KEYBOARD_INPUT_HANDLER
	JSR RESET_UP_MOVEMENT_FLAG
	JSR RESET_DOWN_MOVEMENT_FLAG
	JSR RESET_LEFT_MOVEMENT_FLAG
	JSR RESET_RIGHT_MOVEMENT_FLAG
	
	RTS













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
