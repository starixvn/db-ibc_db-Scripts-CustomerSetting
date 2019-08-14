/*
	Created: 20190814@Alvin
	Task: Insert LogAction for Problem Account Update Review Status
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31608, 'Update Review Status for MA', 'CS_ProblemAccount_ReviewStatusUpd', 0, NULL, NULL UNION ALL
SELECT	31609, 'Update Review Status for Agent', 'CS_ProblemAccount_ReviewStatusUpd', 0, NULL, NULL UNION ALL
SELECT	31610, 'Update Review Status for Member', 'CS_ProblemAccount_ReviewStatusUpd', 0, NULL, NULL

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
