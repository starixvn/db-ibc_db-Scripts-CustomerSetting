/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250919@Dave
	Task: NAP,Alpha | Update setting Winlost Limit of Super, the setting of direct member of Master is not affected. [RedmineID: #238094]
	DB: DBCUST-CustDB
*/
USE CustDB;

SELECT * FROM CustWinLossLimit_Member WITH (NOLOCK)
WHERE CustId IN (259632327,259633104,259634530,260001405);


UPDATE TMP_M
SET
	TMP_M.MaxWinLimit = TMP_A.MaxWinLimit,
	TMP_M.RepUpdateTime = dbo.f_GetDateTime2()
FROM CustWinLossLimit_Agent AS TMP_A WITH (NOLOCK) 
	INNER JOIN CustWinLossLimit_Member AS TMP_M WITH (ROWLOCK, UPDLOCK)
		ON TMP_A.BetType = TMP_M.BetType
		AND TMP_A.SportType = TMP_M.SportType
WHERE TMP_A.CustId = 259629036
AND TMP_M.CustId IN (259632327,259633104,259634530,260001405)
AND TMP_A.SportType = 9918
AND TMP_A.BetType = 4601
AND TMP_A.MaxWinLimit <> TMP_M.MaxWinLimit;


SELECT * FROM CustWinLossLimit_Member WITH (NOLOCK)
WHERE CustId IN (259632327,259633104,259634530,260001405);

