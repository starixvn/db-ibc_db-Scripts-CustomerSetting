/*
	Created: Winnie
	Date: 20181206
	Task: VS Betradar 3 - Virtual Soccer Asian Cup UUS [RedmineID: #104809]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET IsLaunched=0
WHERE sporttype = 194 and Siteid = 11 