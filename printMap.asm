;;;;read input parameter and print out map
include lib.inc 

.code
printMap proc uses eax ecx esi, map_row: dword
    mov ecx, 112
    mov esi, map_row
    .while ecx != 0
        mov al, [esi]
        call writechar
        inc esi
        dec ecx
    .endw
        call crlf
    ret
printMap endp
end