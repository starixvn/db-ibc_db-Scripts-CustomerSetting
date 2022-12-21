/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221215@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#178790]
	DB: DBBOT/bodb_Chatbot
*/

UPDATE BotFunction WITH(ROWLOCK)
SET FunctionName = 'OTP (One Time Password)'
WHERE FunctionID = 15

UPDATE BotAction WITH(ROWLOCK)
SET ActionName = 'OTP (One Time Password)'
WHERE ActionID = 43

;WITH T AS(
SELECT 	'Function_Name'	ResourceName,	'15'	ResourceKey,	'en-US'	Language,	N'OTP (One Time Password)' Value
UNION SELECT 	'Action_Name'	,	'43'	,	'en-US'	,	N'OTP (One Time Password)'
)
UPDATE b
SET b.Value = t.Value
FROM BotResource b WITH(ROWLOCK)
	INNER JOIN T ON b.ResourceName = t.ResourceName
					AND b.ResourceKey = t.ResourceKey
					AND b.Language = t.Language

;WITH T AS(
SELECT 	'Function_Name'	ResourceName,	'15'	ResourceKey,	'zh-Hans'	Language,	N'OTP（一次性密码）' Value
UNION SELECT 	'Function_Name'	,	'15'	,	'zh-Hant'	,	N'OTP（一次性密碼）'
UNION SELECT 	'Function_Name'	,	'15'	,	'th-TH'	,	N'OTP (รหัสผ่านใช้ครั้งเดียว)'
UNION SELECT 	'Function_Name'	,	'15'	,	'vi-VN'	,	N'OTP (Mã xác thực)'
UNION SELECT 	'Function_Description'	,	'15'	,	'zh-Hans'	,	N'通过Telegram Chatbot 接收OTP'
UNION SELECT 	'Function_Description'	,	'15'	,	'zh-Hant'	,	N'通過Telegram Chatbot 接收OTP'
UNION SELECT 	'Function_Description'	,	'15'	,	'th-TH'	,	N'รับรหัส OTP ผ่านเทเลแกรมแชทบอท'
UNION SELECT 	'Function_Description'	,	'15'	,	'vi-VN'	,	N'Nhận OTP qua Telegram Chatbot'
UNION SELECT 	'Action_Name'	,	'43'	,	'zh-Hans'	,	N'OTP（一次性密码）'
UNION SELECT 	'Action_Name'	,	'43'	,	'zh-Hant'	,	N'OTP（一次性密碼）'
UNION SELECT 	'Action_Name'	,	'43'	,	'th-TH'	,	N'OTP (รหัสผ่านใช้ครั้งเดียว)'
UNION SELECT 	'Action_Name'	,	'43'	,	'vi-VN'	,	N'OTP (Mã xác thực)'
UNION SELECT 	'Action_Name'	,	'44'	,	'zh-Hans'	,	N'未完成赛事'
UNION SELECT 	'Action_Name'	,	'44'	,	'zh-Hant'	,	N'未完成賽事'
UNION SELECT 	'Action_Name'	,	'44'	,	'th-TH'	,	N'คู่การแข่งขันที่ยังไม่จบ'
UNION SELECT 	'Action_Name'	,	'44'	,	'vi-VN'	,	N'Trận chưa có kết quả'
UNION SELECT 	'Action_Description'	,	'44'	,	'zh-Hans'	,	N'获取昨天未完成赛事数目'
UNION SELECT 	'Action_Description'	,	'44'	,	'zh-Hant'	,	N'獲取昨天未完成賽事數目'
UNION SELECT 	'Action_Description'	,	'44'	,	'th-TH'	,	N'ตรวจสอบจำนวนคู่การแข่งขันของเมื่อวานที่ยังไม่จบ'
UNION SELECT 	'Action_Description'	,	'44'	,	'vi-VN'	,	N'Nhận số Trận chưa có kết quả hôm qua'
)
INSERT INTO BotResource(ResourceName,ResourceKey,Language,Value)					
SELECT ResourceName,ResourceKey,Language,Value
FROM T
