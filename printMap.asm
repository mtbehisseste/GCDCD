;;;;read input parameter and print out map
include lib.inc 

.code
printMap proc uses eax ecx esi, map_row: dword
    ;;reset color
    mov eax, white + (black*16)
    call settextcolor
    
    ;;print map
    mov ecx, 112
    mov esi, map_row
    .while ecx != 0
        mov al, [esi]
        call writechar
        inc esi
        dec ecx
    .endw
    ret
printMap endp
end