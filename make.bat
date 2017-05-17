@echo off
REM make
REM Assembles and links the 32-bit ASM program into .exe which can be used by WinDBG
REM Uses MicroSoft Macro Assembler version 6.11 and 32-bit Incremental Linker version 5.10.7303
REM Created by Huang

REM delete related files
del main.lst
del main.obj
del main.ilk
del main.pdb
del main.exe

REM /c          assemble without linking
REM /coff       generate object code to be linked into flat memory model
REM /Zi         generate symbolic debugging information for WinDBG
REM /Fl		Generate a listing file

REM main.asm      The name of the source file

setlocal
set INCLUDE=..\..\WINdbgFolder;	REM 這裡要設成WINdbgFolder的路徑
set LIB=..\..\WINdbgFolder;
set PATH=..\..\WINdbgFolder;

C:\folder\WINdbgFolder\ML /c /coff /Zi /Fl main.asm printMap.asm readInput.asm inputHandle.asm
if errorlevel 1 goto terminate

REM /debug              generate symbolic debugging information
REM /subsystem:console  generate console application code
REM /entry:start        entry point from WinDBG to the program
REM                             the entry point of the program must be _start

REM /out:main.exe         output main.exe code
REM main.obj              input main.obj
REM Kernel32.lib        library procedures to be invoked from the program
REM irvine32.lib
REM user32.lib

LINK /debug /subsystem:console  /entry:start /out:main.exe main.obj printMap.obj readInput.obj inputHandle.obj Kernel32.lib irvine32.lib user32.lib
if errorlevel 1 goto terminate

REM Display all files related to this program:
DIR main.*

:terminate
pause
endlocal