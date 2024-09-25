/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: @Helios
	Date: 2024/06/21
	Task: Customer Setting - Unify RNG Lottery and Virtual Sports - Migrate Data BetSetting (Adjusted) to New Structure [redmine : #204358]
		https://nexdev.net/issues/204358
	DB: DBCUST/CustDB
*/

SET NOCOUNT ON

-- JUST RUN THIS SCRIPT AT DBCUST
 
-----------------------------------Check New Structure RepInHouse is Exists---------------------------------

DECLARE @max_custid INT

SELECT @max_custid = xxx

-----------------------------------Check New Structure RepInHouse is Exists---------------------------------

	IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BetSetting3rd_Agent]') AND type in (N'U'))
		RETURN;

	IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BetSetting3rd_Member]') AND type in (N'U'))
		RETURN;

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
	    , MinBet		MONEY
	    , MaxBet		MONEY
	    , MaxPerMatch		MONEY
	    , MaxPerNumber	MONEY
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)


---------------------------------------Declare Deployed Info---------------------------------------
DECLARE
	  @Batch				INT = 2000
	, @Msg				VARCHAR(200)
	, @Srecommend			INT
	, @SportTypeRNGGame		SMALLINT = 9919


CREATE TABLE #Temp_CustAffected
	(
		CustID		INT
	    , SportType		SMALLINT
	    , BetType		SMALLINT
	    , MinBet		MONEY
	    , MaxBet		MONEY
	    , MaxPerMatch		MONEY
	    , MaxPerNumber	MONEY
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

---------------------------------------Collect Data Setting:---------------------------------------

-- Super/ Master/ Agent BetSetting:

INSERT INTO #Temp_DataBetSetting 
	(
		CustID
	    , SportType
	    , BetType
	    , MinBet
	    , MaxBet
	    , MaxPerMatch
	    , MaxPerNumber
	)
-- Number Game 	(161)
SELECT	bs.CustID
	    , bs.SportType
	    , bs.BetType
	    , bs.MinBet
	    , bs.MaxBet
	    , bs.MaxPerMatch
	    , bs.MaxPerNumber
FROM CustBetSetting_Agent bs WITH (NOLOCK)
INNER JOIN custInfo i WITH (NOLOCK)			ON bs.CustID = i.custid
INNER JOIN #Temp_SuperInfo tsi			ON i.srecommend = tsi.CustID
INNER JOIN #Temp_ProductSetting tps			ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
INNER JOIN BetSetting3rd_Agent bsa WITH (NOLOCK) ON bs.CustID = bsa.CustID AND bs.SportType = bsa.SportType AND bs.BetType = bsa.BetType
WHERE i.roleid IN (2,3,4)
AND i.Enabled = 1
AND tps.SportType = 161
AND (
		bs.MinBet			<> bsa.MinBet
	OR	bs.MaxBet			<> bsa.MaxBet
	OR	bs.MaxPerMatch		<> bsa.MaxPerMatch
	OR	bs.MaxPerNumber		<> bsa.MaxPerNumber
    )
AND i.CustID <= @max_custid

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_CustAffected

	DELETE TOP (@Batch) s WITH (ROWLOCK)
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch , DELETED.MaxPerNumber
		INTO #Temp_CustAffected (CustID , SportType , BetType , MinBet , MaxBet , MaxPerMatch , MaxPerNumber)
	FROM #Temp_DataBetSetting s

	IF @@ROWCOUNT = 0 
		BREAK ;

	UPDATE bsa
		SET
			bsa.MinBet			= tem.MinBet ,
			bsa.MaxBet			= tem.MaxBet ,
			bsa.MaxPerMatch		= tem.MaxPerMatch ,
			bsa.MaxPerNumber		= tem.MaxPerNumber ,
			bsa.RepUpdateTime		= SYSDATETIME ()
	FROM BetSetting3rd_Agent bsa WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #Temp_CustAffected tem ON bsa.CustID = tem.CustID AND bsa.SportType = tem.SportType AND bsa.BetType = tem.BetType

	WAITFOR DELAY '00:00:0.050'

	SET @Msg = 'curdt Adjust SMA FROM CustBetSetting_Agent: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT
END

TRUNCATE TABLE #Temp_DataBetSetting

-- Sports Lottery	 (169) , RNG Keno (202) >> Keno/Lottery (9919), Virtual Sports (9908)
INSERT INTO #Temp_DataBetSetting 
	(
		CustID
	    , SportType
	    , BetType
	    , MinBet
	    , MaxBet
	    , MaxPerMatch
	)
SELECT	bs.CustID
	    , CASE WHEN bs.SportType = 202 THEN @SportTypeRNGGame ELSE bs.SportType END AS [SportType]
	    , bs.BetType
	    , bs.MinBet
	    , bs.MaxBet
	    , bs.MaxPerMatch
FROM CustBetSetting3rd_Agent bs WITH (NOLOCK)
INNER JOIN custInfo i WITH (NOLOCK)				ON bs.CustID = i.custid
INNER JOIN #Temp_SuperInfo tsi				ON i.srecommend = tsi.CustID
INNER JOIN #Temp_ProductSetting tps				ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
INNER JOIN BetSetting3rd_Agent bsa WITH (NOLOCK)	ON bs.CustID = bsa.CustID 
									AND CASE WHEN bs.SportType = 202 THEN @SportTypeRNGGame ELSE bs.SportType END = bsa.SportType 
									AND bs.BetType = bsa.BetType
WHERE i.roleid IN (2,3,4)
AND i.Enabled = 1
AND tps.SportType <> 161
AND (
		bs.MinBet			<> bsa.MinBet
	OR	bs.MaxBet			<> bsa.MaxBet
	OR	bs.MaxPerMatch		<> bsa.MaxPerMatch
    )
AND i.CustID <= @max_custid

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_CustAffected

	DELETE TOP (@Batch) s WITH (ROWLOCK)
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch
		INTO #Temp_CustAffected (CustID , SportType , BetType , MinBet , MaxBet , MaxPerMatch)
	FROM #Temp_DataBetSetting s

	IF @@ROWCOUNT = 0 
		BREAK ;

	UPDATE bsa
		SET
			bsa.MinBet			= tem.MinBet ,
			bsa.MaxBet			= tem.MaxBet ,
			bsa.MaxPerMatch		= tem.MaxPerMatch ,
			bsa.RepUpdateTime		= SYSDATETIME ()
	FROM BetSetting3rd_Agent bsa WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #Temp_CustAffected tem ON bsa.CustID = tem.CustID AND bsa.SportType = tem.SportType AND bsa.BetType = tem.BetType

	WAITFOR DELAY '00:00:0.050'

	SET @Msg = 'curdt Adjust SMA FROM CustBetSetting3rd_Agent: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT
END


-- Member BetSetting:

TRUNCATE TABLE #Temp_DataBetSetting


INSERT INTO #Temp_DataBetSetting 
	(
		bs.CustID
	    , bs.SportType
	    , bs.BetType
	    , MinBet
	    , MaxBet
	    , MaxPerMatch
	    , MaxPerNumber
	)
-- Number Game 	(161)
SELECT	bs.CustID
	    , bs.SportType
	    , bs.BetType
	    , bs.MinBet
	    , bs.MaxBet
	    , bs.MaxPerMatch
	    , bs.MaxPerNumber
FROM CustBetSetting_Member bs WITH (NOLOCK)
INNER JOIN custInfo i WITH (NOLOCK)			ON bs.CustID = i.custid
INNER JOIN #Temp_SuperInfo tsi			ON i.srecommend = tsi.CustID
INNER JOIN #Temp_ProductSetting tps			ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
INNER JOIN BetSetting3rd_Member bsa WITH (NOLOCK) ON bs.CustID = bsa.CustID AND bs.SportType = bsa.SportType AND bs.BetType = bsa.BetType
WHERE i.roleid IN (1)
AND i.Enabled = 1
AND tps.SportType = 161
AND (
		bs.MinBet			<> bsa.MinBet
	OR	bs.MaxBet			<> bsa.MaxBet
	OR	bs.MaxPerMatch		<> bsa.MaxPerMatch
	OR	bs.MaxPerNumber		<> bsa.MaxPerNumber
    )
AND i.CustID <= @max_custid

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_CustAffected

	DELETE TOP (@Batch) s WITH (ROWLOCK)
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch , DELETED.MaxPerNumber
		INTO #Temp_CustAffected (CustID , SportType , BetType , MinBet , MaxBet , MaxPerMatch , MaxPerNumber)
	FROM #Temp_DataBetSetting s

	IF @@ROWCOUNT = 0 
		BREAK ;

	UPDATE bsa
		SET
			bsa.MinBet			= tem.MinBet ,
			bsa.MaxBet			= tem.MaxBet ,
			bsa.MaxPerMatch		= tem.MaxPerMatch ,
			bsa.MaxPerNumber		= tem.MaxPerNumber ,
			bsa.RepUpdateTime		= SYSDATETIME ()
	FROM BetSetting3rd_Member bsa WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #Temp_CustAffected tem ON bsa.CustID = tem.CustID AND bsa.SportType = tem.SportType AND bsa.BetType = tem.BetType

	WAITFOR DELAY '00:00:0.050'

	SET @Msg = 'curdt Adjust Member FROM CustBetSetting_Member: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT
END


TRUNCATE TABLE #Temp_DataBetSetting

-- Sports Lottery	 (169) , RNG Keno (202) >> Keno/Lottery (9919), Virtual Sports (9908)
INSERT INTO #Temp_DataBetSetting 
	(
		bs.CustID
	    , bs.SportType
	    , bs.BetType
	    , MinBet
	    , MaxBet
	    , MaxPerMatch
	)
SELECT	bs.CustID
	    , CASE WHEN bs.SportType = 202 THEN @SportTypeRNGGame ELSE bs.SportType END AS [SportType]
	    , bs.BetType
	    , bs.MinBet
	    , bs.MaxBet
	    , bs.MaxPerMatch
FROM CustBetSetting3rd_Member bs WITH (NOLOCK)
INNER JOIN custInfo i WITH (NOLOCK)				ON bs.CustID = i.custid
INNER JOIN #Temp_SuperInfo tsi				ON i.srecommend = tsi.CustID
INNER JOIN #Temp_ProductSetting tps				ON bs.SportType = tps.SportType AND bs.BetType = tps.BetType
INNER JOIN BetSetting3rd_Member bsa WITH (NOLOCK)	ON bs.CustID = bsa.CustID 
									AND CASE WHEN bs.SportType = 202 THEN @SportTypeRNGGame ELSE bs.SportType END = bsa.SportType 
									AND bs.BetType = bsa.BetType
WHERE i.roleid IN (1)
AND i.Enabled = 1
AND tps.SportType <> 161
AND (
		bs.MinBet			<> bsa.MinBet
	OR	bs.MaxBet			<> bsa.MaxBet
	OR	bs.MaxPerMatch		<> bsa.MaxPerMatch
    )
AND i.CustID <= @max_custid

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #Temp_CustAffected

	DELETE TOP (@Batch) s WITH (ROWLOCK)
	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch
		INTO #Temp_CustAffected (CustID , SportType , BetType , MinBet , MaxBet , MaxPerMatch)
	FROM #Temp_DataBetSetting s

	IF @@ROWCOUNT = 0 
		BREAK ;

	UPDATE bsa
		SET
			bsa.MinBet			= tem.MinBet ,
			bsa.MaxBet			= tem.MaxBet ,
			bsa.MaxPerMatch		= tem.MaxPerMatch ,
			bsa.RepUpdateTime		= SYSDATETIME ()
	FROM BetSetting3rd_Member bsa WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #Temp_CustAffected tem ON bsa.CustID = tem.CustID AND bsa.SportType = tem.SportType AND bsa.BetType = tem.BetType

	WAITFOR DELAY '00:00:0.050'

	SET @Msg = 'curdt Adjust Member FROM CustBetSetting3rd_Member: ' + convert(varchar(50), getdate(), 121)
	RAISERROR (@Msg, 0, 1) WITH NOWAIT
END


DROP TABLE #Temp_ProductSetting
DROP TABLE #Temp_CustAffected
DROP TABLE #Temp_SuperInfo
DROP TABLE #Temp_DataBetSetting