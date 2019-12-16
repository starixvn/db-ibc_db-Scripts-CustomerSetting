/*
	Created by: Elodie
	Date: 20191206
	Task: Adjust MinPT for CN88
	DB: DBCUST/CustDB

	MaxRangeS3 = l4 - s3 - MAX(m2+a2)
	IncreaseValue = @MinPT_New - s3 - MIN(m2+a2)
	IncreaseS3 = @MinPT_New - s3 - MAX(m2+a2)

	IF IncreaseValue > 0
		IF IncreaseS3 > 0
			IF IncreaseS3 <= MaxRangeS3 THEN s3 = s3 + IncreaseS3
			IF IncreaseS3 > MaxRangeS3 THEN s3 = s3 + MaxRangeS3, m2 = @MinPT_New - s3_new - a2
		IF IncreaseS3 <= 0 AND a2 + s3 < @MinPT_New THEN m2 = @MinPT_New - s3 - a2
*/
USE CustDB
GO

DECLARE @MinPT_New TINYINT = 70
DECLARE @MinPT_XML XML

CREATE TABLE #SuperList (CustId INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, L4 TINYINT)
CREATE TABLE #MasterList (CustId INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, S3 INT, MaxM2A2 INT, MinM2A2 INT, MaxRangeS3 INT, IncreaseValue INT, IncreaseS3 INT, S3_New INT, SuperPT_XML XML)
CREATE TABLE #AgentList (CustId INT, mrecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, A2 INT, M2_New INT, MasterPT_XML XML)

INSERT INTO #SuperList (CustId, sporttype, bettype, IsLive, L4)
SELECT c.custid, spt.sporttype, spt.bettype, spt.isLive, spt.MaxPT 
FROM vw_Customer c WITH (NOLOCK) 
	CROSS APPLY dbo.f_CS_GetPT_Agent(c.CustId) spt
WHERE c.roleid = 4 AND c.site = 'CN88'
	AND c.currency <> 20
	AND c.custid NOT IN (37639148,37639260,37639305)

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

INSERT INTO #AgentList (CustId, mrecommend, sporttype, bettype, IsLive, A2, M2_New)
SELECT a.custid, a.mrecommend, apt.sporttype, apt.bettype, apt.isLive, apt.AgentPT,
	CASE	WHEN ml.IncreaseS3 > 0 AND IncreaseS3 < IncreaseValue THEN @MinPT_New - ml.S3_New - apt.AgentPT
			WHEN ml.IncreaseS3 <= 0 AND apt.AgentPT + ml.S3_New < @MinPT_New THEN @MinPT_New - ml.S3 - apt.AgentPT END
FROM custinfo a
	CROSS APPLY dbo.f_CS_GetPT_Agent(a.CustId) apt
	INNER JOIN #MasterList ml ON ml.CustId = a.mrecommend AND apt.sporttype = ml.sporttype AND apt.bettype = ml.bettype AND apt.isLive = ml.IsLive
WHERE a.roleid = 2 AND
	IncreaseValue > 0 AND
	((IncreaseS3 > 0 AND IncreaseS3 < IncreaseValue) OR (ml.IncreaseS3 <= 0 AND apt.AgentPT + ml.S3_New < @MinPT_New))	

SET @MinPT_XML =(
				SELECT (
						SELECT	bs.ByteOrder	AS '@pos',
								@MinPT_New		AS '@val'
						FROM dbo.CS_ByteSeq bs WITH (NOLOCK)
						WHERE bs.Type = 'PTSetting' 
						FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
				)

UPDATE ml 
SET ml.SuperPT_XML = (
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ml.S3_New		AS '@val'
								FROM dbo.CS_ByteSeq bs WITH (NOLOCK)
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = ml.sporttype AND bs.BetType = ml.BetType AND bs.IsLive = ml.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)
FROM #MasterList ml

UPDATE al 
SET al.MasterPT_XML = (
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										al.M2_New		AS '@val'
								FROM dbo.CS_ByteSeq bs WITH (NOLOCK)
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = al.sporttype AND bs.BetType = al.BetType AND bs.IsLive = al.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)
FROM #AgentList al

SELECT * FROM #SuperList --WHERE custid = 35555477
SELECT * FROM #MasterList --WHERE srecommend = 35555477
SELECT * FROM #AgentList --WHERE mrecommend = 35555506

------------------UPDATE-------------------------------------------------------------------
--Update MinPT of Super
UPDATE cs
SET cs.MinPT = minpt.binaryStr_new,
	cs.MinPT2 = minpt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK)
	INNER JOIN #SuperList s ON s.CustId = cs.CustId
	CROSS APPLY dbo.f_SetBinaryValues(cs.MinPT, @MinPT_XML) minpt

--Update s3 of Master
UPDATE cs
SET cs.SuperPT = spt.binaryStr_new,
	cs.SuperPT2 = spt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK) 
	INNER JOIN #MasterList ml ON ml.CustId = cs.CustId
	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) spt
WHERE ml.sporttype = 1 AND ml.bettype = 1

UPDATE cs
SET cs.SuperPT = spt.binaryStr_new,
	cs.SuperPT2 = spt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK) 
	INNER JOIN #MasterList ml ON ml.CustId = cs.CustId
	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) spt
WHERE ml.sporttype = 9998 AND ml.bettype = 81

--Update s3 of Member
UPDATE cs
SET cs.SuperPT = mpt.binaryStr_new,
	cs.SuperPT2 = mpt.binaryStr_new
FROM dbo.CS_CustPTGroupSetting_Member cs WITH (ROWLOCK) 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.AgentId
	INNER JOIN #MasterList ml ON ml.CustId = ci.mrecommend
	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) mpt
WHERE ci.roleid = 2
	AND ml.sporttype = 1 AND ml.bettype = 1

UPDATE cs
SET cs.SuperPT = mpt.binaryStr_new,
	cs.SuperPT2 = mpt.binaryStr_new
FROM dbo.CS_CustPTGroupSetting_Member cs WITH (ROWLOCK) 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.AgentId
	INNER JOIN #MasterList ml ON ml.CustId = ci.mrecommend
	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) mpt
WHERE ci.roleid = 2
	AND ml.sporttype = 9998 AND ml.bettype = 81

--Update m2 of Agent
UPDATE cs
SET cs.MasterPT = apt.binaryStr_new,
	cs.MasterPT2 = apt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK) 
	INNER JOIN #AgentList al ON al.CustId = cs.CustId
	CROSS APPLY dbo.f_SetBinaryValues(cs.MasterPT, al.MasterPT_XML) apt
WHERE al.sporttype = 1 AND al.bettype = 1

UPDATE cs
SET cs.MasterPT = apt.binaryStr_new,
	cs.MasterPT2 = apt.binaryStr_new
FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK) 
	INNER JOIN #AgentList al ON al.CustId = cs.CustId
	CROSS APPLY dbo.f_SetBinaryValues(cs.MasterPT, al.MasterPT_XML) apt
WHERE al.sporttype = 9998 AND al.bettype = 81

--Update m2 of Member
UPDATE cs
SET cs.MasterPT = apt.binaryStr_new,
	cs.MasterPT2 = apt.binaryStr_new
FROM dbo.CS_CustPTGroupSetting_Member cs WITH (ROWLOCK) 
	INNER JOIN #AgentList al ON al.CustId = cs.AgentId
	CROSS APPLY dbo.f_SetBinaryValues(cs.MasterPT, al.MasterPT_XML) apt
WHERE al.sporttype = 1 AND al.bettype = 1

UPDATE cs
SET cs.MasterPT = apt.binaryStr_new,
	cs.MasterPT2 = apt.binaryStr_new
FROM dbo.CS_CustPTGroupSetting_Member cs WITH (ROWLOCK) 
	INNER JOIN #AgentList al ON al.CustId = cs.AgentId
	CROSS APPLY dbo.f_SetBinaryValues(cs.MasterPT, al.MasterPT_XML) apt
WHERE al.sporttype = 9998 AND al.bettype = 81

DROP TABLE #SuperList
DROP TABLE #MasterList
DROP TABLE #AgentList
