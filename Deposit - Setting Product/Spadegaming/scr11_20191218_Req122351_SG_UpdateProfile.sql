/*
	Created: 20191218@Winnie
	Task: DCS Deposit for SG - [Redmine:#122351]
		Insert Master Data:
	DB: Run at DBCust.CustDB
*/  
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=247
