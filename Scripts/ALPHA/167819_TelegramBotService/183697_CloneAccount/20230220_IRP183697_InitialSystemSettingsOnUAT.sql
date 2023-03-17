/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230220@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#183697]
	DB: DBBOT/bodb_Chatbot
*/

INSERT INTO [dbo].[BotFunction]
           ([FunctionID]
           ,[FunctionName]
           ,[FunctionKey]
           ,[Type]
           ,[Command]
           ,[Status]
           ,[Order]
           ,[Priority]
		   ,[ParentID])
SELECT 18, 'Customer Settings', 'CustomerSettings', 1, '/cs', 1, 6, NULL, NULL
GO

-------------------------------------------
--add new botAction	
INSERT INTO [dbo].[BotAction]
		   ([ActionID]
		   ,[ActionName]
		   ,[Type]
		   ,[Command]
		   ,[FunctionID]
		   ,[ParentID]
		   ,[Status]
		   ,[IsEndAction]
		   ,[Order])
SELECT 46 ActionID,	'Customer Settings' ActionName, 1 Type, '/cs' Command, 18 FunctionID, 0 ParentID, 1 Status, 0 IsEndAction, 6 [Order]
UNION SELECT 47, 'New Customer', 4, NULL, 18, 46, 1, 1, 601
GO

	
-----------------------------------------------------
--add botResource
;WITH T AS(
SELECT 	'Function_Name'	ResourceName,	'18'	ResourceKey,	'en-US'	Language,	N'Customer Settings' Value
UNION SELECT 	'Function_Name',	'18',	'zh-Hans',	N'客戶设定'
UNION SELECT 	'Function_Name',	'18',	'zh-Hant',	N'客戶設定'
UNION SELECT 	'Function_Name',	'18',	'th-TH',	N'ตั้งค่าลูกค้า'
UNION SELECT 	'Function_Description',	'18',	'en-US',	N'Settings and configurations associated with the management of customer accounts'
UNION SELECT 	'Function_Description',	'18',	'zh-Hans',	N'与客户账号管理相关的设置和配置。'
UNION SELECT 	'Function_Description',	'18',	'zh-Hant',	N'與客戶賬號管理相關的設置和配置。'
UNION SELECT 	'Function_Description',	'18',	'th-TH',	N'การตั้งค่าและการกำหนดค่าที่เกี่ยวข้องกับการจัดการบัญชีลูกค้า'
UNION SELECT 'Action_Name', '46', 'en-US', 'Customer Settings'
UNION SELECT 'Action_Name', '46', 'zh-Hans', N'客戶设定'
UNION SELECT 'Action_Name', '46', 'zh-Hant', N'客戶设定'
UNION SELECT 'Action_Name', '46', 'th-TH', N'ตั้งค่าลูกค้า'
UNION SELECT 'Action_Name', '47', 'en-US', N'New Customer'
UNION SELECT 'Action_Name', '47', 'zh-Hans', N'新的客戶'
UNION SELECT 'Action_Name', '47', 'zh-Hant', N'新的客戶'
UNION SELECT 'Action_Name', '47', 'th-TH', N'ลูกค้าใหม่'
UNION SELECT 'Action_Description', '46', 'en-US', N'Settings and configurations associated with the management of customer accounts'
UNION SELECT 'Action_Description', '46', 'zh-Hans', N'与客户账号管理相关的设置和配置。'
UNION SELECT 'Action_Description', '46', 'zh-Hant', N'與客戶賬號管理相關的設置和配置。'
UNION SELECT 'Action_Description', '46', 'th-TH', N'การตั้งค่าและการกำหนดค่าที่เกี่ยวข้องกับการจัดการบัญชีลูกค้า'

UNION SELECT 	'Function_Name',	'18',	'vi-VN',	N'Cài Đặt Tài Khoản'
UNION SELECT 	'Function_Description',	'18',	'vi-VN',	N'Các cài đặt và cấu hình dùng để quản lý tài khoản cấp dưới.'
UNION SELECT 	'Action_Name',	'46',	'vi-VN',	N'Cài Đặt Tài Khoản'
UNION SELECT 	'Action_Name',	'47',	'vi-VN',	N'Tạo Tài Khoản'
UNION SELECT 	'Action_Description',	'46',	'vi-VN',	N'Các cài đặt và cấu hình dùng để quản lý tài khoản cấp dưới.'
)	
INSERT INTO [dbo].[BotResource]
           ([ResourceName]
           ,[ResourceKey]
           ,[Language]
           ,[Value])
SELECT ResourceName, ResourceKey, Language, Value
FROM T
GO

