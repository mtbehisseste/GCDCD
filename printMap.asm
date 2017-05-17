;;;;read input parameter and print out map
include lib.inc 

.code
printMap proc uses edx, map_row: dword
    mov edx, map_row
    call WriteString
    call Crlf
    ret
printMap endp
end