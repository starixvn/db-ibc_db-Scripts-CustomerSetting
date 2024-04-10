/*<info serverAlias="DBAGE-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240221
	Task:  Alpha - Automate Transfer Enhancement Phase 3 [Redmine: #199951]
	DB: DBAGE/bodb_ChatBot
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
	WHERE FunctionID = 22)
AND 1 = CASE WHEN a.SubAccId = 0 THEN 1
			WHEN CHARINDEX('C',pageAccess) > 0 THEN 1
		ELSE 0 END

CREATE TABLE #batchUpd(UserID INT)

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #batchUpd

	DELETE TOP (5000) t
	OUTPUT deleted.UserID INTO #batchUpd(UserID)
	FROM #tmpUser t

	IF @@ROWCOUNT = 0
		BREAK

	INSERT INTO CustBotFunction(UserID, FunctionID, Status)
	SELECT UserID, 22 AS FunctionID, 1 AS Status 
	FROM #batchUpd
END

DROP TABLE #tmpUser, #batchUpd