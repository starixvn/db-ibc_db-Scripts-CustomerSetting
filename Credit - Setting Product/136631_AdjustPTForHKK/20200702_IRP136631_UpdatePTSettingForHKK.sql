/*
	Created: 20200702@Johnson
	Task: update min/max pt for HKK's supers
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid INT,		
	--@maxcustid INT,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
		if NOT(dbo.f_CheckRepTable('custinfo') = 1 
		AND dbo.f_CheckRepTable('CustSetting') = 1 
	    AND dbo.f_CheckRepTable('CustOverride') = 1 
	    AND dbo.f_CheckRepTable('CustSettingGame') = 1 
	    AND dbo.f_CheckRepTable('CustOverrideGame') = 1 
	    AND dbo.f_CheckRepTable('CustSetting3rd') = 1 
	    AND dbo.f_CheckRepTable('CustOverride3rd') = 1 
		AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1 	    		
	    )
	   RETURN
	   
	DECLARE @PT SMALLMONEY = 0.88
	
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
	
	EXEC dbo.Acc_CustSetting_18 @srecommend = @custid, @roleid = 4, @Target = @Target						
	
	
	--Number Game
	SELECT @PT = 0.85
	
	UPDATE custsetting3rd with (ROWLOCK, UPDLOCK)
    SET
        spositiontaking = CASE WHEN bettype IN (81,83,86,88) THEN @PT ELSE spositiontaking END,
        mpositiontaking = CASE WHEN bettype IN (81,83,86,88) THEN mpositiontaking + @PT - spositiontaking ELSE mpositiontaking END,
		apositiontaking = CASE WHEN bettype IN (81,83,86,88) THEN apositiontaking + @PT - spositiontaking ELSE apositiontaking END,
		
        slivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) THEN @PT ELSE slivepositiontaking END ,
        mlivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) THEN mlivepositiontaking + @PT - slivepositiontaking ELSE mlivepositiontaking END ,
        alivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) THEN alivepositiontaking + @PT - slivepositiontaking ELSE mlivepositiontaking END 
    WHERE custid=@custid and sporttype = 161
	
	UPDATE cs 
	SET maxpositiontaking = CASE WHEN bettype IN (81,83,86,88) AND @PT > maxpositiontaking THEN @PT ELSE maxpositiontaking END,							
		maxlivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) AND @PT > maxlivepositiontaking THEN @PT ELSE maxlivepositiontaking END		
	FROM custoverride3rd cs WITH(ROWLOCK, UPDLOCK)				
	WHERE custid = @custid
		AND sporttype = 161
	
	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @custid, 
									@roleid = 4, 
									@mode = 'number',
									@Target = @Target	
	
	--RnG Keno
	SELECT @PT = 0.85
	
	UPDATE CustSettingGame WITH(UPDLOCK,ROWLOCK)
    SET spositiontaking = @PT
    WHERE custid = @custid 
		AND sporttype = 202
		AND bettype IN (1501,1503,1504,1505,1508,1511,1513,1514)
	
	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @custid, 
									@roleid = 4, 
									@sporttype = 202,
									@mode = 'Keno',
									@Target = @Target
	
	--GoldDeluxe
	SELECT @PT = 0.93
	
	UPDATE CustSettingGame WITH(UPDLOCK,ROWLOCK)
    SET spositiontaking = @PT
    WHERE custid = @custid 
		AND sporttype = 255
		AND bettype = 1701
		
	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @custid, 
									@roleid = 4, 
									@sporttype = 255,									
									@mode = 'GoldDeluxe',
									@Target = @Target
									
	--> FOR DCS products
	DECLARE @tmpSettings TABLE (sporttype INT, PT SMALLINT)
	
	INSERT INTO @tmpSettings(sporttype,PT)
	SELECT 43, 88 --E-Sports
	UNION SELECT 44, 88	--Muay Thai
	UNION SELECT 180, 85 --	Virtual Soccer
	UNION SELECT 181, 85 --	Virtual Horse Racing
	UNION SELECT 182, 85 --	Virtual Greyhounds
	UNION SELECT 183, 85 --	Virtual Speedway
	UNION SELECT 184, 85 --	Virtual Motorsports
	UNION SELECT 185, 85 --	Virtual Cycling
	UNION SELECT 186, 85 --	Virtual Tennis
	UNION SELECT 190, 85 --	Virtual Soccer League
	UNION SELECT 191, 85 --	Virtual Soccer Nation
	UNION SELECT 192, 85 --	Virtual Soccer World Cup
	UNION SELECT 193, 85 --	Virtual Basketball
	UNION SELECT 211, 93 --Allbet
	UNION SELECT 212, 85 --	Macau Games
	UNION SELECT 219, 90 --	Fishing World
	UNION SELECT 220, 85 --	Lottery
	UNION SELECT 222, 85 --	Table Game
	UNION SELECT 224, 85 --	RNG War
	UNION SELECT 225, 85 --	ION
	UNION SELECT 241, 85 --	BBIN
	UNION SELECT 243, 85 --	Sexy Gaming
	UNION SELECT 244, 93 --	SA Gaming
	UNION SELECT 245, 90 --	Virtual Games
	
	DECLARE @xml XML;
	SET @xml = (
				SELECT (
						SELECT SportType AS '@SportType'
							, BetType AS '@BetType'
							, IsLive AS '@IsLive'
						FROM dbo.ProductSettingDetail WITH(NOLOCK)
						WHERE settingtype = 1 
							  AND SportType IN (SELECT sporttype FROM @tmpSettings)
						FOR XML PATH('PT')
							, TYPE
						)
				FOR XML PATH('ROOT')
					, TYPE
				);
	DECLARE @SportBettypeXML NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX),@xml);
	
	UPDATE cs 
	SET cs.MaxPT = CASE WHEN cs.MaxPT < t.PT THEN t.PT ELSE cs.MaxPT END,
		cs.MinPT = CASE WHEN  cs.sporttype IN (43,44) 
						THEN CASE WHEN cs.MinPT < t.PT THEN t.PT ELSE cs.MinPT END 
						ELSE cs.MinPT END,
		cs.SuperPT  =  t.PT ,
		cs.MasterPT =  cs.MasterPT + t.PT - cs.SuperPT ,
		cs.AgentPT  =  cs.AgentPT + t.PT - cs.SuperPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)	
		INNER JOIN @tmpSettings t ON cs.sporttype = t.sporttype
	WHERE custid = @custid
		
	EXEC dbo.Acc_DynamicCustSetting3rd_08 				
				@SuperID = @custid	
				,@Roleid = 4		
				,@SportBettypeXML = @SportBettypeXML
				,@Target = @Target	
	
	--update LossLimit & bet setting
	/*CREATE TABLE #Downlines (custid INT PRIMARY KEY, roleid TINYINT, isfinished BIT DEFAULT 0)
	
	INSERT INTO #Downlines (custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK)
	WHERE srecommend = @custid
		AND Enabled = 1
		AND custid <= @maxcustid
		
	DECLARE @BatchMember TABLE(custid PRIMARY KEY, roleid TINYINT)
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP (5000) t
		SET isfinished = 1
		OUTPUT DELETED.custid, DELTED.roleid INTO @BatchMember(custid,roleid)
		FROM #Downlines
		WHERE isfinished = 0
		ORDER BY roleid DESC
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE cs
		SET MaxLossLimit = 500000
		FROM CustWinLimit cs WITH (UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchMember)
			AND sporttype IN (208) --casino
			AND MaxLossLimit > 500000
		
		UPDATE cs 
		SET MaxLossLimit = 500000
		FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
		WHERE cs.custid IN (SELECT custid FROM @BatchMember WHERE roleid > 1)
			AND sporttype IN (180	,--	Virtual Soccer							
								211	,--	Allbet
								212	,--	Macau Games
								220	,--	Lottery
								222	,--	Table Game
								224	,--	RNG War
								225	,--	ION								
								243	,--	Sexy Gaming
								244	,--	SA Gaming
								245	,--	Virtual Games
								219	,--	Fishing World
								241	--	BBIN
							)	
			AND MaxLossLimit > 500000
			
		UPDATE cs 
		SET MaxLossLimit = 500000
		FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
		WHERE cs.custid IN (SELECT custid FROM @BatchMember WHERE roleid = 1)
			AND sporttype IN (180	,--	Virtual Soccer							
								211	,--	Allbet
								212	,--	Macau Games
								220	,--	Lottery
								222	,--	Table Game
								224	,--	RNG War
								225	,--	ION								
								243	,--	Sexy Gaming
								244	,--	SA Gaming
								245	,--	Virtual Games
								219	,--	Fishing World
								241	--	BBIN
							)	
			AND MaxLossLimit > 500000	
	END*/
END
GO


-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @custid INT

CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE currency = 67
	AND roleid = 4
	AND site IN ('733333','222223','722222')
			
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
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
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
DECLARE @custid INT

CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE currency = 67
	AND roleid = 4
	AND site IN ('733333','222223','722222')
			
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #Supers )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
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
	


	

