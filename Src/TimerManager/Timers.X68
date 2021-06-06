*-----------------------------------------------------------
* Title      : Timer Manager
* Written by : Javier Presmanes Cardama & Samuel Garcia Such
* Date       : 28/04/2021
* Description: This file will contain all timers used in order to avoid delays during the program execution
* Repository : https://github.com/Presmanes3/SMICRO-SOKOBAN
*-----------------------------------------------------------

	PAGE
	
	
TIMERS:		ORG $4000

CURRENT_TIME			DS.L	1	; Time base for the program since midnight
	
KEYBOARD_TIMER_TIMEOUT	EQU		7	; Period which the flag will be activated in [10ms]
KEYBOARD_TIMER_REF		DS.L	1	; Timer time base reference since midnight
KEYBOARD_TIMER_FLAG		DS.L	1	; Flag that indicates if timeout has past

CLK_TIMER_TIMEOUT	EQU		100	; Period which the flag will be activated in [10ms]
CLK_TIMER_REF		DS.L	1	; Timer time base reference since midnight
CLK_TIMER_FLAG		DS.L	1	; Flag that indicates if timeout has past

SCREEN_TIMER_TIMEOUT	EQU		2	; Period which the flag will be activated in [10ms]
SCREEN_TIMER_REF		DS.L	1	; Timer time base reference since midnight
SCREEN_TIMER_FLAG		DS.L	1	; Flag that indicated if timeout has past

DIFF					DS.L	1

UPDATE_CLK_TIMER
	MOVE.L CURRENT_TIME, D0
	SUB.L CLK_TIMER_REF, D0
	
	
	
	; If timeout has past
	IF.L D0 <HS> #CLK_TIMER_TIMEOUT THEN.S
		JSR SET_CLK_TIMER_FLAG				; Set timer flag
		
		MOVE.L CURRENT_TIME, CLK_TIMER_REF	; Update time reference again
	ENDI
	
	RTS
	
UPDATE_SCREEN_TIMER
	MOVE.L CURRENT_TIME, D0
	SUB.L SCREEN_TIMER_REF, D0
	
	
	
	; If timeout has past
	IF.L D0 <HS> #SCREEN_TIMER_TIMEOUT THEN.S
		JSR SET_SCREEN_TIMER_FLAG				; Set timer flag
		
		MOVE.L CURRENT_TIME, SCREEN_TIMER_REF	; Update time reference again
	ENDI
	
	RTS

UPDATE_KEYBOARD_TIMER
	MOVE.L CURRENT_TIME, D0
	SUB.L KEYBOARD_TIMER_REF, D0
	
	MOVE.L D0, DIFF
	
	; If timeout has past
	IF.L D0 <HS> #KEYBOARD_TIMER_TIMEOUT THEN.S
		JSR SET_KEYBOARD_TIMER_FLAG				; Set timer flag
		
		MOVE.L CURRENT_TIME, KEYBOARD_TIMER_REF	; Update time reference again
	ENDI
	
	RTS

UPDATE_CURRENT_TIME
	MOVE.L #8, D0
	TRAP #15
	
	; Current time since midnight has been saven in register D1.L
	MOVE.L	D1, CURRENT_TIME	; Save D1 register into CURRENT_TIME variable
	
	RTS
	
	 

* ===== SETTERS AND RESETS FOR FLAGS ===== *

SET_SCREEN_TIMER_FLAG
	MOVE.L #1, SCREEN_TIMER_FLAG
	RTS
SET_CLK_TIMER_FLAG
	MOVE.L #1, CLK_TIMER_FLAG
	RTS	

SET_KEYBOARD_TIMER_FLAG
	MOVE.L #1, KEYBOARD_TIMER_FLAG
	RTS

RESET_SCREEN_TIMER_FLAG
	MOVE.L #0, SCREEN_TIMER_FLAG
	RTS
	
RESET_KEYBOARD_TIMER_FLAG
	MOVE.L #0, KEYBOARD_TIMER_FLAG
	RTS
RESET_CLK_TIMER_FLAG
	MOVE.L #0, CLK_TIMER_FLAG
	RTS	


* ===== INIT TIMERS ===== *

INIT_TIMERS
	JSR RESET_SCREEN_TIMER_FLAG
	JSR RESET_KEYBOARD_TIMER_FLAG
	JSR RESET_CLK_TIMER_FLAG
	
	; Sert startup values to 0
	MOVE.L #0, CURRENT_TIME
	MOVE.L #0, KEYBOARD_TIMER_REF
	MOVE.L #0, SCREEN_TIMER_REF
	MOVE.L #0, CLK_TIMER_REF
	
	; Update references
	JSR UPDATE_CURRENT_TIME
	JSR UPDATE_SCREEN_TIMER
	JSR UPDATE_KEYBOARD_TIMER
	JSR UPDATE_CLK_TIMER
	
	RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
