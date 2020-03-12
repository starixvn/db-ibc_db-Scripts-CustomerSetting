/*
	Created: 20200310@Johnson
	Task: update min PT to supers under requested sites & RM currency FOR SB & SB2
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid int,	
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustOverride') = 0 RETURN	
	IF dbo.f_CheckRepTable('custSetting') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	
		
	DECLARE @roleid INT, 
			@srecommend INT, 
			@mrecommend INT, 
			@recommend INT, 
			@PT smallmoney = 0.88
	
	SELECT @roleid = roleid, @srecommend=srecommend, @mrecommend=mrecommend, @recommend=recommend FROM customer WITH (NOLOCK) WHERE custid = @custid		
	
	IF @roleid = 2
	BEGIN
		--update preset of direct account & dummy
		UPDATE cs 
		SET cs.apositiontaking = CASE WHEN custid IN (@srecommend, @custid) THEN @PT ELSE apositiontaking END,
			cs.mpositiontaking = CASE WHEN custid IN (@srecommend, @mrecommend) THEN @PT ELSE mpositiontaking END, 
			cs.spositiontaking = CASE WHEN custid IN (@srecommend) THEN @PT ELSE spositiontaking END,
			
			cs.alivepositiontaking = CASE WHEN custid IN (@srecommend, @custid) AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE cs.alivepositiontaking END,
			cs.mlivepositiontaking = CASE WHEN custid IN (@srecommend, @mrecommend) AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE mlivepositiontaking END, 
			cs.slivepositiontaking = CASE WHEN custid IN (@srecommend) AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE slivepositiontaking END
		FROM CustSetting cs WITH (UPDLOCK,ROWLOCK)
		WHERE custid IN (@custid, @srecommend, @mrecommend)
		
		UPDATE co
		SET minpositiontaking = CASE WHEN custid = @custid THEN @PT ELSE minpositiontaking END,
			maxpositiontaking = CASE WHEN @PT > maxpositiontaking THEN @PT ELSE maxpositiontaking END,
			
			minlivepositiontaking = CASE WHEN custid = @custid AND co.sporttype = 1 and co.bettype IN (1,3,7,8) THEN @PT ELSE minlivepositiontaking END,
			maxlivepositiontaking = CASE WHEN co.sporttype = 1 and co.bettype IN (1,3,7,8) AND @PT > maxlivepositiontaking THEN @PT ELSE maxlivepositiontaking END
		FROM custoverride co WITH (UPDLOCK,ROWLOCK)		
		WHERE co.custid IN (@custid,@srecommend,@mrecommend)

		EXEC dbo.Acc_CustSetting_18 @recommend = @recommend, @mrecommend = @mrecommend, @srecommend = @srecommend, @roleid = @roleid, @Target = @Target				
	END
	ELSE IF @roleid = 3
	BEGIN
		--update preset of direct account & dummy
		UPDATE cs 
		SET cs.mpositiontaking = @PT,
			cs.apositiontaking = CASE WHEN custid IN (@srecommend) THEN @PT ELSE apositiontaking END,
			cs.spositiontaking = CASE WHEN custid IN (@srecommend) THEN @PT ELSE spositiontaking END,
			
			cs.mlivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE mlivepositiontaking END,
			cs.alivepositiontaking = CASE WHEN custid IN (@srecommend) AND sporttype = 1 AND bettype IN (1,3,7,8) THEN @PT ELSE alivepositiontaking END,
			cs.slivepositiontaking = CASE WHEN custid IN (@srecommend) AND sporttype = 1 AND bettype IN (1,3,7,8) THEN @PT ELSE slivepositiontaking END
		FROM CustSetting cs WITH (UPDLOCK,ROWLOCK)
		WHERE custid IN (@custid, @srecommend)
		
		UPDATE co
		SET minpositiontaking = CASE WHEN custid = @custid THEN @PT ELSE minpositiontaking END,
			maxpositiontaking = CASE WHEN @PT > maxpositiontaking THEN @PT ELSE maxpositiontaking END,
			
			minlivepositiontaking = CASE WHEN custid = @custid AND co.sporttype = 1 and co.bettype IN (1,3,7,8) THEN @PT ELSE minlivepositiontaking END,
			maxlivepositiontaking = CASE WHEN co.sporttype = 1 and co.bettype IN (1,3,7,8) AND @PT > maxlivepositiontaking THEN @PT ELSE maxlivepositiontaking END
		FROM custoverride co WITH (UPDLOCK,ROWLOCK)		
		WHERE co.custid IN(@custid,@srecommend)

		EXEC dbo.Acc_CustSetting_18 @mrecommend = @mrecommend, @srecommend = @srecommend, @roleid = @roleid, @Target = @Target					
	END
	ELSE IF @roleid= 4 
	BEGIN
		--update preset s4,m4,a4
		UPDATE cs 
		SET cs.spositiontaking = @PT ,
			cs.mpositiontaking = cs.mpositiontaking + @PT - cs.spositiontaking ,
			cs.apositiontaking = cs.apositiontaking + @PT - cs.spositiontaking,
			
			cs.slivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE cs.slivepositiontaking END,
			cs.mlivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN cs.mlivepositiontaking + @PT - cs.slivepositiontaking ELSE cs.mlivepositiontaking END,
			cs.alivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN cs.alivepositiontaking + @PT - cs.slivepositiontaking ELSE cs.alivepositiontaking END
		FROM CustSetting cs WITH (UPDLOCK,ROWLOCK)
		WHERE custid = @custid
		
		UPDATE cs 
		SET maxpositiontaking = CASE WHEN @PT > maxpositiontaking THEN @PT ELSE maxpositiontaking END,			
			minpositiontaking = CASE WHEN @PT > minpositiontaking THEN @PT ELSE minpositiontaking END,			
			
			maxlivepositiontaking = CASE WHEN @PT > maxlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE maxlivepositiontaking END,
			minlivepositiontaking = CASE WHEN @PT > minlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE minlivepositiontaking END
		FROM custoverride cs WITH(ROWLOCK, UPDLOCK)				
		WHERE custid = @custid
		
		EXEC dbo.Acc_CustSetting_18 @srecommend = @srecommend, @roleid = @roleid, @Target = @Target						
	END		

	--> FOR Muay Thai, E-Sports
	DECLARE @xml XML;
	SET @xml = (
				SELECT (
						SELECT SportType AS '@SportType'
							, BetType AS '@BetType'
							, IsLive AS '@IsLive'
						FROM dbo.ProductSettingDetail WITH(NOLOCK)
						WHERE settingtype = 1 
							  AND SportType IN (43,44)
						FOR XML PATH('PT')
							, TYPE
						)
				FOR XML PATH('ROOT')
					, TYPE
				);
	DECLARE @SportBettypeXML NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX),@xml);
	
	IF @roleid = 4
	BEGIN
		UPDATE cs 
		SET cs.MaxPT = CASE WHEN cs.MaxPT < @PT * 100 THEN @PT*100 ELSE cs.MaxPT END,
			cs.MinPT = CASE WHEN cs.MinPT < @PT * 100 THEN @PT*100 ELSE cs.MinPT END,
			cs.SuperPT  =  @PT * 100 ,
			cs.MasterPT =  cs.MasterPT + @PT * 100 - cs.SuperPT ,
			cs.AgentPT  =  cs.AgentPT + @PT * 100 - cs.SuperPT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)		
		WHERE cs.SportType IN (43,44) 
			AND custid = @custid
	END
	ELSE 
	BEGIN
		--update direct account & dummy
		UPDATE cs 
		SET 
			cs.AgentPT = CASE WHEN (@roleid = 2 AND custid = @custid) OR (custid = @srecommend) THEN @PT * 100  ELSE cs.AgentPT END,
			cs.MasterPT = CASE WHEN (@roleid = 3 AND custid = @custid) OR (@roleid = 2 AND custid = @mrecommend) OR (custid = @srecommend) THEN @PT * 100  ELSE cs.MasterPT END,
			cs.SuperPT = CASE WHEN custid = @srecommend THEN @PT*100 ELSE SuperPT END,
			MinPT = CASE WHEN custid = @custid AND cs.MinPT < @PT*100 THEN @PT*100 ELSE cs.MinPT END,
			MaxPT = CASE WHEN MaxPT < 100*@PT THEN @PT*100 ELSE MaxPT END
		FROM CustPTSetting3rd_Agent cs WITH (UPDLOCK,ROWLOCK)			
		WHERE cs.SportType IN (43,44)
			AND custid IN (@custid, @srecommend, @mrecommend)
	END
	
	EXEC dbo.Acc_DynamicCustSetting3rd_08 
				@AgentID = @recommend
				,@MasterID = @mrecommend
				,@SuperID = @srecommend
				,@roleid = @roleid
				,@SportBettypeXML = @SportBettypeXML
				,@Target = @Target
	              
END    
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @custid INT,
		@PT SMALLMONEY = 0.85
		
DECLARE @tmpSite TABLE (site VARCHAR(30), currencyName VARCHAR(10), currency TINYINT)
CREATE TABLE #tblSMA(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO @tmpSite(site,currencyName)
SELECT 'BEST-ODDS','RM'
UNION SELECT '733333','RM'
UNION SELECT '222223','RM'
UNION SELECT '722222','RM'
UNION SELECT 'XYZBet','RM'

UPDATE t
SET t.currency = e.exchangeid
FROM @tmpSite t
	INNER JOIN exchange e (NOLOCK) ON t.currencyName = e.currency

SELECT ci.custid, ci.username 
INTO #WrongDirectMaster
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.vw_customer ci WITH (NOLOCK) ON ci.custid = ca.CustID
	INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
WHERE ci.srecommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 3					
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
SELECT ci.custid, ci.username 
INTO #WrongDirectAgent
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.vw_customer ci WITH (NOLOCK) ON ci.custid = ca.CustID
	INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
WHERE ci.mrecommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 2					
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
SELECT ci.custid, ci.username 
INTO #WrongDirectMember
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.vw_customer ci WITH (NOLOCK) ON ci.custid = ca.CustID
	INNER JOIN dbo.vw_customer agent WITH (NOLOCK) ON agent.custid = ci.recommend
	INNER JOIN @tmpSite t ON agent.site = t.site AND ci.currency = t.currency
WHERE ci.recommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 1					
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
-- get dummy super list
SELECT DISTINCT srecommend custid 
INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
	 INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
WHERE  ci.roleid IN (2, 3) 	
	AND ci.custid NOT IN (SELECT custid FROM #WrongDirectMaster
						UNION  SELECT custid FROM #WrongDirectAgent )						
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
UNION
SELECT DISTINCT ci.srecommend
FROM CustDirectAccount da WITH (NOLOCK)
    INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid    
	INNER JOIN dbo.vw_customer agent WITH (NOLOCK) ON agent.custid = ci.recommend
	INNER JOIN @tmpSite t ON agent.site = t.site AND ci.currency = t.currency
WHERE ci.roleid IN (1) 	
	AND ci.custid NOT IN (SELECT custid FROM #WrongDirectMember)
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

--PhoneBetting
CREATE TABLE #PhoneBetting(mrecommend INT, recommend INT)

--8069 rows affected
INSERT INTO #PhoneBetting(mrecommend,recommend)	
SELECT DISTINCT mrecommend,recommend
FROM dbo.PhoneBettingCustomerList p WITH(NOLOCK)
	INNER JOIN vw_Customer c WITH(NOLOCK) ON p.username = c.username
	
--Get supers normal/direct masters/direct agents
INSERT INTO #tblSMA(custid)
SELECT DISTINCT ci.custid
FROM vw_customer ci WITH (NOLOCK) 
	INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
	INNER JOIN custsetting co WITH(NOLOCK) ON ci.custid = co.custid
	INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid	
WHERE ci.roleid = 4  	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0	
	AND cs.IsInternal=0
	AND ci.custid>=100
	AND ci.custid not in (select custid from #dummySuper)
	AND ci.username not like '3rdSuper%'
    AND ci.username not IN ( 'STAFF')
    AND ci.username not like 'SuperTest%'
    AND ci.username not like 'STEST%'
    AND ci.username not like 'SIBC%'
    AND ci.username not like '%ACCSuper%'
	AND cu.closed=0 
	AND (co.spositiontaking = @PT 
		OR (co.sporttype = 1 AND co.bettype IN (1,3,7,8) AND co.slivepositiontaking = @PT)
		OR (co2.sporttype IN (43,44) AND co2.SuperPT = @PT*100)
		)
--Direct masters exclude who has  phone betting	members
UNION ALL
	SELECT DISTINCT ci.custid
	FROM vw_customer ci with(nolock)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid		
		INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
		INNER JOIN custsetting co WITH(NOLOCK) ON ci.custid = co.custid
		INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 		
		AND ci.srecommend IN (SELECT custid FROM #dummySuper)
		AND c.Enabled=1
		AND c.closed=0 
		AND c.custid NOT IN (SELECT custid from #WrongDirectMaster)
		AND c.custid NOT IN (SELECT mrecommend FROM #PhoneBetting)
		AND (co.mpositiontaking = @PT 
			OR (co.sporttype = 1 AND co.bettype IN (1,3,7,8) AND co.mlivepositiontaking = @PT)
			OR (co2.sporttype IN (43,44) AND co2.MasterPT = @PT*100)
			)
		AND ci.custid NOT IN (3645792)--M9999RM	
UNION ALL	
--Direct agents exclude who has  phone betting	members
	SELECT DISTINCT ci.custid
	FROM vw_Customer ci WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid		
		INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
		INNER JOIN custsetting co WITH(NOLOCK) ON ci.custid = co.custid
		INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid
	WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid = 2 		
		AND ci.srecommend IN (SELECT custid FROM #dummySuper)
		AND c.Enabled=1
		AND c.closed=0 
		AND c.custid NOT IN (SELECT custid FROM #WrongDirectAgent)
		AND c.custid NOT IN (SELECT recommend FROM #PhoneBetting)
		AND (co.apositiontaking = @PT 
			OR (co.sporttype = 1 AND co.bettype IN (1,3,7,8) AND co.alivepositiontaking = @PT)
			OR (co2.sporttype IN (43,44) AND co2.AgentPT = @PT*100)
			)

DELETE #tblSMA WHERE custid IN (726582,13469206)--KAM,JARWRONG
			
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #tblSMA )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tblSMA
	SET isfinished = 1
		,@custid = custid		
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting_19] 
			@custid = @custid, 			
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
-----------------------------------------------------------------------------------	


---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
DECLARE @custid INT,
		@PT SMALLMONEY = 0.85
		
DECLARE @tmpSite TABLE (site VARCHAR(30), currencyName VARCHAR(10), currency TINYINT)
CREATE TABLE #tblSMA(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO @tmpSite(site,currencyName)
SELECT 'BEST-ODDS','RM'
UNION SELECT '733333','RM'
UNION SELECT '222223','RM'
UNION SELECT '722222','RM'
UNION SELECT 'XYZBet','RM'

UPDATE t
SET t.currency = e.exchangeid
FROM @tmpSite t
	INNER JOIN exchange e (NOLOCK) ON t.currencyName = e.currency

SELECT ci.custid, ci.username 
INTO #WrongDirectMaster
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.vw_customer ci WITH (NOLOCK) ON ci.custid = ca.CustID
	INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
WHERE ci.srecommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 3					
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
SELECT ci.custid, ci.username 
INTO #WrongDirectAgent
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.vw_customer ci WITH (NOLOCK) ON ci.custid = ca.CustID
	INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
WHERE ci.mrecommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 2					
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
SELECT ci.custid, ci.username 
INTO #WrongDirectMember
FROM dbo.CustDirectAccount ca WITH (NOLOCK)
	INNER JOIN dbo.vw_customer ci WITH (NOLOCK) ON ci.custid = ca.CustID
	INNER JOIN dbo.vw_customer agent WITH (NOLOCK) ON agent.custid = ci.recommend
	INNER JOIN @tmpSite t ON agent.site = t.site AND ci.currency = t.currency
WHERE ci.recommend NOT IN (SELECT custid FROM dbo.Acc_CustDirect cd WITH (NOLOCK))
	AND ci.roleid = 1					
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
-- get dummy super list
SELECT DISTINCT srecommend custid 
INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid
	 INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
WHERE  ci.roleid IN (2, 3) 	
	AND ci.custid NOT IN (SELECT custid FROM #WrongDirectMaster
						UNION  SELECT custid FROM #WrongDirectAgent )						
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
UNION
SELECT DISTINCT ci.srecommend
FROM CustDirectAccount da WITH (NOLOCK)
    INNER JOIN vw_customer ci WITH(NOLOCK) ON da.CustID = ci.custid    
	INNER JOIN dbo.vw_customer agent WITH (NOLOCK) ON agent.custid = ci.recommend
	INNER JOIN @tmpSite t ON agent.site = t.site AND ci.currency = t.currency
WHERE ci.roleid IN (1) 	
	AND ci.custid NOT IN (SELECT custid FROM #WrongDirectMember)
	AND ci.srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

--PhoneBetting
CREATE TABLE #PhoneBetting(mrecommend INT, recommend INT)

--8069 rows affected
INSERT INTO #PhoneBetting(mrecommend,recommend)	
SELECT DISTINCT mrecommend,recommend
FROM dbo.PhoneBettingCustomerList p WITH(NOLOCK)
	INNER JOIN vw_Customer c WITH(NOLOCK) ON p.username = c.username
	
--Get supers normal/direct masters/direct agents
INSERT INTO #tblSMA(custid)
SELECT DISTINCT ci.custid
FROM vw_customer ci WITH (NOLOCK) 
	INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid	
	INNER JOIN custsetting co WITH(NOLOCK) ON ci.custid = co.custid
	INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid	
WHERE ci.roleid = 4  	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0	
	AND cs.IsInternal=0
	AND ci.custid>=100
	AND ci.custid not in (select custid from #dummySuper)
	AND ci.username not like '3rdSuper%'
    AND ci.username not IN ( 'STAFF')
    AND ci.username not like 'SuperTest%'
    AND ci.username not like 'STEST%'
    AND ci.username not like 'SIBC%'
    AND ci.username not like '%ACCSuper%'
	AND cu.closed=0 
	AND (co.spositiontaking = @PT 
		OR (co.sporttype = 1 AND co.bettype IN (1,3,7,8) AND co.slivepositiontaking = @PT)
		OR (co2.sporttype IN (43,44) AND co2.SuperPT = @PT*100)
		)
--Direct masters exclude who has  phone betting	members
UNION ALL
	SELECT DISTINCT ci.custid
	FROM vw_customer ci with(nolock)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid		
		INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
		INNER JOIN custsetting co WITH(NOLOCK) ON ci.custid = co.custid
		INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 		
		AND ci.srecommend IN (SELECT custid FROM #dummySuper)
		AND c.Enabled=1
		AND c.closed=0 
		AND c.custid NOT IN (SELECT custid from #WrongDirectMaster)
		AND c.custid NOT IN (SELECT mrecommend FROM #PhoneBetting)
		AND (co.mpositiontaking = @PT 
			OR (co.sporttype = 1 AND co.bettype IN (1,3,7,8) AND co.mlivepositiontaking = @PT)
			OR (co2.sporttype IN (43,44) AND co2.MasterPT = @PT*100)
			)
		AND ci.custid NOT IN (3645792)--M9999RM		
UNION ALL	
--Direct agents exclude who has  phone betting	members
	SELECT DISTINCT ci.custid
	FROM vw_Customer ci WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid		
		INNER JOIN @tmpSite t ON ci.site = t.site AND ci.currency = t.currency
		INNER JOIN custsetting co WITH(NOLOCK) ON ci.custid = co.custid
		INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid
	WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid = 2 		
		AND ci.srecommend IN (SELECT custid FROM #dummySuper)
		AND c.Enabled=1
		AND c.closed=0 
		AND c.custid NOT IN (SELECT custid FROM #WrongDirectAgent)
		AND c.custid NOT IN (SELECT recommend FROM #PhoneBetting)
		AND (co.apositiontaking = @PT 
			OR (co.sporttype = 1 AND co.bettype IN (1,3,7,8) AND co.alivepositiontaking = @PT)
			OR (co2.sporttype IN (43,44) AND co2.AgentPT = @PT*100)
			)

DELETE #tblSMA WHERE custid IN (726582,13469206)--KAM,JARWRONG

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #tblSMA )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tblSMA
	SET isfinished = 1
		,@custid = custid		
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting_19] 
			@custid = @custid, 			
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END			
GO	
			
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
-----------------------------------------------------------------------------------	







