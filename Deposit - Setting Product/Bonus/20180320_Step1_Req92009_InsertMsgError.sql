/*	
	Created: 20170320@Winnie
	Task: Insert msg for Bonus
	Redmine: https://nexdev.net/issues/92009
	DB: DBCUST/CUSTDB
*/
INSERT INTO [CustDB].[dbo].[MsgError]
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
           ,[IsActive])
     VALUES
           (200048
           ,11
           ,N'Cannot turn on BA for customers joining Bonus campaign.'
           ,N'無法替已參加紅利活動的會員開啟BA功能'
           ,N'无法替已参加红利活动的会员开启BA功能'
           ,N'Cannot turn on BA for customers joining Bonus campaign.'
           ,N'Cannot turn on BA for customers joining Bonus campaign.'
           ,N'Cannot turn on BA for customers joining Bonus campaign.'
           ,N'Cannot turn on BA for customers joining Bonus campaign.'
           ,N'Cannot turn on BA for customers joining Bonus campaign.'
           ,1)
GO
