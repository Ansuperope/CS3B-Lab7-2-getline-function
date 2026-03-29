// ---------------------------------------------------------------------
// Aspen Cristobal
// CS3b - lab-7-2
// mm/dd/2026
// ---------------------------------------------------------------------
// 	PURPOSE:
// Provided a file descriptor, max characters to read count, 
// and a pointer to a buffer large enought to hold that max,
// return the number of characters read (including '\n') and
// a line from the file stored in the buffer as a C-String
// (excluding any '\n').
// ---------------------------------------------------------------------
// 	PSUEDOCODE:
// 1. Save variables + initalize:
//  a. X0: file descriptor
//  b. X1: string buffer
//  c. X2: length
//
// 2. Iterate through each letter in contents of file
//  a. Check if we reached max number of characters to read
//      i. exit if so 
//  b. Read character
//  c. Check if no more characters to read (read returned 0)
//      i. exit 
//  d. Check if character is a null
//      i. replace null with '\0'
//      ii. exit
//
// 4. End program 
// ---------------------------------------------------------------------
.global getline

getline:
    // CONSTANT SYSTEM CALLS
    .EQU STDOUT,    1
    .EQU SYS_write, 64  // write()
    .EQU SYS_read,  63  // read()

    .text
    // -----------------------------------------------------------------
    // INITALIZE
    //  X0 -> X3: file descriptor
    //  X1 -> X4: string buffer
    //  X2 -> X5: length
    //  X6: counter 
    // -----------------------------------------------------------------
    MOV X3, X0      // file des
    MOV X4, X1      // string buff
    MOV X5, X2      // length
    MOV X6, #0      // counter / index = 0
    
    // -----------------------------------------------------------------
    // READ FILE
    //  X0: characters counted
    //  X3: file descriptor
    //  X4: string buffer
    //  X5: length
    //  X6: counter / index
    //  X7: current character
    // -----------------------------------------------------------------
readFile:
    // CHECK IF REACHED MAX READ LENGTH
    CMP  X6, X5         // counter > max lenght
    B.GT returnMain

    // -----------------------------------------------------------------
    // READ A CHARACTER
    //  X0 = X3: file descriptor
    //  X1 = X4: character buffer
    //  X2 = 1: size
    // RETURNS
    //  X0: characters counted
    // -----------------------------------------------------------------
    MOV X0, X3          // file descriptor
    MOV X1, X4          // character buffer
    MOV X3, #1          // size count
    MOV X8, SYS_read    // read()
    SVC 0               // execute

    // -----------------------------------------------------------------
    // GET CHARACTER
    //  X4:      character buffer
    //  X6:      counter / index
    //  X7 / W7: current character
    // -----------------------------------------------------------------
    STRB W7, [X4, X6]           // W7 = string[counter]
    
    // CHECK IF CHARACTER IS NULL
    CMP  W7, #'\n'
    B.EQ changeNull

    // CHECK IF NO MORE TO READ
    CMP  X0, #0
    B.EQ returnMain

    // -----------------------------------------------------------------
    // OUTPUT CHARACTER
    //  X0: stdout
    //  X1 = X4: character to output
    //  X2: length of string
    // -----------------------------------------------------------------
    MOV X0, STDOUT
    MOV X1, X4
    MOV X2, #1
    MOV X8, SYS_write
    SVC 0

    // INCREMENT COUNTER
    ADD X6, X6, #1

    // -----------------------------------------------------------------
    // CHANGE NULL TO '\0'
    //  X7 / W7: current character
    // -----------------------------------------------------------------
changeNull:
    MOV W7, '\0'

    // -----------------------------------------------------------------
    // RETURN TO MAIN
    // -----------------------------------------------------------------
returnMain:
    RET

.end
