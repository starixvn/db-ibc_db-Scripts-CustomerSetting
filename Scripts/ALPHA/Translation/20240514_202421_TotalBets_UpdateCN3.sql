/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20240514@Tacy
	Task: Add Cn3 - [BotResource] [#RedmineID:#202421]
	DB: DBBOT/bodb_Chatbot
*/
USE bodb_Chatbot
GO


INSERT INTO [dbo].[BotResource] ([ResourceName], [ResourceKey], [Language], [Value])
VALUES 
 ('Function_Name','24','vi-VN',N'Tổng Cược')
,('Function_Description','24','vi-VN',N'Cập nhật Top 10 trận bóng có tiền cược cao nhất và dễ dàng theo dõi chi tiết cược trong trận đấu.')

,('Action_Name','55','vi-VN',N'Tổng Cược')
,('Action_Description','55','vi-VN',N'Cập nhật Top 10 trận bóng có tiền cược cao nhất và dễ dàng theo dõi chi tiết cược trong trận đấu.')

GO