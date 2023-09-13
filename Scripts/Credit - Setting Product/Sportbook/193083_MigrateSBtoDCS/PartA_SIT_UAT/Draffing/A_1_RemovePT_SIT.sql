/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Inital Migrate Data Remove PT Setting SportsBook Currency UUS [#193083]  
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/
	SET NOCOUNT ON

	DECLARE
		@target			VARCHAR(20)

	IF    @@servername IN ('DBCUST' , 'SITDBCUST' , 'TESTDBCUST')
		SET @target = 'DBCUST'
	ELSE
		SET @target = 'REPLICATED'

	PRINT 'Server Name : ' + @target
	
	CREATE TABLE #Cust	 (CustID INT)
	CREATE TABLE #CustAffect (CustID INT)

	DECLARE 
		@Batch			INT = 5000
	,	@Msg				VARCHAR(100)
	,	@Msg_TotalLine		VARCHAR(100) = 'Distinct Count Cust: %d.'
	,	@TotalLine			INT
	,	@JsonData			VARCHAR(MAX)
	,	@SreCommend			INT

	SELECT @SreCommend = 20

	INSERT INTO #Cust (CustID)
	SELECT DISTINCT cpa.CustID
	FROM CustPTSetting3rd_Agent cpa WITH (NOLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cpa.CustID = c.custid
	WHERE cpa.SportType IN (9913,9914,9915)
	AND c.srecommend = @SreCommend
	

	SELECT @TotalLine = (SELECT COUNT(1) FROM #Cust)
	RAISERROR (@Msg_TotalLine, 0, 1, @TotalLine) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffect

		DELETE TOP (@Batch) c
		OUTPUT DELETED.CustID INTO #CustAffect
		FROM #Cust c

		 IF @@ROWCOUNT = 0
				BREAK;


		SELECT @JsonData =
			(
				SELECT CustID
				FROM #CustAffect
				FOR JSON PATH
			)

		EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'PTSMA_Remove'
									  , @JsonData = @JsonData
									  , @target	  = @target

		WAITFOR DELAY '00:00:0.050'

		SET @Msg = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@Msg, 0, 1) WITH NOWAIT
	END

	TRUNCATE TABLE #Cust

	--- DELETE PT MEMBER
	INSERT INTO #Cust (CustID)
	SELECT DISTINCT cpa.CustID
	FROM CustPTSetting3rd_Member cpa WITH (NOLOCK) 
	INNER JOIN Customer c WITH (NOLOCK) ON cpa.CustID = c.custid
	WHERE SportType IN (9913,9914,9915)
	AND c.srecommend = @SreCommend

	SET @TotalLine = (SELECT COUNT(1) FROM #Cust)
	RAISERROR (@Msg_TotalLine, 0, 1, @TotalLine) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffect

		DELETE TOP (@Batch) c
		OUTPUT DELETED.CustID INTO #CustAffect
		FROM #Cust c

		 IF @@ROWCOUNT = 0
				BREAK;

		SELECT @JsonData =
			(
				SELECT CustID
				FROM #CustAffect
				FOR JSON PATH
			)

		EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'PTMember_Remove'
									  , @JsonData = @JsonData
									  , @target	  = @target

		WAITFOR DELAY '00:00:0.050'

		
		SET @Msg = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@Msg, 0, 1) WITH NOWAIT
	END

	TRUNCATE TABLE #Cust



	--- DELETE PT MEMBER
	INSERT INTO #Cust (CustID)
	SELECT DISTINCT gpt.AgentID
	FROM CustPTGroupSetting3rd_Member gpt WITH (NOLOCK)
	WHERE SportType IN (9913,9914,9915)

	SET @TotalLine = (SELECT COUNT(1) FROM #Cust)
	RAISERROR (@Msg_TotalLine, 0, 1, @TotalLine) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffect

		DELETE TOP (@Batch) c
		OUTPUT DELETED.CustID INTO #CustAffect
		FROM #Cust c

		 IF @@ROWCOUNT = 0
				BREAK;

		SELECT @JsonData =
			(
				SELECT CustID
				FROM #CustAffect
				FOR JSON PATH
			)

		EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'PTGroup_Remove'
									  , @JsonData = @JsonData
									  , @target	  = @target
		WAITFOR DELAY '00:00:0.050'

		
		SET @Msg = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@Msg, 0, 1) WITH NOWAIT
	END


	TRUNCATE TABLE #Cust

	-- Remove Discount SMA
	INSERT INTO #Cust (CustID)
	SELECT DISTINCT cda.CustID
	FROM CustDiscount3rd_Agent cda WITH (NOLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cda.CustID = c.custid
	WHERE cda.SportType IN (1,2)
	AND c.srecommend = @SreCommend

	SET @TotalLine = (SELECT COUNT(1) FROM #Cust)
	RAISERROR (@Msg_TotalLine, 0, 1, @TotalLine) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffect

		DELETE TOP (@Batch) c
		OUTPUT DELETED.CustID INTO #CustAffect
		FROM #Cust c

		 IF @@ROWCOUNT = 0
				BREAK;

		SELECT @JsonData =
			(
				SELECT CustID
				FROM #CustAffect
				FOR JSON PATH
			)

		EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'Discount_SMA'
									  , @JsonData = @JsonData
									  , @target	  = @target
		WAITFOR DELAY '00:00:0.050'

		
		SET @Msg = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@Msg, 0, 1) WITH NOWAIT
	END


	TRUNCATE TABLE #Cust

	-- Remove Discount Member
	INSERT INTO #Cust (CustID)
	SELECT DISTINCT cdm.CustID
	FROM CustDiscount3rd_Member cdm WITH (NOLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cdm.CustID = c.custid
	WHERE cdm.SportType IN (1,2)
	AND c.srecommend = @SreCommend

	SET @TotalLine = (SELECT COUNT(1) FROM #Cust)
	RAISERROR (@Msg_TotalLine, 0, 1, @TotalLine) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffect

		DELETE TOP (@Batch) c
		OUTPUT DELETED.CustID INTO #CustAffect
		FROM #Cust c

		 IF @@ROWCOUNT = 0
				BREAK;

		SELECT @JsonData =
			(
				SELECT CustID
				FROM #CustAffect
				FOR JSON PATH
			)

		EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'Discount_Mem'
									  , @JsonData = @JsonData
									  , @target	  = @target
		WAITFOR DELAY '00:00:0.050'

		
		SET @Msg = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@Msg, 0, 1) WITH NOWAIT
	END

	-- Remove BetSetting SMA
	INSERT INTO #Cust (CustID)
	SELECT DISTINCT cbsa.CustID
	FROM CustBetSetting_Agent cbsa WITH (NOLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cbsa.CustID = c.custid
	WHERE cbsa.SportType IN (43,44)
	AND c.srecommend = @SreCommend

	SET @TotalLine = (SELECT COUNT(1) FROM #Cust)
	RAISERROR (@Msg_TotalLine, 0, 1, @TotalLine) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffect

		DELETE TOP (@Batch) c
		OUTPUT DELETED.CustID INTO #CustAffect
		FROM #Cust c

		 IF @@ROWCOUNT = 0
				BREAK;

		SELECT @JsonData =
			(
				SELECT CustID
				FROM #CustAffect
				FOR JSON PATH
			)

		EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'BetSetting_SMA'
									  , @JsonData = @JsonData
									  , @target	  = @target
		WAITFOR DELAY '00:00:0.050'

		
		SET @Msg = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@Msg, 0, 1) WITH NOWAIT
	END

	-- Remove BetSetting Member
	INSERT INTO #Cust (CustID)
	SELECT DISTINCT cbsm.CustID
	FROM CustBetSetting_Member cbsm WITH (NOLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cbsm.CustID = c.custid
	WHERE cbsm.SportType IN (43,44)
	AND c.srecommend = @SreCommend

	SET @TotalLine = (SELECT COUNT(1) FROM #Cust)
	RAISERROR (@Msg_TotalLine, 0, 1, @TotalLine) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffect

		DELETE TOP (@Batch) c
		OUTPUT DELETED.CustID INTO #CustAffect
		FROM #Cust c

		 IF @@ROWCOUNT = 0
				BREAK;

		SELECT @JsonData =
			(
				SELECT CustID
				FROM #CustAffect
				FOR JSON PATH
			)

		EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'BetSetting_Mem'
									  , @JsonData = @JsonData
									  , @target	  = @target
		WAITFOR DELAY '00:00:0.050'

		
		SET @Msg = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@Msg, 0, 1) WITH NOWAIT
	END


	DROP TABLE #CustAffect
	DROP TABLE #Cust