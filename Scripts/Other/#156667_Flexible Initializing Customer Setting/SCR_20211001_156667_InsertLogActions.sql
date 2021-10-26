﻿/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210914@Eden
	Task: Insert LogAction for VRMemberBigStake exclude [RM#156824]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	201051, 'Update initial config status', 'Acc_Initial_DCS_ConfigStatus_Upd', 1, NULL, NULL  UNION ALL
SELECT	201052, 'Update initial config current step', 'Acc_Initial_DCS_CurrentStep_Upd', 1, NULL, NULL  UNION ALL
SELECT	201053, 'Update initial config processed step', 'Acc_Initial_DCS_ProcessedStep_Upd', 1, NULL, NULL  UNION ALL
SELECT	201054, 'Add new initial config', 'Acc_Initial_DCS_SettingConfig_Ins', 1, NULL, NULL  UNION ALL
SELECT	201055, 'Remove initial config', 'Acc_Initial_DCS_SettingConfig_Del', 1, NULL, NULL  UNION ALL
SELECT	201056, 'Edit initial config', 'Acc_Initial_DCS_SettingConfig_Upd', 1, NULL, NULL  

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--SELECT * FROM LogAction (NOLOCK) WHERE ActionID BETWEEN 201051 AND 201056
