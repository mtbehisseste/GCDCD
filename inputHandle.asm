;;;;handle the input and change the corresponding map position
include lib.inc
.data
firstAddr dword ?
secondAddr dword ?
fuckingWrongInput byte "Are you serious? Please make sure you input where the position is not showed.", 0dh, 0ah, 0

.code
inputHandle proc, input: dword, mapInitaddr: dword, mapAnsaddr
	.if [input] == 0ah
		exit
	.endif
	;;analyze first input string
start:						;label for error and re-input
	mov eax, 0
	mov edx, 0
	;get the first character   
	mov eax, [ebx]
	sub eax, 30h
	inc ebx
	;get the second character
	mov edx, [ebx]
	sub edx, 40h
	inc ebx 
	;change first position in map
	shl edx, 4
	shl eax, 1
	add eax, edx            ;position result store in al
	mov edx, mapInitaddr    
	mov esi, mapAnsaddr
	movzx eax, al
	add edx, eax
	push ecx
	mov ecx, [edx]
	.if cl != 5fh			;check if input has already show
		jmp repeatinput
	.endif
	pop ecx
	add esi, eax
	mov eax, [esi]
	mov firstAddr, edx      ;store the chosen position address

	push ebx
	mov ebx, [edx]          ;change 8bits value only
	mov bl, al
	mov [edx], ebx
	pop ebx
	mov ecx, [edx]          ;store in ecx for after compare

	;;analyze second input string
	;get the third character   
	mov eax, [ebx]
	sub eax, 30h
	inc ebx
	;get the fourth character
	mov edx, [ebx]
	sub edx, 40h
	inc ebx 
	;change second position in map
	shl edx, 4
	shl eax, 1
	add eax, edx            ;position result store in al

	mov edx, mapInitaddr    
	mov esi, mapAnsaddr
	movzx eax, al
	add edx, eax
	add esi, eax
	push ecx
	mov ecx, [edx]
	.if cl != 5fh			;check if input has already show
		jmp repeatinput
	.endif
	pop ecx
	mov eax, [esi]
	mov secondAddr, edx     ;store the chosen position address

	push ebx
	mov ebx, [edx]          ;change 8bits value only
	mov bl, al
	mov [edx], ebx
	pop ebx

	call clrscr
	invoke printMap, mapInitaddr
	call waitmsg

	;;judge if two characters are the same
	mov ebx, [edx]
	cmp cl, bl
	jz same
    ;restore map if not equal
	mov edx, firstAddr
	mov esi, secondAddr
	mov ebx, [edx]
	mov bl, 5fh
	mov [edx], ebx
	mov ebx, [esi]
	mov bl, 5fh
	mov [esi], ebx
	jmp exitpoint
same:
	;counting match number
	push eax
	mov al, [matchnumber]
	inc al
	mov [matchnumber], al
	pop eax
exitpoint:
	call clrscr
	invoke printMap, mapInitaddr
	ret

repeatinput:				;printing error message
	push edx
	call crlf
	mov edx, offset fuckingWrongInput
	call writestring
	call waitmsg
	pop edx

	call clrscr
	invoke printMap, mapInitaddr
	call readInput
	jmp start
inputHandle endp
end