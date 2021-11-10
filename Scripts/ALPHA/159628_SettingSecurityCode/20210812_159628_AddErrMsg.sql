/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210812@Elodie
	Task : add MsgError [redmine:#159628]
	
*/
--Step 1: add MsgError @DBCUST/CustDB
USE CustDB
GO

DECLARE @MsgName NVARCHAR(500) = N'Update Security Code Option unsuccessful. Please try again.'
DECLARE @MsgNameCS NVARCHAR(500) = N'更新保安码选项失败。 请重试。'
DECLARE @MsgNameCT NVARCHAR(500) = N'更新保安碼選項失敗。請重試。'
DECLARE @MsgNameTH NVARCHAR(500) = N'อัปเดตตัวเลือกรหัสความปลอดภัยไม่สำเร็จ กรุณาลองอีกครั้ง'
DECLARE @MsgNameVI NVARCHAR(500) = N'Cập nhật Tùy Chọn Mã Bảo Mật không thành công. Vui lòng thử lại.'

DELETE FROM MsgError WHERE MsgID = 40058

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
SELECT 	40058,5, @MsgName, @MsgNameCT, @MsgNameCS, @MsgName, @MsgNameTH, @MsgName, @MsgName, @MsgNameVI, 1, @MsgName

