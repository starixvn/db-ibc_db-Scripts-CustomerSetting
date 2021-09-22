/*
	Created: 20210812@Elodie
	Task : add MsgError [redmine:#159628]
	
*/
--Step 1: add MsgError @DBCUST/CustDB
USE CustDB
GO

DELETE FROM MsgError WHERE MsgID IN (40059, 40060, 40061
)
DECLARE @MsgNameEN NVARCHAR(500) = N'Protection Code cannot be the same as the password.'
DECLARE @MsgNameVI NVARCHAR(500) = N'Mã Bảo Vệ không được trùng với mật khẩu.'
DECLARE @MsgNameCT NVARCHAR(500) = N'保護碼不能與密碼相同。'
DECLARE @MsgNameCS NVARCHAR(500) = N'保护码不能与密码相同。'
DECLARE @MsgNameTH NVARCHAR(500) = N'รหัสป้องกันจะต้องไม่ตรงกับรหัสผ่าน'

INSERT INTO [dbo].[MsgError]
           ([MsgID]
           ,[MsgGroupID]
           ,[MsgNameEN]
           ,[MsgNameCT]
           ,[MsgNameCS]
           ,[MsgNameJP]
           ,[MsgNameTH]
           ,[MsgNameKO]
           ,[MsgNameES]
           ,[MsgNameVI]
           ,[IsActive]
           ,[MsgNameCN])
SELECT 	40059,5, @MsgNameEN, @MsgNameCT, @MsgNameCS, @MsgNameEN, @MsgNameTH, @MsgNameEN, @MsgNameEN, @MsgNameVI, 1, @MsgNameEN

SELECT @MsgNameEN = N'Failed to update Protection Code. Please try again.'
SELECT @MsgNameVI = N'Cập nhật Mã Bảo Vệ thất bại. Vui lòng thử lại.'
SELECT @MsgNameCT = N'保護碼更新失敗。請再試一次。'
SELECT @MsgNameCS = N'保护码更新失败。请再试一次。'
SELECT @MsgNameTH = N'การอัปเดทรหัสป้องกันล้มเหลว กรุณาใหม่ลองอีกครั้ง'

INSERT INTO [dbo].[MsgError]
           ([MsgID]
           ,[MsgGroupID]
           ,[MsgNameEN]
           ,[MsgNameCT]
           ,[MsgNameCS]
           ,[MsgNameJP]
           ,[MsgNameTH]
           ,[MsgNameKO]
           ,[MsgNameES]
           ,[MsgNameVI]
           ,[IsActive]
           ,[MsgNameCN])
SELECT 	40060,5, @MsgNameEN, @MsgNameCT, @MsgNameCS, @MsgNameEN, @MsgNameTH, @MsgNameEN, @MsgNameEN, @MsgNameVI, 1, @MsgNameEN

SELECT @MsgNameEN = N'Your password does not meet the minimum security requirement.'
SELECT @MsgNameVI = N'Mật khẩu của bạn chưa đạt yêu cầu bảo mật tối thiểu.'
SELECT @MsgNameCT = N'您的密碼不符合最低安全要求。'
SELECT @MsgNameCS = N'您的密码不符合最低安全要求。'
SELECT @MsgNameTH = N'รหัสผ่านของคุณไม่ตรงตามข้อกำหนดด้านความปลอดภัยขั้นต่ำ'

INSERT INTO [dbo].[MsgError]
           ([MsgID]
           ,[MsgGroupID]
           ,[MsgNameEN]
           ,[MsgNameCT]
           ,[MsgNameCS]
           ,[MsgNameJP]
           ,[MsgNameTH]
           ,[MsgNameKO]
           ,[MsgNameES]
           ,[MsgNameVI]
           ,[IsActive]
           ,[MsgNameCN])
SELECT 	40061,5, @MsgNameEN, @MsgNameCT, @MsgNameCS, @MsgNameEN, @MsgNameTH, @MsgNameEN, @MsgNameEN, @MsgNameVI, 1, @MsgNameEN