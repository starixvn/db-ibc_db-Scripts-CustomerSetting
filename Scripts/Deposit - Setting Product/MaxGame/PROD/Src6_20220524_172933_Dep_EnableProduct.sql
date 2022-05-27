/*
	Created: Winfred
	Date: 20220524
	Task: UPDATE global SettingStatus = 0 (PROD) [Redmine: 172933]
	DB: DBCUST/CustDB
	
	P/s : Step 6 UPDATE global SettingStatus MaxGame
*/ 
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=5401

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 5401
