/*
	Created by: Elodie
	Date: 20190408
	Task: Update ErrMsg for New Simplified Chinese (CN88) 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpErrMsg TABLE (MsgID INT, MsgNameCS NVARCHAR(500), MsgNameCN NVARCHAR(500))

INSERT INTO @tmpErrMsg (MsgID, MsgNameCN, MsgNameCS)
SELECT	40041, N'无效的股东', N'無效的股東' UNION ALL
SELECT	40001, N'此账户已有人使用。', N'此帳戶已有人使用。' UNION ALL
SELECT	40004, N'会员创建失败，请重试。', N'會員建立失敗，請重試。' UNION ALL
SELECT	40030, N'不好意思，您不能在短时间内创建过多会员。', N'不好意思，您不能在短時間內新建過多會員。' UNION ALL
SELECT	40032, N'您的账户无法创建更多会员。请联系您的上线或客服人员了解更多信息。', N'您的帳戶無法新建更多會員。請聯繫您的上線或客服人員瞭解更多資訊。' UNION ALL
SELECT	90011, N'此功能正在维护， 暂时无法使用。请稍后再尝试。谢谢！', N'此功能正在維護， 暫時無法使用。請稍後再嘗試。謝謝！' UNION ALL
SELECT	70003, N'不好意思，信用额度增加失败。您已超出您的的代理限额。', N'不好意思，信用額度增加失敗。您已超出您的的代理限額。' UNION ALL
SELECT	40029, N'不好意思，您不能在短时间内创建过多会员。', N'不好意思，您不能在短時間內新建過多會員。' UNION ALL
SELECT	70027, N'不好意思，信用额度更新失败，您已超出您的超级代理额度。', N'不好意思，信用額度更新失敗，您已超出您的超級代理額度。' UNION ALL --new msg
SELECT	70028, N'不好意思，信用额度更新失败，您已超出您的总代理额度。', N'不好意思，信用額度更新失敗，您已超出您的總代理額度。' --new msg

UPDATE l
SET l.MsgNameCS = t.MsgNameCS,
	l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
