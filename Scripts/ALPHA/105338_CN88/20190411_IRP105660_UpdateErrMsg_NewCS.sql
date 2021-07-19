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
SELECT	70027, N'不好意思，信用额度更新失败，您已超出您的超级代理额度。', N'不好意思，信用額度更新失敗，您已超出您的超級代理額度。' UNION ALL --new msg
SELECT	70028, N'不好意思，信用额度更新失败，您已超出您的总代理额度。', N'不好意思，信用額度更新失敗，您已超出您的總代理額度。' UNION ALL --new msg
SELECT	40038, N'已超出创建会员数上限，您无法再创建会员账户。请联系您的上线已取得协助。', N'已超出新建會員數上限，您無法再新建會員帳戶。請聯繫您的上線已取得協助。'

UPDATE l
SET l.MsgNameCT = t.MsgNameCT,
	l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
WHERE l.MsgID IN(70027, 70028)

UPDATE l
SET l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
WHERE l.MsgID IN(40038)
