/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230315@Johnson
	Task: Data patch for system setting for telegram bot service [#RedmineID:#184101]
	DB: DBBOT/bodb_Chatbot	
*/

;WITH T AS(
SELECT 	'Action_Name'	ResourceName,	'19'	ResourceKey,	'zh-Hans'	Language,	N'输入下线用户名' Value
UNION ALL SELECT 	'Action_Name'	,	'19'	,	'zh-Hant'	,	N'輸入下線用戶名'
UNION ALL SELECT 	'Action_Name'	,	'19'	,	'th-TH'	,	N'ป้อนชื่อผู้ใช้ดาวน์ไลน์'
UNION ALL SELECT 	'Action_Name'	,	'19'	,	'vi-VN'	,	N'Nhập tên người dùng cấp dưới'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'zh-Hans'	,	N'获取特定下线的今日输赢报告'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'zh-Hant'	,	N'獲取特定下線的今日輸贏報告'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'th-TH'	,	N'รับรายงานชนะ/แพ้ของดาวน์ไลน์เฉพาะวันนี้'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'vi-VN'	,	N'Xem Báo Cáo Thắng Thua Trong Ngày của một cấp dưới'
)
INSERT INTO BotResource(ResourceName,ResourceKey,Language,Value)
SELECT ResourceName,ResourceKey,Language,Value
FROM T