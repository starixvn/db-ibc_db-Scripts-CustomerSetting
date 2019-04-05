/*
	Created by: Johnson	
	Date: 20190405
	Task: update translate msg for LogAction
	DB: DBLOG/bodb_CustomerLog
*/

DECLARE @tmpAction TABLE (ActionID INT, ActionNameCH NVARCHAR(256),ActionNameCS NVARCHAR(256),ActionNameCT NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameCH,ActionNameCS,ActionNameCT)
SELECT	937, N'重置密碼', N'重置密码', N'Reset Password' UNION ALL
SELECT	938, N'重置下線的密碼',N'重置下线的密码',N'Reset downline''s password' UNION ALL
SELECT	934, N'賬戶登錄5次失敗會被關閉',N'账户登录5次失败会被关闭',N'Account closed by failed login 5 times' UNION ALL
SELECT	1324, N'登錄通過代理 網站', N'登录通过代理 网站', N'Login via Agent''s Site' UNION ALL
SELECT	1325, N'登錄通過代理 網站', N'登录通过代理 网站', N'Login via Agent''s Site' UNION ALL
SELECT	935, N'重設特有的保安碼', N'重设特有的保安码', N'Reset own Security Code' UNION ALL
SELECT	936, N'重置下線的機密碼',N'重置下线的机密码',N'Reset Security Code of downline'


UPDATE l
SET l.ActionNameCH = t.ActionNameCH,
	l.ActionNameCS = t.ActionNameCS
FROM LogAction l WITH(UPDLOCK,ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID