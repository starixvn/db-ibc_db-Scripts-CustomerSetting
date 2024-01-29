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
	    , @Batch				INT			= 5000

	
	CREATE TABLE #CustAffected
		(
				CustID		INT
		)


	-- CustSettingMode3rd : Remark = 10
	WHILE  (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tcucs
		OUTPUT DELETED.CustID
		INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tcucs
		WHERE tcucs.Remark = 10

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT	ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustSettingMode3rd'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData
	END


	-- CustProductStatus : Remark = 11
	WHILE  (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) tcucs
		OUTPUT DELETED.CustID
		INTO #CustAffected
		FROM Tmp_CleanUpCustomerSetting tcucs
		WHERE tcucs.Remark = 11

		 IF @@ROWCOUNT = 0
				BREAK;
		
		SELECT @JsonData =
					(
						SELECT	ca.CustID
						FROM #CustAffected ca
						FOR JSON PATH
					)

		--EXEC Acc_DynamicCustSetting3rd_19_HELIOS    
			--  @ModeCode		= 'CustProductStatus'  
			--, @JsonData		= @JsonData
			--, @target			= @target

		SELECT @JsonData
	END

	DROP TABLE #CustAffected