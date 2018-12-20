/*
	Created: Winnie
	Date: 20181220
	Task: VS Betradar 3 - Virtual Soccer Asian Cup UUS [RedmineID: #104809]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET IsTest=0
WHERE sporttype = 194 