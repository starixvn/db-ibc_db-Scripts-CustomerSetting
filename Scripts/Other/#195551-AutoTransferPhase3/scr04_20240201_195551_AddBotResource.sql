/*<info serverAlias="DBAGE-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240126
	Task:  Alpha - Automate Transfer Enhancement Phase 3 [Redmine: #199951]
	DB: DBAGE/bodb_ChatBot
*/

INSERT INTO BotResource(ResourceName,ResourceKey,[Language],[Value])
	SELECT 'Function_Name',	21, 'en-US', 'Auto Transfer' UNION ALL
	SELECT 'Function_Name',	21, 'zh-Hans', N'自动转账' UNION ALL			
	SELECT 'Function_Name',	21, 'zh-Hant', N'自動轉賬' UNION ALL			
	SELECT 'Function_Name',	21, 'th-TH', N'โอนอัตโนมัติ' UNION ALL				
	SELECT 'Function_Description',	21, 'en-US', 'View auto transfer monitor and edit your Auto Transfer settings' UNION ALL
	SELECT 'Function_Description',	21, 'zh-Hans', N'查看监控自动转账及修改您的自动转账设定' UNION ALL			
	SELECT 'Function_Description',	21, 'zh-Hant', N'查看監控自動轉帳及修改您的自動轉帳設定' UNION ALL		
	SELECT 'Function_Description',	21, 'th-TH', N'ดูการตรวจสอบการโอนอัตโนมัติและแก้ไขการตั้งค่าการโอนอัตโนมัติของคุณ' UNION ALL				

	SELECT 'Function_Name',	22, 'en-US', 'Auto Transfer' UNION ALL
	SELECT 'Function_Name',	22, 'zh-Hans', N'自动转账' UNION ALL			
	SELECT 'Function_Name',	22, 'zh-Hant', N'自動轉賬' UNION ALL			
	SELECT 'Function_Name',	22, 'th-TH', N'โอนอัตโนมัติ' UNION ALL				
	SELECT 'Function_Description',	22, 'en-US', 'Receive daily Telegram notifications of your Auto Transfer status upon completion.' UNION ALL
	SELECT 'Function_Description',	22, 'zh-Hans', N'接收每日Telegram 通知有关您自动转账完成后的状态。' UNION ALL			
	SELECT 'Function_Description',	22, 'zh-Hant', N'接收每日Telegram 通知有關您自動轉賬完成後的狀態。' UNION ALL			
	SELECT 'Function_Description',	22, 'th-TH', N'รับการแจ้งเตือนผ่านเทเลแกรมทุกวัน เมื่อการโอนอัตโนมัติของคุณเสร็จสิ้น' UNION ALL 				

	SELECT 'Action_Name',	50, 'en-US', 'Auto Transfer' UNION ALL
	SELECT 'Action_Name',	50, 'zh-Hans', N'自动转账' UNION ALL
	SELECT 'Action_Name',	50, 'zh-Hant', N'自動轉賬' UNION ALL
	SELECT 'Action_Name',	50, 'th-TH', N'โอนอัตโนมัติ' UNION ALL
	SELECT 'Action_Description',	50, 'en-US', 'Receive daily Telegram notifications of your Auto Transfer status upon completion.' UNION ALL
	SELECT 'Action_Description',	50, 'zh-Hans', N'接收每日Telegram 通知有关您自动转账完成后的状态。' UNION ALL
	SELECT 'Action_Description',	50, 'zh-Hant', N'接收每日Telegram 通知有關您自動轉賬完成後的狀態。' UNION ALL
	SELECT 'Action_Description',	50, 'th-TH', N'รับการแจ้งเตือนผ่านเทเลแกรมทุกวัน เมื่อการโอนอัตโนมัติของคุณเสร็จสิ้น' UNION ALL 

	SELECT 'Action_Name',	51, 'en-US', 'Auto Transfer' UNION ALL
	SELECT 'Action_Name',	51, 'zh-Hans', N'自动转账' UNION ALL
	SELECT 'Action_Name',	51, 'zh-Hant', N'自動轉賬' UNION ALL
	SELECT 'Action_Name',	51, 'th-TH', N'โอนอัตโนมัติ' UNION ALL
		
	select 'Action_Name', 52, 'en-US', N'Auto Transfer Monitor' union all
	select 'Action_Name', 52, 'zh-Hans', N'监控自动转账' union all
	select 'Action_Name', 52, 'zh-Hant', N'監控自動轉賬' union all
	select 'Action_Name', 52, 'th-TH', N'ตรวจสอบการโอนอัตโนมัติ' union all	

	select 'Action_Name', 53, 'en-US', N'Edit Auto Transfer' union all
	select 'Action_Name', 53, 'zh-Hans', N'修改自动转账' union all
	select 'Action_Name', 53, 'zh-Hant', N'修改自動轉賬' union all
	select 'Action_Name', 53, 'th-TH', N'แก้ไขการโอนอัตโนมัติ' 