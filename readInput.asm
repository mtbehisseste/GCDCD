;;;;print input title and read user input
include lib.inc
BufSize = 80

.data 
inputPosition byte "Please input two position (ex. 1A1B): ", 0
buffer byte BufSize dup(?), 0, 0
stdInHandle handle ?
bytesRead dword ?

.code
readInput proc uses edx eax
    ;;printing input title
    mov edx, offset inputPosition
    call Crlf
    call WriteString

    ;;read user input
    invoke GetStdHandle, STD_INPUT_HANDLE
    mov stdInHandle, eax
    invoke ReadConsole, stdInHandle, addr buffer, BufSize, addr bytesRead, 0

    mov ebx, offset buffer      ;store the result in ebx to use it outside the procedure
    ret 
readInput endp
end