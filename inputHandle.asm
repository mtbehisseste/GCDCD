	;;;;handle the input and change the corresponding map position
include lib.inc
.data
selectednumber byte 1
matchednumber byte 0
right byte "Matched!", 0
wrong byte "Not matched!", 0
gamewin byte "******************************************************", 10
		byte "******************************************************", 10
		byte "**   _       _       _  _ _ _ _ _ _  _ _      _     **", 10
		byte "**   \ \    /  \    / / _ _ _ _ _ _ |   \    | |    **", 10
		byte "**    \ \  / /\ \  / /      | |     |    \   | |    **", 10
		byte "**     \ \/ /  \ \/ /       | |     | | \ \  | |    **", 10
		byte "**      \  /    \  /    _ _ | | _ _ | |  \ \ | |    **", 10
		byte "**       \/      \/     _ _ _ _ _ _ |_|   \ _ _|    **", 10
		byte "**                                                  **", 10
		byte "******************************************************", 10
		byte "******************************************************", 10, 0

.code
inputHandle proc, mapInitaddr: dword, mapAnsaddr: dword, x: byte, y: byte
	;;analyze cursor position in map
	mov al, x				;find out item of the position in map_ans
	mov dl,	y
	shl dl, 4
	add al, dl				;position result store in al
	mov esi, mapAnsaddr
	movzx eax, al
	add esi, eax				;find current position in each map

	.if eax == ecx				;if select the same item as first time
		mov bl, 3
		ret
	.endif

	mov ebx, mapInitaddr			;check if item has already showed
	add ebx, eax
	mov dl, [ebx]
	.if dl == [esi]
		mov bl, 1
		ret
	.endif

	mov dl, x				
	mov dh, y
	call gotoxy
	push eax				;set color
	mov eax, 14				
	call settextcolor			
	mov al, [esi]
	call writechar
	pop eax

	.if selectednumber == 1			;first selected item
		mov selectednumber, 2		
		mov bl, 2			;bl used at inputHandleKeyboard proc
		ret
	.endif

	mov selectednumber, 1			;if not matched, reset counter
	mov bl, 0
	ret
inputHandle endp

judge proc, mapInitaddr: dword, mapAnsaddr: dword, firstp: dword, secondp: dword
	mov esi, mapAnsaddr
	add esi, firstp
	mov al, [esi]
	mov esi, mapAnsaddr
	add esi, secondp

	cmp al, [esi]
	jnz notmatched

	;;change map_init
	mov esi, mapInitaddr
	add esi, firstp
	mov [esi], al
	mov esi, mapInitaddr
	add esi, secondp
	mov [esi], al

	mov dl, 0				;print right string and delay and set text color
	mov dh, 8
	call gotoxy
	push eax
	mov eax, 13
	call settextcolor
	mov edx, offset right
	call writestring
	mov eax, 500
	call delay
	pop eax
	jmp matched
notmatched:
	mov dl, 0				;print wrong string and delay and set text color
	mov dh, 8
	call gotoxy
	push eax 
	mov eax, 13
	call settextcolor
	mov edx, offset wrong
	call writestring
	mov eax, 500
	call delay
	pop eax
	jmp printlabel
matched:
	inc matchednumber
printlabel:
	call clrscr
	.if matchednumber == 18		;all items are matched
		mov eax, 11
		call settextcolor
		mov edx, offset gamewin
		call writestring
		mov eax, white
		call settextcolor

		call waitmsg
		exit
	.endif
	invoke printMap, mapInitaddr
	ret
judge endp
end