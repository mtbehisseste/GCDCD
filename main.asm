INCLUDE lib.inc

main EQU start@0
.data          

.code
main proc
    invoke printMap, addr map_init      ;print initial map
    call readInput                      ;user input
    invoke inputHandle, ebx, addr map_init, addr map_ans    ;change map
    ;the two parameter is for the precise address of two map
    call clrscr
    call WaitMsg
    exit
main endp
end main