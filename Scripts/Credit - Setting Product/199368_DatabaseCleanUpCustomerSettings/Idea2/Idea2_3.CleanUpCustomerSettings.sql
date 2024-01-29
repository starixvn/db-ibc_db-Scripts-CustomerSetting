/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240104@Helios
	Task: Database - Clean up Customer Settings of Dormant Credit Accounts [#199368]
		https://nexdev.net/issues/199368
	DB: DBCust/CustDB 
*/
	SET NOCOUNT ON

	--DECLARE
	--	@max_custid INT
	--    , @target     VARCHAR(20)

	--IF    @@servername IN ('DBCUST' , 'SITDBCUST' , 'TESTDBCUST')
	--	SET @target = 'DBCUST'
	--ELSE
	--	SET @target = 'REPLICATED'

	--PRINT 'Server Name : ' + @target

	--SELECT @max_custid = xxx


	DECLARE
		@JsonData				VARCHAR(MAX)
	    , @ModeCode				VARCHAR(50)
	    , @Batch				INT


	CREATE TABLE #CustList
		(
				CustID		INT
			,	SportType		SMALLINT
			,	BetType		SMALLINT
			,	IsLive		BIT
			PRIMARY KEY CLUSTERED (CustID , SportType , BetType , IsLive)
		)
	
	CREATE TABLE #CustAffected
		(
				CustID		INT
			,	SportType		SMALLINT
			,	BetType		SMALLINT
			,	IsLive		BIT
		)

	INSERT INTO #CustList (CustID , SportType , BetType , IsLive)
	SELECT cpa.CustID , cpa.SportType, cpa.BetType , cpa.IsLive
	FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
	INNER JOIN Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK) ON cpa.CustID = tcucs.CustID


	SET @Batch = 5000

	-- CustPTSetting3rd_Agent : Remark = 0
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive
			INTO #CustAffected
		FROM #CustList tmp

		IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						,	 ca.SportType
						,	 ca.BetType
						,	 ca.IsLive
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustPTSetting3rd_Agent'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END



	DROP TABLE #CustAffected

	