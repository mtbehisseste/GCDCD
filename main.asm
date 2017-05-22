INCLUDE lib.inc

main EQU start@0
.data          
startTime dword ?          
finishTime dword ?
timespend byte "Time spent: ", 0
minute dword 0
second dword 0

.code
main proc
    call getmseconds            ;get start time
    mov startTime, eax

    mov eax, 5000
    call delay

    call timer

    ; invoke printMap, addr map_init      ;print initial map
    ; invoke inputHandleKeyboard, addr map_init, addr map_ans
    call WaitMsg
    exit
main endp

timer proc uses eax
    call getmseconds
    sub eax, startTime

    .while eax >= 60000
        mov ebx, 60000
        div ebx
        inc minute
        mov eax, edx            ;store remainder
    .endw
    mov second, eax

    mov edx, offset timespend
    call writestring
    mov eax, minute
    call writedec
    mov al, ':'
    call writechar
    mov eax, second
    call writedec

    ret
timer endp
end main