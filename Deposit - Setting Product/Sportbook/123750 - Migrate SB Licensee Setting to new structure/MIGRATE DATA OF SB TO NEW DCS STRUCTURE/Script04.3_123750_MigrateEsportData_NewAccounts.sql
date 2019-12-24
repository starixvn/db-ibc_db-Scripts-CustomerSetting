/*
	Created: Eden
	Date: 20191029
	Task: Migrate data of Sport Book 2 to New tables - New accounts [RM:#123750]
	DB: DBCust/CustDB
*/
DECLARE @max_custid INT = xxx

CREATE TABLE #MemberTemp(
	CustID INT PRIMARY KEY CLUSTERED
	,recommend INT
)
CREATE TABLE #SMATemp(
	CustID INT PRIMARY KEY CLUSTERED
	,roleid TINYINT
)

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1
	AND c.currency NOT IN (20,72,27,28,17,21,31,36,37,40,44,46,50,62,63,65,68,73)

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 AND username LIKE '%Acc%'

INSERT INTO #MemberTemp (CustID,recommend)
SELECT custid,recommend
FROM Custinfo WITH (NOLOCK)
WHERE roleid = 1  AND Enabled = 1 AND custid > @max_custid
	AND srecommend IN (SELECT custid FROM #supers)
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)


	
INSERT INTO #SMATemp (CustID,roleid)
SELECT custid,roleid
FROM Custinfo WITH (NOLOCK)
WHERE roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid
	AND srecommend IN (SELECT custid FROM #supers)
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

------------------------------------Bet Setting-------------------------------------------------	
INSERT INTO DSB_CustBetSetting_Agent(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
)
SELECT a.CustID
	,a.SportType
	,a.BetType
	,a.MinBet
	,a.MaxBet
	,a.MaxPerMatch
FROM Dep_CustBetSetting_Agent a WITH(NOLOCK)
	INNER JOIN #SMATemp c ON a.custid = c.custid
WHERE a.SportType = 43 


INSERT INTO DSB_CustBetSetting_Member(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
)
SELECT a.CustID
	,a.SportType
	,a.BetType
	,a.MinBet
	,a.MaxBet
	,a.MaxPerMatch
FROM Dep_CustBetSetting_Member a WITH(NOLOCK)
	INNER JOIN #MemberTemp c ON a.custid = c.custid
WHERE a.SportType = 43

------------------------------------PT Setting-------------------------------------------------	
;WITH tmp AS (
	SELECT  dc.CustID,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.AgentPT
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						) as apositiontakingXML,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.MasterPT
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)  as mpositiontakingXML,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.SuperPT
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)  as spositiontakingXML
	FROM Dep_CustPTSetting_Agent dc WITH(NOLOCK) 
		INNER JOIN #SMATemp c ON dc.custid = c.custid
	WHERE  SportType = 43 and bettype = 1 and islive =0 
)
UPDATE a
SET	a.AgentPT = aPT.binaryStr_new,
	a.MasterPT = mPT.binaryStr_new,
	a.SuperPT = sPT.binaryStr_new 
FROM Tmp dc  
	INNER JOIN DSB_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK) ON a.CustId = dc.CustID
	CROSS APPLY dbo.f_SetBinaryValues(a.AgentPT, dc.apositiontakingXML) aPT
	CROSS APPLY dbo.f_SetBinaryValues(a.MasterPT, dc.mpositiontakingXML) mPT
	CROSS APPLY dbo.f_SetBinaryValues(a.SuperPT, dc.spositiontakingXML) sPT
	
;WITH tmp AS (
	SELECT  dc.CustID,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.AgentPT
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						) as apositiontakingXML,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.MasterPT
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)  as mpositiontakingXML,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.SuperPT
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)  as spositiontakingXML
	FROM Dep_CustPTSetting_Member dc WITH(NOLOCK) 
		INNER JOIN #MemberTemp c ON dc.custid = c.custid
	WHERE  SportType = 43 and bettype = 1 and islive =0 
)
UPDATE a
SET	a.AgentPT = aPT.binaryStr_new,
	a.MasterPT = mPT.binaryStr_new,
	a.SuperPT = sPT.binaryStr_new 
FROM Tmp dc  
	INNER JOIN DSB_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK) ON a.CustId = dc.CustID  
	CROSS APPLY dbo.f_SetBinaryValues(a.AgentPT, dc.apositiontakingXML) aPT
	CROSS APPLY dbo.f_SetBinaryValues(a.MasterPT, dc.mpositiontakingXML) mPT
	CROSS APPLY dbo.f_SetBinaryValues(a.SuperPT, dc.spositiontakingXML) sPT
	
;WITH tmp AS (
	SELECT  c.CustID,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.AgentPT
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						) as apositiontakingXML,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.MasterPT
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)  as mpositiontakingXML,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.SuperPT
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)  as spositiontakingXML
	FROM Dep_CustPTGroupSetting_Member dc WITH(NOLOCK) 
		INNER JOIN #MemberTemp c ON dc.AgentID = c.recommend
		INNER JOIN Dep_CustSettingMode ds WITH(NOLOCK)  ON ds.CustID = c.CustID AND ds.IsGroupedPT = 1
	WHERE  SportType = 43 and bettype = 1 and islive =0 
)
UPDATE a
SET	a.AgentPT = aPT.binaryStr_new,
	a.MasterPT = mPT.binaryStr_new,
	a.SuperPT = sPT.binaryStr_new 
FROM Tmp dc  
	INNER JOIN DSB_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK) ON a.CustId = dc.CustID  
	CROSS APPLY dbo.f_SetBinaryValues(a.AgentPT, dc.apositiontakingXML) aPT
	CROSS APPLY dbo.f_SetBinaryValues(a.MasterPT, dc.mpositiontakingXML) mPT
	CROSS APPLY dbo.f_SetBinaryValues(a.SuperPT, dc.spositiontakingXML) sPT

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #Dummy
DROP TABLE #supers