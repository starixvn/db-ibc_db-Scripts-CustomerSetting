@echo off
setlocal enabledelayedexpansion

:: Nhận các tham số
set "sourceFolder=%~1"
set "destFolder=%~2"
set "settingType=%~3"
set "psID=%~4"
set "bmpOrder=%~5"
set "childOrder=%~6"
set "nick=%~7"
set "redm=%~8"
set "prodName=%~9"
shift
set "prodID=%~9"
shift
set "sportType=%~9"
shift
set "betType=%~9"
shift
set "dateToday=%~9"

@REM echo ========= RECEIVED PARAMETERS =========
@REM echo Source Folder: %sourceFolder%
@REM echo Destination Folder: %destFolder%
@REM echo Setting Type: %settingType%
@REM echo Product Setting ID: %psID%
@REM echo Bitmap Order: %bmpOrder%
@REM echo Child Display Order: %childOrder%
@REM echo Nickname: %nick%
@REM echo Redmine: %redm%
@REM echo Product Name: %prodName%
@REM echo Product ID: %prodID%
@REM echo Sport Type: %sportType%
@REM echo Bet Type: %betType%
@REM echo Date: %dateToday%
echo Source Path: d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\%sourceFolder%
echo Destination Path: d:\GIT\db-Scripts-CustomerSetting\Scripts\%destFolder%\%prodName%
echo ====================================

set "sourcePath=d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\%sourceFolder%"
set "destPath=d:\GIT\db-Scripts-CustomerSetting\Scripts\%destFolder%\%prodName%"

echo Step 1 - Cloning folder (%settingType% Setting)...
robocopy "%sourcePath%" "%destPath%" /E /NFL /NDL /NJH /NJS /NC /NS
if %errorlevel% geq 8 (
    echo Failed to clone folder.
    exit /b 1
)
echo Folder cloned successfully.

echo Step 2 - Renaming files (%settingType% Setting)...
for /r "%destPath%" %%f in (*date_redmine_productName*) do (
    set "oldFileName=%%~nxf"
    set "newFileName=!oldFileName:date_redmine_productName=%dateToday%_%redm%_%prodName%!"
    set "newFileName=!newFileName: =!"
    ren "%%f" "!newFileName!"
)
echo File names updated successfully.

echo Step 3 - Replacing content in files (%settingType% Setting)...
REM Handle SQL files first
powershell -Command ^
    "Get-ChildItem -Path '%destPath%' -Filter '*.sql' | ForEach-Object { " ^
    "(Get-Content -Path $_.FullName) -replace '{Nickname}@{date}', '%nick%@%dateToday%' " ^
    "-replace '#xxx', '#%redm%' " ^
    "-replace '{ProductName}', '%prodName%' " ^
    "-replace '{%settingType%_psID}', '%psID%' " ^
    "-replace '{ProductID}', '%prodID%' " ^
    "-replace '{SportType}', '%sportType%' " ^
    "-replace '{BetType}', '%betType%' " ^
    "-replace '{BitmapOrder}', '%bmpOrder%' " ^
    "-replace '{Child_DisplayOrder}', '%childOrder%'| Set-Content -Path $_.FullName }"

REM Handle Excel files
echo Processing Excel files...
python "%~dp0replace_excel.py" ^
    "%destPath%" ^
    "%prodID%" ^
    "%prodName%" ^
    "%sportType%" ^
    "%betType%"

if %errorlevel% neq 0 (
    echo Error: Failed to replace content in files.
    exit /b 1
)
echo Content replaced successfully.
exit /b