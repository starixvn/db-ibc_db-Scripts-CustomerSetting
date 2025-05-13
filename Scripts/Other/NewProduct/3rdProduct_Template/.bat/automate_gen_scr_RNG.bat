@echo off
setlocal enabledelayedexpansion

:: Prompt for input variables
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

:: ================== DEPOSIT SETTING ==================
echo ================== DEPOSIT SETTING ==================
set /p Deposit_psID=Enter Deposit Max_ProductSettingID: 
set /p BitmapOrder=Enter BitmapOrder (Deposit): 

set "source_folder=RNG Casino\Deposit Setting"
set "dest_folder=Deposit - Setting Product"
set "setting_type=Deposit"
call ProcessFolder.bat "%source_folder%" "%dest_folder%" "%setting_type%" "%Deposit_psID%" "%BitmapOrder%" "" "%nickname%" "%redmine%" "%productName%" "%ProductID%" "%SportType%" "%BetType%" "%today%"

:: ================== CREDIT SETTING ==================
@REM echo
@REM echo ================== CREDIT SETTING ==================
@REM set /p Credit_psID=Enter Credit Max_ProductSettingID: 
@REM set /p Child_DisplayOrder=Enter Child_DisplayOrder (Credit): 

@REM set "source_folder=Credit Setting"
@REM set "dest_folder=Credit - Setting Product"
@REM set "setting_type=Credit"
@REM call ProcessFolder.bat "%source_folder%" "%dest_folder%" "%setting_type%" "%Credit_psID%" "" "%Child_DisplayOrder%" "%nickname%" "%redmine%" "%productName%" "%ProductID%" "%SportType%" "%BetType%" "%today%"

:: ================== Player Communication ==================
echo
echo ================== Player Communication ==================
set "source_folder=PlayerComm"
set "setting_type=PlayerComm"
call ProcessFolder.bat "%source_folder%" "%dest_folder%" "%setting_type%" "" "" "" "%nickname%" "%redmine%" "%productName%" "%ProductID%" "%SportType%" "%BetType%" "%today%"

:: ================== Import Files ==================
echo
echo ================== Import Files ==================
set "source_folder=RNG Casino\ImportFile"
set "setting_type=Product"
call ProcessFolder.bat "%source_folder%" "%dest_folder%" "%setting_type%" "" "" "" "%nickname%" "%redmine%" "%productName%" "%ProductID%" "%SportType%" "%BetType%" "%today%"

echo Process completed.
endlocal
pause