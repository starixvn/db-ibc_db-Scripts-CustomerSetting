/*
	Created: 20200303@Tiara
	Date: 20200303
	Task: Update Product Setting Detail [Redmine: 128058]
	DB: DBCUST/CustDB
*/  
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=244
