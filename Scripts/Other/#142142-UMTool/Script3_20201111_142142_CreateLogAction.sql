/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20201002@Eden
	Task: Insert LogAction for UMTool [RM#142142]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	210001, 'Insert UM Config', 'Acc_UMTool_Configuration_Ins', 1, NULL, NULL  UNION ALL
SELECT	210002, 'Update UMConfig', 'Acc_UMTool_Configuration_Upd', 1, NULL, NULL UNION ALL
SELECT	210003, 'Delete UMConfig', 'Acc_UMTool_Configuration_Del', 1, NULL, NULL UNION ALL
SELECT	210004, 'Delete Old Data of UMConfig', 'Acc_UMTool_Configuration_Del_OldData', 1, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--SELECT * FROM LogAction (NOLOCK) WHERE ActionID IN(210001,210002,210003,210004)
