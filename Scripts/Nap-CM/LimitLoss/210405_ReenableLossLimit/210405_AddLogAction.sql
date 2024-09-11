/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 202040911@Elodie
	Task: Insert LogAction for LimitLoss
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @IsInternal BIT = 1
DECLARE @ActionType TINYINT = 4
DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	95119, 'Send  LimitLoss Letstalk notification for SMA', 'NAP_LimitLoss_SMAIsNotificationUpd', @IsInternal, @ActionType, NULL UNION ALL
SELECT	95120, 'Send  LimitLoss Letstalk notification for Headline', 'NAP_LimitLoss_SMAIsNotificationUpd', @IsInternal, @ActionType, NULL 

--DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
