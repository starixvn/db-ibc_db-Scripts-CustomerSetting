/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@2021123
	Task: init data for column OverrideASLive, OverrideASNonLive [RM#164888]
	DB: DBCust/CustDB
*/
USE CustDB
GO

CREATE TABLE #tempCust(CustID INT, Sporttype SMALLINT)
CREATE TABLE #tempCust_batch(CustID INT, Sporttype SMALLINT)

INSERT INTO #tempCust(CustID,Sporttype)
SELECT CustID,SportType
FROM CustSettingAutoSuspend WITH(NOLOCK)
WHERE OverrideASLive IS NULL 
	OR OverrideASNonLive IS NULL

WHILE 1= 1
BEGIN
	TRUNCATE TABLE #tempCust_batch

	DELETE TOP (5000) t
	OUTPUT deleted.CustID, deleted.Sporttype INTO #tempCust_batch(CustID,Sporttype)
	FROM #tempCust t

	IF @@ROWCOUNT = 0 
		BREAK

	UPDATE c
	SET c.OverrideASLive = ISNULL(OverrideASLive,0x000000000000000000000000000000000000000000000000000000000000),
		c.OverrideASNonLive = ISNULL(OverrideASNonLive,0x000000000000000000000000000000000000000000000000000000000000)
	FROM CustSettingAutoSuspend c WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tempCust_batch t 
			ON c.CustID = t.CustID 
			AND c.SportType = t.Sporttype
END

DROP TABLE #tempCust
DROP TABLE #tempCust_batch