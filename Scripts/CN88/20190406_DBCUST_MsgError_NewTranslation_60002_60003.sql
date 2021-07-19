USE [CustDB]
GO

/*
	Created: 20190406@Percy
	DB: DBCUST.CustDB
	Task: CN88 - Update translation error message for update credit/status
*/

;WITH CTE_MsgError AS
(
	SELECT 60002 AS MsgID, N'无法编辑。此会员的上线已被暂时停权。' AS MsgNameCN UNION ALL
	SELECT 60003 AS MsgID, N'无法编辑。此会员的上线已关闭。' AS MsgNameCN
)
UPDATE m WITH (ROWLOCK, UPDLOCK)
SET m.MsgNameCN = c.MsgNameCN
FROM dbo.MsgError m
	INNER JOIN CTE_MsgError c ON m.MsgID = c.MsgID