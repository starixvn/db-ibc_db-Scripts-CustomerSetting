/*
	Created: 20200207@Eden
	Task: Insert LogAction for Dynamic SportBook and NumberGame 
	RM: #123750
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	398, 'Update Bet Settings Games DCS Products for Deposit Customers by Admin', 'Acc_Dep_CustSetting_Game_BetLimitFullLineUpd', 1, 3, NULL UNION ALL
SELECT	200000, 'Update Position Taking DSB Products for Deposit Customers by Admin', 'Acc_DSB_CustSetting_PositionTakingSettingUpd', 1, 1, NULL UNION ALL
SELECT	201000, 'Update Bet Settings DSB Products for Deposit Customers by Admin', 'Acc_DSB_CustSetting_BetLimitFullLineUpd', 1, 3, NULL

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)

