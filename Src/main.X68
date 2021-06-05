*-----------------------------------------------------------
* Title      : Main
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       : 28/04/2021
* Description: 
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------

	



; Main function call
MAIN:	ORG $1000

	JSR SETUP	; Go to setup function
	
	JMP LOOP	; Start main loop
	
	JMP KILL_PROGRAM


SETUP	; This function will be called at starup of the program
	JSR INIT_TIMERS
	JSR INIT_KEYBOARD_INPUT_HANDLER	
	;JSR MUSICAL
	;JSR ENABLEBUFFER
	
	MOVE.L #0, LEVEL 
	JSR UPDATE_NEW_MAP
	
	JSR RESET_CHECK_POINT_MANAGER
		
	RTS
	
LOOP	; Main loop, this function will be called constantly until the end of the program

	JSR UPDATE_CURRENT_TIME
	
		* =====	CHECK KEYBOARD FOR INPUT ROUTINE 	===== * 
	JSR READ_KEYBOARD_SUBROUTINE
		
		* =====	CHECK KEYBOARD FLAGS ROUTINE 		===== *
	JSR HANDLE_MOVEMENTS
	
	JSR ENABLEBUFFER
	JSR PINTAMAPA
	JSR NOBUFFER
	
		 
	JSR MAP_CHANGER_CONTROLLER 
		
		* =====	CHECK KEYBOARD FLAGS ROUTINE 		===== *
	JMP LOOP
		
		
	* ===== INCLUDES ===== *
 
	INCLUDE "./TimerManager/Timers.x68"
	INCLUDE "./KeyboardInputHandler/KeyboardInputHandler.x68"
	; INCLUDE "./Commons.x68"
	INCLUDE "./GameController.x68"
	INCLUDE "./GameController/MapPainting.x68"


KILL_PROGRAM

	END MAIN
		























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
