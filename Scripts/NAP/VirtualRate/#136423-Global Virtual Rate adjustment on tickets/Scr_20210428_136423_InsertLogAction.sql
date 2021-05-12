/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20210325@Eden
	Task: Insert LogAction VREngine [RM#136423]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	833, 'Add new rule of Virtual Rate Engine', 'NAP_VREngine_Rule_Insert', 1, NULL, NULL UNION ALL
SELECT	834, 'Update rule of Virtual Rate Engine', 'NAP_VREngine_Rule_Update', 1, NULL, NULL UNION ALL
SELECT	835, 'Delete rule of Virtual Rate Engine', 'NAP_VREngine_Rule_Delete', 1, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--SELECT * FROM LogAction (NOLOCK) WHERE ActionID IN(833,834,835)
