/*
	Created by: Winfred
	Date: 20201124
	Task: Insert LogAction when Create currency for existing licensee [RedmineID:#143761]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @ActionName  VARCHAR(256) = 'Set up new currency for licensee'

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
SELECT 5572, 'Nap_LM_Currency_Licensee_Insert'
, @ActionName AS  ActionNameEN
, @ActionName AS  ActionNameCH
, @ActionName AS  ActionNameCS
, @ActionName AS  ActionNameJP
, @ActionName AS  ActionNameIT
, @ActionName AS  ActionNameTH
, @ActionName AS  ActionNameKO
, @ActionName AS  ActionNameVI
, @ActionName AS  ActionNameCN
, 0 



