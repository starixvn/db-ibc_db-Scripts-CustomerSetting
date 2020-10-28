/*
	Created: 20201022@Johnson
	Task: update min/max pt for 789y's supers
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid INT,			
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF NOT(dbo.f_CheckRepTable('custinfo') = 1 
		AND dbo.f_CheckRepTable('CustSetting') = 1 
	    AND dbo.f_CheckRepTable('CustOverride') = 1 
	    AND dbo.f_CheckRepTable('CustSettingGame') = 1 
	    AND dbo.f_CheckRepTable('CustOverrideGame') = 1 
	    AND dbo.f_CheckRepTable('CustSetting3rd') = 1 
	    AND dbo.f_CheckRepTable('CustOverride3rd') = 1 
		AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1 	    		
		AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
		AND dbo.f_CheckRepTable('CustSettingGame') = 1		
	    )
	   RETURN
	  
	DECLARE @PT SMALLMONEY = 0.805
	
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
	SELECT @PT = 0.805
	
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
		maxlivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) AND @PT > maxlivepositiontaking THEN @PT ELSE maxlivepositiontaking END,

		minpositiontaking = CASE WHEN bettype IN (81,83,86,88) AND @PT > minpositiontaking THEN @PT ELSE minpositiontaking END,							
		minlivepositiontaking = CASE WHEN bettype IN (85,86,87,89,90) AND @PT > minlivepositiontaking THEN @PT ELSE minlivepositiontaking END		
	FROM custoverride3rd cs WITH(ROWLOCK, UPDLOCK)				
	WHERE custid = @custid
		AND sporttype = 161
	
	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @custid, 
									@roleid = 4, 
									@mode = 'number',
									@Target = @Target	

	--RnG Keno
	SELECT @PT = 0.805
	
	UPDATE CustSettingGame WITH(UPDLOCK,ROWLOCK)
    SET spositiontaking = @PT
    WHERE custid = @custid 
		AND sporttype = 202
		AND bettype IN (1501,1503,1504,1505,1508,1511,1513,1514)
	
	
	UPDATE CustOverrideGame WITH(UPDLOCK,ROWLOCK)
	SET minpositiontaking = CASE WHEN @PT > minpositiontaking THEN @PT ELSE minpositiontaking END
	WHERE custid = @custid 
		AND sporttype = 202
	
	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @custid, 
									@roleid = 4, 
									@sporttype = 202,
									@mode = 'Keno',
									@Target = @Target								
									
	--GoldDeluxe
	SELECT @PT = 0.805
	
	UPDATE CustSettingGame WITH(UPDLOCK,ROWLOCK)
    SET spositiontaking = @PT
    WHERE custid = @custid 
		AND sporttype = 255
		AND bettype = 1701
	

	UPDATE CustOverrideGame WITH(UPDLOCK,ROWLOCK)
	SET minpositiontaking = CASE WHEN @PT > minpositiontaking THEN @PT ELSE minpositiontaking END
	WHERE custid = @custid 
		AND sporttype = 255
	
	EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @custid, 
									@roleid = 4, 
									@sporttype = 255,									
									@mode = 'GoldDeluxe',
									@Target = @Target
	
	--> FOR DCS products
	DECLARE @tmpSport TABLE (sporttype INT)
	
	INSERT INTO @tmpSport(sporttype)
	SELECT 43 --E-Sports
	UNION SELECT 44	--Muay Thai
	UNION SELECT 180 --	Virtual Soccer
	UNION SELECT 181 --	Virtual Horse Racing
	UNION SELECT 182 --	Virtual Greyhounds
	UNION SELECT 183 --	Virtual Speedway
	UNION SELECT 184 --	Virtual Motorsports
	UNION SELECT 185 --	Virtual Cycling
	UNION SELECT 186 --	Virtual Tennis
	UNION SELECT 190 --	Virtual Soccer League
	UNION SELECT 191 --	Virtual Soccer Nation
	UNION SELECT 192 --	Virtual Soccer World Cup
	UNION SELECT 193 --	Virtual Basketball
	UNION SELECT 200 -- Saba.club
	UNION SELECT 211 --Allbet
	UNION SELECT 212 --	Macau Games
	UNION SELECT 213 --	N
	UNION SELECT 214 --	Sa
	UNION SELECT 215 --	Sb
	UNION SELECT 217 --	Sp
	UNION SELECT 218 --	S a+b
	UNION SELECT 219 --	Fishing World
	UNION SELECT 220 --	Lottery
	UNION SELECT 222 --	Table Game
	UNION SELECT 224 --	RNG War
	UNION SELECT 225 --	ION
	UNION SELECT 241 --	BBIN
	UNION SELECT 243 --	AE Casino
	UNION SELECT 244 --	SA Gaming
	UNION SELECT 245 --	Virtual Games
	
	DECLARE @xml XML;
	SET @xml = (
				SELECT (
						SELECT SportType AS '@SportType'
							, BetType AS '@BetType'
							, IsLive AS '@IsLive'
						FROM dbo.ProductSettingDetail WITH(NOLOCK)
						WHERE settingtype IN (1 ,18)
							  AND SportType IN (SELECT sporttype FROM @tmpSport)
						FOR XML PATH('PT')
							, TYPE
						)
				FOR XML PATH('ROOT')
					, TYPE
				);
	DECLARE @SportBettypeXML NVARCHAR(MAX) = CONVERT(NVARCHAR(MAX),@xml);
	
	SET @PT = 80.5
	
	UPDATE cs 
	SET cs.MaxPT = CASE WHEN cs.MaxPT < @PT THEN @PT ELSE cs.MaxPT END,
		cs.MinPT = CASE WHEN cs.MinPT < @PT THEN @PT ELSE cs.MinPT END, 
						
		cs.SuperPT  =  @PT ,
		cs.MasterPT =  cs.MasterPT + @PT - cs.SuperPT ,
		cs.AgentPT  =  cs.AgentPT + @PT - cs.SuperPT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)	
		INNER JOIN @tmpSport t ON cs.sporttype = t.sporttype
	WHERE custid = @custid		
		
	EXEC dbo.Acc_DynamicCustSetting3rd_08 				
				@SuperID = @custid	
				,@Roleid = 4		
				,@SportBettypeXML = @SportBettypeXML
				,@Target = @Target	
	
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
WHERE roleid = 4
	AND site IN ('789y')
	AND custid IN (SELECT custid
					FROM Acc_CustGroup (NOLOCK)
					WHERE GroupName in ('ACCUT','ACCYEN789','ACCYEN889')					
					)
	
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
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB SERVER -----
--------------------------------------------------------------------------------------
DECLARE @custid INT

CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Supers(custid)
SELECT custid
FROM vw_customer WITH(NOLOCK)
WHERE roleid = 4
	AND site IN ('789y')
	AND custid IN (SELECT custid
					FROM Acc_CustGroup (NOLOCK)
					WHERE GroupName in ('ACCUT','ACCYEN789','ACCYEN889')					
					)
					
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
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB SERVER -----
-----------------------------------------------------------------------------------	
		