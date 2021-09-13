/*
	Created: 20210812@Elodie
	Task : add MsgError [redmine:#159628]
	
*/
--Step 1: add MsgError @DBCUST/CustDB
USE CustDB
GO

DELETE FROM MsgError WHERE MsgID IN (40059, 40060, 40061
)
DECLARE @MsgName NVARCHAR(500) = N'Protection Code cannot be the same as the password.'
DECLARE @MsgNameVI NVARCHAR(500) = N'Mã Bảo Vệ không được trùng với mật khẩu.'

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
SELECT 	40059,5, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgNameVI, 1, @MsgName

SELECT @MsgName = N'Failed to update Protection Code. Please try again.'
SELECT @MsgNameVI = N'Cập nhật Mã Bảo Vệ thất bại. Vui lòng thử lại.'
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
SELECT 	40060,5, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgNameVI, 1, @MsgName

SELECT @MsgName = N'Your password does not meet the minimum security requirement.'
SELECT @MsgNameVI = N'Mật khẩu của bạn chưa đạt yêu cầu bảo mật tối thiểu.'
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
SELECT 	40061,5, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgName, @MsgNameVI, 1, @MsgName