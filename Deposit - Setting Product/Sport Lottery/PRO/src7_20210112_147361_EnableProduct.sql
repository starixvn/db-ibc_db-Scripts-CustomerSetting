/*
	Created: Winfred
	Date: 20210223
	Task: UPDATE global SettingStatus = 0 (PROD) for Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 6 UPDATE global SettingStatus Sports Lottery
*/ 
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=169

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 169
