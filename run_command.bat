@echo off
setlocal enabledelayedexpansion

REM --- Set report folder ---
set root_report_folder=report\build_%BUILD_NUMBER%
set report_csv_export= --reporter-csv-export 
set csv_folder=%root_report_folder%\csv_report
set reporter_allure_export= --reporter-allure-export 
set allure_folder=%root_report_folder%\allure-results
set reporter_htmlextra_export= --reporter-htmlextra-export 
set htmlextra_folder=%root_report_folder%\htmlextra
set newman_option= --disable-unicode --reporters cli,allure,htmlextra,csv

REM --- Read commands from file ---
set count=0
for /f "tokens=*" %%x in (command.txt) do (
    set /a count+=1
    set var[!count!]=%%x%newman_option%%report_csv_export%%csv_folder%%reporter_allure_export%%allure_folder%%reporter_htmlextra_export%%htmlextra_folder%
)
REM echo %count%
REM echo %var[10]%
REM call %var[10]%

REM --- Define comment out prefix ---
set comment="###"

REM echo %csv_folder%
mkdir %csv_folder%
mkdir %htmlextra_folder%

REM --- Run commands ---
for /l %%n in (1,1,%count%) do (
    Echo.!var[%%n]! | findstr /C:%comment%>nul || (
    echo !var[%%n]!
    call !var[%%n]!
    )
)