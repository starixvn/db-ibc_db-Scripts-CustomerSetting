/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250908@Dave
	Task: NAP,Alpha | Update setting Winlost Limit of Super, the setting of direct member of Master is not affected. [RedmineID: #238094]
	DB: DBCUST-CustDB
*/
USE CustDB;

SELECT * FROM CustWinLossLimit_Member WITH (NOLOCK)
WHERE CustId IN (256193458, 256194534, 256195043, 256195106, 256196914, 256197484);

WITH TMP_lstType AS(
	SELECT 9906 AS SportType, 4001 AS BetType
	UNION ALL SELECT 9908, 1201
	UNION ALL SELECT 9909, 3700
	UNION ALL SELECT 9911, 2400
	UNION ALL SELECT 9918, 4601
)
UPDATE TMP_M
SET
	TMP_M.MaxWinLimit = TMP_A.MaxWinLimit,
	TMP_M.RepUpdateTime = dbo.f_GetDateTime2()
FROM CustWinLossLimit_Agent AS TMP_A WITH (NOLOCK) 
	INNER JOIN TMP_lstType AS TMP_F
		ON TMP_A.BetType = TMP_F.BetType
		AND TMP_A.SportType = TMP_F.SportType
	INNER JOIN CustWinLossLimit_Member AS TMP_M WITH (ROWLOCK, UPDLOCK)
		ON TMP_A.BetType = TMP_M.BetType
		AND TMP_A.SportType = TMP_M.SportType
WHERE TMP_A.CustId = 256006365
AND TMP_M.CustId IN (256193458, 256194534, 256195043, 256195106, 256196914, 256197484)
AND TMP_A.MaxWinLimit <> TMP_M.MaxWinLimit;


SELECT * FROM CustWinLossLimit_Member WITH (NOLOCK)
WHERE CustId IN (256193458, 256194534, 256195043, 256195106, 256196914, 256197484);

