/*
	Created: Eden
	Date: 20191029
	Task: Migrate data of Sport Book and Sport Book 2 (Esport) to New tables - New accounts [RM:#123750]
	DB: DBCust/CustDB
*/
DECLARE @max_custid INT = xxx

DELETE a
FROM DSB_CustBetSetting_Agent a WITH(ROWLOCK,UPDLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.CustID > @max_custid

DELETE a
FROM DSB_CustBetSetting_Member a WITH(ROWLOCK,UPDLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.CustID > @max_custid

DELETE a
FROM DSB_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.CustID > @max_custid
  
DELETE a
FROM DSB_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.CustID > @max_custid
 
DELETE a
FROM DSB_CustDiscount_Agent a WITH(ROWLOCK,UPDLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.CustID > @max_custid  
 
DELETE a
FROM DSB_CustDiscount_Member a WITH(ROWLOCK,UPDLOCK) 
INNER JOIN custinfo c WITH(NOLOCK) ON a.CustID = c.custid AND c.currency <> 20
WHERE a.CustID > @max_custid  

-------------------------------------------------------------

CREATE TABLE #MemberTemp(
		CustID INT PRIMARY KEY CLUSTERED
	,maxpermatch	money
	,maxpermatch2	money
	,maxpermatch3	money
	,maxpermatch5	money
	,maxpermatch8	money
	,maxpermatch10	money
	,maxpermatch11	money
	,maxpermatch99	money
	,MaxPerMatch99MP money
)
CREATE TABLE #SMATemp(
		CustID INT PRIMARY KEY CLUSTERED
	,roleid TINYINT
	,maxpermatch	money
	,maxpermatch2	money
	,maxpermatch3	money
	,maxpermatch5	money
	,maxpermatch8	money
	,maxpermatch10	money
	,maxpermatch11	money
	,maxpermatch99	money
	,MaxPerMatch99MP money
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

INSERT INTO #MemberTemp (
		CustID
	,maxpermatch	
	,maxpermatch2	
	,maxpermatch3	
	,maxpermatch5	
	,maxpermatch8	
	,maxpermatch10	
	,maxpermatch11	
	,maxpermatch99	
	,MaxPerMatch99MP
	)
SELECT custid
	,maxpermatch	
	,maxpermatch2	
	,maxpermatch3	
	,maxpermatch5	
	,maxpermatch8	
	,maxpermatch10	
	,maxpermatch11	
	,maxpermatch99	
	,MaxPerMatch99MP
FROM Custinfo WITH (NOLOCK)
WHERE roleid = 1  AND Enabled = 1 AND custid > @max_custid
	AND srecommend IN (SELECT custid FROM #supers)
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	
INSERT INTO #SMATemp (
		CustID
	,roleid
	,maxpermatch	
	,maxpermatch2	
	,maxpermatch3	
	,maxpermatch5	
	,maxpermatch8	
	,maxpermatch10	
	,maxpermatch11	
	,maxpermatch99	
	,MaxPerMatch99MP
	)
SELECT custid
	,roleid
	,maxpermatch	
	,maxpermatch2	
	,maxpermatch3	
	,maxpermatch5	
	,maxpermatch8	
	,maxpermatch10	
	,maxpermatch11	
	,maxpermatch99	
	,MaxPerMatch99MP
FROM Custinfo WITH (NOLOCK)
WHERE roleid IN (2,3,4) AND Enabled = 1 AND custid > @max_custid
	AND srecommend IN (SELECT custid FROM #supers)
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

------------------------------------Bet Setting-------------------------------------------------
--SportBook	
INSERT INTO DSB_CustBetSetting_Agent(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
)
SELECT a.custid
		,a.sporttype
		,a.bettype
		,a.minbet
		,a.maxbet
		,case when a.sporttype = 1 then c.maxpermatch
			when a.sporttype = 2 then c.maxpermatch2
			when a.sporttype = 3 then c.maxpermatch3
			when a.sporttype = 5 then c.maxpermatch5
			when a.sporttype = 8 then c.maxpermatch8
			when a.sporttype = 10 then c.maxpermatch10
			when a.sporttype = 11 then c.maxpermatch11
			when a.sporttype = 99 and bettype = 1 then c.maxpermatch99
			when a.sporttype = 99 and bettype = 9 then c.MaxPerMatch99MP
		end AS maxpermatch
FROM Dep_CustSetting a WITH(NOLOCK) 
		INNER JOIN #SMATemp c ON a.custid = c.custid AND c.roleid IN (2,3,4)
WHERE SportType IN (1,2,3,5,8,10,11,99) and bettype = 1 and islive = 0
UNION ALL
SELECT a.custid
		,a.sporttype
		,a.bettype
		,a.minbet
		,a.maxbet
		,c.MaxPerMatch99MP
FROM Dep_CustSetting a WITH(NOLOCK) 
	INNER JOIN #SMATemp c ON a.custid = c.custid AND c.roleid IN (2,3,4)
WHERE SportType = 99 and bettype = 9 

INSERT INTO DSB_CustBetSetting_Member(
		CustID
	,SportType
	,BetType
	,MinBet
	,MaxBet
	,MaxPerMatch
)
SELECT a.custid
		,a.sporttype
		,a.bettype
		,a.minbet
		,a.maxbet
		,case when a.sporttype = 1 then c.maxpermatch
			when a.sporttype = 2 then c.maxpermatch2
			when a.sporttype = 3 then c.maxpermatch3
			when a.sporttype = 5 then c.maxpermatch5
			when a.sporttype = 8 then c.maxpermatch8
			when a.sporttype = 10 then c.maxpermatch10
			when a.sporttype = 11 then c.maxpermatch11
			when a.sporttype = 99 and bettype = 1 then c.maxpermatch99
			when a.sporttype = 99 and bettype = 9 then c.MaxPerMatch99MP
		end AS maxpermatch
FROM Dep_CustSetting a WITH(NOLOCK) 
	INNER JOIN #MemberTemp c ON a.custid = c.custid
WHERE SportType IN (1,2,3,5,8,10,11,99) and bettype = 1 and islive = 0
UNION ALL
SELECT a.custid
		,a.sporttype
		,a.bettype
		,a.minbet
		,a.maxbet
		,c.MaxPerMatch99MP
FROM Dep_CustSetting a WITH(NOLOCK) 
	INNER JOIN #MemberTemp c ON a.custid = c.custid
WHERE SportType = 99 and bettype = 9 

--Esport
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
DECLARE @InitialBinaryStr binary(30) =  0x00

;WITH tmp AS (
	SELECT  dc.CustID,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value = dc.apositiontaking
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
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value = dc.mpositiontaking
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
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value = dc.spositiontaking
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)  as spositiontakingXML
	FROM Dep_CustSetting dc WITH(NOLOCK) 
		INNER JOIN #SMATemp c ON dc.custid = c.custid
	WHERE  SportType = 1 and bettype = 1 and islive =0 
)
INSERT INTO DSB_CustPTSetting_Agent (CustID,AgentPT,MasterPT,SuperPT)
SELECT  dc.CustID,
		aPT.binaryStr_new as AgentPT,
		mPT.binaryStr_new as MasterPT,
		sPT.binaryStr_new as SuperPT
FROM Tmp dc  
	CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.apositiontakingXML) aPT
	CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.mpositiontakingXML) mPT
	CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.spositiontakingXML) sPT
	
;WITH tmp AS (
	SELECT  dc.CustID,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value = dc.apositiontaking
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
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value = dc.mpositiontaking
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
									LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value = dc.spositiontaking
								WHERE bs.Type = 'PTSetting' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						)  as spositiontakingXML
	FROM Dep_CustSetting dc WITH(NOLOCK) 
		INNER JOIN #MemberTemp c ON dc.custid = c.custid
	WHERE  SportType = 1 and bettype = 1 and islive =0 
)
INSERT INTO DSB_CustPTSetting_Member (CustID,AgentPT,MasterPT,SuperPT)
SELECT  dc.CustID,
		aPT.binaryStr_new as AgentPT,
		mPT.binaryStr_new as MasterPT,
		sPT.binaryStr_new as SuperPT
FROM Tmp dc  
	CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.apositiontakingXML) aPT
	CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.mpositiontakingXML) mPT
	CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.spositiontakingXML) sPT

------------------------------------Commisson Setting-------------------------------------------------	
;WITH tmp AS (
	SELECT dc.CustID,dc.SportType,dc.bettype,dc.islive,
			CASE WHEN c.roleid = 2 THEN dc.discount
				WHEN c.roleid = 3 THEN dc.adiscount
				WHEN c.roleid = 4 THEN dc.sdiscount END AS discount
	FROM Dep_CustSetting dc WITH(NOLOCK) 
		INNER JOIN #SMATemp c ON dc.custid = c.custid
	WHERE  SportType = 1 and bettype = 1 and islive =0 
)
,tmp1 AS (
	SELECT  dc.CustID,
				(
						SELECT (
								SELECT	bs.ByteOrder	AS '@pos',
										ct.ValueId AS '@val'
								FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.discount
								WHERE bs.Type = 'DiscountAgent' 
									AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								FOR XML PATH('r')
									, TYPE
								)
						FOR XML PATH('root')
							, TYPE
						) as discountXML
	FROM tmp dc
)
INSERT INTO DSB_CustDiscount_Agent (CustID,Discount)
SELECT  dc.CustID,dis.binaryStr_new AS Discount
FROM Tmp1 dc  
	CROSS APPLY dbo.f_SetBinaryValues_2bytes(@InitialBinaryStr, dc.discountXML) dis

;WITH tmp AS (
	SELECT  c.CustID,
				(
				SELECT (
						SELECT	bs.ByteOrder	AS '@pos',
								ct.ValueId AS '@val'
						FROM Dep_CustSetting dc WITH(NOLOCK) 
							INNER JOIN dbo.DSB_ByteSeq bs WITH (NOLOCK) ON bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
							LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.playerdiscount
						WHERE bs.Type = 'DiscountMember' 
							AND  dc.SportType = 1 AND dc.bettype IN (1,4,5,9) AND dc.islive = 0 
							AND  dc.custid = c.custid
						FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
			) as pdiscountXML,
			(
				SELECT (
						SELECT	bs.ByteOrder	AS '@pos',
								ct.ValueId AS '@val'
						FROM Dep_CustSetting dc WITH(NOLOCK) 
							INNER JOIN dbo.DSB_ByteSeq bs WITH (NOLOCK) ON bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
							LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.discount
						WHERE bs.Type = 'DiscountMember' 
							AND  dc.SportType = 1 AND dc.bettype IN (1,4,5,9) AND dc.islive = 0 
							AND  dc.custid = c.custid
						FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
			) as adiscountXML,
			(
				SELECT (
						SELECT	bs.ByteOrder	AS '@pos',
								ct.ValueId AS '@val'
						FROM Dep_CustSetting dc WITH(NOLOCK) 
							INNER JOIN dbo.DSB_ByteSeq bs WITH (NOLOCK) ON bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
							LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.adiscount
						WHERE bs.Type = 'DiscountMember' 
							AND  dc.SportType = 1 AND dc.bettype IN (1,4,5,9) AND dc.islive = 0 
							AND  dc.custid = c.custid
						FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
			) as mdiscountXML,
			(
				SELECT (
						SELECT	bs.ByteOrder	AS '@pos',
								ct.ValueId AS '@val'
						FROM Dep_CustSetting dc WITH(NOLOCK) 
							INNER JOIN dbo.DSB_ByteSeq bs WITH (NOLOCK) ON bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
							LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.sdiscount
						WHERE bs.Type = 'DiscountMember' 
							AND  dc.SportType = 1 AND dc.bettype IN (1,4,5,9) AND dc.islive = 0 
							AND  dc.custid = c.custid
						FOR XML PATH('r')
							, TYPE
						)
				FOR XML PATH('root')
					, TYPE
			) as sdiscountXML
	FROM #MemberTemp c
)
INSERT INTO DSB_CustDiscount_Member (CustID,PlayerDiscount,AgentDiscount,MasterDiscount,SuperDiscount)
SELECT  dc.CustID,
		pdis.binaryStr_new AS PlayerDiscount,
		adis.binaryStr_new AS AgentDiscount,
		mdis.binaryStr_new AS MasterDiscount,
		sdis.binaryStr_new AS SuperDiscount
FROM Tmp dc  
	CROSS APPLY dbo.f_SetBinaryValues_2bytes(@InitialBinaryStr, dc.pdiscountXML) pdis
	CROSS APPLY dbo.f_SetBinaryValues_2bytes(@InitialBinaryStr, dc.adiscountXML) adis
	CROSS APPLY dbo.f_SetBinaryValues_2bytes(@InitialBinaryStr, dc.mdiscountXML) mdis
	CROSS APPLY dbo.f_SetBinaryValues_2bytes(@InitialBinaryStr, dc.sdiscountXML) sdis


DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #Dummy
DROP TABLE #supers