/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230220@Johnson
	Task: Add data for SettingSystem on DBCUST [#RedmineID:#183697]
	DB: DBCUST/CustDB
*/

INSERT INTO [dbo].[SettingSystem]
           ([SystemID]
           ,[SystemName]
           ,[Description]
           ,[SystemPrefix])
SELECT 10, 'Telegram Chatbot', 'Telegram Chatbot','TBot'		   
		   