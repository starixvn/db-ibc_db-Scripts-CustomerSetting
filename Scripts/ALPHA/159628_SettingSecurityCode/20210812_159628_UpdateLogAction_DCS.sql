/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Elodie
	Date: 20190405
	Task: Update LogAction for New Simplified Chinese (CN88) 
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameCH NVARCHAR(256), ActionNameCS NVARCHAR(256), ActionNameTH NVARCHAR(256), ActionNameVI NVARCHAR(256))

INSERT INTO @tmpAction (ActionID, ActionNameCH, ActionNameCS, ActionNameTH, ActionNameVI)
SELECT	951, N'更新保安碼選項 - 投注歷史', N'更新保安码选项 - 投注历史', N'อัปเดตตัวเลือกรหัสความปลอดภัย - รายการวางเดิมพันที่เล่นไปแล้ว', N'Cập nhật Tùy Chọn Mã Bảo Mật - Danh sách cược' UNION ALL
SELECT	952, N'更新保安碼選項 - 綜合', N'更新保安码选项 - 综合 ', N'อัปเดตตัวเลือกรหัสความปลอดภัย - บัญชี ', N'Cập nhật Tùy Chọn Mã Bảo Mật - Sao kê'


UPDATE l
SET l.ActionNameCS = t.ActionNameCS,
	l.ActionNameCH = t.ActionNameCH,
	l.ActionNameTH = t.ActionNameTH,
	l.ActionNameVI = t.ActionNameVI
FROM dbo.LogAction l WITH (ROWLOCK)
	INNER JOIN @tmpAction t ON t.ActionID = l.ActionID
