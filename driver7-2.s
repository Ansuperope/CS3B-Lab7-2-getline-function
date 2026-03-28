// ---------------------------------------------------------------------
// Aspen Cristobal
// CS3b - lab-7-2
// mm/dd/2026
// ---------------------------------------------------------------------
// 	PURPOSE:
// Open a file and read each character one by one
// ---------------------------------------------------------------------
//	VARAIBLES:
// LOREM 
// ---------------------------------------------------------------------
// 	PSUEDOCODE:
// 1. Get file descriptor
//	a. Use openat to open file and get descriptor
//	b. Save file descriptor to preserved register to avoid loosing it
//
// 2. Read file contents one character at a time
//	a. Call function getline to do this. Pass it
//		i. file descriptor
//		ii. buffer to hold input
//		iii. Maximum lenght of buffer
//
// 3. Close file
//
// 4. End program 
// ---------------------------------------------------------------------
.global _start	// Provide program starting address 

// functions
.extern getline

_start: 
	// SYSTEM CALLS CONSTANTS
	.EQU SYS_openat,	56		// openat()
	.EQU SYS_close,		57		// close()
	.EQU SYS_exit,		93		// exit() supervisor call code 
    .EQU AT_FDCWD,		-100	// file descriptor

	// FLAGS
	.EQU O_RDONLY,	00		// read only

	// MODE / USER PERMISSIONS
	.EQU R__R__R__,	0444	// owner: read, group: read, other: read

	// GENERAL CONSTANTS
	.EQU MAX_READ,	65		// max buffer size / max read size

	.text  // code section 

	// -----------------------------------------------------------------
	// 1. OPEN FILE TO GET FILE DESCRIPTOR
	// PARAMETERS:
	//	X0: file descriptor
	//	X1: read file
	//	X2: flags
	//	X3: permissions
	// RETURN:
	//	X0: file descriptor
	// -----------------------------------------------------------------
	MOV X0, AT_FDCWD	// file descriptor
	LDR X1, =szReadFile	// file to read
	MOV X2, O_RDONLY	// flags, what we can do 
	MOV X3, R__R__R__	// user permissions
	MOV X8, SYS_openat	// open file
	SVC 0				// call Linux to open file

	// CHECK IF OPEN ERROR - EXIT IF ERROR
	CMP  X0, #0
	B.LT terminate

	// SAVE FILE DESCRIPTOR TO PRESERVE REGISTER
	MOV X19, X0

	// -----------------------------------------------------------------
	// 2. READ FILE CONTENTS - call getstring
	// PARAMETERS:
	//	X0: file descriptor
	//	X1: buffer to store file contents
	//	X2: max length of buffer pointed
	// RETURN:
	//	X0: file descriptor
	// -----------------------------------------------------------------
	MOV X0, X19			// file descriptor
	LDR X1, =szBuffer	// buffer
	MOV X2, MAX_READ	// max length
	BL  getline			// go to function

	// -----------------------------------------------------------------
	// 3. CLOSE FILE
	// PARAMETERS:
	//	X0: file descriptor
	// RETURN:
	//	X0: file descriptor
	// -----------------------------------------------------------------
	LDR X0, X19			// file descriptor variable value
	MOV X8, SYS_close

	// -----------------------------------------------------------------
	// 4. TERMINATE PROGRAM
	// -----------------------------------------------------------------
terminate: 
	MOV X0, #0			// set return code to 0, all good 
	MOV X8, #SYS_exit	// set exit() supervisor call code 
	SVC 0				// call Linux to exit 

	.data	// data section
szReadFile: .asciz	"Lab7-2InputFile.txt"	// file to read from
szBuffer: 	.skip 	MAX_READ				// stores read file contents

.end	// end of program, optional but good practice 
