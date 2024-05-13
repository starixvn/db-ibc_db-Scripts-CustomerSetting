/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created: 20240423@Johnson
	Task: Add more rules check settings [redmine: #204108]
	DB: DBCHECK/CheckResultDB	
*/

USE [CheckResultDB]
GO

INSERT INTO [dbo].[Rule_Credit]
           ([RuleId]
           ,[RuleName]
           ,[ModifiedDate])
SELECT 345, 'MaxBet > upline''s MaxBet', GETDATE()
UNION SELECT 346, 'MaxPerMatch > upline''s MaxPerMatch', GETDATE()
UNION SELECT 347, 'MaxPayoutPerMatch > upline''s MaxPayoutPerMatch', GETDATE()
UNION SELECT 348, 'MaxPerNumber > upline''s MaxPerNumber', GETDATE()
UNION SELECT 349, 'MinBet > MaxBet', GETDATE()
UNION SELECT 350, 'MaxBet > MaxPerMatch', GETDATE()
UNION SELECT 351, 'MaxBet > MaxPerNumber', GETDATE()
UNION SELECT 352, 'MaxPerNumber > MaxPerMatch', GETDATE()
UNION SELECT 353, 'MaxPerMatch > MaxPayoutPerMatch', GETDATE()
