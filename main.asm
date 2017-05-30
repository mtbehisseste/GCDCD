INCLUDE lib.inc

main EQU start@0
.data          

.code
main proc
    invoke startingframe    
    call WaitMsg
    call clrscr

    invoke printMap, addr map_init      ;print initial map
    invoke inputHandleKeyboard, addr map_init, addr map_ans

    call WaitMsg
    exit
main endp
end