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


	CREATE TABLE #CustAffected
	(
		CustID		INT
	)


	SET @Batch = 215		-- 215 Cust * 23 Rows Setting PT ~ 4945/1 Batch

	-- CustPTSetting3rd_Agent : Remark = 0
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 0

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustPTSetting3rd_Agent'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END

	-- CustPTSetting3rd_Member : Remark = 1
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 1

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustPTSetting3rd_Member'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END

	SET @Batch = 620		-- 620 Cust * 8 Rows Setting PT ~ 4960/1 Batch

	-- CustBetSetting3rd_Agent : Remark = 2
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 2

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustBetSetting3rd_Agent'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END

	-- CustBetSetting3rd_Member : Remark = 3
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 3

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustBetSetting3rd_Member'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END

	SET @Batch = 2500		-- 2500 Cust * 2 Rows Setting PT ~ 5000/1 Batch

	-- CustDiscount3rd_Agent : Remark = 4
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 4

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustDiscount3rd_Agent'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END

	-- CustDiscount3rd_Member : Remark = 5
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 5

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustDiscount3rd_Member'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END

	SET @Batch = 550		-- 550 Cust * 2 Rows Setting PT ~ 4950/1 Batch

	-- CustWinLossLimit_Agent : Remark = 6
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 6

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustWinLossLimit_Agent'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END

	-- CustWinLossLimit_Member : Remark = 7
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 7

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustWinLossLimit_Member'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END

	SET @Batch = 293		-- 293 Cust * 17 Rows Setting PT ~ 4981/1 Batch

	-- CustStakeLevel_Agent : Remark = 8
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 8

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustStakeLevel_Agent'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END

	-- CustStakeLevel_Member : Remark = 9
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tmp
		OUTPUT DELETED.CustID INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tmp WITH (NOLOCK) 
		WHERE Remark = 9

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustStakeLevel_Member'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData

	END




	DROP TABLE #CustAffected

	