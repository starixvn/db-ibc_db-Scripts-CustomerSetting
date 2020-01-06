
USE CustDB_20200101
GO

DECLARE @MinPT_New TINYINT = 70
DECLARE @MinPT_XML XML

CREATE TABLE #SuperList (CustId INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, L4 TINYINT)
CREATE TABLE #MasterList (CustId INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, S3 INT, MaxM2A2 INT, MinM2A2 INT, MaxRangeS3 INT, IncreaseValue INT, IncreaseS3 INT, S3_New INT, SuperPT_XML XML)
CREATE TABLE #AgentList (CustId INT, mrecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, A2 INT, M2 INT, M2_New INT, MasterPT_XML XML)

INSERT INTO #SuperList (CustId, sporttype, bettype, IsLive, L4)
SELECT c.custid, spt.sporttype, spt.bettype, spt.isLive, spt.MaxPT 
FROM vw_Customer c WITH (NOLOCK) 
	INNER JOIN dbo.CustSuper s WITH (NOLOCK) ON s.custid = c.custid
	CROSS APPLY dbo.f_CS_GetPT_Agent(c.CustId) spt
WHERE c.roleid = 4 AND c.site = 'CN88'
	AND c.currency <> 20
	AND s.IsInternal = 0

INSERT INTO #MasterList (CustId, srecommend, sporttype, bettype, IsLive, S3, MaxM2A2, MinM2A2)
SELECT c.custid, c.srecommend, mpt.sporttype, mpt.bettype, mpt.isLive, mpt.SuperPT, MAX(apt.MasterPT+apt.AgentPT), MIN(apt.MasterPT+apt.AgentPT)
FROM vw_Customer c WITH (NOLOCK) 
	INNER JOIN vw_Customer a WITH (NOLOCK) ON a.mrecommend = c.custid
	INNER JOIN #SuperList s WITH (NOLOCK) ON c.srecommend = s.custid
	CROSS APPLY dbo.f_CS_GetPT_Agent(c.CustId) mpt
	CROSS APPLY dbo.f_CS_GetPT_Agent(a.CustId) apt 
WHERE c.roleid = 3 AND a.roleid = 2 AND c.site = 'CN88'
	AND mpt.sporttype = apt.sporttype AND mpt.bettype = apt.bettype AND mpt.isLive = apt.isLive
GROUP BY c.custid, c.srecommend, mpt.sporttype, mpt.bettype, mpt.isLive, mpt.SuperPT

UPDATE ml 
SET MaxRangeS3 = sl.L4 - ml.S3 - MaxM2A2,
	IncreaseValue = @MinPT_New - ml.S3 - MinM2A2,
	IncreaseS3 = @MinPT_New - ml.S3 - MaxM2A2
FROM #MasterList ml
	INNER JOIN #SuperList sl ON sl.CustId = ml.srecommend AND sl.sporttype = ml.sporttype AND sl.bettype = ml.bettype AND sl.IsLive = ml.IsLive

UPDATE ml 
SET ml.S3_New = CASE	WHEN IncreaseValue > 0 AND IncreaseS3 > 0 AND IncreaseS3 <= MaxRangeS3 THEN S3 + ml.IncreaseS3
						WHEN IncreaseValue > 0 AND IncreaseS3 > 0 AND IncreaseS3 > MaxRangeS3 THEN S3 + ml.MaxRangeS3 ELSE ml.S3 END
FROM #MasterList ml

INSERT INTO #AgentList (CustId, mrecommend, sporttype, bettype, IsLive, A2, M2, M2_New)
SELECT a.custid, a.mrecommend, apt.sporttype, apt.bettype, apt.isLive, apt.AgentPT, apt.masterPT,
	CASE	WHEN ml.IncreaseS3 > 0 AND IncreaseS3 < IncreaseValue THEN @MinPT_New - ml.S3_New - apt.AgentPT
			WHEN ml.IncreaseS3 <= 0 AND apt.AgentPT + ml.S3_New < @MinPT_New THEN @MinPT_New - ml.S3 - apt.AgentPT END
FROM custinfo a
	CROSS APPLY dbo.f_CS_GetPT_Agent(a.CustId) apt
	INNER JOIN #MasterList ml ON ml.CustId = a.mrecommend AND apt.sporttype = ml.sporttype AND apt.bettype = ml.bettype AND apt.isLive = ml.IsLive
WHERE a.roleid = 2 AND
	IncreaseValue > 0 AND
	((IncreaseS3 > 0 AND IncreaseS3 < IncreaseValue) OR (ml.IncreaseS3 <= 0 AND apt.AgentPT + ml.S3_New < @MinPT_New))	

SELECT a.custid, ci.username, a.sporttype, a.bettype, a.IsLive, a.A2, a.M2, m.S3, a.M2_New, m.S3_New
FROM #AgentList a
	INNER JOIN #MasterList m ON a.mrecommend = m.custid
	INNER JOIN Custinfo ci ON a.custid = ci.custid
WHERE a.A2 + a.M2 + m.S3 > 70		

/*
DROP TABLE #SuperList
DROP TABLE #MasterList
DROP TABLE #AgentList
*/