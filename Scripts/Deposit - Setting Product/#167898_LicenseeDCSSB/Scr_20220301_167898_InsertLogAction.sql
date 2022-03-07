/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Eden@20220301
	Task: Insert LogAction for Dynamic SportBook and NumberGame, Keno   [Redmine:#167898]	
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	398, 'Update Bet Settings Games DCS Products for Deposit Customers by Admin', 'Acc_Dep_CustSetting_Game_BetLimitFullLineUpd', 1, 3, NULL UNION ALL
SELECT	2047, 'Update Bet Settings Game for Deposit Customers for DCS Products', 'Acc_Dep_CustSetting_Game_BetLimitUpd', 0, 3, NULL

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

