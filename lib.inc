INCLUDE Irvine32.inc

printMap proto map_row: dword
readInput proto
inputHandle proto input: dword, mapInitaddr: dword, mapAnsaddr: dword

.data
;initial map
map_init byte "  1 2 3 4 5 6 ", 0dh, 0ah,
              "A _ _ _ _ _ _ ", 0dh, 0ah,
              "B _ _ _ _ _ _ ", 0dh, 0ah,
              "C _ _ _ _ _ _ ", 0dh, 0ah,
              "D _ _ _ _ _ _ ", 0dh, 0ah,
              "E _ _ _ _ _ _ ", 0dh, 0ah,
              "F _ _ _ _ _ _ ", 0dh, 0ah, 0

;the answer map
map_ans byte "  1 2 3 4 5 6 ", 0dh, 0ah,
             "A $ ^ ! & - < ", 0dh, 0ah,
             "B = < - + ~ : ", 0dh, 0ah,
             "C % : @ ? % . ", 0dh, 0ah,
             "D + / ~ = > > ", 0dh, 0ah,
             "E . & * $ * | ", 0dh, 0ah,
             "F | ! ^ @ ? / ", 0dh, 0ah, 0
             
.code 