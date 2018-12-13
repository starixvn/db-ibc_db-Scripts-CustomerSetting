/*
	Created: 20181001@Winnie
	Task: Insert product profile for Esports
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

UPDATE ProductSettingDetail WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=1
WHERE Sporttype=43


 