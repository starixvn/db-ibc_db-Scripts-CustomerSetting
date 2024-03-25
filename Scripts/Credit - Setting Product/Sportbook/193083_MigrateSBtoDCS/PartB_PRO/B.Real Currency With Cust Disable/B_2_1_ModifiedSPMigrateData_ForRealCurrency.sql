/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/09/21
	Task: Customer Setting - Migrate Sportsbook to DCS With Exchange have IsActive = 0 , CustSuper.isinternal = 1 [redmine : #193083] 
		https://nexdev.net/issues/193083
	DB: DBCUST/CustDB 
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_19] 
  @ModeCode			VARCHAR(50)
, @JsonData			VARCHAR(MAX)
, @target			VARCHAR (20)

AS

BEGIN
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))			RETURN -- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))		RETURN -- run at dbcust only

-----------------------------------Check Replicate---------------------------------

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustSettingMode3rd') = 1
	   )
		RETURN

-----------------------------------Migrate Data ---------------------------------

	IF @ModeCode = 'PTSMA'
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
			FROM OPENJSON(@JsonData) WITH (CustID INT '$.CustID',
			SportType SMALLINT '$.SportType',
			BetType SMALLINT '$.BetType',
			IsLive BIT '$.IsLive',
			IsAutoMasterPT BIT '$.IsAutoMasterPT',
			IsAutoSuperPT BIT '$.IsAutoSuperPT',
			SuperPT SMALLMONEY '$.SuperPT',
			MasterPT SMALLMONEY '$.MasterPT',
			AgentPT SMALLMONEY '$.AgentPT',
			AutoSuperPT SMALLMONEY '$.AutoSuperPT',
			AutoMasterPT SMALLMONEY '$.AutoMasterPT',
			MinPT SMALLMONEY '$.MinPT',
			MaxPT SMALLMONEY '$.MaxPT')

	END
	ELSE
	IF @ModeCode = 'PTMember'
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
			FROM OPENJSON(@JsonData) WITH (CustID INT '$.CustID',
			SportType SMALLINT '$.SportType',
			BetType SMALLINT '$.BetType',
			IsLive BIT '$.IsLive',
			IsAutoMasterPT BIT '$.IsAutoMasterPT',
			IsAutoSuperPT BIT '$.IsAutoSuperPT',
			SuperPT SMALLMONEY '$.SuperPT',
			MasterPT SMALLMONEY '$.MasterPT',
			AgentPT SMALLMONEY '$.AgentPT',
			AutoSuperPT SMALLMONEY '$.AutoSuperPT',
			AutoMasterPT SMALLMONEY '$.AutoMasterPT')
	END
	ELSE
	IF @ModeCode = 'UpdIsGroupPT'
	BEGIN
		UPDATE cs
			SET cs.IsGrouped = 0
		FROM CustSettingMode3rd cs WITH (ROWLOCK , UPDLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (CustID INT '$.CustID') AS Js ON cs.CustID = Js.CustID
	END
	ELSE
	IF @ModeCode = 'InsGroupPT'
	BEGIN
		INSERT INTO [dbo].[CustPTGroupSetting3rd_Member]  ([AgentID] ,[SportType] ,[BetType] ,[IsLive] ,[SuperPT] ,[MasterPT] ,[AgentPT] ,[IsAutoMasterPT] ,[AutoMasterPT] ,[IsAutoSuperPT] ,[AutoSuperPT])
		SELECT
			    recommend
			   ,SportType
			   ,BetType
			   ,IsLive
			   ,SuperPT
			   ,MasterPT
			   ,AgentPT
			   ,IsAutoMasterPT
			   ,AutoMasterPT
			   ,IsAutoSuperPT
			   ,AutoSuperPT
			FROM OPENJSON(@JsonData) WITH (
			recommend INT '$.recommend',
			SportType SMALLINT '$.SportType',
			BetType SMALLINT '$.BetType',
			IsLive BIT '$.IsLive',
			SuperPT SMALLMONEY '$.SuperPT',
			MasterPT SMALLMONEY '$.MasterPT',
			AgentPT SMALLMONEY '$.AgentPT',
			IsAutoMasterPT BIT '$.IsAutoMasterPT',
			AutoMasterPT SMALLMONEY '$.AutoMasterPT',
			IsAutoSuperPT BIT '$.IsAutoSuperPT',
			AutoSuperPT SMALLMONEY '$.AutoSuperPT'
			)

	END
	ELSE
	IF @ModeCode = 'DelPT'
	BEGIN
		DELETE cs
		FROM [dbo].[CustPTSetting3rd_Member] cs WITH(ROWLOCK)
			INNER JOIN OPENJSON(@JsonData) WITH ( CustID INT '$.CustID'
									) AS Js ON cs.CustID = Js.CustID
		WHERE cs.SportType IN (9913,9914,9915)
	END
	ELSE
	IF @ModeCode = 'DiscountSMA'
	BEGIN
		INSERT INTO CustDiscount3rd_Agent (CustID, SportType, BetType, Discount)
			SELECT
				CustID
			   ,SportType
			   ,BetType
			   ,Discount
			FROM OPENJSON(@JsonData) WITH (CustID INT '$.custid',
			SportType SMALLINT '$.sporttype',
			BetType SMALLINT '$.bettype',
			Discount DECIMAL(9, 8) '$.discount')
	END
	ELSE
	IF @ModeCode = 'DiscountMember'
	BEGIN
		INSERT INTO CustDiscount3rd_Member (CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
			SELECT
				CustID
			   ,SportType
			   ,BetType
			   ,PlayerDiscount
			   ,AgentDiscount
			   ,MasterDiscount
			   ,SuperDiscount
			FROM OPENJSON(@JsonData) WITH (CustID INT '$.custid',
			SportType SMALLINT '$.sporttype',
			BetType SMALLINT '$.bettype',
			PlayerDiscount DECIMAL(9, 8) '$.playerdiscount',
			AgentDiscount DECIMAL(9, 8) '$.AgentDiscount',
			MasterDiscount DECIMAL(9, 8) '$.MasterDiscount',
			SuperDiscount DECIMAL(9, 8) '$.SuperDiscount')
	END
	ELSE
	IF @ModeCode = 'BetSettingSMA'
	BEGIN
		INSERT INTO CustBetSetting_Agent (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPerNumber, MaxPayoutPerMatch)
			SELECT
				CustID
			   ,SportType
			   ,BetType
			   ,MinBet
			   ,MaxBet
			   ,MaxPerMatch
			   ,NULL
			   ,NULL
			FROM OPENJSON(@JsonData) WITH (CustID INT '$.CustID',
			SportType SMALLINT '$.SportType',
			BetType SMALLINT '$.BetType',
			MinBet MONEY '$.MinBet',
			MaxBet MONEY '$.MaxBet',
			MaxPerMatch MONEY '$.MaxPerMatch')
	END
	ELSE
	IF @ModeCode = 'BetSettingMember'
	BEGIN
		INSERT INTO CustBetSetting_Member (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPerNumber, MaxPayoutPerMatch)
			SELECT
				CustID
			   ,SportType
			   ,BetType
			   ,MinBet
			   ,MaxBet
			   ,MaxPerMatch
			   ,NULL
			   ,NULL
			FROM OPENJSON(@JsonData) WITH (CustID INT '$.CustID',
			SportType SMALLINT '$.SportType',
			BetType SMALLINT '$.BetType',
			MinBet MONEY '$.MinBet',
			MaxBet MONEY '$.MaxBet',
			MaxPerMatch MONEY '$.MaxPerMatch')
	END

END