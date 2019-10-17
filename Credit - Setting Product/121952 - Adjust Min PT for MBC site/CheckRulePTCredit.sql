declare 

	@SportType SMALLINT = 0
	,@RuleId	SMALLINT = 0

	
-- get dummy super list
SELECT DISTINCT srecommend custid INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
WHERE  ci.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')
and ci.roleid IN (2, 3) AND ci.currency <> 20
UNION
SELECT DISTINCT ci.srecommend
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
     INNER JOIN vw_customer ca WITH(NOLOCK) ON ci.recommend = ca.custid
WHERE ca.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')
     AND ci.roleid IN (1) AND ci.currency <> 20


--DECLARE @max_custid INT
--SELECT @max_custid =39193683
SELECT ci.custid into #supers
FROM vw_customer ci WITH (NOLOCK) 
inner join custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	--AND ci.custid <= @max_custid
	AND ci.currency<>20
	and cs.IsInternal=0
	and ci.username not like '3rdSuper%'
    and ci.username not IN ( 'STAFF')
    and ci.username not like 'SuperTest%'
    and ci.username not like 'STEST%'
    and ci.username not like 'SIBC%'
    and ci.username not like '%ACCSuper%'
	and ci.site in ('BEST-ODDS','XYZBET','INDO','611111','733333','722222','755555','222223','7aa666','KORIBC')
	

	CREATE TABLE #MemberPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY,
							slivepositiontaking SMALLMONEY, mlivepositiontaking SMALLMONEY, alivepositiontaking SMALLMONEY, isautolivempositiontaking BIT, autolivempositiontaking SMALLMONEY, isautolivepositiontaking BIT, autolivepositiontaking SMALLMONEY)
	CREATE TABLE #AgentPT (CustID INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, Minpositiontaking SMALLMONEY, Maxpositiontaking SMALLMONEY, 
							slivepositiontaking SMALLMONEY, mlivepositiontaking SMALLMONEY, alivepositiontaking SMALLMONEY, isautolivempositiontaking BIT, autolivempositiontaking SMALLMONEY, isautolivepositiontaking BIT, autolivepositiontaking SMALLMONEY, MinLivepositiontaking SMALLMONEY, MaxLivepositiontaking SMALLMONEY)
	CREATE TABLE #MasterPT (CustID INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, Minpositiontaking SMALLMONEY, Maxpositiontaking SMALLMONEY, 
							slivepositiontaking SMALLMONEY, mlivepositiontaking SMALLMONEY, alivepositiontaking SMALLMONEY, isautolivempositiontaking BIT, autolivempositiontaking SMALLMONEY, isautolivepositiontaking BIT, autolivepositiontaking SMALLMONEY, MinLivepositiontaking SMALLMONEY, MaxLivepositiontaking SMALLMONEY)
	CREATE TABLE #SuperPT (CustID INT, sporttype SMALLINT, bettype SMALLINT, spositiontaking SMALLMONEY, mpositiontaking SMALLMONEY, apositiontaking SMALLMONEY, isautompositiontaking BIT, autompositiontaking SMALLMONEY, isautopositiontaking BIT, autopositiontaking SMALLMONEY, Minpositiontaking SMALLMONEY, Maxpositiontaking SMALLMONEY, 
							slivepositiontaking SMALLMONEY, mlivepositiontaking SMALLMONEY, alivepositiontaking SMALLMONEY, isautolivempositiontaking BIT, autolivempositiontaking SMALLMONEY, isautolivepositiontaking BIT, autolivepositiontaking SMALLMONEY, MinLivepositiontaking SMALLMONEY, MaxLivepositiontaking SMALLMONEY)
	CREATE TABLE #DirectMaster (CustID INT)
	
	DECLARE @RowCount TINYINT,
		@isDummySuper BIT = 0
	
	INSERT INTO #DirectMaster(custid)
	SELECT custid
	FROM dbo.custInfo ci WITH(NOLOCK) 										
	WHERE  EXISTS (SELECT custid 
					FROM dbo.CustDirectAccount WITH(NOLOCK) 
					WHERE CustID = ci.custid)													
		AND ci.roleid=3 
		AND ci.srecommend in (select custid from #dummySuper)
	
	IF @@rowcount > 0	
		SELECT @isDummySuper = 1
	
	
	SELECT cs.sporttype, cs.bettype
	INTO #DataSample
	FROM dbo.CustSetting cs WITH (NOLOCK)
	WHERE custid = 73104
		AND cs.SportType NOT IN (154) 

	SELECT @RowCount = COUNT(1)
	FROM #DataSample
	-- Starting DATA PREPARATION
	INSERT INTO #MemberPT (CustID, recommend, mrecommend, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking,
							slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking)
	SELECT ci.CustID, recommend, mrecommend, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking,
							slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustSetting cs WITH (NOLOCK) ON ci.CustID = cs.CustID
	WHERE ci.srecommend in (select custid from #supers) 
			AND ci.roleid = 1  
			AND ci.Enabled = 1
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType = CASE WHEN @SportType = 0 then cs.SportType  ELSE @SportType END 
			AND cs.SportType NOT IN (154) --HR
	
	INSERT INTO #AgentPT (CustID, mrecommend, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
							slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking)
	SELECT ci.CustID, mrecommend, srecommend, cs.sporttype, cs.bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
							slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustSetting cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.custoverride co WITH (NOLOCK) ON ci.CustID = co.CustID AND co.sporttype = cs.sporttype AND co.bettype = cs.bettype
	WHERE ci.srecommend in (select custid from #supers)
			AND ci.roleid = 2  
			AND ci.Enabled = 1
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType = CASE WHEN @SportType = 0 then cs.SportType  ELSE @SportType END 
			AND cs.SportType NOT IN (154) --HR 

	INSERT INTO #MasterPT (CustID, srecommend, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
							slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking)
	SELECT ci.CustID, srecommend, cs.sporttype, cs.bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
							slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustSetting cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.custoverride co WITH (NOLOCK) ON ci.CustID = co.CustID AND co.sporttype = cs.sporttype AND co.bettype = cs.bettype
	WHERE ci.srecommend in (select custid from #supers) 
			AND ci.roleid = 3
			AND ci.Enabled = 1
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType = CASE WHEN @SportType = 0 then cs.SportType  ELSE @SportType END 
			AND cs.SportType NOT IN (154) --HR

	INSERT INTO #SuperPT (CustID, sporttype, bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
							slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking)
	SELECT ci.CustID, cs.sporttype, cs.bettype, spositiontaking, mpositiontaking, apositiontaking, isautompositiontaking, autompositiontaking, isautopositiontaking, autopositiontaking, Minpositiontaking, Maxpositiontaking,
							slivepositiontaking, mlivepositiontaking, alivepositiontaking, isautolivempositiontaking, autolivempositiontaking, isautolivepositiontaking, autolivepositiontaking, MinLivepositiontaking, MaxLivepositiontaking
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustSetting cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.custoverride co WITH (NOLOCK) ON ci.CustID = co.CustID AND co.sporttype = cs.sporttype AND co.bettype = cs.bettype
	WHERE ci.custid in (select custid from #supers)  
			AND ci.Enabled = 1
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType = CASE WHEN @SportType = 0 then cs.SportType  ELSE @SportType END 	
			AND cs.SportType NOT IN (154) --HR 
		
		

	---- 1. S1 < 0 OR M1 < 0 OR A1 < 0
	IF @RuleId IN (0,1)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
		SELECT	1 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
				CASE WHEN cs.spositiontaking < 0 THEN cs.spositiontaking 
						WHEN cs.mpositiontaking < 0 THEN cs.mpositiontaking 
						WHEN cs.apositiontaking < 0 THEN cs.apositiontaking
				ELSE 0
				END,
				0, 
				0
		FROM	#MemberPT cs
		WHERE	(cs.spositiontaking < 0 OR cs.mpositiontaking < 0 OR cs.apositiontaking < 0)
		
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
		SELECT	1 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
				CASE WHEN cs.slivepositiontaking < 0 THEN cs.slivepositiontaking 
						WHEN cs.mlivepositiontaking < 0 THEN cs.mlivepositiontaking 
						WHEN cs.alivepositiontaking < 0 THEN cs.alivepositiontaking
				ELSE 0
				END,
				0,
				1
		FROM	#MemberPT cs
		WHERE	cs.Bettype IN (1,3,7,8)
			AND (cs.slivepositiontaking < 0 OR cs.mlivepositiontaking < 0 OR cs.alivepositiontaking < 0)
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
	
	----2. S4 > 0.9 OR M4 > 0.9 OR A4 > 0.9 
	IF @RuleId IN (0,2)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	2 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
				CASE WHEN cs.spositiontaking > 0.9 THEN cs.spositiontaking 
						WHEN cs.mpositiontaking > 0.9 THEN cs.mpositiontaking 
						WHEN cs.apositiontaking > 0.9 THEN cs.apositiontaking	
				ELSE 0.9	
				END,
				0.9,
				0
		FROM	#SuperPT cs
		WHERE	(cs.spositiontaking > 0.9 OR cs.mpositiontaking > 0.9 OR cs.apositiontaking > 0.9)
			
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	2 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
				CASE WHEN cs.slivepositiontaking > 0.9 THEN cs.slivepositiontaking 
						WHEN cs.mlivepositiontaking > 0.9 THEN cs.mlivepositiontaking 
						WHEN cs.alivepositiontaking > 0.9 THEN cs.alivepositiontaking	
				ELSE 0.9	
				END,
				0.9,
				1
		FROM	#SuperPT cs
		WHERE	cs.Bettype IN (1,3,7,8)
			AND (cs.slivepositiontaking > 0.9 OR cs.mlivepositiontaking > 0.9 OR cs.alivepositiontaking > 0.9)
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	----3. S4 < M4 

	IF @RuleId IN (0,3)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	3 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.spositiontaking, cs.mpositiontaking, 0
		FROM #SuperPT cs	
		WHERE cs.spositiontaking < cs.mpositiontaking 

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	3 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.slivepositiontaking, cs.mlivepositiontaking, 1
		FROM #SuperPT cs	
		WHERE cs.Bettype IN (1,3,7,8)
			AND cs.slivepositiontaking < cs.mlivepositiontaking 	
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	----4. S4 < A4
	IF @RuleId IN (0,4)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	4 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.spositiontaking, cs.apositiontaking, 0
		FROM #SuperPT cs	
		WHERE cs.spositiontaking < cs.apositiontaking 

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	4 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.slivepositiontaking, cs.alivepositiontaking, 1
		FROM #SuperPT cs	
		WHERE cs.Bettype IN (1,3,7,8)
			AND cs.slivepositiontaking < cs.alivepositiontaking 
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	----5. S4 < N4  
	IF @RuleId IN (0,5)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	5 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.spositiontaking, cs.minpositiontaking, 0
		FROM #SuperPT cs
		WHERE cs.spositiontaking < cs.minpositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	5 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.slivepositiontaking, cs.minlivepositiontaking, 1
		FROM #SuperPT cs
		WHERE cs.Bettype IN (1,3,7,8)
			AND cs.slivepositiontaking < cs.minlivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
 
	----6. S4 < US3 
	IF @RuleId IN (0,6)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	6 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking , cs.autopositiontaking, 0
		FROM	#SuperPT scs			
			INNER JOIN	#MasterPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype 			
		WHERE	scs.spositiontaking < cs.autopositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	6 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.slivepositiontaking , cs.autolivepositiontaking, 1
		FROM	#SuperPT scs			
			INNER JOIN	#MasterPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype 			
		WHERE	scs.Bettype IN (1,3,7,8)
			AND scs.slivepositiontaking < cs.autolivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	----7. S4 < US1 
	IF @RuleId IN (0,7)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	7 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking, cs.autopositiontaking, 0
		FROM	#SuperPT scs			
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype 
		WHERE scs.spositiontaking < cs.autopositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	7 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.slivepositiontaking, cs.autolivepositiontaking, 1
		FROM	#SuperPT scs			
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype 
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.slivepositiontaking < cs.autolivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
	
	----8. S4 < S3 + M3 
	IF @RuleId IN (0,8)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	8 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking, cs.spositiontaking + cs.mpositiontaking, 0
		FROM	#SuperPT scs			
			INNER JOIN	#MasterPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.spositiontaking < cs.spositiontaking + cs.mpositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	8 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.slivepositiontaking, cs.slivepositiontaking + cs.mlivepositiontaking, 1
		FROM	#SuperPT scs			
			INNER JOIN	#MasterPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.slivepositiontaking < cs.slivepositiontaking + cs.mlivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	----9. S4 < S1 + M1 + A1 
	IF @RuleId IN (0,9)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	9 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.spositiontaking, cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking, 0
		FROM	#SuperPT scs			
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.spositiontaking < cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	9 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.slivepositiontaking, cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking, 1
		FROM	#SuperPT scs			
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.slivepositiontaking < cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	----10. N4 > S1 + M1 + A1  
	IF @RuleId IN (0,10)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	10 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.minpositiontaking, cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking, 0
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.minpositiontaking > cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	10 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.minlivepositiontaking, cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking, 1
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.minlivepositiontaking > cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
	
	-----------------------------------------------------------------------
	----11. M4 < A4
	IF @RuleId IN (0,11)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	11 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.mpositiontaking, cs.apositiontaking, 0
		FROM #SuperPT cs
		WHERE cs.mpositiontaking < cs.apositiontaking 

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	11 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.mlivepositiontaking, cs.alivepositiontaking, 1
		FROM #SuperPT cs
		WHERE cs.Bettype IN (1,3,7,8)
			AND cs.mlivepositiontaking < cs.alivepositiontaking 
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
		
	----12. M4 < M3 
	IF @RuleId IN (0,12)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	12 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking, cs.mpositiontaking, 0
		FROM	#SuperPT scs		
			INNER JOIN	#MasterPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.mpositiontaking < cs.mpositiontaking 

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	12 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking, cs.mlivepositiontaking, 1
		FROM	#SuperPT scs		
			INNER JOIN	#MasterPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.mlivepositiontaking < cs.mlivepositiontaking 
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END	

	----13. M4 < N3 
	IF @RuleId IN (0,13)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	13 as RuleId, scs.BetType, scs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking , cs.minpositiontaking, 0
		FROM	#SuperPT scs		
			INNER JOIN	#MasterPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.mpositiontaking < cs.minpositiontaking 

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	13 as RuleId, scs.BetType, scs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking , cs.minlivepositiontaking, 1
		FROM	#SuperPT scs		
			INNER JOIN	#MasterPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.mlivepositiontaking < cs.minlivepositiontaking 
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	----14. M4 < UM2 
	IF @RuleId IN (0,14)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	14 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking, cs.autompositiontaking, 0
		FROM	#SuperPT scs		
			INNER JOIN	#AgentPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.mpositiontaking < cs.autompositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	14 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking, cs.autolivempositiontaking, 1
		FROM	#SuperPT scs		
			INNER JOIN	#AgentPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.mlivepositiontaking < cs.autolivempositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	----15. M4 < UM1 
	IF @RuleId IN (0,15)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	15 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking, cs.autompositiontaking, 0
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.mpositiontaking < cs.autompositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	15 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking, cs.autolivempositiontaking, 1
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.mlivepositiontaking < cs.autolivempositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	----16. M4 < M1 + A1 
	IF @RuleId IN (0,16)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	16 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mpositiontaking , cs.mpositiontaking + cs.apositiontaking, 0
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.mpositiontaking < cs.mpositiontaking + cs.apositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	16 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.mlivepositiontaking , cs.mlivepositiontaking + cs.alivepositiontaking, 1
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.mlivepositiontaking < cs.mlivepositiontaking + cs.alivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
  
	----17. M3 < N3 
	IF @RuleId IN (0,17)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	17 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.mpositiontaking, cs.minpositiontaking, 0
		FROM #MasterPT cs
		WHERE cs.mpositiontaking < cs.minpositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	17 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.mlivepositiontaking, cs.minlivepositiontaking, 1
		FROM #MasterPT cs
		WHERE cs.Bettype IN (1,3,7,8)
			AND cs.mlivepositiontaking < cs.minlivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	--------------------------------------------------------------------------------------------
	----18. M3 < M2 + A2 
	IF @RuleId IN (0,18)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	18 as RuleId, cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
		FROM	#MasterPT mcs		
			INNER JOIN	#AgentPT cs ON	cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
		WHERE mcs.mpositiontaking < cs.mpositiontaking + cs.apositiontaking


		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	18 as RuleId, cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mlivepositiontaking, cs.mlivepositiontaking + cs.alivepositiontaking, 1
		FROM	#MasterPT mcs		
			INNER JOIN	#AgentPT cs ON	cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
		WHERE cs.Bettype IN (1,3,7,8)				
			AND mcs.mlivepositiontaking < cs.mlivepositiontaking + cs.alivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
	
	----19. M3 < M1 + A1 
	IF @RuleId IN (0,19)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	19 as RuleId, cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
		FROM	#MasterPT mcs		
			INNER JOIN	#MemberPT cs ON	cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
		WHERE mcs.mpositiontaking < cs.mpositiontaking + cs.apositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	19 as RuleId, cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.mlivepositiontaking, cs.mlivepositiontaking + cs.alivepositiontaking, 1
		FROM	#MasterPT mcs		
			INNER JOIN	#AgentPT cs ON	cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
		WHERE cs.Bettype IN (1,3,7,8)
			AND mcs.mlivepositiontaking < cs.mlivepositiontaking + cs.alivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
   
	----20. N3 > M1 + A1 
	IF @RuleId IN (0,20)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	20 as RuleId, cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.minpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
		FROM	#MasterPT mcs		
			INNER JOIN	#MemberPT cs ON	cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
		WHERE mcs.minpositiontaking > cs.mpositiontaking + cs.apositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	20 as RuleId, cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.minlivepositiontaking, cs.mlivepositiontaking + cs.alivepositiontaking, 1
		FROM	#MasterPT mcs		
			INNER JOIN	#MemberPT cs ON	cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
		WHERE cs.Bettype IN (1,3,7,8)
			AND mcs.minlivepositiontaking > cs.mlivepositiontaking + cs.alivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END  
 
	----21. A4 < A2
	IF @RuleId IN (0,21)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLIve)
		SELECT	21 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.apositiontaking, cs.apositiontaking, 0
		FROM	#SuperPT scs		
			INNER JOIN	#AgentPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.apositiontaking < cs.apositiontaking 

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLIve)
		SELECT	21 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.alivepositiontaking, cs.alivepositiontaking, 1
		FROM	#SuperPT scs		
			INNER JOIN	#AgentPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.alivepositiontaking < cs.alivepositiontaking 
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END	
	
	----22. A4 < A1
	IF @RuleId IN (0,22)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	22 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.apositiontaking, cs.apositiontaking, 0
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.apositiontaking < cs.apositiontaking 

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	22 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.alivepositiontaking, cs.alivepositiontaking, 1
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.alivepositiontaking < cs.alivepositiontaking 
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END	

	----23. A2 < N2
	IF @RuleId IN (0,23)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	23 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.apositiontaking, cs.minpositiontaking, 0
		FROM	#AgentPT cs		
		WHERE cs.apositiontaking < cs.minpositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	23 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.alivepositiontaking, cs.minlivepositiontaking, 1
		FROM	#AgentPT cs		
		WHERE cs.Bettype IN (1,3,7,8)
			AND cs.alivepositiontaking < cs.minlivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END 
	 
	----24. N2 > A1
	IF @RuleId IN (0,24)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	24 as RuleId, cs.BetType, cs.SportType, acs.CustId, cs.CustId, acs.minpositiontaking, cs.apositiontaking, 0 
		FROM	#AgentPT acs		
			INNER JOIN	#MemberPT cs ON	cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
		WHERE   acs.minpositiontaking > cs.apositiontaking 

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	24 as RuleId, cs.BetType, cs.SportType, acs.CustId, cs.CustId, acs.minlivepositiontaking, cs.alivepositiontaking, 1 
		FROM	#AgentPT acs		
			INNER JOIN	#MemberPT cs ON	cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
		WHERE   cs.Bettype IN (1,3,7,8)
			AND acs.minlivepositiontaking > cs.alivepositiontaking 
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
 
	---------------------------------------------------
	---- 25. L4 < S1 + M1 + A1 
	IF @RuleId IN (0,25)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	25 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.maxpositiontaking, cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking, 0
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.maxpositiontaking < cs.spositiontaking + cs.mpositiontaking + cs.apositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	25 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.maxlivepositiontaking, cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking, 1
		FROM	#SuperPT scs		
			INNER JOIN	#MemberPT cs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype
		WHERE scs.Bettype IN (1,3,7,8)
			AND scs.maxlivepositiontaking < cs.slivepositiontaking + cs.mlivepositiontaking + cs.alivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END

	---- 26. L3 < M1 +A1
	IF @RuleId IN (0,26)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	26 as RuleId, cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.maxpositiontaking, cs.mpositiontaking + cs.apositiontaking, 0
		FROM	#MasterPT mcs		
			INNER JOIN	#MemberPT cs ON	cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
		WHERE mcs.maxpositiontaking < cs.mpositiontaking + cs.apositiontaking

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
		SELECT	26 as RuleId, cs.BetType, cs.SportType, mcs.CustId, cs.CustId, mcs.maxlivepositiontaking, cs.mlivepositiontaking + cs.alivepositiontaking, 1
		FROM	#MasterPT mcs		
			INNER JOIN	#MemberPT cs ON	cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype
		WHERE cs.Bettype IN (1,3,7,8)
			AND mcs.maxlivepositiontaking < cs.mlivepositiontaking + cs.alivepositiontaking
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END  

	---- 27. L2 < A1 
	IF @RuleId IN (0,27)
	BEGIN
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	27 as RuleId, cs.BetType, cs.SportType, acs.CustId, cs.CustId, acs.maxpositiontaking, cs.apositiontaking, 0
		FROM	#AgentPT acs		
			INNER JOIN	#MemberPT cs ON	cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
		WHERE   acs.maxpositiontaking < cs.apositiontaking 

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT	27 as RuleId, cs.BetType, cs.SportType, acs.CustId, cs.CustId, acs.maxlivepositiontaking, cs.alivepositiontaking, 1
		FROM	#AgentPT acs		
			INNER JOIN	#MemberPT cs ON	cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype
		WHERE   cs.Bettype IN (1,3,7,8)
			AND acs.maxlivepositiontaking < cs.alivepositiontaking 
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
	END
 
	---- 28. MIN(S4-M1-A1, (IS1?US1,US3)) > S1
	IF @RuleId IN (0,28)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT 28 AS RuleId, cs.BetType, cs.SportType 
			,CASE	WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking	ELSE mcs.autopositiontaking END)			
					THEN (	CASE	WHEN cs.isautopositiontaking = 1 
									THEN cs.CustId 
									ELSE mcs.CustId 
							END)
					ELSE scs.CustId
				END 
			,cs.CustId				
			,CASE	WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking	ELSE mcs.autopositiontaking END)			
					THEN (	CASE	WHEN cs.isautopositiontaking = 1 
									THEN cs.autopositiontaking 
									ELSE mcs.autopositiontaking 
							END)
					ELSE scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking
				END 
			,cs.spositiontaking
			,0
		FROM #MemberPT cs 		
			INNER JOIN	#MasterPT mcs ON	cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype			
			INNER JOIN	#SuperPT scs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype			
		WHERE (cs.isautopositiontaking=1 OR mcs.isautopositiontaking=1)
			AND cs.spositiontaking < CASE	WHEN scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautopositiontaking = 1 THEN cs.autopositiontaking	ELSE mcs.autopositiontaking END)			
											THEN (	CASE	WHEN cs.isautopositiontaking = 1 
															THEN cs.autopositiontaking 
															ELSE mcs.autopositiontaking 
													END)
											ELSE scs.spositiontaking - cs.mpositiontaking - cs.apositiontaking
										END 
		----

		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT 28 AS RuleId, cs.BetType, cs.SportType 
			,CASE	WHEN scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivepositiontaking = 1 THEN cs.autolivepositiontaking	ELSE mcs.autolivepositiontaking END)			
					THEN (	CASE	WHEN cs.isautolivepositiontaking = 1 
									THEN cs.CustId 
									ELSE mcs.CustId 
							END)
					ELSE scs.CustId
				END 
			,cs.CustId				
			,CASE	WHEN scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivepositiontaking = 1 THEN cs.autolivepositiontaking	ELSE mcs.autolivepositiontaking END)			
					THEN (	CASE	WHEN cs.isautolivepositiontaking = 1 
									THEN cs.autolivepositiontaking 
									ELSE mcs.autolivepositiontaking 
							END)
					ELSE scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking
				END 
			,cs.slivepositiontaking
			,1
		FROM #MemberPT cs 		
			INNER JOIN	#MasterPT mcs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype			
			INNER JOIN	#SuperPT scs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype			
		WHERE cs.Bettype IN (1,3,7,8)
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
			AND (cs.isautolivepositiontaking=1 OR mcs.isautolivepositiontaking=1)
			AND cs.slivepositiontaking < CASE	WHEN scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivepositiontaking = 1 THEN cs.autolivepositiontaking	ELSE mcs.autolivepositiontaking END)			
											THEN (	CASE	WHEN cs.isautolivepositiontaking = 1 
															THEN cs.autolivepositiontaking 
															ELSE mcs.autolivepositiontaking 
													END)
											ELSE scs.slivepositiontaking - cs.mlivepositiontaking - cs.alivepositiontaking
										END 

		END 
 
	---- 29. MIN (M4-A1, M3-A1,(IM1?UM1,UM2)) > M1 
	IF @RuleId IN (0,29)
	BEGIN 
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT 29 AS RuleId, cs.BetType, cs.SportType 
			,CASE WHEN scs.mpositiontaking > mcs.mpositiontaking 
					THEN	CASE WHEN mcs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
								THEN (CASE WHEN cs.isautompositiontaking = 1 
										THEN cs.CustId
										ELSE acs.CustId 
										END
									)
								ELSE mcs.CustId
						END
				ELSE	
						CASE WHEN scs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
								THEN (CASE WHEN cs.isautompositiontaking = 1 
										THEN cs.CustId
										ELSE acs.CustId 
									END
									)
								ELSE scs.CustId
						END
				END
			,cs.CustId
			,CASE WHEN scs.mpositiontaking > mcs.mpositiontaking 
					THEN	CASE WHEN mcs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
								THEN (CASE WHEN cs.isautompositiontaking = 1 
										THEN cs.autompositiontaking
										ELSE acs.autompositiontaking 
									END
									)
								ELSE mcs.mpositiontaking - cs.apositiontaking
						END
				ELSE	
						CASE WHEN scs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
								THEN (CASE WHEN cs.isautompositiontaking = 1 
										THEN cs.autompositiontaking
										ELSE acs.autompositiontaking 
									END
									)
								ELSE scs.mpositiontaking - cs.apositiontaking
						END
				END
			,cs.mpositiontaking
			,0
		FROM #MemberPT cs 		
			INNER JOIN	#AgentPT acs ON	cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype			
			INNER JOIN	#MasterPT mcs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype			
			INNER JOIN	#SuperPT scs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype	
		WHERE ( acs.isautompositiontaking = 1	OR cs.isautompositiontaking = 1 )
			AND cs.mpositiontaking < CASE WHEN scs.mpositiontaking > mcs.mpositiontaking 
											THEN CASE  WHEN mcs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
														THEN (CASE WHEN cs.isautompositiontaking = 1 
																THEN cs.autompositiontaking
																ELSE acs.autompositiontaking 
															END
															)
														ELSE mcs.mpositiontaking - cs.apositiontaking
														END
											ELSE	
													CASE WHEN scs.mpositiontaking - cs.apositiontaking > (CASE WHEN cs.isautompositiontaking = 1 THEN cs.autompositiontaking ELSE acs.autompositiontaking END) 
															THEN (CASE WHEN cs.isautompositiontaking = 1 
																	THEN cs.autompositiontaking
																	ELSE acs.autompositiontaking 
																END
																)
															ELSE scs.mpositiontaking - cs.apositiontaking
															END
											END

		------
		-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)
		SELECT 29 AS RuleId, cs.BetType, cs.SportType 
			,CASE WHEN scs.mlivepositiontaking > mcs.mlivepositiontaking 
					THEN	CASE WHEN mcs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
								THEN (CASE WHEN cs.isautolivempositiontaking = 1 
										THEN cs.CustId
										ELSE acs.CustId 
										END
									)
								ELSE mcs.CustId
						END
				ELSE	
						CASE WHEN scs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
								THEN (CASE WHEN cs.isautolivempositiontaking = 1 
										THEN cs.CustId
										ELSE acs.CustId 
									END
									)
								ELSE scs.CustId
						END
				END
			,cs.CustId
			,CASE WHEN scs.mlivepositiontaking > mcs.mlivepositiontaking 
					THEN	CASE WHEN mcs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
								THEN (CASE WHEN cs.isautolivempositiontaking = 1 
										THEN cs.autolivempositiontaking
										ELSE acs.autolivempositiontaking 
									END
									)
								ELSE mcs.mlivepositiontaking - cs.alivepositiontaking
						END
				ELSE	
						CASE WHEN scs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
								THEN (CASE WHEN cs.isautolivempositiontaking = 1 
										THEN cs.autolivempositiontaking
										ELSE acs.autolivempositiontaking 
									END
									)
								ELSE scs.mlivepositiontaking - cs.alivepositiontaking
						END
				END
			,cs.mlivepositiontaking
			,1
		FROM #MemberPT cs 		
			INNER JOIN	#AgentPT acs ON	cs.recommend = acs.CustId AND cs.bettype = acs.bettype AND cs.sporttype = acs.sporttype			
			INNER JOIN	#MasterPT mcs ON cs.mrecommend = mcs.CustId AND cs.bettype = mcs.bettype AND cs.sporttype = mcs.sporttype			
			INNER JOIN	#SuperPT scs ON	cs.srecommend = scs.CustId AND cs.bettype = scs.bettype AND cs.sporttype = scs.sporttype	
		WHERE cs.Bettype IN (1,3,7,8)
			AND CASE WHEN @SportType IN (0,1) THEN cs.SportType ELSE 0 END = 1
			AND ( acs.isautolivempositiontaking = 1	OR cs.isautolivempositiontaking = 1 )
			AND cs.mlivepositiontaking < CASE WHEN scs.mlivepositiontaking > mcs.mlivepositiontaking 
											THEN CASE  WHEN mcs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
														THEN (CASE WHEN cs.isautolivempositiontaking = 1 
																THEN cs.autolivempositiontaking
																ELSE acs.autolivempositiontaking 
															END
															)
														ELSE mcs.mlivepositiontaking - cs.alivepositiontaking
														END
											ELSE	
													CASE WHEN scs.mlivepositiontaking - cs.alivepositiontaking > (CASE WHEN cs.isautolivempositiontaking = 1 THEN cs.autolivempositiontaking ELSE acs.autolivempositiontaking END) 
															THEN (CASE WHEN cs.isautolivempositiontaking = 1 
																	THEN cs.autolivempositiontaking
																	ELSE acs.autolivempositiontaking 
																END
																)
															ELSE scs.mlivepositiontaking - cs.alivepositiontaking
															END
											END



	END 
	
	IF @isDummySuper = 1
	BEGIN
		---- 36. dummy super has s3<> 0
		IF @RuleId IN (0,36)
		BEGIN 	
			-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
			SELECT	36 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
					spositiontaking,
					0, 
					0
			FROM #MasterPT cs
			WHERE spositiontaking<>0 
				AND custid IN (SELECT custid FROM #DirectMaster)
			
			-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
			SELECT	36 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
					slivepositiontaking,
					0, 
					1
			FROM #MasterPT cs
			WHERE slivepositiontaking <> 0
				AND custid IN (SELECT custid FROM #DirectMaster)
		END
		
		--37. dummy super has s1 <> 0
		IF @RuleId IN (0,37)
		BEGIN 	
			-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
			SELECT	37 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
					spositiontaking,
					0, 
					0
			FROM #MemberPT cs
			WHERE spositiontaking<>0 
				AND mrecommend IN (SELECT custid FROM #DirectMaster)
			
			-- INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive) 
			SELECT	37 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,
					slivepositiontaking,
					0, 
					1
			FROM #MemberPT cs
			WHERE slivepositiontaking <> 0
				AND mrecommend IN (SELECT custid FROM #DirectMaster)
		END
	END		

