INCLUDE lib.inc

main EQU start@0
.data          

.code
main proc
    invoke printMap, addr map_init      ;print initial map
looppoint:
    mov al, [matchnumber]               ;check i f all items are matched
    mov bl, 18
    cmp al, bl
    ja exitpoint
    call readInput                      ;user input
    invoke inputHandle, ebx, addr map_init, addr map_ans    ;change map
    ;the two parameter is for the precise address of two map
    jmp looppoint
exitpoint:
    call WaitMsg
    exit
main endp
end main