/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: Eden@20210205
    Task:  Insert LogAction for new setting type  [#149450]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	1179, 'Update Close Reason By Archive', 'DBA_ArchiveAccount1_CloseAgentLine', 1, 5, NULL UNION ALL
SELECT	1180, 'Update Close Reason By Archive', 'DBA_ArchiveAccount1_CloseMaster', 1, 5, NULL UNION ALL
SELECT	1181, 'Update Close Reason By Archive', 'DBA_ArchiveAccount1_CloseSuper', 1, 5, NULL

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--SELECT * FROM LogAction (NOLOCK) WHERE ActionID IN(1179,1180,1181)
