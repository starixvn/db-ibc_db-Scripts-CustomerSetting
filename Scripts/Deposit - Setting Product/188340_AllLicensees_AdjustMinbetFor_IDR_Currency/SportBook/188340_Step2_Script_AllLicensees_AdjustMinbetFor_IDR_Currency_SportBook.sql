/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/05/17
	Task: All licensees - Adjust minbet for IDR currency [redmine : #188340]
	DB: DBCUST/CustDB
	Revisions: Initial Script Collect Cust Setting Need Update
*/


	PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	SET NOCOUNT ON
	DECLARE @max_custid			INT

	SELECT  @max_custid = xxx
	   	
	--Currency apply setting
	CREATE TABLE #Exchange (ExchangeId INT PRIMARY KEY  )

	INSERT INTO #Exchange
	SELECT ExchangeId 
	FROM exchange WITH (NOLOCK)
	WHERE currency IN ('IN','IN2')

	CREATE TABLE #SportType_BetType_ApplyChanged(
		SportType		INT ,
		BetType			INT ,
		PRIMARY KEY CLUSTERED (SportType , BetType)
	)


	-- Collect SportType BetType of SportBook
	INSERT INTO #SportType_BetType_ApplyChanged
	SELECT DISTINCT SportType , Bettype 
	FROM Dep_ProductSetting ps WITH(NOLOCK)   
	INNER JOIN Dep_ProductSettingDetail d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID    
	WHERE ProductID = 1 AND SettingType IN (10,12)


	CREATE TABLE #tmpSuperBetSetting (
		CustID			INT ,
		SportType		INT ,
		BetType			INT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	--Collect ALL Super FlowBet Setting Sportbook
	INSERT INTO #tmpSuperBetSetting
	SELECT ca.custid  , ca.SportType , ca.BetType
	FROM Customer ci WITH (NOLOCK) 
		INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN Dep_CustBetSettingGame_Agent ca WITH (NOLOCK)
				ON ci.custid = ca.CustID
		INNER JOIN #SportType_BetType_ApplyChanged sb
				ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE 
		ci.username NOT LIKE '3rdSuper%' 
		AND ci.roleid = 4  
		AND ci.currency IN (SELECT ExchangeId FROM #Exchange)							-- Apply Curreny :IN, IN2
		AND ci.custid <= @max_custid
	
	-- For Deployed Info
	CREATE TABLE #CustAffected (
		CustID			INT ,
		SportType		INT ,
		BetType			INT  )

	DECLARE	@AffectedList	VARCHAR(MAX) = ''
		,	@Batch			INT = 1000
		,	@super_cnt INT
		,	@msg_total NVARCHAR(200) = 'Total of supers: %d.'

	SET @super_cnt = (SELECT COUNT(1) FROM #tmpSuperBetSetting )
	RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType 
			INTO #CustAffected (CustID , SportType , BetType )
		FROM #tmpSuperBetSetting s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				

		SET @AffectedList =  (	SELECT 
								CustID			as '@C' ,			-- @CustID
								SportType		as '@S' ,			-- @SportType
								BetType			as '@B'				-- @BetType
								FROM #CustAffected
								FOR XML PATH('r'), ROOT ('root')  
							)

		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @max_custid = @max_custid 		  -- RUN UPDATE FOR SMA

		WAITFOR DELAY  '00:00:0.050'	
		
		SET @msg_total = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total, 0, 1) WITH NOWAIT
	END
	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 


	DROP TABLE #Exchange
	DROP TABLE #SportType_BetType_ApplyChanged
	DROP TABLE #tmpSuperBetSetting
	DROP TABLE #CustAffected
	
	GO

















