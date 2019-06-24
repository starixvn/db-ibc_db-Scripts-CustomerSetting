/*
	Created by: Elodie
	Date: 20190621
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameEN NVARCHAR(256), ActionNameCH NVARCHAR(256), ActionNameCN NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameEN, ActionNameCN, ActionNameCH)
SELECT	165003, 'Add account status for SMA', N'新增超级代理帐户状态', N'新增超級代理帳戶狀態' UNION ALL
SELECT	165005, 'Add account status for Master Agent', N'新增总代理帐户状态', N'新增總代理帳戶狀態' UNION ALL
SELECT	165006, 'Add account status for Agent', N'新增代理商账户状态', N'新增代理商帳戶狀態' UNION ALL
SELECT	165007, 'Add account status for Member', N'新增会员账户状态', N'新增會員帳戶狀態' UNION ALL
SELECT	941, 'Failed providing Security Code of Sub-Account', N'提供的子账户安全验证码错误', N'提供的子帳戶安全驗證碼錯誤' UNION ALL
SELECT	942, 'Sub account is locked due to failed security code validations', N'安全碼驗證失敗，已鎖定帳戶', N'安全碼驗證失敗，已鎖定帳戶' UNION ALL
SELECT	943, 'Failed providing Security Code of customer', N'提供的会员安全验证码错误', N'提供的會員安全驗證碼錯誤' UNION ALL
SELECT	944, 'Account is locked due to failed security code validations', N'安全码验证失败，已锁定账户', N'安全碼驗證失敗，已鎖定帳戶' UNION ALL
SELECT	939, 'Sub account is locked due to failed logins 5 times', N'登入失败5次，已锁定子账户', N'登入失敗5次，已鎖定子賬戶' UNION ALL
SELECT	940, 'Account is locked due to failed logins 5 times', N'登录失败次数达5次，账户已被锁定。', N'登入錯誤次數達5次，已鎖定帳戶' UNION ALL
SELECT	165004, 'Update Account Status for SMA', N'更新超级代理帐户状态', N'更新超級代理帳戶狀態' UNION ALL
SELECT	165008, 'Update Account Status for Master Agent', N'更新总代理帐户状态', N'更新總代理帳戶狀態' UNION ALL
SELECT	165009, 'Update Account Status for Agent', N'更新代理商账户状态', N'更新代理商帳戶狀態' UNION ALL
SELECT	165010, 'Update Account Status for Member', N'更新会员账户状态', N'更新會員帳戶狀態' UNION ALL
SELECT	165011, 'Unlock Sub Account', N'解锁子账户', N'解鎖子帳戶' UNION ALL
SELECT	1324, 'Login via Agent''s Site', N'透过代理网站登入', N'登錄通過代理 網站' UNION ALL
SELECT	1325, 'Login via Agent''s Site', N'透过代理网站登入', N'登錄通過代理 網站' UNION ALL
SELECT	1326, 'Login via Agent''s Site', N'透过代理网站登入', N'登錄通過代理 網站' UNION ALL
SELECT	1327, 'Login via Agent''s Site', N'透过代理网站登入', N'登錄通過代理 網站' UNION ALL
SELECT	1328, 'Login via Agent''s Site', N'透过代理网站登入', N'登錄通過代理 網站' UNION ALL
SELECT	1329, 'Login via Agent''s Site', N'透过代理网站登入', N'登錄通過代理 網站' UNION ALL
SELECT	1330, 'Log-out', N'登出', N'登出' UNION ALL
SELECT	687, 'Create nickname', N'创建简易登入账号', N'創建簡易登入賬號' UNION ALL
SELECT	165011, 'Unlock access status for sub account', N'解除锁定子账户', N'解除鎖定子帳戶'

UPDATE l
SET l.ActionNameCN = t.ActionNameCN,
	l.ActionNameCH = t.ActionNameCH
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

UPDATE l
SET l.ActionNameEN = t.ActionNameEN
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
WHERE t.ActionID = 165005