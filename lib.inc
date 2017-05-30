INCLUDE Irvine32.inc

startingframe proto
printMap proto map_row: dword
printans proto map:dword
inputHandle proto mapInitaddr: dword, mapAnsaddr: dword, x: byte, y: byte
inputHandleKeyboard proto mapInitaddr: dword, mapAnsaddr: dword
judge proto mapInitaddr: dword, mapAnsaddr: dword, firstp: dword, secondp: dword


.data
;initial map
map_init byte '  ', '1 ', '2 ', '3 ', '4 ', '5 ', '6 ', 0dh, 0ah
         byte 'A ', '_ ', '_ ', '_ ', '_ ', '_ ', '_ ', 0dh, 0ah
         byte 'B ', '_ ', '_ ', '_ ', '_ ', '_ ', '_ ', 0dh, 0ah
         byte 'C ', '_ ', '_ ', '_ ', '_ ', '_ ', '_ ', 0dh, 0ah
         byte 'D ', '_ ', '_ ', '_ ', '_ ', '_ ', '_ ', 0dh, 0ah
         byte 'E ', '_ ', '_ ', '_ ', '_ ', '_ ', '_ ', 0dh, 0ah
         byte 'F ', '_ ', '_ ', '_ ', '_ ', '_ ', '_ ', 0dh, 0ah
;   "  1 2 3 4 5 6 ", 0dh, 0ah,
;   "A _ _ _ _ _ _ ", 0dh, 0ah,
;   "B _ _ _ _ _ _ ", 0dh, 0ah,
;   "C _ _ _ _ _ _ ", 0dh, 0ah,
;   "D _ _ _ _ _ _ ", 0dh, 0ah,
;   "E _ _ _ _ _ _ ", 0dh, 0ah,
;   "F _ _ _ _ _ _ ", 0dh, 0ah, 0

;the answer map
map_ans byte '  ', '1 ', '2 ', '3 ', '4 ', '5 ', '6 ', 0dh, 0ah
        byte 'A ', '$ ', '$ ', '! ', '& ', 'x ', '< ', 0dh, 0ah
        byte 'B ', 'o ', '< ', 'x ', '+ ', '# ', ': ', 0dh, 0ah
        byte 'C ', '% ', ': ', '@ ', '? ', '% ', '. ', 0dh, 0ah
        byte 'D ', '+ ', '/ ', '# ', 'o ', '> ', '> ', 0dh, 0ah
        byte 'E ', '. ', '& ', '* ', '\ ', '* ', '| ', 0dh, 0ah
        byte 'F ', '| ', '! ', '\ ', '@ ', '? ', '/ ', 0dh, 0ah

;  "  1 2 3 4 5 6 ", 0dh, 0ah,
;  "A $ $ ! & x < ", 0dh, 0ah,
;  "B o < x + # : ", 0dh, 0ah,
;  "C % : @ ? % . ", 0dh, 0ah,
;  "D + / # o > > ", 0dh, 0ah,
;  "E . & * \ * | ", 0dh, 0ah,
;  "F | ! \ @ ? / ", 0dh, 0ah, 0

;---------cursor position-------------------
coor struct
	x sbyte 0
	y sbyte 0
coor ends

cursor coor <2,1>

.code 