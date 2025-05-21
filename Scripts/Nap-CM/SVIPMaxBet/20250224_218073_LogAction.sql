/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250224@Winfred
	Task: 20250224@Winfred: [NAP CM] Customer - Increase Bet Limit [RedmineID: #218073] 
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31928, 'Insert rule Increase Bet Limit for VVIP', 'NAP_CM_SVIPMaxBetPlayerInsert', 1, NULL, NULL UNION ALL
SELECT	31929, 'Update rule Increase Bet Limit for VVIP', 'NAP_CM_SVIPMaxBetPlayerUpd', 1, NULL, NULL UNION ALL
SELECT	31930, 'Delete rule Increase Bet Limit for VVIP', 'NAP_CM_SVIPMaxBetPlayerDel', 1, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)