/*
	Created by: Elodie
	Date: 20210614
	Task: Correct LogAction for Profile picture
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT 95000,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI
FROM LogAction t WITH (NOLOCK)
WHERE t.ActionID = 700

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT 95001,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI
FROM LogAction t WITH (NOLOCK)
WHERE t.ActionID = 701

GO