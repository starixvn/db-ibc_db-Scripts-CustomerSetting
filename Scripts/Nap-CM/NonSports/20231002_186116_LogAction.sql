/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20231002@Winfred
          - 20231002@Winfred: NAP CM Customer Class - Support for Non-Sports [RedmineID: #186116] 
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31917, 'Delete rule customer class Non-Sports', 'NAP_LM_CustomerClassNonSportsDel', 1, NULL, NULL UNION ALL
SELECT	31918, 'Enabled rule customer class Non-Sports', 'NAP_LM_CustomerClassNonSportsEnable', 1, NULL, NULL UNION ALL
SELECT	31919, 'Update rule customer class Non-Sports', 'NAP_LM_CustomerClassNonSportsUpd', 1, NULL, NULL UNION ALL
SELECT	31920, 'Insert rule customer class Non-Sports', 'NAP_LM_CustomerClassNonSportsIns', 1, NULL, NULL  

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)