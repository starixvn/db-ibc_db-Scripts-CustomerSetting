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
SELECT	40006, N'这个登入账号不可使用', N'這個登入賬號不可使用' UNION ALL
SELECT	40007, N'无法创建用户名。请再试一次', N'無法創建用戶名。請再試一次' UNION ALL
SELECT	80001, N'用户名、登入账号或密码错误。', N'用戶名、登入賬號或密碼錯誤。' UNION ALL
SELECT	80003, N'您当前所在地点禁止访问本网站。', N'您目前所在地禁止進入本網站。' UNION ALL
SELECT	80004, N'你试图从未经许可的地区登入本網站。', N'您試圖從未經許可地區登入本網站。' UNION ALL
SELECT	80002, N'账号关闭，请联系您的管理员。', N'帳號關閉，請聯繫您的管理員。' UNION ALL
SELECT	60020, N'本账户已停用。', N'本帳戶已停用。' UNION ALL
SELECT	80007, N'多次认证输入失败，已锁定您的账户。请联系您的上线进行解锁。', N'多次認證輸入失敗，已鎖定您的帳戶。請聯繫您的上線進行解鎖。' UNION ALL
SELECT	40045, N'多次认证输入失败，已锁定您的账户。请联系您的上线进行解锁。', N'多次認證輸入失敗，已鎖定您的帳戶。請聯繫您的上線進行解鎖。' UNION ALL
SELECT	80009, N'您的账户已失效。请联系您的上线激活账号。', N'您的帳戶已失效。請聯繫您的上線啟用帳號。' UNION ALL
SELECT	80010, N'您的账户已停用。请联系您的上线激活账号。', N'您的帳戶已停用。請聯繫您的上線啟用帳號。' UNION ALL
SELECT	40044, N'认证连续输入失败，已锁定您的子账户。请联系主账号用户上线进行解锁。', N'認證連續輸入失敗，已鎖定您的子帳戶。請聯繫主帳號用戶上線進行解鎖。' UNION ALL
SELECT	40026, N'安全代码错误，请重试。', N'安全代碼錯誤，請重試。' UNION ALL
SELECT	40043, N'此账户的上线仍未启用，您无法进行此行为。', N'由於此帳戶的上線未啟用，您無法完成此行為。' 

UPDATE l
SET l.MsgNameCS = t.MsgNameCS,
	l.MsgNameCN = t.MsgNameCN
FROM dbo.MsgError l WITH (ROWLOCK)
	INNER JOIN @tmpErrMsg t ON t.MsgID = l.MsgID
	