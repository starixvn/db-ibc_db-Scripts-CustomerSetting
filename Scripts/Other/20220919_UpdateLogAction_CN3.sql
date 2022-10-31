/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Elodie
	Date: 20220919
	Task: Update LogAction
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameVI NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameVI)
SELECT 31801, N'Cập nhật Giới Hạn Chung cho tài khoản' --'Updated Global Threshold for customer(s)'
UNION ALL 
SELECT 31802, N'Thêm Giới Hạn Riêng cho tài khoản' --'Inserted Personal Threshold for customer(s)'
UNION ALL
SELECT 31803, N'Cập nhật Giới Hạn Riêng cho tài khoản' --'Updated Personal Threshold for customer(s)'
UNION ALL 
SELECT 31804, N'Xóa Giới Hạn Riêng cho tài khoản' --'Deleted Personal Threshold for customer(s)'


UPDATE l
SET l.ActionNameVI = t.ActionNameVI
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID

GO