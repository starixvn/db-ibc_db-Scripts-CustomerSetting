/*
	Created: 20190912@Johnson
	DB: DBONUSER/On_User
	Task: structure for robot management
*/
use On_User
GO

ALTER TABLE dbo.RobotUsers ADD remark NVARCHAR(500) NULL

ALTER TABLE dbo.RobotUsers ADD AddedBy INT NULL

ALTER TABLE dbo.RobotUsers_DelLog ADD remark NVARCHAR(500) NULL

ALTER TABLE dbo.RobotUsers_DelLog ADD AddedBy INT NULL

GO

--Add new log actions
 use bodb_customerlog
 GO
 
 INSERT INTO [bodb_CustomerLog].[dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]           
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT 694, 4, 'NAP_Customer_RobotAccountNew_Ins', N'Update account in robot list', N'Update account in robot list', N'Update account in robot list', N'Update account in robot list', N'Update account in robot list', N'Update account in robot list', N'Update account in robot list',1, N'Update account in robot list', N'Update account in robot list'		   
UNION SELECT 695, 4, 'NAP_Customer_RobotAccountNew_Ins', N'Add account to robot list', N'Add account to robot list', N'Add account to robot list', N'Add account to robot list', N'Add account to robot list', N'Add account to robot list', N'Add account to robot list',1, N'Add account to robot list', N'Add account to robot list'    
UNION SELECT 696, 4, 'NAP_Customer_RobotAccountNew_Del', N'Remove account from robot list', N'Remove account from robot list', N'Remove account from robot list', N'Remove account from robot list', N'Remove account from robot list', N'Remove account from robot list', N'Remove account from robot list',1, N'Remove account from robot list', N'Remove account from robot list'