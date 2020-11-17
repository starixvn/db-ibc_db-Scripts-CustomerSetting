/*
	Created: Tina
	Date: 20201117
	Task: Update Product Setting Detail (0:PRO) Big Gaming [Redmine: 142458]
	DB: DBCUST/CustDB
*/  
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=239
