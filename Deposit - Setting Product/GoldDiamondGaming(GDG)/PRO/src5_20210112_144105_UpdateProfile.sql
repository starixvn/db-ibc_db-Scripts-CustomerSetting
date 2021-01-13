/*
	Created: Winfred
	Date: 20210112
	Task: Update Product Setting Detail (0:PRO) GDG [Redmine: 144105]
	DB: DBCUST/CustDB
*/  
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=236
