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

/*
select 'UNINON SELECT ', ActionID, ',', ''''+ ActionName +''',', Type,',', ''''+Command+'''',',',FunctionID,',',ParentID,',',Status,',',IsEndAction
from BotAction
*/
;WITH T AS (	
SELECT 	1	ActionID,	'Outstanding' ActionName,	1	Type,	'/os' Command,	1	FunctionID,	0	ParentID,	0	Status,	0 IsEndAction
UNION ALL SELECT 	2	,	'Balance Info',	1	,	'/bal',	2	,	0	,	0	,	0
UNION ALL SELECT 	3	,	'Today Win Loss',	1	,	'/wl',	3	,	0	,	0	,	0
UNION ALL SELECT 	4	,	'Yesterday Win Loss',	1	,	'/ywl',	4	,	0	,	0	,	0
UNION ALL SELECT 	5	,	'Top 50 Outstanding',	1	,	'50',	1	,	1	,	0	,	1
UNION ALL SELECT 	6	,	'Enter downline username',	1	,	'&lt;Username&gt;',	1	,	1	,	0	,	0
UNION ALL SELECT 	7	,	'Top Downlines',	3	,	NULL,	1	,	1	,	0	,	1
UNION ALL SELECT 	8	,	'Top X Outstanding',	1	,	'&lt;#&gt;',	1	,	1	,	0	,	0
UNION ALL SELECT 	9	,	'Please enter your downline username to view Outstanding',	2	,	NULL,	1	,	6	,	0	,	1
UNION ALL SELECT 	10	,	'How many Downlines you''d like to view Outstanding.\nChatbot supports listing up to 100 Downlines',	2	,	NULL,	1	,	8	,	0	,	1
UNION ALL SELECT 	11	,	'Settings',	1	,	'/settings',	12	,	0	,	0	,	0
UNION ALL SELECT 	12	,	'My Balance',	1	,	'm',	2	,	2	,	0	,	1
UNION ALL SELECT 	13	,	'Enter downline username',	1	,	'&lt;Username&gt;',	2	,	2	,	0	,	0
UNION ALL SELECT 	14	,	'Top Downlines',	3	,	NULL,	2	,	2	,	0	,	1
UNION ALL SELECT 	15	,	'Top X Balance',	1	,	'&lt;#&gt;',	2	,	2	,	0	,	0
UNION ALL SELECT 	16	,	'Please enter your downline username to view Balance',	2	,	NULL,	2	,	13	,	0	,	1
UNION ALL SELECT 	17	,	'How many Downlines you''d like to view Balance.
Chatbot supports listing up to 100 Downlines',	2	,	NULL,	2	,	15	,	0	,	1
UNION ALL SELECT 	18	,	'My Today Win Loss',	1	,	'm',	3	,	3	,	0	,	1
UNION ALL SELECT 	19	,	'Enter downline username',	1	,	'&lt;Username&gt;',	3	,	3	,	0	,	0
UNION ALL SELECT 	20	,	'Top Downlines',	3	,	NULL,	3	,	3	,	0	,	1
UNION ALL SELECT 	21	,	'Please enter your downline username to view Today Win Loss',	2	,	NULL,	3	,	19	,	0	,	1
UNION ALL SELECT 	22	,	'My Yesterday Win Loss',	1	,	'm',	4	,	4	,	0	,	1
UNION ALL SELECT 	23	,	'Enter downline username',	1	,	'&lt;Username&gt;',	4	,	4	,	0	,	0
UNION ALL SELECT 	24	,	'Top Downlines',	3	,	NULL,	4	,	4	,	0	,	1
UNION ALL SELECT 	25	,	'Please enter your downline username to view Yesterday Win Loss',	2	,	NULL,	4	,	23	,	0	,	1
UNION ALL SELECT 	26	,	'Notifications',	1	,	NULL,	12	,	11	,	0	,	0
UNION ALL SELECT 	27	,	'Yesterday Win Loss',	1	,	'5',	12	,	26	,	0	,	1
UNION ALL SELECT 	28	,	'Personal Message',	1	,	'6',	12	,	26	,	0	,	1
UNION ALL SELECT 	29	,	'Problem Account',	1	,	'7',	12	,	26	,	0	,	1
UNION ALL SELECT 	30	,	'Member Win Loss Limit',	1	,	'8',	12	,	26	,	0	,	1
UNION ALL SELECT 	31	,	'Change Password Alert',	1	,	'9',	12	,	26	,	0	,	1
UNION ALL SELECT 	32	,	'Change Security Code Alert',	1	,	'10',	12	,	26	,	0	,	1
UNION ALL SELECT 	33	,	'Abnormal Login Alert',	1	,	'11',	12	,	26	,	0	,	1
UNION ALL SELECT 	34	,	'Stop Using Chatbot',	1	,	'stop',	12	,	11	,	0	,	1
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

;WITH T AS (
	SELECT 	'Action_Description'	ResourceName,	'1'	ResourceKey,	'en-US'	Language,	'Open Outstanding Menu' Value
UNION ALL SELECT 	'Action_Description'	,	'12'	,	'en-US'	,	' Get your Balance Info Report'
UNION ALL SELECT 	'Action_Description'	,	'13'	,	'en-US'	,	'Get Balance Info of specific member'
UNION ALL SELECT 	'Action_Description'	,	'15'	,	'en-US'	,	'Get Balance Info of top # members'
UNION ALL SELECT 	'Action_Description'	,	'18'	,	'en-US'	,	'Get your Today Win Loss Report'
UNION ALL SELECT 	'Action_Description'	,	'19'	,	'en-US'	,	' Get Today Win Loss Report of specfic member'
UNION ALL SELECT 	'Action_Description'	,	'2'	,	'en-US'	,	'Open Balance Info Menu'
UNION ALL SELECT 	'Action_Description'	,	'22'	,	'en-US'	,	'Get your Yesterday Win Loss Report'
UNION ALL SELECT 	'Action_Description'	,	'23'	,	'en-US'	,	'Get Yesterday Win Loss Report of specific member'
UNION ALL SELECT 	'Action_Description'	,	'3'	,	'en-US'	,	'Open Today Win Loss Report Menu'
UNION ALL SELECT 	'Action_Description'	,	'4'	,	'en-US'	,	'Open Yesterday Win Loss Report Menu'
UNION ALL SELECT 	'Action_Description'	,	'5'	,	'en-US'	,	'Get Outstanding Report of top 50 members'
UNION ALL SELECT 	'Action_Description'	,	'6'	,	'en-US'	,	'Get Outstanding Report of specific member'
UNION ALL SELECT 	'Action_Description'	,	'8'	,	'en-US'	,	'Get Outstanding Report of top # members'
UNION ALL SELECT 	'Action_Name'	,	'1'	,	'en-US'	,	'Outstanding'
UNION ALL SELECT 	'Action_Name'	,	'10'	,	'en-US'	,	'How many Downlines you''d like to view Outstanding.
Chatbot supports listing up to 100 Downlines'
UNION ALL SELECT 	'Action_Name'	,	'11'	,	'en-US'	,	'Settings'
UNION ALL SELECT 	'Action_Name'	,	'12'	,	'en-US'	,	'My Balance'
UNION ALL SELECT 	'Action_Name'	,	'13'	,	'en-US'	,	'Enter downline username'
UNION ALL SELECT 	'Action_Name'	,	'15'	,	'en-US'	,	'Top X Balance'
UNION ALL SELECT 	'Action_Name'	,	'16'	,	'en-US'	,	'Please enter your downline username to view Balance'
UNION ALL SELECT 	'Action_Name'	,	'17'	,	'en-US'	,	'How many Downlines you''d like to view Balance.
Chatbot supports listing up to 100 Downlines'
UNION ALL SELECT 	'Action_Name'	,	'18'	,	'en-US'	,	'My Today Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'19'	,	'en-US'	,	'Enter downline username'
UNION ALL SELECT 	'Action_Name'	,	'2'	,	'en-US'	,	'Balance Info'
UNION ALL SELECT 	'Action_Name'	,	'21'	,	'en-US'	,	'Please enter your downline username to view Today Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'22'	,	'en-US'	,	'My Yesterday Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'23'	,	'en-US'	,	'Enter downline username'
UNION ALL SELECT 	'Action_Name'	,	'25'	,	'en-US'	,	'Please enter your downline username to view Yesterday Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'26'	,	'en-US'	,	'Notifications'
UNION ALL SELECT 	'Action_Name'	,	'27'	,	'en-US'	,	'Yesterday Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'28'	,	'en-US'	,	'Personal Message'
UNION ALL SELECT 	'Action_Name'	,	'29'	,	'en-US'	,	'Problem Account'
UNION ALL SELECT 	'Action_Name'	,	'3'	,	'en-US'	,	'Today Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'30'	,	'en-US'	,	'Member Win Loss Limit'
UNION ALL SELECT 	'Action_Name'	,	'31'	,	'en-US'	,	'Change Password Alert'
UNION ALL SELECT 	'Action_Name'	,	'32'	,	'en-US'	,	'Change Security Code Alert'
UNION ALL SELECT 	'Action_Name'	,	'33'	,	'en-US'	,	'Abnormal Login Alert'
UNION ALL SELECT 	'Action_Name'	,	'34'	,	'en-US'	,	'Stop Using Chatbot'
UNION ALL SELECT 	'Action_Name'	,	'4'	,	'en-US'	,	'Yesterday Win Loss'
UNION ALL SELECT 	'Action_Name'	,	'5'	,	'en-US'	,	'Top 50 Outstanding'
UNION ALL SELECT 	'Action_Name'	,	'6'	,	'en-US'	,	'Enter downline username'
UNION ALL SELECT 	'Action_Name'	,	'8'	,	'en-US'	,	'Top X Outstanding'
UNION ALL SELECT 	'Action_Name'	,	'9'	,	'en-US'	,	'Please enter your downline username to view Outstanding'
UNION ALL SELECT 	'Function_Description'	,	'1'	,	'en-US'	,	'Get the total row of Alpha Outstanding Report of current Date. You can also get downlines'' Outstanding report'
UNION ALL SELECT 	'Function_Description'	,	'10'	,	'en-US'	,	' Alert to your Telegram when your Security Code is changed'
UNION ALL SELECT 	'Function_Description'	,	'11'	,	'en-US'	,	'Alert to your Telegram when there''s unrecognized login activity using your account on Alpha Site'
UNION ALL SELECT 	'Function_Description'	,	'12'	,	'en-US'	,	'Settings'
UNION ALL SELECT 	'Function_Description'	,	'2'	,	'en-US'	,	'Get the Alpha Balance Info Report. You can also get downlines'' Balance Info report'
UNION ALL SELECT 	'Function_Description'	,	'3'	,	'en-US'	,	'Get the total row of Alpha Win Loss report of current date. You can also get downlines'' Win Loss of current date'
UNION ALL SELECT 	'Function_Description'	,	'4'	,	'en-US'	,	'Get the total row of Alpha Win Loss report of yesterday. You can also get downlines'' Win Loss of yesterday'
UNION ALL SELECT 	'Function_Description'	,	'5'	,	'en-US'	,	'Daily send the total row of Alpha Win Loss report of yesterday at 3:00PM (GMT-4)'
UNION ALL SELECT 	'Function_Description'	,	'6'	,	'en-US'	,	'Push Alpha''s Personal Message to your Telegram'
UNION ALL SELECT 	'Function_Description'	,	'7'	,	'en-US'	,	'Alert to your Telegram when there''s new downline that''s marked as Problem Account'
UNION ALL SELECT 	'Function_Description'	,	'8'	,	'en-US'	,	'Alert to your Telegram whenever a Member reached their Win Loss limit'
UNION ALL SELECT 	'Function_Description'	,	'9'	,	'en-US'	,	'Alert to your Telegram when your Alpha Site''s Account''s Password is changed'
UNION ALL SELECT 	'Function_Name'	,	'1'	,	'en-US'	,	'Outstanding'
UNION ALL SELECT 	'Function_Name'	,	'10'	,	'en-US'	,	'Change Security Code Alert'
UNION ALL SELECT 	'Function_Name'	,	'11'	,	'en-US'	,	'Abnormal Login Alert'
UNION ALL SELECT 	'Function_Name'	,	'12'	,	'en-US'	,	'Settings'
UNION ALL SELECT 	'Function_Name'	,	'2'	,	'en-US'	,	'Balance Info'
UNION ALL SELECT 	'Function_Name'	,	'3'	,	'en-US'	,	'Today Win Loss'
UNION ALL SELECT 	'Function_Name'	,	'4'	,	'en-US'	,	'Yesterday Win Loss'
UNION ALL SELECT 	'Function_Name'	,	'5'	,	'en-US'	,	'Yesterday Win Loss'
UNION ALL SELECT 	'Function_Name'	,	'6'	,	'en-US'	,	'Personal Message'
UNION ALL SELECT 	'Function_Name'	,	'7'	,	'en-US'	,	'Problem Account'
UNION ALL SELECT 	'Function_Name'	,	'8'	,	'en-US'	,	'Member Win Loss Limit'
UNION ALL SELECT 	'Function_Name'	,	'9'	,	'en-US'	,	'Change Password Alert'
)
INSERT INTO BotResource(ResourceName,ResourceKey,Language,Value)
SELECT ResourceName,ResourceKey,Language,Value
FROM T

