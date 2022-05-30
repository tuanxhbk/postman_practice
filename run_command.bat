@echo off
setlocal enabledelayedexpansion

REM --- Set csv report folder ---
set report_csv_export= --reporter-csv-export 
set csv_folder=csv_report_%BUILD_NUMBER%

REM --- Read commands from file ---
set count=0
for /f "tokens=*" %%x in (command.txt) do (
    set /a count+=1
    set var[!count!]=%%x%report_csv_export%%csv_folder%
)
REM echo %count%
REM echo %var[10]%
REM call %var[10]%

REM --- Define comment out prefix ---
set comment="###"

echo %csv_folder%
mkdir %csv_folder%

REM --- Run command ---
for /l %%n in (1,1,%count%) do (
    Echo.!var[%%n]! | findstr /C:%comment%>nul || (
    echo !var[%%n]!
    call !var[%%n]!
    )
)