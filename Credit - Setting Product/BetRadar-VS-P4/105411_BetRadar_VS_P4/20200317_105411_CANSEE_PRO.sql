/*
	Created: Tiara
	Task: Insert CanSee BetRadar VS 2 - Phase 4 PRO [RedmineID: #105411]
	DB: DBCUST/CustDB
	Date: 20200317
*/ 
USE CustDB
GO

--Update IsTest = 0
UPDATE PS
SET PS.IsTest = 0
FROM dbo.ProductLaunchedSiteCurrency PS WITH (ROWLOCK,UPDLOCK)
WHERE SportType IN (195,196)

