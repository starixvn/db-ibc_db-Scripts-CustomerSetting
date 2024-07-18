/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240429 
	Task: Exchange - Update SettingStatus PRO [RedmineID: #201239]
	DB: DBCUST/CustDB 
*/
USE CustDB
GO

UPDATE Dep_ProductSettingDetail WITH (ROWLOCK, UPDLOCK)
SET SettingStatus=0
WHERE ProductSettingID=195 AND SportType=221
GO