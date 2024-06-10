/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240611
	Task:  Telegram Chatbot - Notify Member Last bet [Redmine: #193689]
	DB: DBBOT/bodb_ChatBot
*/

IF EXISTS (SELECT 1 FROM BotFunction WITH (NOLOCK) WHERE FunctionID = 23)
	OR EXISTS (SELECT 1 FROM BotAction WITH (NOLOCK) WHERE ActionID = 54)
BEGIN
	RAISERROR('FunctionId/ActionId has been chosen, please check again', 16, 1)
END
ELSE
BEGIN
	INSERT INTO BotFunction(FunctionID,	FunctionName,FunctionKey,[Type],Command,[Status],[Order],[Priority],ParentID)
		SELECT 23 AS FunctionID, 'Last Bets Alert' AS FunctionName, 'LastBetsAlert' AS FunctionKey, 2 AS [Type], NULL AS Command, 1 AS [Status], 112 AS [Order], 70 AS [Priority], NULL AS ParentID
	
	INSERT INTO BotAction(ActionID,	ActionName,[Type],Command,FunctionID,ParentID,[Status],IsEndAction,[Order])
		SELECT 54 AS ActionID,	'Last Bets Alert' AS ActionName, 1 AS [Type], '23' AS Command, 23 AS FunctionID, 26 AS ParentID, 1 AS [Status], 1 AS IsEndAction, 5013 AS [Order]
END