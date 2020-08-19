/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20200806@Eden
	Task: Insert LogAction for Auto Update bet Limit Control [#139701]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31756, 'Reduce Bet Limit after Check Performance', 'NAP_BLControl_PerformanceChecking_ReduceBetLimit', 1, NULL, NULL UNION ALL
SELECT	31757, 'Remove Bet Limit after Check Performance', 'NAP_BLControl_PerformanceChecking_RemoveBetLimit', 1, NULL, NULL UNION ALL
SELECT	31758, 'CTS flag  evidence for customers', 'NAP_BLControl_EvidenceFlagged', 1, NULL, NULL UNION ALL
SELECT	31759, 'CTS unflag  evidence for customers', 'NAP_BLControl_EvidenceUnflagged', 1, NULL, NULL UNION ALL
SELECT	31760, 'Create Default Bet Limit Setting', 'NAP_BLControl_DefaultSetting_Ins', 0, NULL, NULL UNION ALL
SELECT	31761, 'Update Default Bet Limit Setting', 'NAP_BLControl_DefaultSetting_Upd', 0, NULL, NULL UNION ALL
SELECT	31762, 'Delete Default Bet Limit Setting', 'NAP_BLControl_DefaultSetting_Del', 0, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

--SELECT * FROM LogAction (NOLOCK) WHERE ActionID BETWEEN 31756 AND 31762
