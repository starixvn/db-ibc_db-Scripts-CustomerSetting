/*
	Created: Elodie
	Task: Correct Dangerous value 
	DB: DBLOG/bodb02
	Date: 20171208
*/ 
USE bodb02
GO

CREATE TABLE #RawDataHistory (RowNo INT, CustID INT, LogDate DATETIME, HistoryDate DATETIME)
CREATE TABLE #DataHistory (CustID INT, HistoryDate DATETIME, Danger TINYINT, Danger2 TINYINT, Danger3 TINYINT)
CREATE TABLE #ListUpdate (CustID INT, HistoryDate DATETIME)
CREATE TABLE #CustList (CustID INT PRIMARY KEY, LogDate DATETIME)
CREATE TABLE #RawCustList (CustID INT, LogDate DATETIME)
CREATE TABLE #TmpList (CustID INT, Danger TINYINT, Danger2 TINYINT, Danger3 TINYINT)

SELECT ci.custid, ci.roleid, u.logdate
INTO #RawDataLog
FROM custinfo ci WITH (NOLOCK)
	INNER JOIN DB052.bodb_CustomerLog.dbo.UserLog_RunSP u WITH (NOLOCK) ON ci.custid = u.custid
WHERE ci.currency <> 20 AND u.ActionID = 1165
	AND ci.custid NOT IN (1280,640041,753422,4230489,4396024,4488557,4706215,11405172,16698297,20617088,22867894,22867902,22867908,22868316,26521138,27058503,1981797)

SELECT custid, roleid, MIN(logdate) AS LogDate
INTO #ListUpline
FROM #RawDataLog r
GROUP BY custid, roleid

--Super
INSERT INTO #RawCustList (CustID, LogDate)
SELECT ci.custid, LogDate
FROM #ListUpline l 
	INNER JOIN CustInfo ci WITH (NOLOCK) ON l.custid = ci.srecommend
WHERE l.roleid = 4
UNION 
SELECT ci.custid, LogDate
FROM #ListUpline l 
	INNER JOIN CustInfo ci WITH (NOLOCK) ON l.custid = ci.mrecommend
WHERE l.roleid = 3
UNION 
SELECT ci.custid, LogDate
FROM #ListUpline l 
	INNER JOIN CustInfo ci WITH (NOLOCK) ON l.custid = ci.recommend
WHERE l.roleid = 2
UNION 
SELECT ci.custid, LogDate
FROM #ListUpline l 
	INNER JOIN CustInfo ci WITH (NOLOCK) ON l.custid = ci.custid
WHERE l.roleid = 1
UNION 
SELECT ci.custid, LogDate
FROM #ListUpline l 
	INNER JOIN CustInfo ci WITH (NOLOCK) ON l.custid = ci.custid
WHERE l.roleid > 4

INSERT INTO #CustList (CustID, LogDate)
SELECT l.custid, MIN(LogDate)
FROM #RawCustList l 
WHERE l.custid NOT IN (1280,640041,753422,4230489,4396024,4488557,4706215,11405172,16698297,20617088,22867894,22867902,22867908,22868316,26521138,27058503,1981797)
GROUP BY custid

INSERT INTO #RawDataHistory (RowNo, CustID, HistoryDate)
SELECT  ROW_NUMBER() OVER(PARTITION BY l.CustID ORDER BY ch.Updatetime ASC) AS RowNo, l.custid, ch.UpdateTime
FROM #CustList l 
	INNER JOIN bodb_CustHistory.dbo.CustInfo_History ch WITH (NOLOCK) ON l.custid = ch.custid AND l.LogDate < ch.Updatetime
WHERE ch.UpdateTime >= '2017-12-06 00:00:000' 

INSERT INTO #ListUpdate (CustID, HistoryDate)
SELECT h.CustID, h.HistoryDate
FROM #RawDataHistory h 
WHERE h.RowNo = 1

CREATE CLUSTERED INDEX CLX_ListUpdate ON #ListUpdate (HistoryDate, CustID)

INSERT INTO DataHistory_danielTmp (CustID, HistoryDate, Danger, Danger2, Danger3)
SELECT h.CustID, h.HistoryDate, ch.Danger, ch.Danger2, ch.Danger3
FROM #ListUpdate h 
	INNER JOIN bodb_CustHistory.dbo.CustInfo_History ch WITH (NOLOCK) ON h.custid = ch.custid AND h.HistoryDate = ch.Updatetime

WHILE (1=1)
BEGIN
	INSERT INTO #TmpList (CustID, Danger, Danger2, Danger3)
	SELECT TOP 5000 CustID, Danger, Danger2, Danger3
	FROM #DataHistory

	IF @@ROWCOUNT = 0
		BREAK

	UPDATE c
	SET c.danger = tmp.Danger,
		c.danger2 = tmp.Danger2,
		c.danger3 = tmp.Danger3
	FROM dbo.custInfo c WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #TmpList tmp ON c.custid = tmp.CustID

	DELETE h
	FROM #DataHistory h
		INNER JOIN #TmpList tmp ON tmp.CustID = h.CustID
	
	DELETE FROM #TmpList

	WAITFOR DELAY '00:00:0.300'
END