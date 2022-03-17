/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220215
	Task:  UPDATE global SettingStatus = 0 (PROD) for Product Leap Gaming Virtual Sports 3 Deposit RedmineID:#168395
	DB: DBCust/CustDB
	
	P/s : Step 6 UPDATE global SettingStatus
*/

USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType = 231

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 231