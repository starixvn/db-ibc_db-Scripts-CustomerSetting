/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20231002@Winfred
	Task: 20231002@Winfred: Allow to offer Parlay Boost on rule setting [RedmineID: #190607]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31912, 'Insert customer class offer parlay boost', 'NAP_LM_CustomerClassUtilityOfferIns', 1, NULL, NULL UNION ALL
SELECT	31913, 'Update customer class offer parlay boost', 'NAP_LM_CustomerClassUtilityOfferUpd', 1, NULL, NULL UNION ALL
SELECT	31914, 'Delete customer class offer parlay boost', 'NAP_LM_CustomerClassUtilityOfferDel', 1, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)