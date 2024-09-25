/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 07/06/2024
	Task: Migrate RNG Keno For Headline Is Hidden [#204358]
		- Indirect Account - Line Super:
			Scr 1: 
				product status = disable
				bet setting = 0 / 0/ 0
				Super max PT = 0.9 (max value của Keno đang offer)

			Scr 2:
				product status = disable
				bet setting = 0 / 0/ 0.1
				PT value= 0 (follow rule create new customer)

		- Direct Account:
			For direct Master/ Agent/ Members, will follow:
				product status = disable
				bet setting = 0 / 0/ 0.1
				PT value = max value
				
	DB: DBCust/CustDB
*/
SET NOCOUNT ON

DECLARE
	@max_custid INT
	, @target     VARCHAR(20)

IF    @@servername IN ('DBCUST' , 'SITDBCUST' , 'TESTDBCUST')
	SET @target = 'DBCUST'
ELSE
	SET @target = 'REPLICATED'

PRINT 'Server Name : ' + @target

DECLARE 

	@SportType			SMALLINT	= 202,
	@BetType			SMALLINT	= 1501
--Get Super Account Affect
CREATE TABLE #SuperID (SuperID INT , IsHidden BIT , IsDisable BIT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid 
FROM Customer c WITH (NOLOCK) 
WHERE c.username IN ('999MYR','DT','JARWRONG','KOR','CSDTEST','MIRI SD','PPO','S2C','skwrongxxx','StarixSCYEN','SuperTestTH','PRU','S188AH','S1NT','S52RMB','S688T','SBSR','SJ','SMOT','SQE','SSP','SWT','SXRS','TL1','TL6')

SELECT @max_custid = (	SELECT MAX(c.custid) 
				FROM Customer c WITH (NOLOCK)
				INNER JOIN #SuperID si ON c.srecommend = si.SuperID
			   )

--Get Downline Account Affect
CREATE TABLE #TmpCustAffected
		(
			Site		VARCHAR(10),
			ExchangeId	TINYINT,
			UserName	VARCHAR(30),
			RoleID	TINYINT,
			CustID	INT,
			srecommend	INT,
			mrecommend	INT,
			recommend	INT,
			PRIMARY KEY CLUSTERED (CustID)
		)

INSERT INTO #TmpCustAffected 
	(
		Site
	    , ExchangeId
	    , UserName
	    , RoleID
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
	)
SELECT	Site
	    , currency
	    , UserName
	    , cu.roleid
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
FROM Customer cu WITH (NOLOCK)
INNER JOIN #SuperID c ON cu.srecommend = c.SuperID
WHERE cu.custid <= @max_custid

-- Check Data
--SELECT @SportType AS SportType , @BetType AS BetType
--SELECT si.*
--FROM #TmpCustAffected si

---------------------------------------Declare Deployed Info---------------------------------------
DECLARE
	  @Batch			INT = 2000
	, @JsonData			VARCHAR(MAX)
	, @Msg			VARCHAR(200)

CREATE TABLE #tmp_CustCheck
	(
		CustId	 INT
	    , SportType	 SMALLINT
	    , BetType	 SMALLINT
	    , PRIMARY KEY (CustID , SportType , BetType)
	)


-------------------------------------------2.BetSetting-------------------------------------------------

CREATE TABLE #tmp_BetSetting
	(
		CustID	INT
	    , SportType   SMALLINT
	    , BetType     SMALLINT
	    , MinBet	MONEY
	    , MaxBet	MONEY
	    , MaxPerMatch MONEY
	    , PRIMARY KEY (CustID , SportType , BetType)
	)

CREATE TABLE #tmp_BetSettingAffected
	(
		CustID	INT
	    , SportType   SMALLINT
	    , BetType     SMALLINT
	    , MinBet	MONEY
	    , MaxBet	MONEY
	    , MaxPerMatch MONEY
	)


IF EXISTS (	
			SELECT TOP 1 1
			FROM #TmpCustAffected cc
			INNER JOIN CustBetSetting3rd_Member cpa WITH (NOLOCK) ON cc.CustId = cpa.CustID 
			WHERE cpa.SportType = @SportType 
			AND cpa.BetType = @BetType
			AND cc.RoleID = 1
		)
BEGIN
	RAISERROR ( N'Error Data BetSetting Member', 0, 1) ;
	RETURN;
END

ELSE
BEGIN
	
	INSERT INTO #tmp_BetSetting 
	(
		CustID
	    , SportType
	    , BetType
	    , MinBet
	    , MaxBet
	    , MaxPerMatch
	)

	SELECT
		cc.CustID
	    , @SportType AS SportType
	    , @BetType AS BetType
	    , 0 AS MinBet
	    , 0 AS MaxBet
	    , 0.10 AS MaxPerMatch
	FROM #TmpCustAffected cc
	WHERE  cc.RoleID = 1
END


-- Check Data
SELECT * FROM #TmpCustAffected

SELECT 'Check Data BetSetting' AS Note, tsa.srecommend , tsa.RoleID , tp.*
FROM #tmp_BetSetting tp
INNER JOIN #TmpCustAffected tsa ON tp.CustID = tsa.CustID


SELECT 'Check Data BetSetting' AS Note,  tsa.RoleID , tp.*
FROM CustBetSetting3rd_Member tp
INNER JOIN #TmpCustAffected tsa ON tp.CustID = tsa.CustID
AND tp.SportType = @SportType
AND tp.BetType = @BetType

--WHILE (1=1)
--BEGIN
--	TRUNCATE TABLE #tmp_BetSettingAffected

--	DELETE TOP (@Batch) temp
--	OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.MinBet , DELETED.MaxBet , DELETED.MaxPerMatch
--		INTO #tmp_BetSettingAffected (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
--	FROM #tmp_BetSetting temp
--	INNER JOIN #TmpCustAffected tsa ON temp.CustID = tsa.CustID
--	WHERE tsa.RoleID IN (1)

--	IF @@ROWCOUNT = 0 
--			BREAK ;

--	SET @JsonData = (	SELECT CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch
--					FROM	#tmp_BetSettingAffected tp
--					FOR JSON PATH
--			    )

--	EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'BetSetting_Member'
--								   , @JsonData = @JsonData
--								   , @Target   = @target

--	WAITFOR DELAY '00:00:0.050'

--	SET @Msg = 'Curdt BetSetting Member: ' + convert(varchar(50), GETDATE(), 121)
--	RAISERROR (@Msg, 0, 1) WITH NOWAIT

--END



DROP TABLE #SuperID
DROP TABLE #tmp_CustCheck

DROP TABLE #tmp_BetSetting
DROP TABLE #tmp_BetSettingAffected

DROP TABLE #TmpCustAffected