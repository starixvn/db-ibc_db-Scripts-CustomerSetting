/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240723
	Task:  Adjust data Last Bets function for test acc [Redmine: #193689]
	DB: DBBOT/bodb_ChatBot
*/

DELETE f
FROM dbo.CustBotFunction f WITH (ROWLOCK)
WHERE f.FunctionID = 23
	AND f.UserID IN (400, 3201)
