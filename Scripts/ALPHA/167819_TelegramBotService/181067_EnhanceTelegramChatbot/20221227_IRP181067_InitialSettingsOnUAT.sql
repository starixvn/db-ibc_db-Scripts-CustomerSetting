/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221227@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#181067]
	DB: DBBOT/bodb_Chatbot
*/

INSERT INTO [dbo].[BotFunction]
           ([FunctionID]
           ,[FunctionName]
           ,[FunctionKey]
           ,[Type]
           ,[Command]
           ,[Status]
           ,[Order]
           ,[Priority]
		   ,[ParentID])
SELECT 17, 'Risk Alert', 'RiskAlert', 2, NULL, 1, 103, NULL, NULL
GO

-------------------------------------------
--add new botAction	
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
SELECT 45 ActionID,	'Risk Alert' ActionName, 1 Type, '17' Command, 17 FunctionID, 26 ParentID, 1 Status, 1 IsEndAction, 5002 [Order]
GO
		
-----------------------------------------------------
--add botResource
;WITH T AS(
SELECT 	'Action_Name'	ResourceName,	'45'	ResourceKey,	'en-US'	Language,	N'Risk Alert' Value
UNION SELECT 'Function_Description', '17', 'en-US', N'Notify via your Telegram when any set win loss limit is reached'
UNION SELECT 'Function_Name', '17', 'en-US', N'Risk Alert'
UNION SELECT 'Action_Name',	'45',	'zh-Hans',	N'风险提示'
UNION SELECT 'Function_Description', '17', 'zh-Hans', N'会通过Telegram通知当达到任何设定的输赢限额'
UNION SELECT 'Function_Name', '17', 'zh-Hans', N'风险提示'
UNION SELECT 'Action_Name',	'45',	'zh-Hant',	N'風險提示'
UNION SELECT 'Function_Description', '17', 'zh-Hant', N'會通過Telegram通知當達到任何設定的輸贏限額'
UNION SELECT 'Function_Name', '17', 'zh-Hant', N'風險提示'
UNION SELECT 'Action_Name',	'45',	'th-TH',	N'ขอบพระคุณ'
UNION SELECT 'Function_Description', '17', 'th-TH', N'แจ้งเตือนผ่านเทเลแกรมของคุณเมื่อถึงขีดจำกัดการแพ้ชนะที่ตั้งไว้'
UNION SELECT 'Function_Name', '17', 'th-TH', N'ขอบพระคุณ'
UNION SELECT 'Action_Name',	'45',	'vi-VN',	N'Cảnh Báo Rủi Ro'
UNION SELECT 'Function_Description', '17', 'vi-VN', N'Thông báo trên Telegram khi đạt đến bất kỳ giới hạn thắng thua nào đã đặt'
UNION SELECT 'Function_Name', '17', 'vi-VN', N'Cảnh Báo Rủi Ro'
)	
INSERT INTO [dbo].[BotResource]
           ([ResourceName]
           ,[ResourceKey]
           ,[Language]
           ,[Value])
SELECT ResourceName, ResourceKey, Language, Value
FROM T
GO

--initial setting for linked accounts UUS on UAT
INSERT INTO [dbo].[CustBotFunction]
           ([UserID]
           ,[FunctionID]
           ,[Status])
SELECT c.[UserID]
        ,t.[FunctionID]
        ,c2.Status
FROM CustBotAccount c WITH(NOLOCK)
INNER JOIN bodb02.dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
CROSS APPLY (SELECT 17 as FunctionID			
			) t
INNER JOIN (
			SELECT UserID, Max(CASE WHEN status = 0 THEN 0 ELSE 1 END) as Status
			FROM CustBotFunction WITH(NOLOCK)
			WHERE FunctionID IN (8,14)
			GROUP BY UserID 
		) c2 ON c.UserID = c2.UserID		
WHERE NOT EXISTS (SELECT 1 FROM custBotFunction cf WITH(NOLOCK)
				WHERE c.UserId = cf.UserID
					AND t.FunctionID = cf.FunctionID)
	AND ci.currency = 20					