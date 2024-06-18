/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Tacy
	Date: 20240618
	Task:  Telegram Chatbot - Notify Member Last bets [Redmine: #193689]
	DB: DBBOT/bodb_ChatBot
*/
USE bodb_ChatBot
GO

INSERT INTO dbo.BotResource(ResourceName,ResourceKey,[Language],[Value])
SELECT 'Function_Name',	'23', 'vi-VN', N'Cược Gần Nhất' UNION ALL
SELECT 'Function_Description',	'23', 'vi-VN', N'Nhận thông báo qua Telegram khi có vé cược mới khớp với bộ lọc của bạn' UNION ALL

SELECT 'Action_Name', '54', 'vi-VN', N'Cược Gần Nhất' UNION ALL
SELECT 'Action_Description', '54', 'vi-VN', N'Nhận thông báo qua Telegram khi có vé cược mới khớp với bộ lọc của bạn'
GO