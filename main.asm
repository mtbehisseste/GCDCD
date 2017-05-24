INCLUDE lib.inc

main EQU start@0
.data          
; startTime dword ?          
; finishTime dword ?
; timespend byte "Time spent: ", 0
; minute dword 0
; second dword 0
; errorstring byte "You spend too much time, the world has crashed.", 0

.code
main proc
    ; call getmseconds            ;get start time
    ; mov startTime, eax

    invoke printMap, addr map_init      ;print initial map
    invoke inputHandleKeyboard, addr map_init, addr map_ans

    ;call timer

    call WaitMsg
    exit
main endp

; timer proc uses eax
;     call getmseconds
;     cmp eax, startTime          ;check if time overflow
;     jb error

;     sub eax, startTime

;     .while eax >= 60000
;         mov ebx, 60000
;         div ebx
;         inc minute
;         mov eax, edx            ;store remainder
;     .endw
;     mov second, eax

;     mov edx, offset timespend
;     call writestring
;     mov eax, minute
;     call writedec
;     mov al, ':'
;     call writechar
;     mov eax, second
;     call writedec
;     jmp return

; error:
;     mov edx, offset errorstring
;     call writestring 

; return:
;     ret
; timer endp
end