/*
	Created by: Elodie
	Date: 20190329
	Task: Insert ErrMsg for sub account of CN88
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpMsg TABLE (MsgID INT, MsgName NVARCHAR(500), MsgGroupId INT, IsActive BIT)

INSERT INTO @tmpMsg (MsgID, MsgName, MsgGroupId, IsActive)
SELECT	40042, 'You have exceeded the maxiumum number of Sub Account. Unable to proceed with account creation.', 5, 1

INSERT INTO dbo.MsgError (MsgID, MsgGroupID, MsgNameEN, MsgNameCT, MsgNameCS, MsgNameJP, MsgNameTH, MsgNameKO, MsgNameES, MsgNameVI, IsActive, MsgNameCN)
SELECT t.MsgID, t.MsgGroupId, t.MsgName, '已超過可使用子賬戶限制, 無法新增子帳戶。', t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.MsgName, t.IsActive, '已超过可使用子帐户限制, 无法新增子帐户。'
FROM @tmpMsg t
WHERE NOT EXISTS (SELECT 1 FROM MsgError WHERE MsgID = t.MsgID)
