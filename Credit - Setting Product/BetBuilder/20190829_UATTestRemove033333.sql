/*
	Created: Winnie
	Date: 20190829
	Task: Support QC test BetBuilder remove site '033333' [RedmineID: #105664] 
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

DELETE FROM ProductLaunchedSiteCurrency
WHERE SiteID IN(SELECT siteid FROM Site WITH(NOLOCK) WHERE site IN('033333'))
	AND SportType=1 AND BetType=38