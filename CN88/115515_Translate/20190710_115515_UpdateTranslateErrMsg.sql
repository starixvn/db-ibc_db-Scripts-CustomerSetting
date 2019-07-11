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
SELECT	80001, N'用户名、登入账号或密码错误。', N'用戶名、登入賬號或密碼錯誤。' UNION ALL
SELECT	80009, N'您的账户已停用。请联系您的上线启用账号。', N'您的帳戶已停用。請聯繫您的上線啟用帳號。' UNION ALL
SELECT	80010, N'您的账户已禁止登入。请联系您的上线启用账号。', N'您的帳戶已禁止登入。請聯繫您的上線啟用帳號。' UNION ALL
SELECT	40043, N'此账户的上线仍未启用，您无法进行此行为。', N'由於此帳戶的上線未啟用，您無法完成此行為。' UNION ALL
SELECT	40047, N'无法更新状态，上线层级未启用。', N'無法更新狀態，上線層級未啟用'

UPDATE l
SET l.MsgNameCT = t.MsgNameCT,
	l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
	