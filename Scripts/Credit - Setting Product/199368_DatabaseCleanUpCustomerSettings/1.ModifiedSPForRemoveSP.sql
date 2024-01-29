/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240104@Helios
	Task: Modified SP execrep for Remove Data [#199368]
		https://nexdev.net/issues/199368
	DB: DBCust/CustDB 
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_19] 
  @__tableName		VARCHAR(200)  
, @JsonData			VARCHAR(MAX) 
, @target			VARCHAR (20)

AS

BEGIN
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))			RETURN -- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))		RETURN -- run at dbcust only

---------------------------------Check Replicate---------------------------------

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustSettingMode3rd') = 1
	   
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1
	   
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Member') = 1

	   AND dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 1
	   AND dbo.f_CheckRepTable('CustWinLossLimit_Member') = 1
	   
	   AND dbo.f_CheckRepTable('CustStakeLevel_Agent') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Member') = 1
	   )
		RETURN

-----------------------------------Migrate Data ---------------------------------

	---- CustPTSetting3rd_Agent : Remark = 1
	IF @__tableName = 'CustPTSetting3rd_Agent'
	BEGIN
		
		DELETE cpa
		FROM CustPTSetting3rd_Agent cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT '$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustPTSetting3rd_Member : Remark = 2
	ELSE IF @__tableName = 'CustPTSetting3rd_Member'
	BEGIN
		
		DELETE cpa
		FROM CustPTSetting3rd_Member cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT '$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustBetSetting3rd_Agent : Remark = 3
	ELSE IF @__tableName = 'CustBetSetting3rd_Agent'
	BEGIN

		DELETE cpa
		FROM CustBetSetting3rd_Agent cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT '$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustBetSetting3rd_Member : Remark = 4
	ELSE IF @__tableName = 'CustBetSetting3rd_Member'
	BEGIN

		DELETE cpa
		FROM CustBetSetting3rd_Member cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT '$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustDiscount3rd_Agent : Remark = 5
	ELSE IF @__tableName = 'CustDiscount3rd_Agent'
	BEGIN

		DELETE cpa
		FROM CustDiscount3rd_Agent cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT '$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustDiscount3rd_Member : Remark = 6
	ELSE IF @__tableName = 'CustDiscount3rd_Member'
	BEGIN

		DELETE cpa
		FROM CustDiscount3rd_Member cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT '$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustWinLossLimit_Agent : Remark = 7
	ELSE IF @__tableName = 'CustWinLossLimit_Agent'
	BEGIN

		DELETE cpa
		FROM CustWinLossLimit_Agent cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT '$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustWinLossLimit_Member : Remark = 8
	ELSE IF @__tableName = 'CustWinLossLimit_Member'
	BEGIN

		DELETE cpa
		FROM CustWinLossLimit_Member cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT		'$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustStakeLevel_Agent : Remark = 9
	ELSE IF @__tableName = 'CustStakeLevel_Agent'
	BEGIN

		DELETE cpa
		FROM CustStakeLevel_Agent cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT		'$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustStakeLevel_Member : Remark = 10
	ELSE IF @__tableName = 'CustStakeLevel_Member'
	BEGIN

		DELETE cpa
		FROM CustStakeLevel_Member cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT		'$.CustID',
			SportType		SMALLINT '$.SportType',
			BetType		SMALLINT '$.BetType'
		) AS js ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustPTGroupSetting3rd_Member : Remark = 11
	ELSE IF @__tableName = 'CustPTGroupSetting3rd_Member'
	BEGIN

		DELETE cpa
		FROM CustPTGroupSetting3rd_Member cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT		'$.CustID',
			SportType		SMALLINT	'$.SportType',
			BetType		SMALLINT		'$.BetType'
		) AS js ON cpa.AgentID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END

	---- CustSettingMode3rd : Remark = 12
	ELSE IF @__tableName = 'CustSettingMode3rd'
	BEGIN

		DELETE cpa
		FROM CustSettingMode3rd cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID		INT '$.CustID'
		) AS js ON cpa.CustID = js.CustID
	END

	
	

END
