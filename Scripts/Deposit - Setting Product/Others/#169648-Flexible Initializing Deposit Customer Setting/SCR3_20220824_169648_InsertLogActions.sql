﻿/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/ 
/*
	Created: 20220824@Eden
	Task: Insert LogAction for Flexible Init custsetting Deposit [Redmine: #169648]   
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	201061, 'Update initial config status (Deposit)', 'Acc_Dep_Initial_DCS_ConfigStatus_Upd', 1, NULL, NULL  UNION ALL
SELECT	201062, 'Update initial config current step (Deposit)', 'Acc_Dep_Initial_DCS_CurrentStep_Upd', 1, NULL, NULL  UNION ALL
SELECT	201063, 'Update initial config processed step (Deposit)', 'Acc_Dep_Initial_DCS_ProcessedStep_Upd', 1, NULL, NULL  UNION ALL
SELECT	201064, 'Add new initial config (Deposit)', 'Acc_Dep_Initial_DCS_SettingConfig_Ins', 1, NULL, NULL  UNION ALL
SELECT	201065, 'Remove initial config (Deposit)', 'Acc_Dep_Initial_DCS_SettingConfig_Del', 1, NULL, NULL  UNION ALL
SELECT	201066, 'Edit initial config (Deposit)', 'Acc_Dep_Initial_DCS_SettingConfig_Upd', 1, NULL, NULL  

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--SELECT * FROM LogAction (NOLOCK) WHERE ActionID BETWEEN 201061 AND 201066
