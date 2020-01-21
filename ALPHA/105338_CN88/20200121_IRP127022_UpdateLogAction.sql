/*
	Created by: Elodie
	Date: 20200121
	Task: Update LogAction [Redmine: #127022]
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

UPDATE l 
SET l.ActionNameEN = REPLACE(ActionNameEN,'5','6'),
	l.ActionNameCH = REPLACE(ActionNameCH,'5','6'),
	l.ActionNameCS = REPLACE(ActionNameCS,'5','6'),
	l.ActionNameJP = REPLACE(ActionNameJP,'5','6'),
	l.ActionNameTH = REPLACE(ActionNameTH,'5','6'),
	l.ActionNameKO = REPLACE(ActionNameKO,'5','6'),
	l.ActionNameVI = REPLACE(ActionNameVI,'5','6'),
	l.ActionNameCN = REPLACE(ActionNameCN,'5','6')
FROM dbo.LogAction L WITH (ROWLOCK)
WHERE ActionID IN (934,939,940)

UPDATE l 
SET l.ActionNameEN = l1.ActionNameEN,
	l.ActionNameCH = l1.ActionNameCH,
	l.ActionNameCS = l1.ActionNameCS,
	l.ActionNameJP = l1.ActionNameJP,
	l.ActionNameTH = l1.ActionNameTH,
	l.ActionNameKO = l1.ActionNameKO,
	l.ActionNameVI = l1.ActionNameVI,
	l.ActionNameCN = l1.ActionNameCN,
	l.ActionNameIT = l1.ActionNameIT
FROM dbo.LogAction L WITH (ROWLOCK)
	CROSS JOIN LogAction l1 
WHERE l.ActionID = 934 AND l1.ActionID = 940

SELECT *
FROM dbo.LogAction 
WHERE ActionID IN (934,939,940)