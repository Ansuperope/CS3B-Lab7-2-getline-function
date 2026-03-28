Write a function called getline (see the interface below) that accepts a file descriptor, a maximum number of characters/bytes to read, and a pointer to a buffer large enough to hold that maximum, and returns the number of characters/bytes read and a line from the file as a null terminated string (i.e. a C-String) in the buffer. getline should read characters from the file until it encounters either an end of line ('\n' which should be stripped but still counted), an end of file, or the maximum number of characters/bytes has been read. Note: use the read() system call and read only one byte at a time.

//*****************************************************************************
// Function getline:  Provided a file descriptor, max characters to read count, 
//                    and a pointer to a buffer large enought to hold that max,
//                    return the number of characters read (including '\n') and
//                    a line from the file stored in the buffer as a C-String
//                    (excluding any '\n').
//
//  X0: Must be a file descriptor for a file successfully opened for read
//      access by the caller. On return from the function, X0 should hold the
//      number bytes read, including the '\n' if it was encountered.
//  X1: Points to the first byte of the buffer to receive the line. This must
//      be preserved (i.e. X1 should still point to the buffer when this function
//      returns).
//  X2: The maximum length of the buffer pointed to by X1 (note this length
//      should account for the null termination of the read line (i.e. C-String)
//  LR: Must contain the return address (automatic when BL
//      is used for the call)
//  Registers X0 - X8 are modified and not preserved
Note: your function must remove '\n' from the input line if present and terminate the line/string with null. Hint: you have reached the end of the input file when read() is called to read one byte and returns zero characters/bytes read.

Create an assembly driver "main" to test your function and submit your output. Your driver should print each line read from the provided input file to the console (output an end-of-line after each line read from the input file by getline).

Ensure that your code (including driver) conforms to the course Coding Standard which is referenced in the Program Grading Rubrics.

Submission requirements: Upload your getline.s, driver7-2.s and any supporting source files (including makefile if used), your executable with a .out extension, and a screenshot depicting assembling, linking, and executing your code using the provided input file with the buffer (i.e. X2) set to 65.