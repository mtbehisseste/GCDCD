INCLUDE lib.inc

.data
gamerule  byte "Flip Card Rules and Tips" ,10
          byte "   ",10
          byte "1.The main goal is to match all signs in pairs." ,10
          byte "2.Please switch your input method to English.", 10
          byte "3.If you are a lazy person press space and type -help to get hints." ,10
          byte "4.Press esc to exit." ,10
          byte "5.Most important of all, enjoy yourself <3" ,10, 10,0
.code
startingframe proc uses eax edx
    mov eax, white + (black*16)
    call settextcolor
    mov edx, offset gamerule
    call writestring
    ret
startingframe endp
end

