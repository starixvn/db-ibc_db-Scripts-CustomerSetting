/*
	Created: Winfred
	Date: 20200828
	Task: Update Product Setting Detail (2:DISABLE) WM [Redmine: 131589]
	DB: DBCUST/CustDB
*/  
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=2
WHERE SportType=233
