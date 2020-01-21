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
	l.ActionNameCH = REPLACE(ActionNameEN,'5','6'),
	l.ActionNameCS = REPLACE(ActionNameEN,'5','6'),
	l.ActionNameJP = REPLACE(ActionNameEN,'5','6'),
	l.ActionNameTH = REPLACE(ActionNameEN,'5','6'),
	l.ActionNameKO = REPLACE(ActionNameEN,'5','6'),
	l.ActionNameVI = REPLACE(ActionNameEN,'5','6'),
	l.ActionNameCN = REPLACE(ActionNameEN,'5','6')
FROM dbo.LogAction L WITH (ROWLOCK)
WHERE ActionID IN (934,939,940)

SELECT *
FROM dbo.LogAction 
WHERE ActionID IN (934,939,940)