/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220819@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#176397]
	DB: DBBOT/bodb_Chatbot
*/
	
-------------------------------------------
--add new botAction	
;WITH T AS (
SELECT 41 ActionID,	'System Announcement' ActionName, 1 Type, 13 Command, 13 FunctionID, 26 ParentID, 1 Status, 1 IsEndAction, 5008 Order
UNION SELECT 42, 'My Watchlist', 1, 14, 14, 26, 1, 1, 5009
UNION SELECT 33, 'Wrong Password Alert', 1,	11,	11, 26,	1, 1, 5006
)
INSERT INTO [dbo].[BotAction]
           ([ActionID]
           ,[ActionName]
           ,[Type]
           ,[Command]
           ,[FunctionID]
           ,[ParentID]
           ,[Status]
           ,[IsEndAction]
           ,[Order])
SELECT [ActionID]
	   ,[ActionName]
	   ,[Type]
	   ,[Command]
	   ,[FunctionID]
	   ,[ParentID]
	   ,[Status]
	   ,[IsEndAction]
	   ,[Order]
FROM T  
GO

-----------------------------------------------------
--add new functions

;WITH T AS (
SELECT  11 FunctionID, 'Wrong Password Alert' FunctionName, 'WrongPasswordAlert' FunctionKey, 2 Type, NULL Command,	1 Status, 106 Order, NULL Priority
UNION SELECT 13, 'System Announcement',	'SystemAnnouncement', 2, NULL, 1, 107, NULL
UNION SELECT 14, 'My Watchlist', 'MyWatchlist',	2, NULL, 1, 108, NULL
)
INSERT INTO [dbo].[BotFunction]
           ([FunctionID]
           ,[FunctionName]
           ,[FunctionKey]
           ,[Type]
           ,[Command]
           ,[Status]
           ,[Order]
           ,[Priority])
SELECT [FunctionID]
	   ,[FunctionName]
	   ,[FunctionKey]
	   ,[Type]
	   ,[Command]
	   ,[Status]
	   ,[Order]
	   ,[Priority]
FROM T		   
GO

------------------------------------------------------
--set priority for botfunction
;WITH T AS (
	SELECT 	5	FunctionID,	40 Priority	--	Yesterday Win Loss
	UNION SELECT 	6	,	20	--	Personal Message
	UNION SELECT 	7	,	10	--	Problem Account
	UNION SELECT 	8	,	1	--	Member Win Loss Limit	
	UNION SELECT 	13	,	30	--	System Announcement
	UNION SELECT 	14	,	50	--	My Watchlist
)
UPDATE b
SET b.Priority = t.Priority
FROM BotFunction b WITH(NOLOCK)
	INNER JOIN T on b.FunctionID = t.FunctionID
GO	


--------------------------------------------------
--set order for BotAction
/*
SELECT 'UNION SELECT', [ActionID],',',[Order], '--', ActionName  
FROM [bodb_ChatBot].[dbo].[BotAction]
*/
;WITH T AS (
SELECT	1	ActionID,	1 as [Order] --	Outstanding
UNION SELECT	2	,	2	--	Balance Info
UNION SELECT	3	,	3	--	Today Win Loss
UNION SELECT	4	,	4	--	Yesterday Win Loss
UNION SELECT	5	,	101	--	Top 50 Outstanding
UNION SELECT	6	,	102	--	Enter downline username
UNION SELECT	7	,	103	--	Top Downlines
UNION SELECT	8	,	104	--	Top X Outstanding
UNION SELECT	9	,	1001	--	Please enter your downline username to view Outstanding Report.
UNION SELECT	10	,	1002	--	How many downlines would you like to include in Outstanding Report? Chatbot supports listing up to 100 downlines.
UNION SELECT	11	,	5	--	Settings
UNION SELECT	12	,	201	--	My Balance
UNION SELECT	13	,	202	--	Enter downline username
UNION SELECT	14	,	203	--	Top Downlines
UNION SELECT	15	,	204	--	Top X Balance
UNION SELECT	16	,	2001	--	Please enter your downline username to view Balance Report.
UNION SELECT	17	,	2002	--	How many downlines would you like to include in Balance Report? Chatbot supports listing up to 100 downlines.
UNION SELECT	18	,	301	--	My Today Win Loss
UNION SELECT	19	,	302	--	Enter downline username
UNION SELECT	20	,	303	--	Top Downlines
UNION SELECT	21	,	3001	--	Please enter your downline username to view Today Win Loss Report.
UNION SELECT	22	,	401	--	My Yesterday Win Loss
UNION SELECT	23	,	402	--	Enter downline username
UNION SELECT	24	,	403	--	Top Downlines
UNION SELECT	25	,	4001	--	Please enter your downline username to view Yesterday Win Loss Report.
UNION SELECT	26	,	501	--	Notifications
UNION SELECT	27	,	5001	--	Yesterday Win Loss
UNION SELECT	28	,	5007	--	Personal Message
UNION SELECT	29	,	5003	--	Problem Account
UNION SELECT	30	,	5002	--	Member Win Loss Limit
UNION SELECT	31	,	5005	--	Change Password Alert
UNION SELECT	32	,	5004	--	Change Security Code Alert
UNION SELECT	33	,	5006	--	Wrong Password Alert
UNION SELECT	34	,	502	--	Language
UNION SELECT	35	,	5101	--	English
UNION SELECT	36	,	5102	--	ChineseTraditional
UNION SELECT	37	,	5103	--	ChineseSimplified
UNION SELECT	38	,	5104	--	Thai
UNION SELECT	39	,	5105	--	vn
UNION SELECT	40	,	503	--	Stop Using Chatbot
UNION SELECT	41	,	5008	--	System Announcement
UNION SELECT	42	,	5009	--	My Watchlist
)
UPDATE b
SET b.Order = t.Order
FROM BotAction b WITH(ROWLOCK)
	INNER JOIN T ON b.ActionID = t.ActionID
GO

------------------------------------------------------
--add system setting for service 'SystemAnnouncement'

;WITH T AS (
SELECT 	'SystemAnnouncement'	ServiceName,	'LastQueryTime'	SettingName,	 CONVERT(varchar(20), GETDATE(), 120) Value
UNION SELECT 	'SystemAnnouncement'	,	'LastQueryTimeUAT'	,	 CONVERT(varchar(20), GETDATE(), 120)
UNION SELECT 	'SystemAnnouncement'	,	'ServiceFlag'	,	'0'
UNION SELECT 	'SystemAnnouncement'	,	'ServiceFlagUAT'	,	'1'
UNION SELECT 	'SystemAnnouncement'	,	'SyncSettingPRO'	,	'0'
UNION SELECT 	'SystemAnnouncement'	,	'LastRuntimeUAT'	,	 CONVERT(varchar(20), GETDATE(), 120)
UNION SELECT 	'SystemAnnouncement'	,	'LastRuntime'	,	 CONVERT(varchar(20), GETDATE(), 120)
UNION SELECT 	'SystemAnnouncement'	,	'JobStatus'	,	 'Completed'
UNION SELECT 	'SystemAnnouncement'	,	'JobStatusUAT'	,	 'Completed'
UNION SELECT 	'SystemAnnouncement'	,	'SendLastNotificationId',	0
UNION SELECT 	'SystemAnnouncement'	,	'SendLastNotificationIdUAT',	0
)
INSERT INTO [dbo].[BotSystemSetting]
           ([ServiceName]
           ,[SettingName]
           ,[Value])
SELECT
FROM T		   
GO

-----------------------------------------------------
--add botResource
;WITH T AS(
SELECT 	'Function_Name'	ResourceName,	'11'	ResourceKey,	'en-US'	Language,	N'Wrong Password Alert' Value
UNION SELECT 	'Function_Name'	,	'11'	,	'zh-Hans'	,	N'密码错误提示'
UNION SELECT 	'Function_Name'	,	'11'	,	'zh-Hant'	,	N'密碼錯誤提示'
UNION SELECT 	'Function_Name'	,	'11'	,	'th-TH'	,	N'แจ้งเตือนรหัสผ่านผิด'
UNION SELECT 	'Function_Name'	,	'11'	,	'vi-VN'	,	N'Thông báo sai mật khẩu'
UNION SELECT 	'Function_Name'	,	'13'	,	'en-US'	,	N'System Announcement'
UNION SELECT 	'Function_Name'	,	'13'	,	'zh-Hans'	,	N'系统公告'
UNION SELECT 	'Function_Name'	,	'13'	,	'zh-Hant'	,	N'系統公告'
UNION SELECT 	'Function_Name'	,	'13'	,	'th-TH'	,	N'ประกาศระบบ'
UNION SELECT 	'Function_Name'	,	'13'	,	'vi-VN'	,	N'Thông báo hệ thống'
UNION SELECT 	'Function_Name'	,	'14'	,	'en-US'	,	N'My Watchlist'
UNION SELECT 	'Function_Name'	,	'14'	,	'zh-Hans'	,	N'我的监控列表'
UNION SELECT 	'Function_Name'	,	'14'	,	'zh-Hant'	,	N'我的監控列表'
UNION SELECT 	'Function_Name'	,	'14'	,	'th-TH'	,	N'รายการเฝ้าดูของฉัน'
UNION SELECT 	'Function_Name'	,	'14'	,	'vi-VN'	,	N'Danh Sách Theo Dõi'
UNION SELECT 	'Action_Name'	,	'33'	,	'en-US'	,	N'Wrong Password Alert'
UNION SELECT 	'Action_Name'	,	'33'	,	'zh-Hans'	,	N'密码错误提示'
UNION SELECT 	'Action_Name'	,	'33'	,	'zh-Hant'	,	N'密碼錯誤提示'
UNION SELECT 	'Action_Name'	,	'33'	,	'th-TH'	,	N'แจ้งเตือนรหัสผ่านผิด'
UNION SELECT 	'Action_Name'	,	'33'	,	'vi-VN'	,	N'Thông báo sai mật khẩu'
UNION SELECT 	'Action_Name'	,	'41'	,	'en-US'	,	N'System Announcement'
UNION SELECT 	'Action_Name'	,	'41'	,	'zh-Hans'	,	N'系统公告'
UNION SELECT 	'Action_Name'	,	'41'	,	'zh-Hant'	,	N'系統公告'
UNION SELECT 	'Action_Name'	,	'41'	,	'th-TH'	,	N'ประกาศระบบ'
UNION SELECT 	'Action_Name'	,	'41'	,	'vi-VN'	,	N'Thông báo hệ thống'
UNION SELECT 	'Action_Name'	,	'42'	,	'en-US'	,	N'My Watchlist'
UNION SELECT 	'Action_Name'	,	'42'	,	'zh-Hans'	,	N'我的监控列表'
UNION SELECT 	'Action_Name'	,	'42'	,	'zh-Hant'	,	N'我的監控列表'
UNION SELECT 	'Action_Name'	,	'42'	,	'th-TH'	,	N'รายการเฝ้าดูของฉัน'
UNION SELECT 	'Action_Name'	,	'42'	,	'vi-VN'	,	N'Danh Sách Theo Dõi'
UNION SELECT 	'Function_Description'	,	'11'	,	'en-US'	,	N'Notify via your Telegram when your account password is entered wrongly three times in a row.'
UNION SELECT 	'Function_Description'	,	'11'	,	'zh-Hans'	,	N'账号密码连续3次输入错误时，将通过Telegram通知。'
UNION SELECT 	'Function_Description'	,	'11'	,	'zh-Hant'	,	N'賬號密碼連續3次輸入錯誤時，將通過Telegram通知。'
UNION SELECT 	'Function_Description'	,	'11'	,	'th-TH'	,	N'แจ้งเตือนผ่านทางเทเลแกรมของคุณเมื่อมีการป้อนรหัสผ่านผิดติดต่อกันสามครั้ง'
UNION SELECT 	'Function_Description'	,	'11'	,	'vi-VN'	,	N'Thông báo trên Telegram khi mật khẩu tài khoản của bạn bị nhập sai ba lần liên tiếp.'
UNION SELECT 	'Function_Description'	,	'13'	,	'en-US'	,	N'Forward System Announcement to your telegram.'
UNION SELECT 	'Function_Description'	,	'13'	,	'zh-Hans'	,	N'将系统公告转发到您的Telegram'
UNION SELECT 	'Function_Description'	,	'13'	,	'zh-Hant'	,	N'將系統公告轉發到您的Telegram'
UNION SELECT 	'Function_Description'	,	'13'	,	'th-TH'	,	N'ส่งต่อประกาศระบบไปยังเทเลแกรมของคุณ'
UNION SELECT 	'Function_Description'	,	'13'	,	'vi-VN'	,	N'Chuyển Thông báo hệ thống qua Telegram của bạn.'
UNION SELECT 	'Function_Description'	,	'14'	,	'en-US'	,	N'Notify via your Telegram when a Member reaches their Winning / Losing threshold.'
UNION SELECT 	'Function_Description'	,	'14'	,	'zh-Hans'	,	NULL
UNION SELECT 	'Function_Description'	,	'14'	,	'zh-Hant'	,	NULL
UNION SELECT 	'Function_Description'	,	'14'	,	'th-TH'	,	NULL
UNION SELECT 	'Function_Description'	,	'14'	,	'vi-VN'	,	NULL
)
MERGE BotResource as Target
USING (SELECT * FROM T WHERE Language <> 'vi-VN') as Source 
ON Target.ResourceName = Source.ResourceName
	AND Target.ResourceKey = Source.ResourceKey
	AND Target.Language = Source.Language
WHEN MATCHED THEN UPDATE Target.VALUE = Source.Value	
WHEN NOT MATCHED THEN 
	INSERT ([ResourceName]
		   ,[ResourceKey]
		   ,[Language]
		   ,[Value])
	VALUES(Source.ResourceName,Source.ResourceKey,Source.Language,Source.Value)
GO

--initial setting for linked accounts
INSERT INTO [dbo].[CustBotFunction]
           ([UserID]
           ,[FunctionID]
           ,[Status])
SELECT [UserID]
        ,[FunctionID]
        ,1
from CustBotAccount c WITH(NOLOCK)
CROSS APPLY (SELECT 11 as FunctionID
			UNION SELECT 13 
			UNION SELECT 14) t
WHERE NOT EXISTS (SELECT 1 FROM custBotFunction cf WITH(NOLOCK)
				WHERE c.UserId = cf.UserID
					AND t.FunctionID = cf.FunctionID)
