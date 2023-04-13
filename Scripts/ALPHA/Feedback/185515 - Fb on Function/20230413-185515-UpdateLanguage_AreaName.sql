/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230413@Tacy
	Task : Update Language Age_FeedbackArea
		https://nexdev.net/issues/185515
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

UPDATE fa
SET	 AreaNameEN = CASE	WHEN AreaNameEN=N'Select no.of accounts'			THEN N'Account quantity input'
						WHEN AreaNameEN=N'Copy Account after creation'		THEN N'Username(s) copy after creation'
						WHEN AreaNameEN=N'Choose first available username'	THEN N'Account naming convention?'
						WHEN AreaNameEN=N'Input Given Credit'				THEN N'Given Credit input'
				END
	,AreaNameCN3 = CASE	WHEN AreaNameCN3=N'Select no.of accounts'			THEN N'Account quantity input'
						WHEN AreaNameCN3=N'Copy Account after creation'		THEN N'Username(s) copy after creation'
						WHEN AreaNameCN3=N'Choose first available username'	THEN N'Account naming convention?'
						WHEN AreaNameCN3=N'Input Given Credit'				THEN N'Given Credit input'
				END
	,AreaNameCH = CASE	WHEN AreaNameCH=N'Select no.of accounts'			THEN N'Account quantity input'
						WHEN AreaNameCH=N'Copy Account after creation'		THEN N'Username(s) copy after creation'
						WHEN AreaNameCH=N'Choose first available username'	THEN N'Account naming convention?'
						WHEN AreaNameCH=N'Input Given Credit'				THEN N'Given Credit input'
				END
	,AreaNameCS = CASE	WHEN AreaNameCS=N'Select no.of accounts'			THEN N'Account quantity input'
						WHEN AreaNameCS=N'Copy Account after creation'		THEN N'Username(s) copy after creation'
						WHEN AreaNameCS=N'Choose first available username'	THEN N'Account naming convention?'
						WHEN AreaNameCS=N'Input Given Credit'				THEN N'Given Credit input'
				END
	,AreaNameTH = CASE	WHEN AreaNameTH=N'Select no.of accounts'			THEN N'Account quantity input'
						WHEN AreaNameTH=N'Copy Account after creation'		THEN N'Username(s) copy after creation'
						WHEN AreaNameTH=N'Choose first available username'	THEN N'Account naming convention?'
						WHEN AreaNameTH=N'Input Given Credit'				THEN N'Given Credit input'
				END
	,AreaNameJP = CASE	WHEN AreaNameJP=N'Select no.of accounts'			THEN N'Account quantity input'
						WHEN AreaNameJP=N'Copy Account after creation'		THEN N'Username(s) copy after creation'
						WHEN AreaNameJP=N'Choose first available username'	THEN N'Account naming convention?'
						WHEN AreaNameJP=N'Input Given Credit'				THEN N'Given Credit input'
				END
	,AreaNameKO = CASE	WHEN AreaNameKO=N'Select no.of accounts'			THEN N'Account quantity input'
						WHEN AreaNameKO=N'Copy Account after creation'		THEN N'Username(s) copy after creation'
						WHEN AreaNameKO=N'Choose first available username'	THEN N'Account naming convention?'
						WHEN AreaNameKO=N'Input Given Credit'				THEN N'Given Credit input'
				END
FROM Age_FeedbackArea fa WITH (ROWLOCK, UPDLOCK)
INNER JOIN Age_FeedbackFunc ff WITH (NOLOCK) ON ff.FuncID=fa.FuncID
WHERE FuncNameEN=N'Search & Copy (new version)'