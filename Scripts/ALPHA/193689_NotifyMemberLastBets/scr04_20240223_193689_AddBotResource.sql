/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240312
	Task:  Telegram Chatbot - Notify Member Last bets [Redmine: #193689]
	DB: DBBOT/bodb_ChatBot
*/

IF EXISTS(
	SELECT 1
	FROM dbo.BotResource WITH (NOLOCK)
	WHERE (ResourceName = 'Function_Name' AND ResourceKey = '23')
		OR (ResourceName = 'Action_Name' AND ResourceKey = '54')
)
	RAISERROR('This function/action has been chosen.', 16, 1)
ELSE
	INSERT INTO dbo.BotResource(ResourceName,ResourceKey,[Language],[Value])
		SELECT 'Function_Name',	'23', 'en-US', 'Last Bets' UNION ALL
		SELECT 'Function_Name',	'23', 'zh-Hans', N'最后投注' UNION ALL			
		SELECT 'Function_Name',	'23', 'zh-Hant', N'最後投注' UNION ALL			
		SELECT 'Function_Name',	'23', 'th-TH', N'เดิมพันล่าสุด ' UNION ALL				
		SELECT 'Function_Description',	'23', 'en-US', 'Notify via Telegram when new tickets match your filters' UNION ALL
		SELECT 'Function_Description',	'23', 'zh-Hans', N'当新注单符合您的筛选，会在Telegram上收到通知。' UNION ALL			
		SELECT 'Function_Description',	'23', 'zh-Hant', N'當新注單符合您的篩選，會在Telegram上收到通知。' UNION ALL		
		SELECT 'Function_Description',	'23', 'th-TH', N'แจ้งเตือนผ่านเทเลแกรมเมื่อมีตั๋วใหม่ตรงกับตัวกรองของคุณ'	 UNION ALL

		SELECT 'Action_Name', '54', 'en-US', N'Last Bets' UNION ALL
		SELECT 'Action_Name', '54', 'zh-Hans', N'最后投注' UNION ALL
		SELECT 'Action_Name', '54', 'zh-Hant', N'最後投注' UNION ALL			
		SELECT 'Action_Name', '54', 'th-TH', N'เดิมพันล่าสุด ' UNION ALL	
		SELECT 'Action_Description',	'54', 'en-US', 'Notify via Telegram when new tickets match your filters' UNION ALL
		SELECT 'Action_Description',	'54', 'zh-Hans', N'当新注单符合您的筛选，会在Telegram上收到通知。' UNION ALL			
		SELECT 'Action_Description',	'54', 'zh-Hant', N'當新注單符合您的篩選，會在Telegram上收到通知。' UNION ALL		
		SELECT 'Action_Description',	'54', 'th-TH', N'แจ้งเตือนผ่านเทเลแกรมเมื่อมีตั๋วใหม่ตรงกับตัวกรองของคุณ'	 
