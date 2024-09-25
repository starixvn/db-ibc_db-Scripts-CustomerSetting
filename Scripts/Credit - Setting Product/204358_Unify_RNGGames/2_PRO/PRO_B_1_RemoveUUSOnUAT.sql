/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: @Helios
	Date: 2024/06/21
	Task: Customer Setting - Unify RNG Lottery and Virtual Sports - Migrate Data BetSetting to New Structure [redmine : #204358] 
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

SELECT @max_custid = xxx

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
CREATE TABLE #Temp_DataBetSetting
	(
		CustID		INT
	    , SportType		SMALLINT
	    , BetType		SMALLINT
	    ,	PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)


---------------------------------------Declare Deployed Info---------------------------------------
DECLARE
	  @Batch				INT = 3000
	, @JsonData				VARCHAR(MAX)
	, @Msg				VARCHAR(200)

CREATE TABLE #Temp_Cust
	(
		CustID		INT
	    , SportType		SMALLINT
	    , BetType		SMALLINT
	)
	

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
SELECT	202		  , 1501		UNION ALL		-- RNG Keno >> Keno/Lottery 		
SELECT	9908		  , 1201		UNION ALL		-- Virtual Sports		
SELECT	161		  , 81					-- Number Game 		


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
	AND e.ExchangeId = 20	

---------------------------------------Collect Cust List S/M/A on UAT:--------------------------------------- 

INSERT INTO #Temp_Cust 
	(
		CustID
	    , SportType
	    , BetType
	)
SELECT bsa.CustID , bsa.SportType , bsa.BetType
FROM CustBetSetting3rd_Agent cbsa WITH (NOLOCK)
INNER JOIN custInfo i WITH (NOLOCK)				ON cbsa.CustID = i.custid
INNER JOIN #Temp_SuperInfo tsi				ON i.srecommend = tsi.CustID
INNER JOIN #Temp_ProductSetting tps				ON cbsa.SportType = tps.SportType AND cbsa.BetType = tps.BetType
INNER JOIN BetSetting3rd_Agent bsa	WITH (NOLOCK)	ON cbsa.CustID = bsa.CustID AND cbsa.SportType = CASE WHEN bsa.SportType = 9919 THEN 202 ELSE  bsa.SportType END AND cbsa.BetType = bsa.BetType 
WHERE i.roleid IN (2,3,4)
AND i.Enabled = 1
AND tps.SportType <> 161
AND i.custid <= @max_custid

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_CustAffected

	DELETE TOP (@Batch) s WITH (ROWLOCK)
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
		INTO #Temp_CustAffected (CustID , SportType , BetType)
	FROM #Temp_Cust s

	IF @@ROWCOUNT = 0 
		BREAK ;

	SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType
					FROM #Temp_CustAffected
						FOR JSON PATH
				)

	EXEC dbo.[Acc_DynamicCustSetting3rd_16] @ModeCode = 'BS_SMA_Remove_On_UAT'
								, @JsonData = @JsonData
								, @target	  = @target

	WAITFOR DELAY '00:00:0.020'

	SET @Msg = 'curdt Done Remove SMA BetSetting3rd_Agent From CustBetSetting3rd_Agent: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END

TRUNCATE TABLE #Temp_Cust


INSERT INTO #Temp_Cust 
	(
		CustID
	    , SportType
	    , BetType
	)
SELECT bsa.CustID , bsa.SportType , bsa.BetType
FROM CustBetSetting_Agent cbsa WITH (NOLOCK)
INNER JOIN custInfo i WITH (NOLOCK)				ON cbsa.CustID = i.custid
INNER JOIN #Temp_SuperInfo tsi				ON i.srecommend = tsi.CustID
INNER JOIN #Temp_ProductSetting tps				ON cbsa.SportType = tps.SportType AND cbsa.BetType = tps.BetType
INNER JOIN BetSetting3rd_Agent bsa	WITH (NOLOCK)	ON cbsa.CustID = bsa.CustID AND cbsa.SportType = bsa.SportType AND cbsa.BetType = bsa.BetType 
WHERE i.roleid IN (2,3,4)
AND i.Enabled = 1
AND tps.SportType = 161
AND i.custid <= @max_custid


WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_CustAffected

	DELETE TOP (@Batch) s WITH (ROWLOCK)
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
		INTO #Temp_CustAffected (CustID , SportType , BetType)
	FROM #Temp_Cust s

	IF @@ROWCOUNT = 0 
		BREAK ;

	SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType
					FROM #Temp_CustAffected
						FOR JSON PATH
				)

	EXEC dbo.[Acc_DynamicCustSetting3rd_16] @ModeCode = 'BS_SMA_Remove_On_UAT'
								, @JsonData = @JsonData
								, @target	  = @target

	WAITFOR DELAY '00:00:0.020'

	SET @Msg = 'curdt Done Remove SMA BetSetting3rd_Agent From CustBetSetting_Agent: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END

TRUNCATE TABLE #Temp_Cust


---------------------------------------Collect Cust List Member on UAT:---------------------------------------

INSERT INTO #Temp_Cust 
	(
		CustID
	    , SportType
	    , BetType
	)
SELECT bsa.CustID , bsa.SportType , bsa.BetType
FROM CustBetSetting3rd_Member cbsa WITH (NOLOCK)
INNER JOIN custInfo i WITH (NOLOCK)				ON cbsa.CustID = i.custid
INNER JOIN #Temp_SuperInfo tsi				ON i.srecommend = tsi.CustID
INNER JOIN #Temp_ProductSetting tps				ON cbsa.SportType = tps.SportType AND cbsa.BetType = tps.BetType
INNER JOIN BetSetting3rd_Member bsa	WITH (NOLOCK)	ON cbsa.CustID = bsa.CustID AND cbsa.SportType = CASE WHEN bsa.SportType = 9919 THEN 202 ELSE  bsa.SportType END AND cbsa.BetType = bsa.BetType 
WHERE i.roleid = 1
AND i.Enabled = 1
AND tps.SportType <> 161
AND i.custid <= @max_custid

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_CustAffected

	DELETE TOP (@Batch) s WITH (ROWLOCK)
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
		INTO #Temp_CustAffected (CustID , SportType , BetType)
	FROM #Temp_Cust s

	IF @@ROWCOUNT = 0 
		BREAK ;

	SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType
					FROM #Temp_CustAffected
						FOR JSON PATH
				)

	EXEC dbo.[Acc_DynamicCustSetting3rd_16] @ModeCode = 'BS_Member_Remove_On_UAT'
								, @JsonData = @JsonData
								, @target	  = @target

	WAITFOR DELAY '00:00:0.020'

	SET @Msg = 'curdt Done Remove SMA BetSetting3rd_Member From CustBetSetting3rd_Member: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END

TRUNCATE TABLE #Temp_Cust


INSERT INTO #Temp_Cust 
	(
		CustID
	    , SportType
	    , BetType
	)
SELECT bsa.CustID , bsa.SportType , bsa.BetType
FROM CustBetSetting_Member cbsa WITH (NOLOCK)
INNER JOIN custInfo i WITH (NOLOCK)				ON cbsa.CustID = i.custid
INNER JOIN #Temp_SuperInfo tsi				ON i.srecommend = tsi.CustID
INNER JOIN #Temp_ProductSetting tps				ON cbsa.SportType = tps.SportType AND cbsa.BetType = tps.BetType
INNER JOIN BetSetting3rd_Member bsa	WITH (NOLOCK)	ON cbsa.CustID = bsa.CustID AND cbsa.SportType = bsa.SportType AND cbsa.BetType = bsa.BetType 
WHERE i.roleid = 1
AND i.Enabled = 1
AND tps.SportType = 161
AND i.custid <= @max_custid

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_CustAffected

	DELETE TOP (@Batch) s WITH (ROWLOCK)
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
		INTO #Temp_CustAffected (CustID , SportType , BetType)
	FROM #Temp_Cust s

	IF @@ROWCOUNT = 0 
		BREAK ;

	SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType
					FROM #Temp_CustAffected
						FOR JSON PATH
				)

	EXEC dbo.[Acc_DynamicCustSetting3rd_16] @ModeCode = 'BS_Member_Remove_On_UAT'
								, @JsonData = @JsonData
								, @target	  = @target

	WAITFOR DELAY '00:00:0.020'

	SET @Msg = 'curdt Done Remove SMA BetSetting3rd_Member From CustBetSetting_Member: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT

END

DROP TABLE #Temp_ProductSetting
DROP TABLE #Temp_SuperInfo
DROP TABLE #Temp_CustAffected
DROP TABLE #Temp_DataBetSetting
DROP TABLE #Temp_Cust