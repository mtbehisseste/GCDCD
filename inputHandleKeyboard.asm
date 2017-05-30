;;;;handle input with keyboard
include lib.inc
.data
correct BYTE "OK I'll help you",0
compare BYTE "-help",0
wrong BYTE "What r u saying?",0
buffer  BYTE 10 DUP(0)

.code
inputHandleKeyboard proc uses ebx, mapInitaddr: dword, mapAnsaddr: dword
	;;print cursor position
print:
	mov dl, cursor.x
	mov dh, cursor.y
	;;reset previous position
	call gotoxy


	;;print '['
	sub dl, 1
	call gotoxy
	mov eax, 10
	call settextcolor
	mov al, '['
	call writechar
	;;print ']'
	add dl, 2
	call gotoxy
	mov eax, 10
	call settextcolor
	mov al, ']'
	call writechar

	push eax
	mov eax, 7
	call settextcolor
	pop eax

	push edx				;printing current position
	push eax
	mov dl, 0
	mov dh, 8
	call gotoxy
	mov al, '['
	call writechar
	mov al, cursor.x
	shr al, 1
	add al, 48
	call writechar
	mov al, ','
	call writechar
	mov al, cursor.y
	add al, 64
	call writechar
	mov al, ']'
	call writechar
	call crlf
	pop eax
	pop edx

;------------------------------------
	;;read cursor input 
waitInput:
	call readchar
	cmp eax, 4800h				;up
	jz up
	cmp eax, 5000h				;down
	jz down
	cmp eax, 4B00h				;left
	jz left
	cmp eax, 4D00h				;right
	jz right
	cmp eax, 1C0Dh				;enter
	jz ent
	cmp eax, 011Bh				;esc
	jz escp
	cmp eax, 3920h				;space
	jz help

	jmp  waitInput
help:							;Alvin Zhan
	.if bl == 2
		jmp print
	.endif 
    mov edx  , OFFSET buffer           ; 指定緩衝區  
    mov ecx  , ( SIZEOF buffer ) - 1   ; 扣掉null，指定最大讀取字串長度
	call readstring
	INVOKE str_compare,ADDR buffer,ADDR compare
	.IF ZERO?
		mov edx,offset correct
		call Writestring
		mov eax,2000
		call delay
		call Clrscr
		INVOKE printMap, mapAnsaddr
		mov eax,2000
		call delay
		call Clrscr
		invoke printMap, mapInitaddr      ;print initial map
	.else
		mov edx,offset wrong
		call Writestring
		mov eax,2000
		call delay
		call Clrscr
		invoke printMap, mapInitaddr 
	.endif
	jmp print
up:
	mov dl, cursor.x			;reset previous cursor
	mov dh, cursor.y
	call gotoxy
	mov al, ' '
	sub dl, 1
	call gotoxy
	call writechar
	add dl, 2
	call gotoxy
	call writechar

	mov dl, cursor.x
	mov dh, cursor.y
	dec dh						;go up
	cmp dh, 0
	jz print
	mov cursor.x, dl
	mov cursor.y, dh
	jmp print
down:                    
	mov dl, cursor.x			;reset previous cursor
	mov dh, cursor.y
	call gotoxy
	mov al, ' '
	sub dl, 1
	call gotoxy
	call writechar
	add dl, 2
	call gotoxy
	call writechar

	mov dl, cursor.x
	mov dh, cursor.y
	inc dh						;go down
	cmp dh, 7
	jz print
	mov cursor.x, dl
	mov cursor.y, dh
	jmp print
left:
	mov dl, cursor.x			;reset previous cursor
	mov dh, cursor.y
	mov al, ' '
	sub dl, 1
	call gotoxy
	call writechar
	add dl, 2
	call gotoxy
	call writechar

	mov dl, cursor.x
	mov dh, cursor.y
	sub dl, 2					;go left
	cmp dl, 0
	jz print
	mov cursor.x, dl
	mov cursor.y, dh
	jmp print
right:
	mov dl, cursor.x			;reset previous cursor
	mov dh, cursor.y
	mov al, ' '
	sub dl, 1
	call gotoxy
	call writechar
	mov al, ' '
	add dl, 2
	call gotoxy 
	call writechar

	mov dl, cursor.x
	mov dh, cursor.y
	add dl, 2
	cmp dl, 14
	jz print
	mov cursor.x, dl
	mov cursor.y, dh
	jmp print
ent:
	invoke inputHandle, mapInitaddr, mapAnsaddr, cursor.x, cursor.y
	.if bl == 1					;item has already showed
		jmp waitInput
	.elseif bl == 2				;first select
		mov ecx, eax			;mark first item
		jmp waitInput		
	.elseif bl == 3				;current select item is the same as first time
		jmp waitInput
	.endif

	push eax 					;second select
	mov eax, 1000
	call delay
	pop eax
	
	invoke judge, mapInitaddr, mapAnsaddr, ecx, eax		;ecx store first position, eax store second position
	mov ecx, 0					;reset for after use
	jmp print
escp:
	exit
	ret
inputHandleKeyboard endp
end