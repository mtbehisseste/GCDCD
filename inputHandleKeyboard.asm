;;;;handle input with keyboard 
include lib.inc

.code
keyboardinput proc uses ebx 
	;;print cursor position
print:
	mov dl, cursor.x
	mov dh, cursor.y
	;;reset previous position
	call gotoxy


	;;print '['
	sub dl, 1
	call gotoxy
	mov eax, 11
	call settextcolor
	mov al, '['
	call writechar
	;;print ']'
	add dl, 2
	call gotoxy
	mov eax, 11
	call settextcolor
	mov al, ']'
	call writechar

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
	; cmp  eax, 1C0Dh			;enter
	; jz   ent
	jmp  waitInput
up:
	mov dl, cursor.x             ;reset previous cursor
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
	dec dh                      ;go up
	cmp dh, 0
	jz waitInput
	mov cursor.x, dl
	mov cursor.y, dh
	jmp print
down:                    
	mov dl, cursor.x            ;reset previous cursor
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
	inc dh                      ;go down
	cmp dh, 7
	jz waitInput
	mov cursor.x, dl
	mov cursor.y, dh
	jmp print
left:
	mov dl, cursor.x            ;reset previous cursor
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
	sub dl, 2                   ;go left
	cmp dl, 0
	jz waitInput
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
	jz waitInput
	mov cursor.x, dl
	mov cursor.y, dh
	jmp print
; ent:
;     mov bh, cursor.x
;     mov bl, cursor.y
;     inc bl 
;     cmp bl, 0
;     jz waitInput
;     mov cursor.x, bh
;     mov cursor.y, bl
;     jmp print

	ret
keyboardinput endp
end