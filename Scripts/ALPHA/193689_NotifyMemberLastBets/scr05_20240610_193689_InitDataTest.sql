/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240610
	Task:  Telegram Chatbot - Notify Member Last bets [Redmine: #193689]
	DB: DBBOT/bodb_ChatBot
*/
CREATE TABLE #tmpUser(UserID INT)

INSERT INTO #tmpUser(UserID)
SELECT DISTINCT c.UserID
FROM CustBotFunction c WITH (NOLOCK)	
	INNER JOIN  CustBotAccount a with (NOLOCK) on c.UserID = a.UserId
	LEFT JOIN bodb02.dbo.custSub s WITH (NOLOCK) ON a.SubAccId = s.subaccid
WHERE c.UserID NOT IN(
	SELECT UserID
	FROM CustBotFunction WITH (NOLOCK)
	WHERE FunctionID = 23)
AND 1 = CASE WHEN a.SubAccId = 0 THEN 1
			WHEN CHARINDEX('L',pageAccess) > 0 AND s.username = 'SUPERTESTTE010M00Sub01' THEN 1
		ELSE 0 END
AND a.CustId IN (
	SELECT custid 
	FROM bodb02.dbo.Customer (NOLOCK)
	WHERE username = 'SUPERTESTTE010M00'
)

INSERT INTO CustBotFunction(UserID, FunctionID, Status)
SELECT UserID, 23 AS FunctionID, 1 AS Status 
FROM #tmpUser

DROP TABLE #tmpUser