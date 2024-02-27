/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231213@Helios
	Task: Remove Redundant Setting of MuyaThai & Esport (PT , BetSetting) [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/
ALTER PROCEDURE dbo.Acc_DynamicCustSetting3rd_16
  @ModeCode			VARCHAR(50)
, @JsonData			VARCHAR(MAX)
, @target			VARCHAR (20)

AS

BEGIN
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))			RETURN -- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))			RETURN -- run at dbcust only

	--=============================
	--CHECK REPLICATE
	--=============================

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Member') = 1
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   )
		RETURN

	--=============================
	--REMOVE DATA
	--=============================

	IF @ModeCode = 'SMAPT'
	BEGIN
		DELETE cpa
		FROM CustPTSetting3rd_Agent cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (      CustID		INT		'$.Custid',
				SportType		SMALLINT	'$.SportType',
				BetType		SMALLINT	'$.BetType'
			) AS js	ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'GPT'
	BEGIN
		DELETE cpa
		FROM CustPTGroupSetting3rd_Member cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (      CustID		INT		'$.Custid',
				SportType		SMALLINT	'$.SportType',
				BetType		SMALLINT	'$.BetType'
			) AS js	ON cpa.AgentID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'MemPT'
	BEGIN
		DELETE cpa
		FROM CustPTSetting3rd_Member cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (      CustID		INT		'$.Custid',
				SportType		SMALLINT	'$.SportType',
				BetType		SMALLINT	'$.BetType'
			) AS js	ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'SMABS'
	BEGIN
		DELETE cpa
		FROM CustBetSetting3rd_Agent cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (      CustID		INT		'$.Custid',
				SportType		SMALLINT	'$.SportType',
				BetType		SMALLINT	'$.BetType'
			) AS js	ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'MemBS'
	BEGIN
		DELETE cpa
		FROM CustBetSetting3rd_Member cpa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (      CustID		INT		'$.Custid',
				SportType		SMALLINT	'$.SportType',
				BetType		SMALLINT	'$.BetType'
			) AS js	ON cpa.CustID = js.CustID AND cpa.SportType = js.SportType AND cpa.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'Reset_CustProductStatus'
	BEGIN
		UPDATE cpa
			SET   cpa.bitmapHasSynced = js.bitmapHasSynced
			,	cpa.bitmapIsHidden  =  js.bitmapIsHidden
			,	cpa.bitmapIsDisabled = js.bitmapIsDisabled
		FROM CustProductStatus cpa WITH (ROWLOCK , UPDLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (      CustID			INT		'$.CustID',
				bitmapHasSynced		BINARY(32)	'$.bitmapHasSynced',
				bitmapIsHidden		BINARY(32)	'$.bitmapIsHidden',
				bitmapIsDisabled		BINARY(32)	'$.bitmapIsDisabled'
			) AS js	
		ON cpa.CustID = js.CustID
	END


END