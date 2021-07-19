USE [bodb_CustomerLog]
GO

/*
	Created: 20190406@Percy
	DB: DBLOG.bodb_CustomerLog
	Task: CN88 - Update translation for update credit/status log
*/

;WITH CTE_Action AS
(
	SELECT 1217 AS ActionID, N'更新會員信用額度' AS ActionNameCH UNION ALL
	SELECT 1218 AS ActionID, N'更新帶領信用額度' AS ActionNameCH UNION ALL
	SELECT 1219 AS ActionID, N'更新總代理信用額度' AS ActionNameCH UNION ALL
	SELECT 1220 AS ActionID, N'更新超級代理信用額度' AS ActionNameCH
)
UPDATE l WITH (ROWLOCK, UPDLOCK)
SET l.ActionNameCH = c.ActionNameCH
FROM dbo.LogAction l
	INNER JOIN CTE_Action c ON l.ActionID = c.ActionID
GO
