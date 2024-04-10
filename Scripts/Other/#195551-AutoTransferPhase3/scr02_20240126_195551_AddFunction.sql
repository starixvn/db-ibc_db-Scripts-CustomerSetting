/*<info serverAlias="DBAGE-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240126
	Task:  Alpha - Automate Transfer Enhancement Phase 3 [Redmine: #199951]
	DB: DBAGE/bodb_ChatBot
*/

use bodb_ChatBot
go

INSERT INTO BotFunction(FunctionID,	FunctionName,FunctionKey,[Type],Command,[Status],[Order],[Priority],ParentID)
	SELECT 21 AS FunctionID, 'Auto Transfer Settings' AS FunctionName, 'AutoTransferSettings' AS FunctionKey, 1 AS [Type], '/at' AS Command, 1 AS [Status], 7 AS [Order], NULL AS [Priority], NULL AS ParentID	UNION ALL
	SELECT 22 AS FunctionID, 'Auto Transfer Alert' AS FunctionName, 'AutoTransferAlert' AS FunctionKey, 2 AS [Type], NULL AS Command, 1 AS [Status], 111 AS [Order], 60 AS [Priority], NULL AS ParentID
GO

INSERT INTO BotAction(ActionID,	ActionName,[Type],Command,FunctionID,ParentID,[Status],IsEndAction,[Order])
	SELECT 50 AS ActionID,	'Auto Transfer Alert' AS ActionName, 1 AS [Type], '22' AS Command, 22 AS FunctionID, 26 AS ParentID, 1 AS [Status], 1 AS IsEndAction, 5012 AS [Order] UNION ALL
	SELECT 51 AS ActionID,	'Auto Transfer Settings' AS ActionName, 1 AS [Type], '/at' AS Command, 21 AS FunctionID, 0 AS ParentID, 1 AS [Status], 0 AS IsEndAction, 7 AS [Order] UNION ALL
	SELECT 52 AS ActionID,	'Auto Transfer Monitor' AS ActionName, 4 AS [Type], NULL AS Command, 21 AS FunctionID, 51 AS ParentID, 1 AS [Status], 1 AS IsEndAction, 701 AS [Order] UNION ALL
	SELECT 53 AS ActionID,	'Edit Auto Transfer' AS ActionName, 4 AS [Type], NULL AS Command, 21 AS FunctionID, 51 AS ParentID, 1 AS [Status], 1 AS IsEndAction, 702 AS [Order]	
GO