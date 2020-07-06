/*
	Created by: Elodie
	Date: 20200706
	Task: Insert LogAction for updating MinPT
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	508, 'Update Other Products Min Position Taking for Super', 'Acc_CustSetting_SuperPTUpd', 0, 1, NULL UNION ALL
SELECT	509, 'Update Other Products Min Position Taking for Master', 'Acc_CustSetting_MasterPTUpd', 0, 1, NULL UNION ALL
SELECT	510, 'Update Other Products Min Position Taking for Agent', 'Acc_CustSetting_AgentPTUpd', 0, 1, NULL

--DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
