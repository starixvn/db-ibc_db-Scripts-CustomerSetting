/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230919@Johnson
	Task: update minPT for SB,SB2 for 611111
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid int,	
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustOverride') = 0 RETURN	
	IF dbo.f_CheckRepTable('custSetting') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	

	DECLARE @PT smallmoney = 0.93
		
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
	
	EXEC dbo.Acc_CustSetting_18 @custid = @custid, @srecommend = @custid, @roleid = 4, @Target = @Target						
		
		
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
	

	UPDATE cs 
	SET cs.MaxPT = CASE WHEN cs.MaxPT < @PT * 100 THEN @PT*100 ELSE cs.MaxPT END,
		cs.MinPT = CASE WHEN cs.MinPT < @PT * 100 THEN @PT*100 ELSE cs.MinPT END,
		cs.SuperPT  =  @PT * 100 ,
		cs.MasterPT =  cs.MasterPT + @PT * 100 - cs.SuperPT ,
		cs.AgentPT  =  cs.AgentPT + @PT * 100 - cs.SuperPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)		
	WHERE cs.SportType IN (43,44) 
		AND custid = @custid
		
	EXEC dbo.Acc_DynamicCustSetting3rd_09 
				@AgentID = 0
				,@MasterID = 0
				,@SuperID = @custid
				,@roleid = 4
				,@SportBettypeXML = @SportBettypeXML
				,@Target = @Target
END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @custid INT,
		@PT SMALLMONEY = 0.88,
		@Target VARCHAR(20)
	
CREATE TABLE #tblSMA(CustID INT, isfinished BIT DEFAULT(0))

IF @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SELECT @Target = 'DBCUST'
ELSE 	
	SELECT @Target = 'REPLICATED'
		
--Get supers normal/direct masters/direct agents
INSERT INTO #tblSMA(custid)	
SELECT DISTINCT ci.custid
FROM vw_customer ci WITH (NOLOCK) 
    INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
    INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site 
    INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid  
    INNER JOIN custsetting co WITH(NOLOCK) ON ci.custid = co.custid
    INNER JOIN CustPTSetting3rd_Agent co2 WITH(NOLOCK) ON ci.custid = co2.custid    
WHERE ci.roleid = 4     
    AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
    AND s.islicensee = 0    
    AND cs.IsInternal=0
    AND ci.custid>=100   
    AND ci.username not like '3rdSuper%'   
    AND ci.site = '611111' 
    AND cu.Enabled = 1
    AND cu.currency NOT IN (20,72)
    AND (co.spositiontaking = @PT 
        OR (co.sporttype = 1 AND co.bettype IN (1,3,7,8) AND co.slivepositiontaking = @PT)
        OR (co2.sporttype IN (43,44) AND co2.SuperPT = @PT*100)
        )

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
			@target = @target
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #tblSMA	
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	
				