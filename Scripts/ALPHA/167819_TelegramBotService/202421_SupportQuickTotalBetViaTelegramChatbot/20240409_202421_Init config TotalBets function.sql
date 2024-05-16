/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20240409@Kelvin	
	Task: Set up config TotalBets function [Redmine: #202421]
	DB: DBBOT/bodb_Chatbot
*/

--Check if existed ID -> RETURN
IF EXISTS (SELECT TOP 1 1 FROM [BotFunction](NOLOCK) WHERE [FunctionID] = 24 AND [FunctionName] <> 'Total Bets')
BEGIN
	RAISERROR('[BotFunction].[FunctionID] = 24 is existed! Please check with DEV.',16,1)
	RETURN
END
IF EXISTS (SELECT TOP 1 1 FROM [BotAction](NOLOCK) WHERE [ActionID] = 55 AND [ActionName] <> 'Total Bets')
BEGIN
	RAISERROR('[BotAction].[ActionID] = 55 is existed! Please check with DEV.',16,1)
	RETURN
END

GO

--BotFunction
DELETE FROM [BotFunction] WHERE [FunctionID] = 24 AND [FunctionKey] = 'TotalBets'

;WITH T AS (
SELECT  24 [FunctionID], 'Total Bets' [FunctionName], 'TotalBets' [FunctionKey], 1 [Type], NULL [Command], 1 [Status], 8 [Order], NULL [Priority], NULL [ParentID]
)
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
SELECT [FunctionID]
	   ,[FunctionName]
	   ,[FunctionKey]
	   ,[Type]
	   ,[Command]
	   ,[Status]
	   ,[Order]
	   ,[Priority]
	   ,[ParentID]
FROM T

GO

--BotAction
UPDATE [BotAction]
SET [Order] = CASE  WHEN ActionID = 1	AND ActionName = 'Outstanding'				THEN 2
					WHEN ActionID = 2	AND ActionName = 'Balance Info'				THEN 3
					WHEN ActionID = 3	AND ActionName = 'Today Win Loss'			THEN 4
					WHEN ActionID = 4	AND ActionName = 'Yesterday Win Loss'		THEN 5
					WHEN ActionID = 48	AND ActionName = 'Available Domains'		THEN 6
					WHEN ActionID = 46	AND ActionName = 'Customer Settings'		THEN 7
					WHEN ActionID = 51	AND ActionName = 'Auto Transfer Settings'	THEN 8
					WHEN ActionID = 11	AND ActionName = 'Settings'					THEN 9
			  END
WHERE ActionID IN (1,2,3,4,48,46,51,11)

DELETE FROM [BotAction] WHERE ActionID = 55 AND ActionName = 'Total Bets'

;WITH T AS (
SELECT 55 ActionID,	'Total Bets' ActionName, 1 Type, NULL Command, 24 FunctionID, 0 ParentID, 1 Status, 1 IsEndAction, 1 [Order])
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

--BotResource
DELETE FROM [BotResource] WHERE [ResourceKey] in (24,55)

INSERT INTO [dbo].[BotResource]
           ([ResourceName]
           ,[ResourceKey]
           ,[Language]
           ,[Value])
VALUES 
 ('Function_Name', 24, 'en-US', N'Total Bets')
,('Function_Name', 24, 'th-TH', N'จำนวนการวางเดิมพันทั้งหมด')
,('Function_Name', 24, 'zh-Hans', N'总投注')
,('Function_Name', 24, 'zh-Hant', N'總投注')

,('Function_Description', 24, 'en-US', N'Stay updated on the top 10 highest-turnover soccer matches and monitor their total turnover easily.')
,('Function_Description', 24, 'th-TH', N'ดูข้อมูลล่าสุด ของการแข่งขันฟุตบอลที่มีมูลค่าการเดิมพันสูงสุด 10 อันดับแรก และตรวจสอบมูลค่าการเดิมพันรวมของแต่ละเกมได้อย่างรวดเร็ว')
,('Function_Description', 24, 'zh-Hans', N'随时获知前10场足球赛事最高投注额的最新动态，并轻松监控其总投注额。')
,('Function_Description', 24, 'zh-Hant', N'隨時獲知前10場足球賽事最高投注額的最新動態，並輕鬆監控其總投注額。')

,('Action_Name', 55, 'en-US', N'Total Bets')
,('Action_Name', 55, 'th-TH', N'จำนวนการวางเดิมพันทั้งหมด')
,('Action_Name', 55, 'zh-Hans', N'总投注')
,('Action_Name', 55, 'zh-Hant', N'總投注')

,('Action_Description', 55, 'en-US', N'Stay updated on the top 10 highest-turnover soccer matches and monitor their total turnover easily.')
,('Action_Description', 55, 'th-TH', N'ดูข้อมูลล่าสุด ของการแข่งขันฟุตบอลที่มีมูลค่าการเดิมพันสูงสุด 10 อันดับแรก และตรวจสอบมูลค่าการเดิมพันรวมของแต่ละเกมได้อย่างรวดเร็ว')
,('Action_Description', 55, 'zh-Hans', N'随时获知前10场足球赛事最高投注额的最新动态，并轻松监控其总投注额。')
,('Action_Description', 55, 'zh-Hant', N'隨時獲知前10場足球賽事最高投注額的最新動態，並輕鬆監控其總投注額。')
				 



