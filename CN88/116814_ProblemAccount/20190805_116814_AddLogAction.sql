/*
	Created: 20190808@Elodie
	Task: Insert LogAction for Problem Account
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @IsInternal BIT = 1
DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31601, 'Mark New Problem Account', 'CS_ProblemAccount_AddCustomer', @IsInternal, NULL, NULL UNION ALL
SELECT	31602, 'Reduce Bet Limit', 'CS_ProblemAccount_ReduceBetLimit', @IsInternal, NULL, NULL UNION ALL
SELECT	31603, 'Remove Reduced Bet Limit - S/M/A', 'CS_ProblemAccount_RemoveReduceBetLimit', @IsInternal, NULL, NULL UNION ALL
SELECT	31604, 'Remove Reduced Bet Limit - Member', 'CS_ProblemAccount_RemoveReduceBetLimit', @IsInternal, NULL, NULL UNION ALL
SELECT	31605, 'Inactivate Problem Account', 'CS_ProblemAccount_InactiveAccount', @IsInternal, NULL, NULL UNION ALL
SELECT	31607, 'Unmark Problem Account - S/M/A', 'CS_ProblemAccount_RemoveCustomer', @IsInternal, NULL, NULL UNION ALL
SELECT	31611, 'Unmark Problem Account - Member', 'CS_ProblemAccount_RemoveCustomer', @IsInternal, NULL, NULL UNION ALL
SELECT	31606, 'Remove Reduced Bet Limit - Following Upline', 'CS_ProblemAccount_RemoveReduceBetLimit', @IsInternal, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
