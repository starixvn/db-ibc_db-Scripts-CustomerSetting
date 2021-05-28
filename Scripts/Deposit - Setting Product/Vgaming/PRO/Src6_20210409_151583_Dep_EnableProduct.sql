/*
	Created: Winfred
	Date: 20210409
	Task: UPDATE global SettingStatus = 0 (PROD) for 151583 [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 6 UPDATE global SettingStatus Vgaming
*/ 
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=171

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 171
