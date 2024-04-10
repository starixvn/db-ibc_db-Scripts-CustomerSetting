﻿/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240126
	Task:  Alpha - Automate Transfer Enhancement Phase 3 [Redmine: #199951]
	DB: DBBOT/bodb_ChatBot
*/

CREATE TABLE #TmpResource(ResourceName VARCHAR(100), ResourceKey VARCHAR(100), Language VARCHAR(10), VALUE NVARCHAR(1000))

INSERT INTO #TmpResource(ResourceName,ResourceKey,[Language],[Value])
	SELECT 'Action_Name',	'50', 'en-US', N'Auto Transfer' UNION ALL
	SELECT 'Action_Name',	'50', 'zh-Hans', N'自动转账' UNION ALL
	SELECT 'Action_Name',	'50', 'zh-Hant', N'自動轉賬' UNION ALL
	SELECT 'Action_Name',	'50', 'th-TH', N'โอนอัตโนมัติ' UNION ALL
	SELECT 'Action_Description',	'50', 'en-US', N'Receive daily Telegram notifications of your Auto Transfer status upon completion.' UNION ALL
	SELECT 'Action_Description',	'50', 'zh-Hans', N'接收每日Telegram 通知有关您自动转账完成后的状态。' UNION ALL
	SELECT 'Action_Description',	'50', 'zh-Hant', N'接收每日Telegram 通知有關您自動轉賬完成後的狀態。' UNION ALL
	SELECT 'Action_Description',	'50', 'th-TH', N'รับการแจ้งเตือนผ่านเทเลแกรมทุกวัน เมื่อการโอนอัตโนมัติของคุณเสร็จสิ้น' UNION ALL

	SELECT 'Action_Name',	'51', 'en-US', N'Auto Transfer' UNION ALL
	SELECT 'Action_Name',	'51', 'zh-Hans', N'自动转账' UNION ALL
	SELECT 'Action_Name',	'51', 'zh-Hant', N'自動轉賬' UNION ALL
	SELECT 'Action_Name',	'51', 'th-TH', N'โอนอัตโนมัติ' UNION ALL
	SELECT 'Action_Description',	'51', 'en-US', N'Open Auto Transfer Menu' UNION ALL
	SELECT 'Action_Description',	'51', 'zh-Hans', N'Open Auto Transfer Menu' UNION ALL
	SELECT 'Action_Description',	'51', 'zh-Hant', N'Open Auto Transfer Menu' UNION ALL
	SELECT 'Action_Description',	'51', 'th-TH', N'Open Auto Transfer Menu' UNION ALL
	
	select 'Action_Name', '52', 'en-US', N'Auto Transfer Monitor' union all
	select 'Action_Name', '52', 'zh-Hans', N'监控自动转账' union all
	select 'Action_Name', '52', 'zh-Hant', N'監控自動轉賬' union all
	select 'Action_Name', '52', 'th-TH', N'ตรวจสอบการโอนอัตโนมัติ' union all	
	SELECT 'Action_Description',	'52', 'en-US', N'Auto Transfer Monitor Description' UNION ALL
	SELECT 'Action_Description',	'52', 'zh-Hans', N'Auto Transfer Monitor Description' UNION ALL
	SELECT 'Action_Description',	'52', 'zh-Hant', N'Auto Transfer Monitor Description' UNION ALL
	SELECT 'Action_Description',	'52', 'th-TH', N'Auto Transfer Monitor Description' UNION ALL

	select 'Action_Name', '53', 'en-US', N'Edit Auto Transfer' union all
	select 'Action_Name', '53', 'zh-Hans', N'修改自动转账' union all
	select 'Action_Name', '53', 'zh-Hant', N'修改自動轉賬' union all
	select 'Action_Name', '53', 'th-TH', N'แก้ไขการโอนอัตโนมัติ' UNION ALL
	SELECT 'Action_Description',	'53', 'en-US', N'Edit Auto Transfer Description' UNION ALL
	SELECT 'Action_Description',	'53', 'zh-Hans', N'Edit Auto Transfer Description' UNION ALL
	SELECT 'Action_Description',	'53', 'zh-Hant', N'Edit Auto Transfer Description' UNION ALL
	SELECT 'Action_Description',	'53', 'th-TH', N'Edit Auto Transfer Description' 

MERGE BotResource AS TARGET
USING (SELECT ResourceName,ResourceKey,[Language],[Value] FROM #TmpResource) AS SOURCE
ON Target.ResourceName = Source.ResourceName
	AND Target.ResourceKey = Source.ResourceKey
	AND Target.Language = Source.Language
WHEN MATCHED THEN UPDATE SET Target.Value = Source.Value
WHEN NOT MATCHED BY TARGET THEN 
	INSERT (ResourceName,ResourceKey,[Language],[Value])
	VALUES (Source.ResourceName,Source.ResourceKey,Source.[Language],Source.[Value]);

