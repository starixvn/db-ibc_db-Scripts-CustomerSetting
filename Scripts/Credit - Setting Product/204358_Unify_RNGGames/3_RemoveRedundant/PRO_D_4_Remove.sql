/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: @Helios
	Date: 2024/06/21
	Task: Customer Setting - Unify RNG Lottery and Virtual Sports - Remove Data Redundant [redmine : #204358]
		https://nexdev.net/issues/204358
	DB: DBCUST/CustDB
*/

SET NOCOUNT ON
 
-----------------------------------Check New Structure RepInHouse is Exists---------------------------------

-- RUN THIS SCRIPT AT DBCUST AND ALL REPLICATED SERVERS

DECLARE
		@max_custid INT
	    , @target     VARCHAR(20)

	IF    @@servername IN ('DBCUST' , 'SITDBCUST' , 'TESTDBCUST')
		SET @target = 'DBCUST'
	ELSE
		SET @target = 'REPLICATED'

	PRINT 'Server Name : ' + @target

SELECT @max_custid = (SELECT MAX(CustID) FROM custInfo i )

---------------------------------------CREARE TEMP TABLE--------------------------------------

-- Create Temp Table stored SuperInfo
CREATE TABLE #Temp_SuperInfo
	(
		CustID	INT,
		PRIMARY KEY CLUSTERED (custid)
	)

-- Create Temp Table stored SportType - BetType...
CREATE TABLE #Temp_ProductSetting
	(
		  SportType   SMALLINT
		, BetType     SMALLINT
		, PRIMARY KEY CLUSTERED (Sporttype , BetType)
	)

-- Create Temp Table stored Setting
CREATE TABLE #Temp_Data
	(
		CustID		INT
	    , SportType		SMALLINT
	    , BetType		SMALLINT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)


---------------------------------------Declare Deployed Info---------------------------------------
DECLARE
	  @Batch				INT = 3000
	, @JsonData				VARCHAR(MAX)
	, @Msg				VARCHAR(200)
	, @Srecommend			INT
	, @ReadBatchSize			INT = 100000

CREATE TABLE #Temp_CustAffected
	(
		CustID		INT
	    , SportType		SMALLINT
	    , BetType		SMALLINT
	)
	
---------------------------------------Initial SportType-BetType---------------------------------------

INSERT INTO #Temp_ProductSetting 
	(
		SportType     , BetType
	)
SELECT	169		  , 3611		UNION ALL		-- Sports Lottery	
SELECT	202		  , 1501		UNION ALL		-- RNG Keno		
SELECT	9908		  , 1201		UNION ALL		-- Virtual Sports	
SELECT	220		  , 1024		UNION ALL		-- Lottery
SELECT	222		  , 4901		UNION ALL		-- Table Games

SELECT	161		  , 81		UNION ALL		-- Number Game 	
SELECT	164		  , 8101					-- Happy 5


---------------------------------------Collect Super Infor:---------------------------------------

INSERT INTO #Temp_SuperInfo (custid)
SELECT cu.custid
FROM Customer cu WITH (NOLOCK)
INNER JOIN custinfo ci WITH(NOLOCK) 
		ON ci.custid = cu.custid
INNER JOIN site s WITH (NOLOCK)
		ON cu.site = s.site
INNER JOIN exchange e WITH (NOLOCK)
		ON cu.currency = e.ExchangeId
		AND e.IsActive = 1
		AND e.OfferSite IN (0 , 1)
LEFT JOIN CustSuper cs WITH (NOLOCK)
		ON cu.custid = cs.custid
WHERE cu.roleid = 4
	AND ci.Enabled = 1
	AND s.isLicensee = 0
	AND s.IsActive = 1
	AND cu.username NOT LIKE '3rdSuper%'
	AND cs.IsInternal = 0
	AND cu.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
	--AND e.ExchangeId = 20	

---------------------------------------Remove Data BetSetting:---------------------------------------

-- Super/ Master/ Agent BetSetting:

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_Data
	-- Number Game (161) ,  Happy 5 (164)
	INSERT INTO #Temp_Data 
		(
			CustID
		    , SportType
		    , BetType
		)

	SELECT	TOP (@ReadBatchSize)
			bs.CustID
		    , bs.SportType
		    , bs.BetType
	FROM CustBetSetting_Agent bs WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK)			ON bs.CustID = i.custid
	INNER JOIN #Temp_SuperInfo tsi			ON i.srecommend = tsi.CustID
	INNER JOIN #Temp_ProductSetting tps			ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
	WHERE i.roleid IN (2,3,4)
	AND i.Enabled = 1
	AND tps.SportType IN (161,164)
	AND i.CustID <= @max_custid

	IF @@ROWCOUNT = 0 
		BREAK ;

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Temp_CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #Temp_CustAffected (CustID , SportType , BetType)
		FROM #Temp_Data s

		IF @@ROWCOUNT = 0 
			BREAK ;

		SELECT @JsonData = 
					(
						SELECT CustID , SportType , BetType
						FROM #Temp_CustAffected
							FOR JSON PATH
					)

		EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'BS_Agent_Remove'
									, @JsonData = @JsonData
									, @target	  = @target
	END

	WAITFOR DELAY '00:00:0.280'

	SET @Msg = 'curdt Remove SMA CustBetSetting_Agent: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT
END

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_Data
	-- Sports Lottery (169) , RNG Keno (202) , Lottery (220) , Table Game (222) , Virtual Sports (9908)
	INSERT INTO #Temp_Data 
		(
			CustID
		    , SportType
		    , BetType
		)

	SELECT	TOP (@ReadBatchSize)
			bs.CustID
		    , bs.SportType
		    , bs.BetType
	FROM CustBetSetting3rd_Agent bs WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK)			ON bs.CustID = i.custid
	INNER JOIN #Temp_SuperInfo tsi			ON i.srecommend = tsi.CustID
	INNER JOIN #Temp_ProductSetting tps			ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
	WHERE i.roleid IN (2,3,4)
	AND i.Enabled = 1
	AND tps.SportType NOT IN (161,164)
	AND i.CustID <= @max_custid

	IF @@ROWCOUNT = 0 
		BREAK ;

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Temp_CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #Temp_CustAffected (CustID , SportType , BetType)
		FROM #Temp_Data s

		IF @@ROWCOUNT = 0 
			BREAK ;

		SELECT @JsonData = 
					(
						SELECT CustID , SportType , BetType
						FROM #Temp_CustAffected
							FOR JSON PATH
					)

		EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'BS_3rdAgent_Remove'
									, @JsonData = @JsonData
									, @target	  = @target
	END
	
	WAITFOR DELAY '00:00:0.280'

	SET @Msg = 'curdt Remove SMA CustBetSetting3rd_Agent: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END

-- Member BetSetting:

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_Data
	-- Number Game (161) ,  Happy 5 (164)
	INSERT INTO #Temp_Data 
		(
			CustID
		    , SportType
		    , BetType
		)

	SELECT	TOP (@ReadBatchSize)
			bs.CustID
		    , bs.SportType
		    , bs.BetType
	FROM CustBetSetting_Member bs WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK)			ON bs.CustID = i.custid
	INNER JOIN #Temp_SuperInfo tsi			ON i.srecommend = tsi.CustID
	INNER JOIN #Temp_ProductSetting tps			ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
	WHERE i.roleid IN (1)
	AND i.Enabled = 1
	AND tps.SportType IN (161,164)
	AND i.CustID <= @max_custid

	IF @@ROWCOUNT = 0 
		BREAK ;

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Temp_CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #Temp_CustAffected (CustID , SportType , BetType)
		FROM #Temp_Data s

		IF @@ROWCOUNT = 0 
			BREAK ;

		SELECT @JsonData = 
					(
						SELECT CustID , SportType , BetType
						FROM #Temp_CustAffected
							FOR JSON PATH
					)

		EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'BS_Member_Remove'
									, @JsonData = @JsonData
									, @target	  = @target
	END

	WAITFOR DELAY '00:00:0.280'

	SET @Msg = 'curdt Remove Member CustBetSetting_Member: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT
END

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_Data
	-- Sports Lottery (169) , RNG Keno (202) , Lottery (220) , Table Game (222) , Virtual Sports (9908)
	INSERT INTO #Temp_Data 
		(
			CustID
		    , SportType
		    , BetType
		)

	SELECT	TOP (@ReadBatchSize)
			bs.CustID
		    , bs.SportType
		    , bs.BetType
	FROM CustBetSetting3rd_Member bs WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK)			ON bs.CustID = i.custid
	INNER JOIN #Temp_SuperInfo tsi			ON i.srecommend = tsi.CustID
	INNER JOIN #Temp_ProductSetting tps			ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
	WHERE i.roleid IN (1)
	AND i.Enabled = 1
	AND tps.SportType NOT IN (161,164)
	AND i.CustID <= @max_custid

	IF @@ROWCOUNT = 0 
		BREAK ;

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Temp_CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #Temp_CustAffected (CustID , SportType , BetType)
		FROM #Temp_Data s

		IF @@ROWCOUNT = 0 
			BREAK ;

		SELECT @JsonData = 
					(
						SELECT CustID , SportType , BetType
						FROM #Temp_CustAffected
							FOR JSON PATH
					)

		EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'BS_3rdMember_Remove'
									, @JsonData = @JsonData
									, @target	  = @target
	END
	
	WAITFOR DELAY '00:00:0.280'

	SET @Msg = 'curdt Remove SMA CustBetSetting3rd_Member: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END

---------------------------------------Remove Data PTSetting:---------------------------------------
-- Happy 5 don't have PT Setting
DELETE FROM #Temp_ProductSetting WHERE SportType = 164

-- Super/ Master/ Agent :

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_Data

	INSERT INTO #Temp_Data 
		(
			CustID
		    , SportType
		    , BetType
		)

	SELECT	TOP (@ReadBatchSize)
			bs.CustID
		    , bs.SportType
		    , bs.BetType
	FROM CustPTSetting3rd_Agent bs WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK)			ON bs.CustID = i.custid
	INNER JOIN #Temp_SuperInfo tsi			ON i.srecommend = tsi.CustID
	INNER JOIN #Temp_ProductSetting tps			ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
	WHERE i.roleid IN (2,3,4)
	AND i.Enabled = 1
	AND bs.IsLive = 0
	AND i.CustID <= @max_custid

	IF @@ROWCOUNT = 0 
		BREAK ;

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Temp_CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #Temp_CustAffected (CustID , SportType , BetType)
		FROM #Temp_Data s

		IF @@ROWCOUNT = 0 
			BREAK ;

		SELECT @JsonData = 
					(
						SELECT CustID , SportType , BetType
						FROM #Temp_CustAffected
							FOR JSON PATH
					)

		EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'PT_Agent_Remove'
									, @JsonData = @JsonData
									, @target	  = @target
	END

	WAITFOR DELAY '00:00:0.280'

	SET @Msg = 'curdt Remove SMA CustPTSetting3rd_Agent: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT
END


-- GroupMember:
WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_Data

	INSERT INTO #Temp_Data 
		(
			CustID
		    , SportType
		    , BetType
		)

	SELECT	TOP (@ReadBatchSize)
			bs.AgentID
		    , bs.SportType
		    , bs.BetType
	FROM CustPTGroupSetting3rd_Member bs WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK)			ON bs.AgentID = i.custid
	INNER JOIN #Temp_SuperInfo tsi			ON i.srecommend = tsi.CustID
	INNER JOIN #Temp_ProductSetting tps			ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
	WHERE i.roleid = 2
	AND i.Enabled = 1
	AND bs.IsLive = 0
	AND bs.AgentID <= @max_custid

	IF @@ROWCOUNT = 0 
		BREAK ;

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Temp_CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #Temp_CustAffected (CustID , SportType , BetType)
		FROM #Temp_Data s

		IF @@ROWCOUNT = 0 
			BREAK ;

		SELECT @JsonData = 
					(
						SELECT CustID , SportType , BetType
						FROM #Temp_CustAffected
							FOR JSON PATH
					)

		EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'PT_GroupMember_Remove'
									, @JsonData = @JsonData
									, @target	  = @target
	END

	WAITFOR DELAY '00:00:0.280'

	SET @Msg = 'curdt Remove GroupMember CustPTGroupSetting3rd_Member: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT
END

-- Member

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_Data

	INSERT INTO #Temp_Data 
		(
			CustID
		    , SportType
		    , BetType
		)

	SELECT	TOP (@ReadBatchSize)
			bs.CustID
		    , bs.SportType
		    , bs.BetType
	FROM CustPTSetting3rd_Member bs WITH (NOLOCK)
	INNER JOIN custInfo i WITH (NOLOCK)			ON bs.CustID = i.custid
	INNER JOIN #Temp_SuperInfo tsi			ON i.srecommend = tsi.CustID
	INNER JOIN #Temp_ProductSetting tps			ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
	WHERE i.roleid IN (1)
	AND i.Enabled = 1
	AND bs.IsLive = 0
	AND i.CustID <= @max_custid

	IF @@ROWCOUNT = 0 
		BREAK ;

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Temp_CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #Temp_CustAffected (CustID , SportType , BetType)
		FROM #Temp_Data s

		IF @@ROWCOUNT = 0 
			BREAK ;

		SELECT @JsonData = 
					(
						SELECT CustID , SportType , BetType
						FROM #Temp_CustAffected
							FOR JSON PATH
					)

		EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'PT_Member_Remove'
									, @JsonData = @JsonData
									, @target	  = @target
	END

	WAITFOR DELAY '00:00:0.280'

	SET @Msg = 'curdt Remove Member CustPTSetting3rd_Member: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT
END

DROP TABLE #Temp_ProductSetting
DROP TABLE #Temp_CustAffected
DROP TABLE #Temp_SuperInfo
DROP TABLE #Temp_Data