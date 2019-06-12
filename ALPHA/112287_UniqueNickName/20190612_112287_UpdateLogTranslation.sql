/*
	Created by: Kan
	Date: 20190612
	Task: Insert LogAction for Unique Nickname of MBC
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

-- CH: Traditional, CN: CN88, CS: Simplify
DECLARE @tmpAction TABLE (
    ActionID INT,
    ActionNameCH NVARCHAR(256),
    ActionNameCS NVARCHAR(256),
    ActionNameTH NVARCHAR(256),
    ActionNameVI NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameCH, ActionNameCS, ActionNameTH, ActionNameVI)
SELECT	688, N'子帳戶建立暱稱', N'子账户创建昵称', N'ชื่อเล่นถูกตั้งโดยผู้ใช้งานย่อย', N'Tài khoản phụ tạo biệt danh' UNION ALL
SELECT	689, N'此子帳戶僅能使用暱稱登入。', N'此子账户仅能使用昵称登入。', N'ผู้ใช้งานย่อย ตั้งค่าการเข้าใช้งานด้วยชื่อเล่นเท่านั้น', N'Tài khoản phụ thiết lập chỉ đăng nhập bằng biệt danh'

UPDATE l
SET l.ActionNameCH = t.ActionNameCH,
	l.ActionNameCS = t.ActionNameCS,
    l.ActionNameTH = t.ActionNameTH,
    l.ActionNameVI = t.ActionNameVI
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
GO
