/*
	Created by: Winfred
	Date: 20201124
	Task: Insert LogAction when Create currency for existing licensee [RedmineID:#143761]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

CREATE TABLE #LogAction (ActionID	INT, SPName VARCHAR(50), ActionName VARCHAR(256))

DECLARE @ActionName  VARCHAR(256) = 'Set up new currency for licensee'

INSERT INTO #LogAction (ActionID, SPName, ActionName)
VALUES (2216,'Dot_Dep_CreateCurrencyLicensee','Create Currency for Licensee')

DELETE a FROM LogAction a INNER JOIN #LogAction b ON a.ActionID = b.ActionID

INSERT INTO dbo.LogAction (ActionID, SPName
		, ActionNameEN
		, ActionNameCH
		, ActionNameCS
		, ActionNameJP
		, ActionNameIT
		, ActionNameTH
		, ActionNameKO
		, ActionNameVI
		, ActionNameCN
		, IsInternal)
SELECT ActionID, SPName
, ActionName AS  ActionNameEN
, ActionName AS  ActionNameCH
, ActionName AS  ActionNameCS
, ActionName AS  ActionNameJP
, ActionName AS  ActionNameIT
, ActionName AS  ActionNameTH
, ActionName AS  ActionNameKO
, ActionName AS  ActionNameVI
, ActionName AS  ActionNameCN
, 0 
FROM #LogAction

--DROP TABLE #LogAction


