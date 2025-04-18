@echo off
setlocal enabledelayedexpansion
set "ErrCode=0"

:: Prompt for input variables
set /p nickname=Enter Nickname: 
set /p redmine=Enter RedmineID: 
set /p productName=Enter Product Name: 
set /p pType=Enter Product Type (e.g: 1 ~ RNG or 2 ~ LiveCasino): 

:: Get Date
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I
set "today=%datetime:~0,8%"

:: SQL query to retrieve multiple values
set "query=SET NOCOUNT ON;"
set "query=%query% SELECT TOP 1 sbm.ProductID, sbm.SportType, sbm.BetType"
set "query=%query% FROM SportBettypeMatrix sbm WITH (NOLOCK)"
set "query=%query% INNER JOIN Products p WITH (NOLOCK) ON p.ProductID=sbm.ProductID"
set "query=%query% WHERE p.ProductName='%productName%'"

REM :: Execute SQL query and capture results
REM for /f "tokens=1,2,3 delims=," %%A in ('sqlcmd -S TESTDB061 -d bodb02 -U vndba_local -P #1234aA# -Q "%query%" -h -1 -W -s ","') do (
    REM if %%A=="" (
        REM echo Error: No results returned from the query.
        REM exit /b 1
    REM )
    REM set "ProductID=%%A"
    REM set "SportType=%%B"
    REM set "BetType=%%C"
REM )

REM echo ProductID: !ProductID!
REM echo SportType: !SportType!
REM echo BetType: !BetType!

sqlcmd -S TESTDB061 -d bodb02 -U vndba_local -P #1234aA# -Q "%query%" -h -1 -W -s "," > temp.txt
if %errorlevel% neq 0 (
	set "ErrCode=1"
    echo Error: Failed to execute the SQL query.
    goto :errorHandler
)
for /f "tokens=1,2,3 delims=," %%A in (temp.txt) do (
    set "ProductID=%%A"
    set "SportType=%%B"
    set "BetType=%%C"
)
if not defined ProductID (
	set "ErrCode=2"
    echo Error: No results returned from the query.
    goto :errorHandler
)
del temp.txt

echo ProductID: !ProductID!
echo SportType: !SportType!
echo BetType: !BetType!

if /i "%pType%"=="1" (
	set "productType=RNG Casino"
) else (
	if /i "%pType%"=="2" (
		set "productType=Live Casino"
	) else (
		set "ErrCode=3"
		echo Error: Invalid product type entered.
		goto :errorHandler
	)
)

echo ================== DEPOSIT SETTING ==================
set /p Deposit_psID=Enter Deposit Max_ProductSettingID: 
set /p BitmapOrder=Enter BitmapOrder (Deposit): 

call :ProcessFolder "%productType%" "Deposit Setting" "Deposit - Setting Product" "Deposit" "%Deposit_psID%" "%BitmapOrder%" ""

:: ================== CREDIT SETTING ==================
if /i "%pType%"=="2" (   
	echo ================== CREDIT SETTING ==================
	set /p Credit_psID=Enter Credit Max_ProductSettingID: 
	set /p Child_DisplayOrder=Enter Child_DisplayOrder (Credit): 

	call :ProcessFolder "%productType%" "Credit Setting" "Credit - Setting Product" "Credit" "%Credit_psID%" "" "%Child_DisplayOrder%"
)

echo Process completed.
endlocal
timeout /t 5 /nobreak
exit /b 0

:: ================== Function: ProcessFolder ==================
:ProcessFolder
:: Arguments:
:: %1 - Product Type (e.g., "RNG Casino")
:: %2 - Source folder name (e.g., "Deposit Setting")
:: %3 - Destination folder name (e.g., "Deposit - Setting Product")
:: %4 - Setting type (e.g., "Deposit" or "Credit")
:: %5 - ProductSettingID
:: %6 - BitmapOrder (optional)
:: %7 - Child_DisplayOrder (optional)

set "sourceFolder=d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\%~1\%~2"
set "destinationFolder=d:\GIT\db-Scripts-CustomerSetting\Scripts\%~3\%productName%"

echo Step 1 - Cloning folder (%~4 Setting)...
if not exist "%sourceFolder%" (
	set "ErrCode=4"
    echo Error: Source folder "%sourceFolder%" does not exist.
    goto :errorHandler
)
robocopy "%sourceFolder%" "%destinationFolder%" /E /NFL /NDL /NJH /NJS /NC /NS
if %errorlevel% geq 8 (
	set "ErrCode=5"
    echo Error: Failed to clone folder.
	goto :errorHandler
)
echo Folder cloned successfully.

echo Step 2 - Renaming files (%~4 Setting)...
for /r "%destinationFolder%" %%f in (*date_redmine_productName*.sql) do (
    set "oldFileName=%%~nxf"
    set "newFileName=!oldFileName:date_redmine_productName=%today%_%redmine%_%productName%!"
    set "newFileName=!newFileName: =!"
    ren "%%f" "!newFileName!"
)
echo File names updated successfully.

echo Step 3 - Replacing content in files (%~4 Setting)...
powershell -Command ^
    "Get-ChildItem -Path '%destinationFolder%' -Filter '*.sql' | ForEach-Object { " ^
    "(Get-Content -Path $_.FullName) -replace '{Nickname}@{date}', '%nickname%@%today%' " ^
    "-replace '#xxx', '#%redmine%' " ^
    "-replace '{ProductName}', '%productName%' " ^
    "-replace '{%~4_psID}', '%~5%' " ^
    "-replace '{ProductID}', '%ProductID%' " ^
    "-replace '{SportType}', '%SportType%' " ^
    "-replace '{BetType}', '%BetType%' " ^
    "-replace '{BitmapOrder}', '%~6%' " ^
    "-replace '{Child_DisplayOrder}', '%~7%' | Set-Content -Path $_.FullName }"
if %errorlevel% neq 0 (
	set "ErrCode=6"
    echo Error: Failed to replace content in files.
	goto :errorHandler
)
echo Content replaced successfully.

:: ================== Function: ProcessFolder ==================
if /i "%ErrCode%"!="0" (
:errorHandler
	timeout /t 5 /nobreak > nul
    exit /b %ErrCode%
)