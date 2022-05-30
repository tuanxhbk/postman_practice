@echo off
setlocal enabledelayedexpansion
set count=0
for /f "tokens=*" %%x in (command.txt) do (
    set /a count+=1
    set var[!count!]=%%x
)
REM echo %count%
REM echo %var[10]%
REM call %var[10]%

for /l %%n in (1,1,%count%) do ( 
   call !var[%%n]! 
)