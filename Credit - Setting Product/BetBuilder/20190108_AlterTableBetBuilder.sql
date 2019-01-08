/*
	Created: Winnie
	Date: 20190108
	Task: BetBuilder [RedmineID: #105664]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

ALTER TABLE ProductLaunchedSiteCurrency ADD BetType SMALLINT NOT NULL DEFAULT(0)
ALTER TABLE ProductLaunchedSiteCurrency ADD LaunchedLevel TINYINT NOT NULL DEFAULT(0)