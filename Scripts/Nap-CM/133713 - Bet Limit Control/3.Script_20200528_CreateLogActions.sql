/*
	Created: 20200529@Eden
	Task: Insert LogAction for Bet Limit Control [#132736]
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionName NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)
INSERT INTO @tmpAction (ActionID, ActionName, SPName, IsInternal, ActionTypeId, Level)
SELECT	31750, 'Create Bet Limit Type', 'NAP_BLControl_TypeInsert', 1, NULL, NULL UNION ALL
SELECT	31751, 'Update Bet Limit Type', 'NAP_BLControl_TypeUpdate', 1, NULL, NULL UNION ALL
SELECT	31752, 'Delete Bet Limit Type', 'NAP_BLControl_TypeDelete', 1, NULL, NULL UNION ALL
SELECT	31753, 'Create Bet Limit (Bet Limit Control)', 'NAP_BLControl_CustInsert', 1, NULL, NULL UNION ALL
SELECT	31754, 'Update Bet Limit (Bet Limit Control)', 'NAP_BLControl_CustUpdate', 1, NULL, NULL UNION ALL
SELECT	31755, 'Delete Bet Limit (Bet Limit Control)', 'NAP_BLControl_CustDelete', 1, NULL, NULL

DELETE l FROM dbo.LogAction l INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

INSERT INTO dbo.LogAction (ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI,ActionNameCN)
SELECT ActionID,SPName,ActionTypeID,ActionName,ActionName,ActionName,ActionName,ActionName,ActionName,IsInternal,ActionName,ActionName
FROM @tmpAction t
WHERE NOT EXISTS (SELECT 1 FROM LogAction WHERE ActionID = t.ActionID)