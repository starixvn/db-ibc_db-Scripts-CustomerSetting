/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task:  [#193083] 
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

	SELECT @max_custid = 112225524

	-- Create Temp Table stored SuperInfo
	CREATE TABLE #TmpSuperInfo
		(
			CustID	INT
			PRIMARY KEY CLUSTERED (custid)
		)

	CREATE TABLE #Tmp_DataSettingRemove (CustID INT , SportType SMALLINT , BetType SMALLINT )
	CREATE TABLE #Tmp_DataSettingAffect (CustID INT , SportType SMALLINT , BetType SMALLINT )

	-- Create Temp Table stored Discount Setting
	CREATE TABLE #Discount_Setting
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
			PRIMARY KEY CLUSTERED (custid , sporttype , bettype)
		)

	---------------------------------------Declare Deployed Info---------------------------------------
	DECLARE
		@Batch		INT = 5000
	    , @JsonData		VARCHAR(MAX)
	    , @Srecommend		INT
	    , @Msg			VARCHAR(200)


	INSERT INTO #TmpSuperInfo
				(
					custid
				)
	SELECT cu.custid
	FROM Customer cu WITH (NOLOCK)
	INNER JOIN site s WITH (NOLOCK)
		    ON cu.site = s.site
	INNER JOIN exchange e WITH (NOLOCK)
		    ON cu.currency = e.ExchangeId
		    AND e.IsActive = 1
		    AND e.OfferSite IN (0 , 1)
	LEFT JOIN CustSuper cs WITH (NOLOCK)
		    ON cu.custid = cs.custid
		WHERE
			cu.roleid = 4
			AND s.isLicensee = 0
			AND s.IsActive = 1
			AND cu.username NOT LIKE '3rdSuper%'
			AND cs.IsInternal = 0
			AND cu.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
			--AND e.ExchangeId <> 20
			AND cu.srecommend <= @max_custid

	---------------------------------------UPDATE COMM SETTING---------------------------------------
	WHILE  (1=1)
	BEGIN
		-- Pick top 1 Super to run all line
		SELECT @Srecommend = NULL

		SELECT @Srecommend =  (SELECT TOP 1 tsi.CustID FROM #TmpSuperInfo tsi)

		IF @Srecommend IS NULL
			BREAK;

		DELETE FROM #TmpSuperInfo WHERE CustID = @Srecommend

		-- Collect Super, Master, Agent Setting PT Need Remove Follow TOP 1 Super Headline

		INSERT INTO #Tmp_DataSettingRemove 
		(
			CustID
		    , SportType
		    , BetType
		)
		SELECT cpa.CustID , cpa.SportType , cpa.BetType
		FROM custInfo i WITH (NOLOCK)
		INNER JOIN CustDiscount3rd_Member cpa WITH (NOLOCK) ON i.custid = cpa.CustID
		WHERE i.Enabled = 1
		AND	i.roleid = 1
		AND	i.srecommend = @Srecommend
		AND	cpa.SportType = 1
		AND	cpa.BetType IN (3,7,8)

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #Tmp_DataSettingAffect

			DELETE TOP (@Batch) ss
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #Tmp_DataSettingAffect (CustID , SportType, BetType)
			FROM #Tmp_DataSettingRemove ss

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType 
					FROM #Tmp_DataSettingAffect
						FOR JSON PATH
				)

			EXEC dbo.[Acc_DynamicCustSetting3rd_17] @ModeCode = 'Discount_Member'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Comm Member curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

	END


	DROP TABLE #Discount_Setting
	DROP TABLE #Tmp_DataSettingAffect
	DROP TABLE #Tmp_DataSettingRemove
	DROP TABLE #TmpSuperInfo
