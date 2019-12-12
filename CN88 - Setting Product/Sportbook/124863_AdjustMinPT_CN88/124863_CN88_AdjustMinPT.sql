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
		IF IncreaseS3 < 0 THEN m2 = @MinPT_New - s3 - a2
*/

USE CustDB
GO

DECLARE @MinPT_New TINYINT = 70
DECLARE @MinPT_XML XML

CREATE TABLE #SuperList (CustId INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, L4 TINYINT)
CREATE TABLE #MasterList (CustId INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, S3 INT, MaxM2A2 INT, MinM2A2 INT, MaxRangeS3 INT, IncreaseValue INT, IncreaseS3 INT, S3_New INT, SuperPT_XML XML)
CREATE TABLE #AgentList (CustId INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, M2_New INT, MasterPT_XML XML)

INSERT INTO #SuperList (CustId, sporttype, bettype, IsLive, L4)
SELECT c.custid, spt.sporttype, spt.bettype, spt.isLive, spt.MaxPT 
FROM vw_Customer c WITH (NOLOCK) 
	CROSS APPLY dbo.f_CS_GetPT_Agent(c.CustId) spt
WHERE c.roleid = 4 AND c.site = 'CN88'

INSERT INTO #MasterList (CustId, srecommend, sporttype, bettype, IsLive, S3, MaxM2A2, MinM2A2)
SELECT c.custid, c.srecommend, mpt.sporttype, mpt.bettype, mpt.isLive, mpt.SuperPT, MAX(apt.MasterPT+apt.AgentPT), MIN(apt.MasterPT+apt.AgentPT)
FROM vw_Customer c WITH (NOLOCK) 
	INNER JOIN vw_Customer a WITH (NOLOCK) ON a.mrecommend = c.custid
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

INSERT INTO #AgentList (CustId, sporttype, bettype, IsLive, M2_New)
SELECT a.custid, apt.sporttype, apt.bettype, apt.isLive,
	CASE	WHEN ml.IncreaseS3 > 0 AND IncreaseS3 > MaxRangeS3 THEN @MinPT_New - ml.S3_New - apt.AgentPT
			WHEN ml.IncreaseS3 < 0 THEN @MinPT_New - ml.S3 - apt.AgentPT END
FROM custinfo a
	CROSS APPLY dbo.f_CS_GetPT_Agent(a.CustId) apt
	INNER JOIN #MasterList ml ON ml.CustId = a.mrecommend AND apt.sporttype = ml.sporttype AND apt.bettype = ml.bettype AND apt.isLive = ml.IsLive
WHERE IncreaseValue > 0 AND
	((IncreaseS3 > 0 AND IncreaseS3 > MaxRangeS3) OR ml.IncreaseS3 < 0)


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

--UPDATE cs
--SET cs.MinPT = minpt.binaryStr_new
--FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK)
--	INNER JOIN #SuperList s ON s.CustId = cs.CustId
--	CROSS APPLY dbo.f_SetBinaryValues(cs.MinPT, @MinPT_XML) minpt

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

--UPDATE cs
--SET cs.SuperPT = spt.binaryStr_new
--FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK) 
--	INNER JOIN #MasterList ml ON ml.CustId = cs.CustId
--	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) spt

--UPDATE cs
--SET cs.SuperPT = mpt.binaryStr_new
--FROM dbo.CS_CustPTGroupSetting_Member cs WITH (ROWLOCK) 
--	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.AgentId
--	INNER JOIN #MasterList ml ON ml.CustId = ci.mrecommend
--	CROSS APPLY dbo.f_SetBinaryValues(cs.SuperPT, ml.SuperPT_XML) mpt
--WHERE ci.roleid = 2

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

--UPDATE cs
--SET cs.MasterPT = apt.binaryStr_new
--FROM dbo.CS_CustPTSetting_Agent cs WITH (ROWLOCK) 
--	INNER JOIN #AgentList al ON al.CustId = cs.CustId
--	CROSS APPLY dbo.f_SetBinaryValues(cs.MasterPT, al.MasterPT_XML) apt

--UPDATE cs
--SET cs.MasterPT = apt.binaryStr_new
--FROM dbo.CS_CustPTGroupSetting_Member cs WITH (ROWLOCK) 
--	INNER JOIN #AgentList al ON al.CustId = cs.AgentId
--	CROSS APPLY dbo.f_SetBinaryValues(cs.MasterPT, al.MasterPT_XML) apt
