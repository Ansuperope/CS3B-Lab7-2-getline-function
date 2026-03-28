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
// 1. Save variables:
//  a. file to read
//  b. string buffer
//  c. lenght
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

    .text
    // hello Gianni :3

    RET

.end
