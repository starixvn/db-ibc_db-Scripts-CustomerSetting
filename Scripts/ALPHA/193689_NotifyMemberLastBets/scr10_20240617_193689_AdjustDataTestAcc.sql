/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240617
	Task:  Adjust data Last Bets function for test acc [Redmine: #193689]
	DB: DBBOT/bodb_ChatBot
*/

CREATE TABLE #tmpCust (CustID INT, SubAccID INT)
INSERT INTO #tmpCust (CustID, SubAccID)
	SELECT custid, 0 AS SubAccID
	FROM bodb02.dbo.Customer c WITH (NOLOCK) 
	WHERE username IN ('SupertestTE1001', 'SupertestTE02', 'SupertestTE01')
UNION ALL
	SELECT custid, subaccid
	FROM bodb02.dbo.custSub s WITH (NOLOCK)
	WHERE username = 'SUPERTESTTE02Sub02'

DELETE f
FROM dbo.CustBotFunction f WITH (ROWLOCK)
	INNER JOIN dbo.CustBotAccount a WITH (NOLOCK) ON f.UserID = a.UserId
	INNER JOIN #tmpCust t ON a.CustId = t.CustID AND a.SubAccId = t.SubAccID
WHERE f.FunctionID = 23
