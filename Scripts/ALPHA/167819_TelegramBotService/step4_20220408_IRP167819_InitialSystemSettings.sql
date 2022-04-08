/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220408@Johnson
	Task: Initial system setting for telegram bot service [#RedmineID:#167819]
	DB: DBBOT/bodb_Chatbot
*/

WITH T as (
SELECT 1 FunctionID,'Outstanding' FunctionName,'Outstanding' FunctionKey,1 Type,'/os' Command,0 Status,1 [Order]
UNION SELECT 2,'Balance Info','BalanceInfo',1,'/bal',0,2
UNION SELECT 3,'Today Win Loss','TodayWinLoss',1,'/wl',0,3
UNION SELECT 4,'Yesterday Win Loss','YesterdayWinLossReport',1,'/ywl',0,4
UNION SELECT 5,'Yesterday Win Loss','YesterdayWinLoss',2,NULL,0,100
UNION SELECT 6,'Personal Message','PersonalMessage',2,NULL,0, 101
UNION SELECT 7,'Problem Account','ProblemAccount',2,NULL,0, 102
UNION SELECT 8,'Member Win Loss Limit','MemberWinLossLimit',2,NULL,0,103
UNION SELECT 9,'Change Password Alert','ChangePasswordAlert',2,NULL,0,104
UNION SELECT 10,'Change Security Code Alert','ChangeSecurityCodeAlert',2,NULL,0,105
UNION SELECT 11,'Abnormal Login Alert','AbnormalLoginAlert',2,NULL,0,106
UNION SELECT 12,'Settings','Settings',3,'/settings',0,200)
INSERT INTO [dbo].[BotFunction]
           ([FunctionID]
		   ,[FunctionName]
           ,[FunctionKey]
           ,[Type]
           ,[Command]
           ,[Status]
		   ,[Order])
SELECT [FunctionID]
		,[FunctionName]
	   ,[FunctionKey]
	   ,[Type]
	   ,[Command]
	   ,[Status]
	   ,[Order]
FROM T
GO

WITH T AS (
	SELECT 1 as ActionID, 'Outstanding' as ActionName,	1 as Type,	'/os' as Command, 1 FunctionID,	0 as ParentID, 0 as Status, 0 as IsEndAction
	UNION SELECT 2,	'Top Outstanding', 1, '200', 1, 1, 0, 1
	UNION SELECT 3,	'Specific Downline', 1,	'', 1, 1, 0, 0
	UNION SELECT 4,	'Please input username', 2, '',	1, 3, 0, 1
	UNION SELECT 5,	'Balance Info', 1, '/bal', 2, 0, 0, 0
	UNION SELECT 6,	'My Balance Info', 1, 'm', 2, 5, 0, 1
	UNION SELECT 7,	'Specific Downline', 1, '',	2, 5, 0, 0
	UNION SELECT 8,	'Please input username', 2, '', 2, 7, 0, 1
	UNION SELECT 9,	'Top Balance', 2, '10', 2, 5, 0, 1
)
INSERT INTO [dbo].[BotAction]
           ([ActionID]
           ,[ActionName]
           ,[Type]
           ,[Command]
           ,[FunctionID]
           ,[ParentID]
           ,[Status]
           ,[IsEndAction])
SELECT [ActionID]
           ,[ActionName]
           ,[Type]
           ,[Command]
           ,[FunctionID]
           ,[ParentID]
           ,[Status]
           ,[IsEndAction]
FROM T
GO

WITH T AS (
	SELECT 'Function_Description' as ResourceName, 'BalanceInfo' as ResourceKey, 'en-US' as Language, 'Get the Alpha Balance Info Report. You can also get downlines'' Balance Info report' as Value
	UNION SELECT 'Function_Name', 'BalanceInfo', 'en-US', 'Balance Info'
	UNION SELECT 'Function_Description', 'Outstanding', 'en-US', 'Get the total row of Alpha Outstanding Report of current Date. You can also get downlines'' Outstanding report'
	UNION SELECT 'Function_Name', 'Outstanding', 'en-US', 'Outstanding'
	UNION SELECT 'Function_Description', 'YesterdayWinLossReport', 'en-US', 'Get the total row of Alpha Win Loss report of yesterday. You can also get downlines'' Win Loss of yesterday'
	UNION SELECT 'Function_Name', 'YesterdayWinLossReport', 'en-US', 'Yesterday Win Loss'
	UNION SELECT 'Function_Description', 'TodayWinLoss', 'en-US', 'Get the total row of Alpha Win Loss report of current date. You can also get downlines'' Win Loss of current date'
	UNION SELECT 'Function_Name', 'TodayWinLoss', 'en-US', 'Today Win Loss'
	UNION SELECT 'Function_Description', 'YesterdayWinLoss', 'en-US', 'Daily send the total row of Alpha Win Loss report of yesterday at 3:00PM (GMT-4)'
	UNION SELECT 'Function_Name', 'YesterdayWinLoss', 'en-US', 'Yesterday Win Loss' 
	UNION SELECT 'Function_Description', 'PersonalMessage', 'en-US', 'Push Alpha''s Personal Message to your Telegram'
	UNION SELECT 'Function_Name', 'PersonalMessage', 'en-US', 'Personal Message' 
	UNION SELECT 'Function_Description', 'AbnormalLoginAlert', 'en-US', 'Alert to your Telegram when there''s unrecognized login activity using your account on Alpha Site'
	UNION SELECT 'Function_Name', 'AbnormalLoginAlert', 'en-US', 'Abnormal Login Alert'
	UNION SELECT 'Function_Description', 'ChangePasswordAlert', 'en-US', 'Alert to your Telegram when your Alpha Site''s Account''s Password is changed'
	UNION SELECT 'Function_Name', 'ChangePasswordAlert', 'en-US', 'Change Password Alert' 
	UNION SELECT 'Function_Description', 'ChangeSecurityCodeAlert', 'en-US', ' Alert to your Telegram when your Security Code is changed'
	UNION SELECT 'Function_Name', 'ChangeSecurityCodeAlert', 'en-US', 'Change Security Code Alert'
	UNION SELECT 'Function_Description', 'ProblemAccount', 'en-US', 'Alert to your Telegram when there''s new downline that''s marked as Problem Account'
	UNION SELECT 'Function_Name', 'ProblemAccount', 'en-US', 'Problem Account'
	UNION SELECT 'Function_Description', 'MemberWinLossLimit', 'en-US', 'Alert to your Telegram whenever a Member reached their Win Loss limit'
	UNION SELECT 'Function_Name', 'MemberWinLossLimit', 'en-US', 'Member Win Loss Limit' 
)
INSERT INTO BotResource(ResourceName,ResourceKey,Language,Value)
SELECT ResourceName,ResourceKey,Language,Value
FROM T

