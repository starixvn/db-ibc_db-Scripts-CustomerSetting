/*
	Created: Tina
	Date: 20201116
	Task: Update SettingStatus = 2 (PROD) for Big Gaming (BG) [Redmine: 142458]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=2
WHERE SportType=239

