/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240104@Helios
	Task: Database - Clean up Customer Settings of Dormant Credit Accounts - CustPTGroupSetting3rd_Member [#199368]
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
	    , @Batch				INT			= 5000

	CREATE TABLE #CustGroupPTMember
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

	-- CustPTGroupSetting3rd_Member : Remark = 12
	INSERT INTO #CustGroupPTMember (CustID , SportType , BetType, IsLive)
	SELECT cpsm.AgentID , cpsm.SportType , cpsm.BetType , cpsm.IsLive
	FROM Tmp_CleanUpCustomerSetting tcucs WITH (NOLOCK)
	INNER JOIN CustPTGroupSetting3rd_Member cpsm WITH (NOLOCK) ON tcucs.CustID = cpsm.AgentID
	WHERE tcucs.Remark = 12

	WHILE  (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive 
		INTO #CustAffected
		FROM #CustGroupPTMember tmp

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT	ca.CustID
							,	ca.SportType
							,	ca.BetType
							,	ca.IsLive
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustPTSetting3rd_Agent'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData
	END

	
	DROP TABLE #CustGroupPTMember
	DROP TABLE #CustAffected