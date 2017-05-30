;;;;read input parameter and print out map
include lib.inc 

.code
printans proc uses eax ecx esi, map: dword
    ;;reset color
    mov eax, white + (black*16)
    call settextcolor
    
    ;;print map
    mov ecx, 112
    mov esi, map
    .while ecx != 0
        mov al, [esi]
        call writechar
        inc esi
        dec ecx
    .endw
    ret
printans endp
end