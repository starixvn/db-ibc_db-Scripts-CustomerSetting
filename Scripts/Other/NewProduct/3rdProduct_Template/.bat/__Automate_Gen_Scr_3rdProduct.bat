@echo off
setlocal enabledelayedexpansion

cd /d "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\.bat"

:: Set and verify the path to ProcessFolder.bat
set "SCRIPT_PATH=%~dp0ProcessFolder.bat"
echo DEBUG: Setting SCRIPT_PATH to: !SCRIPT_PATH!

if not exist "!SCRIPT_PATH!" (
    echo ERROR: ProcessFolder.bat not found at: !SCRIPT_PATH!
    echo Current directory: %CD%
    dir
    pause
    exit /b 1
)

:: Prompt for input variables
echo Select Product Type:
echo 1. RNG Casino
echo 2. Live Casino
set /p choice=Enter choice (1 or 2): 

if "!choice!"=="1" (
    set "productType=RNG Casino"
) else if "!choice!"=="2" (
    set "productType=Live Casino"
) else (
    echo Invalid choice
    pause
    exit /b 1
)

echo Selected: !productType!

echo Starting process...

echo Checking directory structure...
dir "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template"

if not exist "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\!productType!" (
    echo ERROR: Product type folder does not exist!
    echo Looking for: "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\!productType!"
    pause
    exit /b 1
)

echo Product Type set to: !productType!
echo Press any key to continue...
pause

set /p nickname=Enter Nickname: 
set /p redmine=Enter Redmine ID: 
set /p productName=Enter Product Name: 
set /p ProductID=Enter ProductID: 
set /p SportType=Enter SportType: 
set /p BetType=Enter BetType: 

:: Get Date
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I
set "today=%datetime:~0,8%"


echo ProductID: !ProductID!
echo SportType: !SportType!
echo BetType: !BetType!

echo DEBUG: About to enter Credit Setting section...
echo DEBUG: choice=!choice!
echo DEBUG: productType=!productType!

:: ================== CREDIT SETTING ==================
echo DEBUG: Testing IF condition...
if /I "!choice!"=="2" (
    echo DEBUG: Inside Credit Setting IF block
    echo.
    echo ================== CREDIT SETTING ==================
    echo Processing Credit Setting for Live Casino...
    set /p Credit_psID=Enter Credit Max_ProductSettingID: 
    set /p Child_DisplayOrder=Enter Child_DisplayOrder (Credit): 

    set "source_folder=!productType!\Credit Setting"
    set "dest_folder=Credit - Setting Product"
    set "setting_type=Credit"

    echo ============ CREDIT SETTING DEBUG INFO ============
    echo Current Product Type: "!productType!"
    echo Source Folder Path: "!source_folder!"
    echo Full source path: "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\!source_folder!"
    echo ================================================

    echo Checking if Credit Setting source path exists...
    if not exist "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\!source_folder!" (
        echo ERROR: Credit Setting source path does not exist
        echo Path: "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\!source_folder!"
        pause
        exit /b 1
    )    echo DEBUG: About to call ProcessFolder.bat
    echo DEBUG: SCRIPT_PATH=!SCRIPT_PATH!
    
    call "!SCRIPT_PATH!" "!source_folder!" "!dest_folder!" "!setting_type!" "!Credit_psID!" "" "!Child_DisplayOrder!" "!nickname!" "!redmine!" "!productName!" "!ProductID!" "!SportType!" "!BetType!" "!today!"
    
    echo DEBUG: ProcessFolder.bat returned errorlevel=!errorlevel!
    if !errorlevel! neq 0 (
        echo ProcessFolder.bat failed for Credit Setting with error code !errorlevel!
        pause
        exit /b !errorlevel!
    )
)

:: ================== DEPOSIT SETTING ==================
echo ================== DEPOSIT SETTING ==================
set /p Deposit_psID=Enter Deposit Max_ProductSettingID: 
set /p BitmapOrder=Enter BitmapOrder (Deposit): 

echo ============ DEBUG INFO ============
echo Current Product Type: "!productType!"
set "source_folder=!productType!\Deposit Setting"
echo Source Folder Path: "!source_folder!"
set "dest_folder=Deposit - Setting Product"
set "setting_type=Deposit"

echo Base Template Path: "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template"
echo Full source path: "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\!source_folder!"
echo Destination path: "d:\GIT\db-Scripts-CustomerSetting\Scripts\!dest_folder!\!prodName!"
echo ================================

echo Checking if source path exists...
if not exist "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\!source_folder!" (
    echo ERROR: Source path does not exist
    echo Path: "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\!source_folder!"
    pause
    exit /b 1
)

echo Calling ProcessFolder.bat with parameters:
echo Source: "!source_folder!"
echo Destination: "!dest_folder!"
echo Setting Type: "!setting_type!"
echo Product Name: "!productName!"
echo Nickname: "!nickname!"
echo Redmine: "!redmine!"

call "!SCRIPT_PATH!" "!source_folder!" "!dest_folder!" "!setting_type!" "!Deposit_psID!" "!BitmapOrder!" "" "!nickname!" "!redmine!" "!productName!" "!ProductID!" "!SportType!" "!BetType!" "!today!"

if !errorlevel! neq 0 (
    echo ProcessFolder.bat failed with error code !errorlevel!
    pause
    exit /b !errorlevel!
)

:: ================== Import Files ==================
echo.
echo ================== Import Files ==================
echo DEBUG: Verifying ImportFile folder...

:: Verify ImportFile folder exists
if not exist "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\ImportFile" (
    echo ERROR: ImportFile folder not found
    echo Looking for: "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\ImportFile"
    pause
    exit /b 1
)

set "source_folder=ImportFile"
set "setting_type=Product"
echo DEBUG: Calling ProcessFolder.bat for Import Files...
echo DEBUG: SCRIPT_PATH=!SCRIPT_PATH!
call "!SCRIPT_PATH!" "!source_folder!" "!dest_folder!" "!setting_type!" "" "" "" "!nickname!" "!redmine!" "!productName!" "!ProductID!" "!SportType!" "!BetType!" "!today!"

if !errorlevel! neq 0 (
    echo ERROR: ProcessFolder.bat failed for Import Files with error code !errorlevel!
    pause
    exit /b !errorlevel!
)
echo Import Files completed.
pause

:: ================== Player Communication ==================
echo.
echo ================== Player Communication ==================
echo DEBUG: Verifying PlayerComm folder...

:: Verify PlayerComm folder exists
if not exist "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\PlayerComm" (
    echo ERROR: PlayerComm folder not found
    echo Looking for: "d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\PlayerComm"
    pause
    exit /b 1
)

set "source_folder=PlayerComm"
set "setting_type=PlayerComm"
echo DEBUG: Calling ProcessFolder.bat for Player Communication...
echo DEBUG: SCRIPT_PATH=!SCRIPT_PATH!
call "!SCRIPT_PATH!" "!source_folder!" "!dest_folder!" "!setting_type!" "" "" "" "!nickname!" "!redmine!" "!productName!" "!ProductID!" "!SportType!" "!BetType!" "!today!"

if !errorlevel! neq 0 (
    echo ERROR: ProcessFolder.bat failed for Player Communication with error code !errorlevel!
    pause
    exit /b !errorlevel!
)
echo Player Communication completed.
pause

echo Process completed.
endlocal
pause