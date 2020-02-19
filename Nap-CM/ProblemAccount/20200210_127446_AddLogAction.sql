/*
	Created: 20200210@Elodie
	Task: Insert LogAction for Problem Account
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @IsInternal BIT = 1
DECLARE @ActionType TINYINT = 6
DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31613, 'Mark New Problem Account', 'NAP_ProblemAccount_AddCustomer', @IsInternal, @ActionType, NULL UNION ALL
SELECT	31614, 'Reduce Bet Limit', 'NAP_ProblemAccount_ReduceBetLimit', @IsInternal, @ActionType, NULL UNION ALL
SELECT	31615, 'Remove Reduced Bet Limit - S/M/A', 'NAP_ProblemAccount_RemoveReduceBetLimit', @IsInternal, @ActionType, NULL UNION ALL
SELECT	31616, 'Remove Reduced Bet Limit - Member', 'NAP_ProblemAccount_RemoveReduceBetLimit', @IsInternal, @ActionType, NULL UNION ALL
SELECT	1172,  'Close Problem Account', 'NAP_ProblemAccount_ClosedAccount', @IsInternal, 5, NULL UNION ALL
SELECT	31619, 'Unmark Problem Account - S/M/A', 'NAP_ProblemAccount_RemoveCustomer', @IsInternal, @ActionType, NULL UNION ALL
SELECT	31623, 'Unmark Problem Account - Member', 'NAP_ProblemAccount_RemoveCustomer', @IsInternal, @ActionType, NULL UNION ALL
SELECT	31618, 'Remove Reduced Bet Limit - Following Upline', 'NAP_ProblemAccount_RemoveReduceBetLimit', @IsInternal, @ActionType, NULL UNION ALL
SELECT	31617, 'Update Preventive Action', 'NAP_ProblemAccount_PreventiveActionUpd', @IsInternal, @ActionType, NULL UNION ALL

SELECT	31620, 'Update Review Status for MA', 'NAP_ProblemAccount_ReviewStatusUpd', 0, @ActionType, NULL UNION ALL
SELECT	31621, 'Update Review Status for Agent', 'NAP_ProblemAccount_ReviewStatusUpd', 0, @ActionType, NULL UNION ALL
SELECT	31622, 'Update Review Status for Member', 'NAP_ProblemAccount_ReviewStatusUpd', 0, @ActionType, NULL

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
