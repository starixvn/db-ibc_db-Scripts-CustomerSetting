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
SELECT 346, 'MaxPerMatch > upline''s MaxPerMatch', GETDATE()
UNION SELECT 347, 'MaxPayoutPerMatch > upline''s MaxPayoutPerMatch', GETDATE()
UNION SELECT 348, 'MaxPerBall > upline''s MaxPerBall', GETDATE()

UNION SELECT 349, 'MaxPerBall > MaxPerMatch', GETDATE()
UNION SELECT 350, 'MaxBet > upline''s MaxBet', GETDATE()
