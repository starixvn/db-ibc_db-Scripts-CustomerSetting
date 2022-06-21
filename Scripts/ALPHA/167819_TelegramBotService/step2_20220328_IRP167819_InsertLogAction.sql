/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20220328@Johnson
	Task: Insert log action for telegram bot service [#RedmineID:#165682]
	DB: DBLOG/bodb_CustomerLog
*/

--20220622: update translation
;WITH T AS
(
	SELECT 95064 as ActionID, N'Link Telegram ID' ActionEn, N'链接Telegram ID' as ActionCS, N'鏈接Telegram ID' as ActionCH, N'เชื่อมต่อบัญชีTelegram' as ActionTH, N'Liên kết Telegram ID' as ActionVI
	UNION SELECT 95065, 'Verify Telegram ID', N'验证Telegram ID', N'驗證Telegram ID', N'ยืนยันบัญชีTelegram', N'Xác nhận Telegram ID'
	UNION SELECT 95066, 'Unlink Telegram ID', N'取消链接 Telegram ID', N'取消鏈接Telegram ID', N'ยกเลิกการเชื่อมต่อบัญชีTelegram', N'Hủy liên kết Telegram ID'
	UNION SELECT 95067, 'Update Chatbot''s Language', N'更新Chatbot的语言',N'更新Chatbot的語言', N'อัปเดตภาษาของChatbot', N'Cập nhật ngôn ngữ của Chatbot'
	UNION SELECT 95068, 'Update Linking Status of Telegram Chatbot', N'更新Telegram Chatbot的链接 状态', N'更新Telegram Chatbot的鏈接狀態', N'อัปเดตสถานะการเชื่อมโยงของเทเลแกรมแชทบ็อต', N'Cập nhật trạng thái liên kết của Telegram Chatbot'
	UNION SELECT 95069, 'Update Telegram Chatbot Function',	N'更新Telegram Chatbot的功能', N'更新Telegram Chatbot的功能', N'อัปเดตฟังก์ชันแชทบ็อตของบัญชีเทเลแกรม', N'Cập nhật chức năng Telegram Chatbot'
)
UPDATE l
SET [ActionNameEN]= ActionEn,
	[ActionNameCH]= ActionCH,
	[ActionNameCS]= ActionCS,
	[ActionNameJP]= ActionEn,
	[ActionNameIT]= ActionEn,
	[ActionNameTH]= ActionTH,
	[ActionNameKO]= ActionEn,
	[ActionNameVI]= ActionVI,
	[ActionNameCN]= ActionEn
FROM T
	INNER JOIN [LogAction] l ON t.ActionID = l.ActionID

;WITH T AS
(
	SELECT 95071 as ActionID, 1 as IsInternal, 'NAP_Chatbot_BotUpd' spName, N'Update Telegram Bot system' ActionEn
	UNION SELECT 95072, 1, 'NAP_Chatbot_BotIns', 'Add Telegram Bot system'
)
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],
	[ActionNameEN],
	[ActionNameCH],
	[ActionNameCS],
	[ActionNameJP],
	[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
SELECT ActionID, 4, spName, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, NULL, IsInternal, ActionEn, ActionEn
FROM T

/*
DELETE LogAction 
WHERE ActionID IN (95064,95065,95066,95067,95068,95069)


;WITH T AS
(
	SELECT 95064 as ActionID, 0 as IsInternal, 'Age_Chatbot_CustBotAccountIns' spName, N'Link Telegram ID' ActionEn
	UNION SELECT 95065, 0, 'Age_Chatbot_CustBotAccountStatusUpd', 'Verify Telegram ID'
	UNION SELECT 95066, 0, 'Age_Chatbot_CustBotAccountStatusUpd', 'Unlink Telegram ID'
	UNION SELECT 95067, 0, 'Age_Chatbot_CustBotAccountLanguageUpd', 'Update Chatbot''s Language'
	UNION SELECT 95068, 1, 'NAP_Chatbot_CustBotAccountInfoUpd', 'Update Linking Status of Telegram Chatbot'
	UNION SELECT 95069, 0, 'Age_Chatbot_CustBotFunctionUpd','Update Telegram Chatbot''s Function'	
)
INSERT INTO [dbo].[LogAction]
	([ActionID],[ActionTypeID],[SPName],
	[ActionNameEN],
	[ActionNameCH],
	[ActionNameCS],
	[ActionNameJP],
	[ActionNameIT]
	,[ActionNameTH],[ActionNameKO],[XsltContent],[IsInternal],[ActionNameVI],[ActionNameCN])
SELECT ActionID, 4, spName, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, ActionEn, NULL, IsInternal, ActionEn, ActionEn
FROM T
*/