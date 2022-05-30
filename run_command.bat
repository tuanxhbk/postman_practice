@echo off
setlocal enabledelayedexpansion

REM --- Set csv report folder ---
set root_report_folder=report_build_%BUILD_NUMBER%
set report_csv_export= --reporter-csv-export 
set csv_folder=%root_report_folder%\csv_report_%BUILD_NUMBER%
set reporter_allure_export= --reporter-allure-export 
set allure_folder=%root_report_folder%
set reporter_htmlextra_export= --reporter-htmlextra-export 
set htmlextra_folder=%root_report_folder%\htmlextra_%BUILD_NUMBER%

REM --- Read commands from file ---
set count=0
for /f "tokens=*" %%x in (command.txt) do (
    set /a count+=1
    set var[!count!]=%%x%report_csv_export%%csv_folder%%reporter_allure_export%%allure_folder%%reporter_htmlextra_export%%htmlextra_folder%
)
REM echo %count%
REM echo %var[10]%
REM call %var[10]%

REM --- Define comment out prefix ---
set comment="###"

echo %csv_folder%
mkdir %csv_folder%
mkdir %htmlextra_folder%

REM --- Run command ---
for /l %%n in (1,1,%count%) do (
    Echo.!var[%%n]! | findstr /C:%comment%>nul || (
    echo !var[%%n]!
    call !var[%%n]!
    )
)