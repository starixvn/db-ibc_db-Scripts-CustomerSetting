/*
	Created: Winfred
	Date: 20210223
	Task: Update SettingStatus = 2 (PROD) for Sports Lottery [Redmine: 147361]
	DB: DBCUST/CustDB
	
	P/s : Step 1 hide Sports Lottery
*/ 
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=2
WHERE SportType=169

--SELECT * FROM Dep_ProductSettingDetail S WITH (NOLOCK) where SportType = 169
