/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/

/*
	Created: 20241113@Virgil
	Task: Alpha - Initial data Offer Last Bets function for Super/Master [RedmineId : #213315]
	DB: DBBOT-bodb_ChatBot
*/

USE [bodb_ChatBot]
GO

CREATE TABLE #tmpUser(UserID INT)

INSERT INTO #tmpUser(UserID)
SELECT DISTINCT c.UserID
FROM CustBotFunction c WITH (NOLOCK)	
INNER JOIN CustBotAccount a WITH (NOLOCK) 
	ON c.UserID = a.UserId
INNER JOIN bodb02.dbo.Customer b WITH (NOLOCK) 
	ON a.CustId = b.custid
LEFT JOIN bodb02.dbo.custSub s WITH (NOLOCK) 
	ON a.SubAccId = s.subaccid
WHERE c.UserID NOT IN (
		SELECT UserID
		FROM CustBotFunction WITH (NOLOCK)
		WHERE FunctionID = 23
	)
	AND CustomerLevel IN (3,4)
	AND b.currency = 20	
	AND	1 = CASE WHEN a.SubAccId = 0 THEN 1
				WHEN CHARINDEX('L',pageAccess) > 0 THEN 1
			ELSE 0 END

SELECT * FROM #tmpUser

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
	SELECT UserID, 23 AS FunctionID, 1 AS Status 
	FROM #batchUpd
END

DROP TABLE #tmpUser , #batchUpd