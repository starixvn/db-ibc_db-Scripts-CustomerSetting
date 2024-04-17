/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20240409@Kelvin	
	Task: Set up config TotalBets function [Redmine: #202421]
	DB: DBBOT/bodb_Chatbot
*/

--Check if existed ID -> RETURN
IF EXISTS (SELECT TOP 1 1 FROM [BotFunction](NOLOCK) WHERE [FunctionID] = 24 AND [FunctionKey] <> 'TotalBets')
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
DELETE FROM [BotAction] WHERE ActionID = 55 AND ActionName = 'Total Bets'

;WITH T AS (
SELECT 55 ActionID,	'Total Bets' ActionName, 1 Type, NULL Command, 24 FunctionID, 0 ParentID, 1 Status, 1 IsEndAction, 5 [Order])
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

UPDATE [BotAction]
SET [Order] = CASE ActionName 
					WHEN 'Available Domains' THEN 6
					WHEN 'Customer Settings' THEN 7
					WHEN 'Auto Transfer Settings' THEN 8
					ELSE 9 END
WHERE ActionName IN ('Available Domains','Customer Settings','Auto Transfer Settings','Settings')

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
,('Function_Name', 24, 'vi-VN', N'Tổng Cược')

,('Function_Description', 24, 'en-US', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')
,('Function_Description', 24, 'th-TH', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')
,('Function_Description', 24, 'zh-Hans', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')
,('Function_Description', 24, 'zh-Hant', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')
,('Function_Description', 24, 'vi-VN', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')

,('Action_Name', 55, 'en-US', N'Total Bets')
,('Action_Name', 55, 'th-TH', N'จำนวนการวางเดิมพันทั้งหมด')
,('Action_Name', 55, 'zh-Hans', N'总投注')
,('Action_Name', 55, 'zh-Hant', N'總投注')
,('Action_Name', 55, 'vi-VN', N'Tổng Cược')

,('Action_Description', 55, 'en-US', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')
,('Action_Description', 55, 'th-TH', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')
,('Action_Description', 55, 'zh-Hans', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')
,('Action_Description', 55, 'zh-Hant', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')
,('Action_Description', 55, 'vi-VN', N'Get the latest top 10 highest-turnover soccer matches and quickly monitor the total turnover of each game.')
				 



