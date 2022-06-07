/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220408@Johnson
	Task: Initial system setting for telegram bot service [#RedmineID:#167819]
	DB: DBBOT/bodb_Chatbot
*/

--20220610: delete wrong data on UAT
DELETE CustBotMessenger WITH(ROWLOCK) WHERE botid = 1

/*
;WITH T AS
(SELECT 36 as ActionID, 'zh-Hant' as Command
UNION SELECT 37, 'zh-Hans'
)
UPDATE b
SET b.Command = t.Command
FROM BotAction b
	INNER JOIN T ON b.ActionID = t.ActionID

;WITH T AS (
	SELECT 	27	ActionID,	5 FunctionID
UNION ALL SELECT 	28	,	6
UNION ALL SELECT 	29	,	7
UNION ALL SELECT 	30	,	8
UNION ALL SELECT 	31	,	9
UNION ALL SELECT 	32	,	10
)	
UPDATE b
SET b.FunctionID = t.FunctionID
FROM BotAction b
	INNER JOIN T ON b.ActionID = t.ActionID
*/
	
/*
;WITH T AS (
SELECT 	'Function_Description'	ResourceName,	'5'	ResourceKey,	'en-US'	Language,	'Daily send the total row of Alpha Win Loss report of yesterday at 2:00PM (GMT-4)' Value
)
UPDATE b
SET b.VALUE = t.value
FROM BotResource b
	INNER JOIN T ON b.ResourceName = t.ResourceName 
					AND b.ResourceKey = t.ResourceKey
					AND b.Language = t.Language
GO
*/

/*
WITH T AS (
	SELECT 1 as botid, 'AlphaUAT2Bot' as Name, '5460331755:AAHTPJlBTE8hsLf8-datMO_U4Ub38Nx4aYg' Accesstoken
	UNION SELECT 3, 'AlphaUAT3Bot', '5578042931:AAFH6YVm_BnF1sPvD_1fmQ6hK0qrPe58ZGs'
)
UPDATE b
SET b.Name = t.Name,
	b.Accesstoken = t.Accesstoken
FROM bot b WITH(ROWLOCK)
	INNER JOIN t ON b.botid = t.botid
*/

/*
;WITH T AS(
SELECT 	'Action_Name'	ResourceName,	'36'	ResourceKey,	'en-US'	Language,	N'繁體中文' Value
UNION ALL SELECT 	'Action_Name'	,	'37'	,	'en-US'	,	N'简体中文'
UNION ALL SELECT 	'Action_Name'	,	'38'	,	'en-US'	,	N'ภาษาไทย'
UNION ALL SELECT 	'Action_Name'	,	'39'	,	'en-US'	,	N'Tiếng Việt'
)	
UPDATE b
SET b.Value = t.Value
FROM BotResource b WITH(ROWLOCK)
	INNER JOIN T ON b.ResourceName = t.ResourceName
					AND b.ResourceKey = t.ResourceKey
					AND b.Language = t.Language
*/					
					