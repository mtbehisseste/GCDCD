;;;;handle the input and change the corresponding map position
include lib.inc
.data
firstAddr dword ?
secondAddr dword ?

.code
inputHandle proc, input: dword, mapInitaddr: dword, mapAnsaddr
	;;analyze first input string
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
	add esi, eax
	mov eax, [esi]
	mov firstAddr, esi      ;store the chosen position address

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
	mov eax, [esi]
	mov secondAddr, esi     ;store the chosen position address

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
	call clrscr
	mov edx, firstAddr
	mov esi, secondAddr
	mov ebx, [edx]
	mov bl, 5fh
	mov [edx], ebx
	mov ebx, [esi]
	mov bl, 5fh
	mov [esi], ebx
same:
	invoke printMap, addr map_init
	call waitmsg
	ret
inputHandle endp
end