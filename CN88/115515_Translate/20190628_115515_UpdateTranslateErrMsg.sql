/*
	Created by: Elodie
	Date: 20190408
	Task: Update ErrMsg for New Simplified Chinese (CN88) 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpErrMsg TABLE (MsgID INT, MsgNameCT NVARCHAR(500), MsgNameCN NVARCHAR(500))

INSERT INTO @tmpErrMsg (MsgID, MsgNameCN, MsgNameCT)
SELECT	40006, N'此登入账号已有人使用。', N'此登入賬號已有人使用。' UNION ALL
SELECT	80001, N'用户名、登入账号或密码错误。', N'用戶名、登入賬號或密碼錯誤。'

UPDATE l
SET l.MsgNameCT = t.MsgNameCT,
	l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
	