/*
	Created by: Elodie
	Date: 20190612
	Task: Update LogAction
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameEN NVARCHAR(256), ActionNameCS NVARCHAR(256), ActionNameCH NVARCHAR(256), ActionNameTH NVARCHAR(256), ActionNameVI NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameEN, ActionNameCS, ActionNameCH, ActionNameTH, ActionNameVI)
SELECT	919, N'Sub account resets his own Security Code', N'子账户已重置其安全代码。', N'子帳戶已重設其安全密碼。', N'ผู้ใช้งานย่อย ตั้งค่ารหัสความปลอดภัยใหม่', N'Tài khoản phụ đặt lại Mã Bảo Mật'

UPDATE l
SET l.ActionNameEN = t.ActionNameEN,
	l.ActionNameCS = t.ActionNameCS,
	l.ActionNameCH = t.ActionNameCH,
	l.ActionNameTH = t.ActionNameTH,
	l.ActionNameVI = t.ActionNameVI
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
