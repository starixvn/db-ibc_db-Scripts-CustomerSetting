/*
	Created by: Elodie
	Date: 20200108
	Task: Update LogAction
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

UPDATE l
SET l.ActionNameCS = N'默认个人头像已添加成功。',
	l.ActionNameCH = N'默認個人頭像已添加成功。',
	l.ActionNameTH = N'รูปโปรไฟล์ เพิ่มสำเร็จแล้ว',
	l.ActionNameVI = N'Ảnh đại diện đã được thêm vào'
FROM dbo.LogAction l WITH (ROWLOCK)
WHERE l.ActionID = 697

UPDATE l
SET l.ActionNameCS = N'默认个人头像已成功更改为用户个人头像。',
	l.ActionNameCH = N'默認個人頭像已成功更改為用戶個人頭像。',
	l.ActionNameTH = N'รูปโปรไฟล์ ได้เริ่มต้นเปลี่ยนเป็นรูปภาพโปรไฟล์ของผู้ใช้แล้ว',
	l.ActionNameVI = N'Ảnh đại diện mặc định đã được thay bằng ảnh của người dùng.'
FROM dbo.LogAction l WITH (ROWLOCK)
WHERE l.ActionID = 698

UPDATE l
SET l.ActionNameCS = N'用户个人头像已成功更改为默认个人头像。',
	l.ActionNameCH = N'用戶個人頭像已成功更改為默認個人頭像。',
	l.ActionNameTH = N'รูปโปรไฟล์ของผู้ใช้ถูกเปลี่ยนเป็น รูปโปรไฟล์เริ่มต้น',
	l.ActionNameVI = N'Ảnh đại diện của người dùng đã được thay bằng ảnh mặc định.'
FROM dbo.LogAction l WITH (ROWLOCK)
WHERE l.ActionID = 699

UPDATE l
SET l.ActionNameCS = N'默认个人头像已更改成功。',
	l.ActionNameCH = N'默認個人頭像已更改成功。',
	l.ActionNameTH = N'รูปภาพโปรไฟล์ เปลี่ยนแปลงแล้ว',
	l.ActionNameVI = N'Ảnh đại diện mặc định đã được đổi.'
FROM dbo.LogAction l WITH (ROWLOCK)
WHERE l.ActionID = 700

UPDATE l
SET l.ActionNameCS = N'用户个人头像已更改成功。',
	l.ActionNameCH = N'用戶個人頭像已更改成功。',
	l.ActionNameTH = N'รูปภาพโปรไฟล์ของผู้ใช้ ถูกเปลี่ยนแล้ว',
	l.ActionNameVI = N'Ảnh đại diện của người dùng đã được đổi.'
FROM dbo.LogAction l WITH (ROWLOCK)
WHERE l.ActionID = 701