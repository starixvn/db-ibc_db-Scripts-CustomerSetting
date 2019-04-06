USE [bodb_CustomerLog]
GO

/*
	Created: 20190406@Percy
	DB: DBLOG.bodb_CustomerLog
	Task: CN88 - Update translation for update credit/status log
*/

;WITH CTE_Action AS
(
	SELECT 1217 AS ActionID, N' 更新会员信用额度' AS ActionNameCN UNION ALL
	SELECT 1218 AS ActionID, N' 更新代理信用额度' AS ActionNameCN UNION ALL
	SELECT 1219 AS ActionID, N' 更新总代理信用额度' AS ActionNameCN UNION ALL
	SELECT 1220 AS ActionID, N' 更新超级代理信用额度' AS ActionNameCN UNION ALL
	SELECT 165004 AS ActionID, N' 更改帐户状态' AS ActionNameCN
)
UPDATE l WITH (ROWLOCK, UPDLOCK)
SET l.ActionNameCN = c.ActionNameCN
FROM dbo.LogAction l
	INNER JOIN CTE_Action c ON l.ActionID = c.ActionID