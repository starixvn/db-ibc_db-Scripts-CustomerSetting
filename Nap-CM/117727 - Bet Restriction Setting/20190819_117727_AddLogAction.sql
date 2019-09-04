/*
	Created: 20190819@Eden
	Task: Insert LogAction for BetRestriction
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31701, 'Add account to Bet Restriction List', 'NAP_BetRestriction_CustomerIns', 1, NULL, NULL UNION ALL
SELECT	31702, 'Edit Bet Restriction Account', 'NAP_BetRestriction_CustomerUpd', 1, NULL, NULL UNION ALL
SELECT	31703, 'Remove Bet Restriction Account', 'NAP_BetRestriction_CustomerDel', 1, NULL, NULL UNION ALL
SELECT	31704, 'Add site to Bet Restriction List', 'NAP_BetRestriction_SiteIns', 1, NULL, NULL UNION ALL
SELECT	31705, 'Edit Bet Restriction Site', 'NAP_BetRestriction_SiteUpd', 1, NULL, NULL UNION ALL
SELECT	31706, 'Remove Bet Restriction Site', 'NAP_BetRestriction_SiteDel', 1, NULL, NULL UNION ALL
SELECT	31707, 'Add currency to Bet Restriction List', 'NAP_BetRestriction_CurrencyIns', 1, NULL, NULL UNION ALL
SELECT	31708, 'Edit Bet Restriction Currency', 'NAP_BetRestriction_CurrencyUpd', 1, NULL, NULL UNION ALL
SELECT	31709, 'Remove Bet Restriction Currency', 'NAP_BetRestriction_CurrencyDel', 1, NULL, NULL UNION ALL
SELECT	31710, 'On/Off Applying Bet Restriction', 'NAP_BetRestriction_SettingUpd', 1, NULL, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
