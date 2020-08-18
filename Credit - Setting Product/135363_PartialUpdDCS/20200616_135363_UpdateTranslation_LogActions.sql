/*
	Created: 20200818@Elodie
	Task: Update Translation for updating MinPT
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

UPDATE l
SET l.ActionNameCS = N'更新其他产品的最低占成数于超级总代理',
	l.ActionNameCH = N'更新其他產品的最低占成數於超級總代理',
	l.ActionNameTH = N'อัปเดตผลิตภัณฑ์อื่นๆ ค่าแบ่งสู้ขั้นต่ำสำหรับซุปเปอร์',
	l.ActionNameVI = N'Cập nhật Position Taking Nhỏ Nhất của Super cho Sản Phẩm Khác'
FROM dbo.LogAction l WITH (NOLOCK)
WHERE l.ActionID = 508

UPDATE l
SET l.ActionNameCS = N'更新其他产品的最低占成数于总代理',
	l.ActionNameCH = N'更新其他產品的最低占成數於總代理',
	l.ActionNameTH = N'อัปเดตผลิตภัณฑ์อื่นๆ ค่าแบ่งสู้ขั้นต่ำสำหรับมาสเตอร์',
	l.ActionNameVI = N'Cập nhật Position Taking Nhỏ Nhất của Master cho Sản Phẩm Khác'
FROM dbo.LogAction l WITH (NOLOCK)
WHERE l.ActionID = 509

UPDATE l
SET l.ActionNameCS = N'更新其他产品的最低占成数于代理',
	l.ActionNameCH = N'更新其他產品的最低占成數於代理',
	l.ActionNameTH = N'อัปเดตผลิตภัณฑ์อื่นๆ ค่าแบ่งสู้ขั้นต่ำสำหรับเอเจ่นต์',
	l.ActionNameVI = N'Cập nhật Position Taking Nhỏ Nhất của Agent cho Sản Phẩm Khác'
FROM dbo.LogAction l WITH (NOLOCK)
WHERE l.ActionID = 510