@echo off
setlocal enabledelayedexpansion

:: Prompt for input variables
set /p nickname=Enter Nickname: 
set /p redmine=Enter Redmine ID: 
set /p productName=Enter Product Name: 

:: Get Date
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I
set "today=%datetime:~0,8%"

:: SQL query to retrieve multiple values
set "query=SET NOCOUNT ON;"
set "query=%query% SELECT TOP 1 sbm.ProductID, sbm.SportType, sbm.BetType"
set "query=%query% FROM SportBettypeMatrix sbm WITH (NOLOCK)"
set "query=%query% INNER JOIN Products p WITH (NOLOCK) ON p.ProductID=sbm.ProductID"
set "query=%query% WHERE p.ProductName='%productName%'"

:: Execute SQL query and capture results
for /f "tokens=1,2,3 delims=," %%A in ('sqlcmd -S TESTDB061 -d bodb02 -U vndba_local -P #1234aA# -Q "%query%" -h -1 -W -s ","') do (
    if %%A=="" (
        echo Error: No results returned from the query.
        exit /b 1
    )
    set "ProductID=%%A"
    set "SportType=%%B"
    set "BetType=%%C"
)

echo ProductID: !ProductID!
echo SportType: !SportType!
echo BetType: !BetType!

:: ================== DEPOSIT SETTING ==================
echo ================== DEPOSIT SETTING ==================
set /p Deposit_psID=Enter Deposit Max_ProductSettingID: 
set /p BitmapOrder=Enter BitmapOrder (Deposit): 

call :ProcessFolder "Deposit Setting" "Deposit - Setting Product" "Deposit" "%Deposit_psID%" "%BitmapOrder%" ""

:: ================== CREDIT SETTING ==================
echo
echo ================== CREDIT SETTING ==================
set /p Credit_psID=Enter Credit Max_ProductSettingID: 
set /p Child_DisplayOrder=Enter Child_DisplayOrder (Credit): 

call :ProcessFolder "Credit Setting" "Credit - Setting Product" "Credit" "%Credit_psID%" "" "%Child_DisplayOrder%"

echo Process completed.
endlocal
pause
exit /b

:: ================== Function: ProcessFolder ==================
:ProcessFolder
:: Arguments:
:: %1 - Source folder name (e.g., "Deposit Setting")
:: %2 - Destination folder name (e.g., "Deposit - Setting Product")
:: %3 - Setting type (e.g., "Deposit" or "Credit")
:: %4 - ProductSettingID
:: %5 - BitmapOrder (optional)
:: %6 - Child_DisplayOrder (optional)

set "sourceFolder=d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\Live Casino\%~1"
set "destinationFolder=d:\GIT\db-Scripts-CustomerSetting\Scripts\%~2\%productName%"

echo Step 1 - Cloning folder (%~3 Setting)...
robocopy "%sourceFolder%" "%destinationFolder%" /E /NFL /NDL /NJH /NJS /NC /NS
if %errorlevel% geq 8 (
    echo Failed to clone folder.
    exit /b 1
)
echo Folder cloned successfully.

echo Step 2 - Renaming files (%~3 Setting)...
for /r "%destinationFolder%" %%f in (*date_redmine_productName*.sql) do (
    set "oldFileName=%%~nxf"
    set "newFileName=!oldFileName:date_redmine_productName=%today%_%redmine%_%productName%!"
    set "newFileName=!newFileName: =!"
    ren "%%f" "!newFileName!"
)
echo File names updated successfully.

echo Step 3 - Replacing content in files (%~3 Setting)...
powershell -Command ^
    "Get-ChildItem -Path '%destinationFolder%' -Filter '*.sql' | ForEach-Object { " ^
    "(Get-Content -Path $_.FullName) -replace '{Nickname}@{date}', '%nickname%@%today%' " ^
    "-replace '#xxx', '#%redmine%' " ^
    "-replace '{ProductName}', '%productName%' " ^
    "-replace '{%~3_psID}', '%~4%' " ^
    "-replace '{ProductID}', '%ProductID%' " ^
    "-replace '{SportType}', '%SportType%' " ^
    "-replace '{BetType}', '%BetType%' " ^
	"-replace '{BitmapOrder}', '%~5%' " ^
    "-replace '{Child_DisplayOrder}', '%~6%' | Set-Content -Path $_.FullName }"
if %errorlevel% neq 0 (
    echo Error: Failed to replace content in files.
    exit /b 1
)
echo Content replaced successfully.
exit /b