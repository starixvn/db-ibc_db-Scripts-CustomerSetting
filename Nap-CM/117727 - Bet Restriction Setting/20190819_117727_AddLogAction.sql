/*
	Created: 20190819@Eden
	Task: Insert LogAction for BetRestriction
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31701, 'Insert Bet Restriction Customer', 'NAP_BetRestriction_CustomerIns', 0, 4, NULL UNION ALL
SELECT	31702, 'Update Bet Restriction Customer', 'NAP_BetRestriction_CustomerUpd', 0, 4, NULL UNION ALL
SELECT	31703, 'Delete Bet Restriction Customer', 'NAP_BetRestriction_CustomerDel', 0, 4, NULL UNION ALL
SELECT	31704, 'Insert Bet Restriction Site', 'NAP_BetRestriction_SiteIns', 0, 4, NULL UNION ALL
SELECT	31705, 'Update Bet Restriction Site', 'NAP_BetRestriction_SiteUpd', 0, 4, NULL UNION ALL
SELECT	31706, 'Delete Bet Restriction Site', 'NAP_BetRestriction_SiteDel', 0, 4, NULL UNION ALL
SELECT	31707, 'Insert Bet Restriction Currency', 'NAP_BetRestriction_CurrencyIns', 0, 4, NULL UNION ALL
SELECT	31708, 'Update Bet Restriction Currency', 'NAP_BetRestriction_CurrencyUpd', 0, 4, NULL UNION ALL
SELECT	31709, 'Delete Bet Restriction Currency', 'NAP_BetRestriction_CurrencyDel', 0, 4, NULL 

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)
