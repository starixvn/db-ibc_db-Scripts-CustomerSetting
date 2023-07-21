/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20230626@Winfred
	Task: 20230626@Winfred: NAP CM Customer Class - Add Spread on rule setting [RedmineID: #187354]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31907, 'Delete rule customer class Spread', 'NAP_LM_CustomerClassSpreadDel', 1, NULL, NULL UNION ALL
SELECT	31908, 'Enabled rule customer class Spread', 'NAP_LM_CustomerClassSpreadEnable', 1, NULL, NULL UNION ALL
SELECT	31909, 'Update rule customer class Spread', 'NAP_LM_CustomerClassSpreadUpd', 1, NULL, NULL UNION ALL
SELECT	31910, 'Insert rule customer class Spread', 'NAP_LM_CustomerClassSpreadIns', 1, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)