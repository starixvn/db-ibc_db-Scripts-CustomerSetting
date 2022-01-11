/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211217@Johnson
	Task: update minPT for Non-sports for Malaysia market
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@custid INT, 	
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustOverrideGame') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN
	IF dbo.f_CheckRepTable('CustOverride3rd') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustSetting3rd') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	
	DECLARE @roleid INT, 
			@srecommend INT, 
			@mrecommend INT, 
			@recommend INT,
			@PT SMALLMONEY
	
	SELECT @roleid = roleid, @srecommend=srecommend, @mrecommend=mrecommend, @recommend=recommend FROM customer WITH (NOLOCK) WHERE custid = @custid		
		
	--Keno		
	IF @roleid = 4
	BEGIN
		SELECT @PT = spositiontaking
		FROM CustSettingGame WITH(NOLOCK)		
		WHERE custid = @custid
			AND sporttype = 202
			AND bettype = 1501
			
		UPDATE CustOverrideGame WITH(UPDLOCK, ROWLOCK)
		SET minpositiontaking = @PT
		WHERE custid = @custid
			AND sporttype = 202
			AND bettype = 1501
			AND minpositiontaking <> @PT
		
		IF @@ROWCOUNT > 0
			EXEC Acc_CustSetting3rd_18 @srecommend = @CustID, @roleid = 4, @mode = 'Keno', @sporttype = 202, @bettype = 1501, @Target = @Target				
	END
	ELSE IF @roleid = 3
    BEGIN
		SELECT @PT = mpositiontaking
		FROM CustSettingGame WITH(NOLOCK)		
		WHERE custid = @custid
			AND sporttype = 202
			AND bettype = 1501
			
		UPDATE CustOverrideGame WITH(UPDLOCK, ROWLOCK)
		SET minpositiontaking = @PT
		WHERE custid = @custid
			AND sporttype = 202
			AND bettype = 1501
			AND minpositiontaking <> @PT
			
		IF @@ROWCOUNT > 0
			EXEC Acc_CustSetting3rd_18 @custid = @CustID, @srecommend = @srecommend, @roleid = 3, @mode = 'Keno', @sporttype = 202, @bettype = 1501, @Target = @Target        
    END
    ELSE IF @roleid = 2
    BEGIN        
		SELECT @PT = apositiontaking
		FROM CustSettingGame WITH(NOLOCK)		
		WHERE custid = @custid
			AND sporttype = 202
			AND bettype = 1501
			
		UPDATE CustOverrideGame WITH(UPDLOCK, ROWLOCK)
		SET minpositiontaking = @PT
		WHERE custid = @custid
			AND sporttype = 202
			AND bettype = 1501
			AND minpositiontaking <> @PT
			
		IF @@ROWCOUNT > 0
			EXEC Acc_CustSetting3rd_18 @custid = @CustID, @mrecommend = @mrecommend, @roleid = 2, @mode = 'Keno', @sporttype = 202, @bettype = 1501, @Target = @Target	        
    END 
	
	--Number Game
	IF @roleid = 4
	BEGIN
		 --v161
		UPDATE co
		SET minpositiontaking = b.minpositiontaking, minlivepositiontaking = b.minlivepositiontaking
		FROM custoverride3rd co WITH(ROWLOCK)
		INNER JOIN     
			(SELECT custid, sporttype, bettype, 
				CASE WHEN bettype IN (81,83,86,88) THEN spositiontaking ELSE 0 END as minpositiontaking, 
				CASE WHEN bettype IN (85,86,87,89,90) THEN slivepositiontaking ELSE 0 END as minlivepositiontaking
			FROM CustSetting3rd WITH(NOLOCK)
			WHERE custid = @custid
				AND sporttype = 161
			)b on co.custid = b.custid and co.sporttype=b.sporttype and co.bettype = b.bettype
		WHERE co.minpositiontaking <> b.minpositiontaking
			OR co.minlivepositiontaking <> b.minlivepositiontaking
		
		IF @@ROWCOUNT > 0
			EXEC dbo.Acc_CustSetting3rd_18 @srecommend = @srecommend, @roleid = 4, @mode = 'number', @Target = @Target
	END
	ELSE IF @roleid = 3
	BEGIN
		UPDATE co
		SET minpositiontaking = b.minpositiontaking, minlivepositiontaking = b.minlivepositiontaking
		FROM custoverride3rd co WITH(ROWLOCK)
		INNER JOIN     
			(SELECT custid, sporttype, bettype, 
				CASE WHEN bettype IN (81,83,86,88) THEN mpositiontaking ELSE 0 END as minpositiontaking, 
				CASE WHEN bettype IN (85,86,87,89,90) THEN mlivepositiontaking ELSE 0 END as minlivepositiontaking
			FROM CustSetting3rd WITH(NOLOCK)
			WHERE custid = @custid
				AND sporttype = 161
			)b on co.custid = b.custid and co.sporttype=b.sporttype and co.bettype = b.bettype
		WHERE co.minpositiontaking <> b.minpositiontaking
			OR co.minlivepositiontaking <> b.minlivepositiontaking
		
		IF @@ROWCOUNT > 0	
			EXEC dbo.Acc_CustSetting3rd_18 @mrecommend = @mrecommend, @srecommend = @srecommend, @roleid = 3, @mode = 'number', @Target = @Target
	END
	ELSE IF @roleid = 2
	BEGIN
		UPDATE co
		SET minpositiontaking = b.minpositiontaking, minlivepositiontaking = b.minlivepositiontaking
		FROM custoverride3rd co WITH(ROWLOCK)
		INNER JOIN     
			(SELECT custid, sporttype, bettype, 
				CASE WHEN bettype IN (81,83,86,88) THEN apositiontaking ELSE 0 END as minpositiontaking, 
				CASE WHEN bettype IN (85,86,87,89,90) THEN alivepositiontaking ELSE 0 END as minlivepositiontaking
			FROM CustSetting3rd WITH(NOLOCK)
			WHERE custid = @custid
				AND sporttype = 161
			)b on co.custid = b.custid and co.sporttype=b.sporttype and co.bettype = b.bettype
		WHERE co.minpositiontaking <> b.minpositiontaking
			OR co.minlivepositiontaking <> b.minlivepositiontaking
		
		IF @@ROWCOUNT > 0
			EXEC dbo.Acc_CustSetting3rd_18 @recommend = @recommend, @mrecommend = @mrecommend, @srecommend = @srecommend, @roleid = 2, @mode = 'number', @Target = @Target
	END
	
	--> FOR non-sports DCS
	DECLARE @tmpSport TABLE (sporttype INT, bettype INT, isLive BIT)
	
	INSERT INTO @tmpSport(sporttype,bettype,isLive)
	SELECT sporttype,bettype,isLive
	FROM dbo.ProductSettingDetail WITH(NOLOCK)
	WHERE settingtype IN (1,18)
		AND settingstatus = 0	
		AND SportType IN (175,--bitcoin
					245,--virtual games
					171,--VGaming
					169,220,222,224,--RnG Lottery
					219,--FW
					212,---Macau games
					170,211,225,233,236,239,241,242,243,244,--Live casino
					180,181,182,183,184,185,186,190,191,192,193,231--Virtual Sport
		  )
							  
	DECLARE @xml XML;
	SET @xml = (
				SELECT (
						SELECT SportType AS '@SportType'
							, BetType AS '@BetType'
							, IsLive AS '@IsLive'
						FROM @tmpSport
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
		SET cs.MinPT = cs.SuperPT
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @tmpSport b ON cs.Sporttype = b.SportType
									AND cs.bettype = b.BetType
									AND cs.isLive = b.IsLive								
		WHERE cs.custid = @custid
			AND cs.MinPT <> cs.SuperPT
		
		IF @@ROWCOUNT > 0		
			EXEC dbo.Acc_DynamicCustSetting3rd_08 
				@SuperID = @custid
				,@RoleID = 4
				,@SportBettypeXML = @SportBettypeXML
	END
	ELSE IF @roleid = 3
	BEGIN
		UPDATE cs
		SET cs.MinPT = cs.MasterPT
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @tmpSport b ON cs.Sporttype = b.SportType
									AND cs.bettype = b.BetType
									AND cs.isLive = b.IsLive								
		WHERE cs.custid = @custid
			AND cs.MinPT <> cs.MasterPT
		
		IF @@ROWCOUNT > 0	
			EXEC dbo.Acc_DynamicCustSetting3rd_08 
				@MasterID = @custid
				,@SuperID = @srecommend
				,@RoleID = 3
				,@SportBettypeXML = @SportBettypeXML
	END
	ELSE IF @roleid = 2
	BEGIN
		UPDATE cs
		SET cs.MinPT = cs.AgentPT
		FROM CustPTSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @tmpSport b ON cs.Sporttype = b.SportType
									AND cs.bettype = b.BetType
									AND cs.isLive = b.IsLive								
		WHERE cs.custid = @custid
			AND cs.MinPT <> cs.AgentPT
		
		IF @@ROWCOUNT > 0	
			EXEC dbo.Acc_DynamicCustSetting3rd_08 
				@AgentID = @custid
				,@MasterID = @mrecommend
				,@SuperID = @srecommend
				,@RoleID = 2
				,@SportBettypeXML = @SportBettypeXML
	END
END	
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @custid INT
		
CREATE TABLE #tblSMA(CustID INT, isfinished BIT DEFAULT(0))

--PhoneBetting
CREATE TABLE #PhoneBetting(mrecommend INT, recommend INT)

--115 rows affected
INSERT INTO #PhoneBetting(mrecommend,recommend)	
SELECT DISTINCT mrecommend,recommend
FROM dbo.PhoneBettingCustomerList p WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON p.username = c.username
	
-- get dummy super list
SELECT DISTINCT srecommend custid 
INTO #dummySuper
FROM CustDirectAccount da WITH (NOLOCK)
     INNER JOIN customer ci WITH(NOLOCK) ON da.CustID = ci.custid	 
WHERE  ci.roleid IN (1, 2, 3) 	
	AND ci.site IN ('BEST-ODDS','INDO','IBCIndo','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet','76666B')				
	AND srecommend NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	
--Get supers normal/direct masters/direct agents
INSERT INTO #tblSMA(custid)
SELECT DISTINCT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site	
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid		
WHERE ci.roleid = 4 
	AND ci.site IN ('BEST-ODDS','INDO','IBCIndo','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet','76666B')	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND ci.custid NOT IN (SELECT custid FROM #dummySuper)
	AND cu.Enabled = 1
	AND s.islicensee = 0	
	AND cs.IsInternal=0
	AND ci.custid>=100
	AND ci.username not like '3rdSuper%'   
--Direct masters exclude who has  phone betting	members
UNION ALL
	SELECT DISTINCT ci.custid
	FROM customer ci with(nolock)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
	WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid=3 
		AND ci.site IN ('BEST-ODDS','INDO','IBCIndo','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet','76666B')		
		AND c.Enabled=1				
		AND c.custid NOT IN (SELECT mrecommend FROM #PhoneBetting)		
UNION ALL	
--Direct agents exclude who has  phone betting	members
	SELECT DISTINCT ci.custid
	FROM customer ci WITH(NOLOCK)
		INNER JOIN custInfo c WITH(NOLOCK) ON ci.custid=c.custid				
	WHERE  EXISTS (SELECT custid FROM dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.roleid = 2 
		AND ci.site IN ('BEST-ODDS','INDO','IBCIndo','611111','733333','755555','222223','7aa666','KORIBC','722222','XYZBet','76666B')		
		AND c.Enabled=1		
		AND c.custid NOT IN (SELECT recommend FROM #PhoneBetting)


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
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@custid = @custid, 			
			@target = @target
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #tblSMA	
DROP TABLE #dummySuper	
DROP TABLE #PhoneBetting
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	
		