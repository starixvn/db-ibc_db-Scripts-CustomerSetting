/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20220119@Johnson
	Task: update log action for Cash Out
	DB: DBLOG/bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

;WITH T AS (
	SELECT 60534 ActionID, N'通過網絡管理更新超級總代理即時兌現的狀態' as CH
	UNION SELECT 60535, N'更新超級總代理即時兌現的狀態'
	UNION SELECT 65568, N'通過網絡管理更新超級總代理即時兌現的狀態'
	UNION SELECT 65569, N'通過網絡管理更新總代理即時兌現的狀態'
	UNION SELECT 65570, N'更新超級總代理即時兌現的狀態'
	UNION SELECT 65571, N'更新總代理即時兌現的狀態'
	UNION SELECT 70606, N'通過網絡管理更新超級總代理即時兌現的狀態'
	UNION SELECT 70607, N'通過網絡管理更新總代理即時兌現的狀態'
	UNION SELECT 70608, N'通過網絡管理更新代理即時兌現的狀態'
	UNION SELECT 70609, N'更新超級總代理即時兌現的狀態'
	UNION SELECT 70610, N'更新總代理即時兌現的狀態'
	UNION SELECT 70611, N'更新代理即時兌現的狀態'
	UNION SELECT 75636, N'通過網絡管理更新超級總代理即時兌現的狀態'
	UNION SELECT 75637, N'通過網絡管理更新總代理即時兌現的狀態'
	UNION SELECT 75638, N'通過網絡管理更新代理即時兌現的狀態'
	UNION SELECT 75639, N'通過網絡管理更新會員即時兌現的狀態'
	UNION SELECT 75640, N'更新超級總代理即時兌現的狀態'
	UNION SELECT 75641, N'更新總代理即時兌現的狀態'
	UNION SELECT 75642, N'更新代理即時兌現的狀態'
	UNION SELECT 75643, N'更新會員即時兌現的狀態'
)
UPDATE l
SET ActionNameCH = CH
FROM LogAction l
	INNER JOIN T ON l.ActionID = t.ActionID
GO
