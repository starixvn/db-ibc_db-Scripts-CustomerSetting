/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231213@Helios
	Task: reset CustProductStatus [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/
	DECLARE
		@max_custid INT
	    , @target     VARCHAR(20)

	IF    @@servername IN ('DBCUST' , 'SITDBCUST' , 'TESTDBCUST')
		SET @target = 'DBCUST'
	ELSE
		SET @target = 'REPLICATED'

	PRINT 'Server Name : ' + @target

	SELECT @max_custid = xxx


	-- Create Temp Table stored SuperInfo
	CREATE TABLE #TmpSuperInfo
		(
			CustID INT
			PRIMARY KEY CLUSTERED (CustID)
		)

	INSERT INTO #TmpSuperInfo ( CustID )
	SELECT cu.CustId
	FROM Customer cu WITH (NOLOCK)
	INNER JOIN Site s WITH (NOLOCK)
		    ON cu.Site = s.Site
	INNER JOIN exchange e WITH (NOLOCK)
		    ON cu.currency = e.ExchangeId
		    AND e.IsActive = 1
		    AND e.OfferSite IN (0 , 1)
	LEFT JOIN CustSuper cs WITH (NOLOCK)
		    ON cu.custid = cs.custid
		WHERE
			cu.roleid			= 4
			AND s.islicensee		= 0
			AND s.isActive		= 1
			AND cu.username		NOT LIKE '3rdSuper%'
			AND cs.isinternal		= 0
			AND cu.custid		NOT IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
			--AND e.ExchangeId		= 20

	CREATE TABLE #tmp_CustProductStatus
	(
		CustID	     INT PRIMARY KEY
	    , bitmapHasSynced  BINARY(32)
	    , bitmapIsHidden   BINARY(32)
	    , bitmapIsDisabled BINARY(32)
	)

	CREATE TABLE #CustAffected
	(
		CustID	     INT
	    , bitmapHasSynced  BINARY(32)
	    , bitmapIsHidden   BINARY(32)
	    , bitmapIsDisabled BINARY(32)
	)

	DECLARE
		@Batch	 INT	   = 5000
	    , @SuperID	 INT
	    , @JsonData	 VARCHAR(MAX)
	    , @Msg		 VARCHAR(200)
	    , @bitmapOrder TINYINT = 18

	WHILE (1=1)
	BEGIN
		
		-- Pick top 1 Super to run all line
		SELECT @SuperID = NULL

		SELECT @SuperID = (SELECT TOP 1 tsi.CustID FROM #TmpSuperInfo tsi)

		IF @SuperID IS NULL
			BREAK;

		DELETE FROM #TmpSuperInfo WHERE CustID = @SuperID


		INSERT INTO #tmp_CustProductStatus  (CustID , bitmapHasSynced , bitmapIsHidden , bitmapIsDisabled)
		SELECT cs.CustID
			,bitmapHasSynced = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapHasSynced,  @bitmapOrder, 1))
			,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden,    @bitmapOrder, 1))
			,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsDisabled,  @bitmapOrder, 1))
		FROM custInfo i WITH (NOLOCK)
		INNER JOIN CustProductStatus cs WITH(NOLOCK) ON i.custid = cs.CustID
		WHERE i.Enabled = 1
		--AND i.roleid IN (1,2,3,4)
		AND i.srecommend = @SuperID
		AND i.custid		<= @max_custid

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #CustAffected
			
			DELETE TOP (@Batch) cps
			OUTPUT DELETED.CustID , DELETED.bitmapHasSynced , DELETED.bitmapIsHidden , DELETED.bitmapIsDisabled
				INTO #CustAffected (CustID, bitmapHasSynced, bitmapIsHidden, bitmapIsDisabled)
			FROM #tmp_CustProductStatus cps

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
					(
						SELECT ca.CustID, ca.bitmapHasSynced, ca.bitmapIsHidden, ca.bitmapIsDisabled
						FROM #CustAffected ca
						FOR JSON PATH
					)

			EXEC dbo.[Acc_DynamicCustSetting3rd_16] @ModeCode = 'Reset_CustProductStatus'
									  , @JsonData = @JsonData
									  , @target = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @SuperID) + ' end run reset Disabled curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END
	END

	
	
	DROP TABLE #TmpSuperInfo
	DROP TABLE #tmp_CustProductStatus
	DROP TABLE #CustAffected
	