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
SELECT	70024, N'信用额度不足。', N'信用額度不足。' UNION ALL
SELECT	70025, N'信用额度必须是正数', N'信用額度必須是正數' UNION ALL
SELECT	70029, N'不好意思，信用额度更新失败，您已超出您的代理额度。', N'不好意思，信用額度更新失敗，您已超出您的代理額度。'

UPDATE l
SET l.MsgNameCT = t.MsgNameCT,
	l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
	
SELECT * FROM dbo.MsgError WHERE MsgID IN (70024, 70025, 70026, 70027, 70028, 70029)