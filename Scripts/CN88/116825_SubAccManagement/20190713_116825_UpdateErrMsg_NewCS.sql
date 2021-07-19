/*
	Created by: Elodie
	Date: 20190729
	Task: Update ErrMsg for New Simplified Chinese (CN88) 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @tmpErrMsg TABLE (MsgID INT, MsgNameCT NVARCHAR(500), MsgNameCN NVARCHAR(500))

INSERT INTO @tmpErrMsg (MsgID, MsgNameCN, MsgNameCT)
SELECT	40048, N'无法删除子账户。请重试。', N'無法刪除子帳戶。請重試。' UNION ALL
SELECT	40049, N'行为无效。请重试。', N'行為無效。請重試。' UNION ALL
SELECT	40050, N'你没有勾选"可管理帐号",请勾选其中一个或全选', N'你沒有勾選"可管理帳號",請勾選其中一個或全選'

UPDATE l
SET l.MsgNameCT = t.MsgNameCT,
	l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
	