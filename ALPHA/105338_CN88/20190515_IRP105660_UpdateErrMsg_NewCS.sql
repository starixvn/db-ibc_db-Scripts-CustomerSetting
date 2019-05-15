/*
	Created by: Elodie
	Date: 20190515
	Task: Update ErrMsg for New Simplified Chinese (CN88) 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpErrMsg TABLE (MsgID INT, MsgNameCS NVARCHAR(500), MsgNameCN NVARCHAR(500))

INSERT INTO @tmpErrMsg (MsgID, MsgNameCN, MsgNameCS)
SELECT	80001, N'帐户/昵称或是密码错误。', N'帳戶/暱稱/密碼錯誤。'

UPDATE l
SET l.MsgNameCS = t.MsgNameCS,
	l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
