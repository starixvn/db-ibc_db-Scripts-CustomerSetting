
/*
	Created: Winnie
	Date: 20190111
	Task: BetBuilder [RedmineID: #105664]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

update ProductLaunchedSiteCurrency WITH(ROWLOCK,UPDLOCK)
set IsLaunched = 0
where BetType = 38 and siteid=11 --INDO