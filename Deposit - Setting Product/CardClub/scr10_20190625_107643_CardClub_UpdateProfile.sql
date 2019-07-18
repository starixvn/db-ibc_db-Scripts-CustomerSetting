/*
	Created: 20190625@Winnie
	Task: DCS Deposit for CardClub - [Redmine:#115322]
		Insert Master Data:
	DB: Run at DBCust.CustDB
*/  
USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE SportType=165
