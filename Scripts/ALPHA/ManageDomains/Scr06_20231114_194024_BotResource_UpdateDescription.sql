/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20231114@Tacy
	Task: update data system setting for telegram bot service [#RedmineID:#194024]
	DB: DBBOT/bodb_Chatbot
*/
USE bodb_Chatbot
GO

--[BotResource]
--Update 
UPDATE [dbo].[BotResource] WITH (ROWLOCK, UPDLOCK)
SET [VALUE]=CASE WHEN Language='en-US' THEN 'View a list of all the available domains.'
				WHEN Language='zh-Hans' THEN N'获取所有可用域名的列表。'
				WHEN Language='zh-Hant' THEN N'獲取所有可用域名的列表。'
				WHEN Language='th-TH' THEN N'แสดงรายชื่อโดเมนที่มีอยู่ทั้งหมด'
				WHEN Language='vi-VN' THEN N'Xem danh sách tất cả tên miền khả dụng.'
		END
WHERE (ResourceKey=48 AND ResourceName IN ('Action_Description'))
	OR (ResourceKey=19 AND ResourceName IN ('Function_Description'))