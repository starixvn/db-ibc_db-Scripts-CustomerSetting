/*
	Created by: Elodie
	Date: 20210824
	Task: Insert LogAction
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

DECLARE @tmpAction TABLE (ActionID INT, ActionNameEN NVARCHAR(256), ActionNameCH NVARCHAR(256), ActionNameCS NVARCHAR(256), ActionNameTH NVARCHAR(256), ActionNameVI NVARCHAR(256), SPName VARCHAR(50), IsInternal BIT, ActionTypeId INT, Level TINYINT)

INSERT INTO @tmpAction (ActionID, ActionNameEN, ActionNameCH, ActionNameCS, ActionNameTH, ActionNameVI, SPName, IsInternal, ActionTypeId, Level)
SELECT 953, 'Reset Protection Code', N'重置保護碼', N'重置保护码', N'รีเซ็ตรหัสป้องกัน', N'Đổi Mã Bảo Vệ','Age_CustomerUpdProtectionCode', 0, 4, NULL UNION ALL
SELECT 1183, 'Update Protection Status By Upline', N'上線更新保護碼狀態', N'上线更新保护码状态', N'อัปเดตสถานะการป้องกันโดยอัพไลน์', N'Cập nhật Trạng Thái Bảo Vệ bởi Cấp Trên', 'Age_CustomerUpdProtectedMode', 0, 5, NULL UNION ALL
SELECT 1184, 'Update Protection Status by logged-in user', N'用戶登錄更新保護碼狀態', N'用户登录更新保护码状态', N'อัปเดตสถานะการป้องกันโดยผู้ใช้ที่เข้าสู่ระบบ', N'Cập nhật Trạng Thái Bảo Vệ bởi người dùng hiện tại', 'Age_LoginVerifyDownline', 0, 5, NULL UNION ALL
SELECT 1185, 'Update Protection Status by logged-in user', N'用戶登錄更新保護碼狀態', N'用户登录更新保护码状态', N'อัปเดตสถานะการป้องกันโดยผู้ใช้ที่เข้าสู่ระบบ', N'Cập nhật Trạng Thái Bảo Vệ bởi người dùng hiện tại', 'Age_LoginDownLine', 0, 5, NULL UNION ALL
SELECT 1186, 'Update Protection Status by logged-in user', N'用戶登錄更新保護碼狀態', N'用户登录更新保护码状态', N'อัปเดตสถานะการป้องกันโดยผู้ใช้ที่เข้าสู่ระบบ', N'Cập nhật Trạng Thái Bảo Vệ bởi người dùng hiện tại', 'Age_LoginDownLine_Sub', 0, 5, NULL UNION ALL
SELECT 1338, 'Login by Protection Code via Agent''s Site', N'通過使用保護碼登入代理網', N'通过使用保护码登入代理网', N'เข้าสู่ระบบด้วยรหัสป้องกันผ่านเว็บไซต์ของตัวแทน', N'Đăng nhập bằng Mã Bảo Vệ qua trang web Đại Lý', 'Age_LoginVerifyDownline', 0, NULL, NULL UNION ALL
SELECT 1339, 'Login by Protection Code via Agent''s Site', N'通過使用保護碼登入代理網', N'通过使用保护码登入代理网', N'เข้าสู่ระบบด้วยรหัสป้องกันผ่านเว็บไซต์ของตัวแทน', N'Đăng nhập bằng Mã Bảo Vệ qua trang web Đại Lý', 'Age_LoginDownLine', 0, NULL, NULL UNION ALL
SELECT 1340, 'Login by Protection Code via Agent''s Site', N'通過使用保護碼登入代理網', N'通过使用保护码登入代理网', N'เข้าสู่ระบบด้วยรหัสป้องกันผ่านเว็บไซต์ของตัวแทน', N'Đăng nhập bằng Mã Bảo Vệ qua trang web Đại Lý', 'Age_LoginDownLine_Sub', 0, NULL, NULL UNION ALL
SELECT 1341, 'Login by Protection Code via Agent''s Site', N'通過使用保護碼登入代理網', N'通过使用保护码登入代理网', N'เข้าสู่ระบบด้วยรหัสป้องกันผ่านเว็บไซต์ของตัวแทน', N'Đăng nhập bằng Mã Bảo Vệ qua trang web Đại Lý', 'Age_LoginClaimDownline', 0, NULL, NULL

DELETE FROM LogAction WITH (ROWLOCK) WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

INSERT INTO dbo.LogAction (ActionID, SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameJP,ActionNameTH,ActionNameKO,IsInternal,ActionNameVI)
SELECT ActionID,SPName,ActionTypeID,ActionNameEN,ActionNameCH,ActionNameCS,ActionNameEN,ActionNameTH,ActionNameEN,IsInternal,ActionNameVI
FROM @tmpAction t

SELECT * 
FROM LogAction WITH (NOLOCK)
WHERE ActionID IN (SELECT ActionID FROM @tmpAction)

GO