/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 07/06/2024
	Task: Migrate RNG Keno For Headline Is Hidden [#204358]
		- Indirect Account - Line Super:
			Scr 1: 
				product status = disable
				bet setting = 0 / 0/ 0
				Super max PT = 0.9 (max value của Keno đang offer)

			Scr 2:
				product status = disable
				bet setting = 0 / 0/ 0.1
				PT value= 0 (follow rule create new customer)

		- Direct Account:
			For direct Master/ Agent/ Members, will follow:
				product status = disable
				bet setting = 0 / 0/ 0.1
				PT value = max value
				
	DB: DBCust/CustDB
*/

ALTER PROCEDURE dbo.Acc_DynamicCustSetting3rd_17
  @ModeCode			VARCHAR(50) 
, @JsonData			VARCHAR(MAX) 
, @target			VARCHAR (20)

AS

BEGIN

	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))			RETURN -- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))		RETURN -- run at dbcust only

-------------------------------------Check Replicate---------------------------------

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1
	   )
		RETURN
	


	IF @ModeCode = 'PT_MA'
	BEGIN
		INSERT INTO CustPTSetting3rd_Agent (CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, MinPT, MaxPT)
		SELECT
			 CustID
			,SportType
			,BetType
			,IsLive
			,IsAutoMasterPT
			,IsAutoSuperPT
			,SuperPT
			,MasterPT
			,AgentPT
			,AutoSuperPT
			,AutoMasterPT
			,MinPT
			,MaxPT
		FROM OPENJSON(@JsonData) WITH (
			CustID		INT		'$.CustID',
			SportType		SMALLINT	'$.SportType',
			BetType		SMALLINT	'$.BetType',
			IsLive		BIT		'$.IsLive',
			IsAutoMasterPT	BIT		'$.IsAutoMasterPT',
			IsAutoSuperPT	BIT		'$.IsAutoSuperPT',
			SuperPT		SMALLMONEY  '$.SuperPT',
			MasterPT		SMALLMONEY  '$.MasterPT',
			AgentPT		SMALLMONEY  '$.AgentPT',
			AutoSuperPT		SMALLMONEY  '$.AutoSuperPT',
			AutoMasterPT	SMALLMONEY  '$.AutoMasterPT',
			MinPT			SMALLMONEY  '$.MinPT',
			MaxPT			SMALLMONEY  '$.MaxPT')


	END
	ELSE IF @ModeCode = 'PT_Member'
	BEGIN
		INSERT INTO CustPTSetting3rd_Member (CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT)
		SELECT
			 CustID
			,SportType
			,BetType
			,IsLive
			,IsAutoMasterPT
			,IsAutoSuperPT
			,SuperPT
			,MasterPT
			,AgentPT
			,AutoSuperPT
			,AutoMasterPT
		FROM OPENJSON(@JsonData) WITH (
			CustID		INT		'$.CustID',
			SportType		SMALLINT	'$.SportType',
			BetType		SMALLINT	'$.BetType',
			IsLive		BIT		'$.IsLive',
			IsAutoMasterPT	BIT		'$.IsAutoMasterPT',
			IsAutoSuperPT	BIT		'$.IsAutoSuperPT',
			SuperPT		SMALLMONEY  '$.SuperPT',
			MasterPT		SMALLMONEY  '$.MasterPT',
			AgentPT		SMALLMONEY  '$.AgentPT',
			AutoSuperPT		SMALLMONEY	'$.AutoSuperPT',
			AutoMasterPT	SMALLMONEY	'$.AutoMasterPT')
	END
	ELSE IF @ModeCode = 'BetSetting_MA'
	BEGIN
		INSERT INTO CustBetSetting3rd_Agent  (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
		SELECT
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		FROM OPENJSON(@JsonData) WITH (
			CustID		INT		'$.CustID',
			SportType		SMALLINT	'$.SportType',
			BetType		SMALLINT	'$.BetType',
			MinBet		MONEY		'$.MinBet',
			MaxBet		MONEY		'$.MaxBet',
			MaxPerMatch		MONEY		'$.MaxPerMatch')

	END
	ELSE IF @ModeCode = 'BetSetting_Member'
	BEGIN
		INSERT INTO CustBetSetting3rd_Member (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
		SELECT
			 CustID
			,SportType
			,BetType
			,MinBet
			,MaxBet
			,MaxPerMatch
		FROM OPENJSON(@JsonData) WITH (
			CustID		INT		'$.CustID',
			SportType		SMALLINT	'$.SportType',
			BetType		SMALLINT	'$.BetType',
			MinBet		MONEY		'$.MinBet',
			MaxBet		MONEY		'$.MaxBet',
			MaxPerMatch		MONEY		'$.MaxPerMatch')
	END
	ELSE IF @ModeCode = 'CustPS'
	BEGIN
		--SELECT cps.CustID 
		--,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsHidden,    40, 0))
		--,IsHidden = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel ((SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsHidden,    40, 0)),  40))
		--,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsDisabled,  40, 1))
		--,IsDisable = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel ((SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsDisabled,  40, 1)),  40))
		UPDATE  cps
			SET
				cps.bitmapIsHidden	= (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsHidden,    40, 0)),
				cps.bitmapIsDisabled	= (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cps.bitmapIsDisabled,  40, 1))
		FROM CustProductStatus cps WITH (ROWLOCK ,UPDLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
			CustID		INT		'$.CustID') 
		AS js 
		ON cps.CustID = js.CustID
	END

END
