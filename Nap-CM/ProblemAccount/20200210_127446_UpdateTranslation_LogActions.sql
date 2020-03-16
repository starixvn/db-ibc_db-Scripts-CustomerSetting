/*
	Created: 20190909@Alvin
	Task: Update Type and Translation for Problem Account Update Review Status LogActions
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

UPDATE l
SET l.ActionNameCS = N'更新总代理审核状态',
	l.ActionNameCH = N'更新總代理審核狀態',
	l.ActionNameTH = N'อัปเดตสถานะการตรวจสอบสำหรับมาสเตอร์',
	l.ActionNameVI = N'Cập nhật Trạng Tái Đã Xem cho Master'
FROM dbo.LogAction l WITH (NOLOCK)
WHERE l.ActionID = 31620

UPDATE l
SET l.ActionNameCS = N'更新代理审核状态',
	l.ActionNameCH = N'更新代理審核狀態',
	l.ActionNameTH = N'อัปเดตสถานะการตรวจสอบสำหรับเอเจนต์',
	l.ActionNameVI = N'Cập nhật Trạng Tái Đã Xem cho Agent'
FROM dbo.LogAction l WITH (NOLOCK)
WHERE l.ActionID = 31621

UPDATE l
SET l.ActionNameCS = N'更新会员审核状态',
	l.ActionNameCH = N'更新會員審核狀態',
	l.ActionNameTH = N'อัปเดตสถานะการตรวจสอบสำหรับสมาชิก',
	l.ActionNameVI = N'Cập nhật Trạng Tái Đã Xem cho Member'
FROM dbo.LogAction l WITH (NOLOCK)
WHERE l.ActionID = 31622