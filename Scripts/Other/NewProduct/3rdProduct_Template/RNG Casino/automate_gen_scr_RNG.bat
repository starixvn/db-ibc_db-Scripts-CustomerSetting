@echo off
setlocal enabledelayedexpansion

:: Prompt for input variables
set /p nickname=Enter Nickname: 
set /p redmine=Enter Redmine ID: 
set /p productName=Enter Product Name: 
set /p Max_psID=Enter Max ProductSettingID (Deposit): 
set /p BitmapOrder=Enter BitmapOrder (Deposit): 

:: Get Date
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I
set "today=%datetime:~0,8%"

:: SQL query to retrieve multiple values
set "query=SET NOCOUNT ON;"
set "query=%query% SELECT TOP 1 sbm.ProductID, sbm.SportType, sbm.BetType"
set "query=%query% FROM SportBettypeMatrix sbm WITH (NOLOCK)"
set "query=%query% INNER JOIN Products p WITH (NOLOCK) ON p.ProductID=sbm.ProductID"
set "query=%query% WHERE p.ProductName='%productName%'"

:: Use sqlcmd to execute the query and capture the results
for /f "tokens=1,2,3 delims=," %%A in ('sqlcmd -S TESTDB061 -d bodb02 -U vndba_local -P #1234aA# -Q "%query%" -h -1 -W -s ","') do (
    if %%A=="" (
        echo Error: No results returned from the query.
        exit /b 1
    )
	setlocal enabledelayedexpansion
	set "ProductID=%%A"
    set "SportType=%%B"
    set "BetType=%%C"
)

echo ProductID: !ProductID!
echo SportType: !SportType!
echo BetType: !BetType!

:: Step 1: Clone folder
set "sourceFolder=d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\RNG Casino\Deposit Setting"
set "destinationFolder=d:\GIT\db-Scripts-CustomerSetting\Scripts\Deposit - Setting Product\%productName%"

echo Step 1 - Cloning folder...
robocopy "%sourceFolder%" "%destinationFolder%" /E /NFL /NDL /NJH /NJS /NC /NS
if %errorlevel% geq 8 (
    echo Failed to clone folder.
    exit /b 1
)
echo Folder cloned successfully.

:: Step 2: Replace file names
echo Step 2 - Renaming files...
for /r "%destinationFolder%" %%f in (*date_redmine_productName*.sql) do (
    set "oldFileName=%%~nxf"
    set "newFileName=!oldFileName:date_redmine_productName=%today%_%redmine%_%productName%!"
    set "newFileName=!newFileName: =!"
    ren "%%f" "!newFileName!"
)
echo File names updated successfully.

:: Step 3: Replace content in files
echo Step 3 - Replacing content in files...
pause
powershell -Command ^
    "Get-ChildItem -Path '%destinationFolder%' -Filter '*.sql' | ForEach-Object { " ^
    "(Get-Content -Path $_.FullName) -replace '{Nickname}@{date}', '%nickname%@%today%' " ^
    "-replace '#xxx', '#%redmine%' " ^
    "-replace '{ProductName}', '%productName%' " ^
    "-replace '{Max_psID}', '%Max_psID%' " ^
    "-replace '{ProductID}', '%ProductID%' " ^
    "-replace '{SportType}', '%SportType%' " ^
    "-replace '{BetType}', '%BetType%' " ^
    "-replace '{BitmapOrder}', '%BitmapOrder%' | Set-Content -Path $_.FullName }"
if %errorlevel% neq 0 (
    echo Error: Failed to replace content in files.
    exit /b 1
)

echo Content replaced successfully.
echo Process completed.
endlocal
pause