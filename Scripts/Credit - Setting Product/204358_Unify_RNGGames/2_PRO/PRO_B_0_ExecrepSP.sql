/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: @Helios
	Date: 2024/06/21
	Task: Customer Setting - Unify RNG Lottery and Virtual Sports - Migrate Data BetSetting to New Structure [redmine : #204358] 
		https://nexdev.net/issues/204358
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_16] 
  @ModeCode			VARCHAR(50)
, @JsonData			VARCHAR(MAX)
, @target			VARCHAR (20)
AS

BEGIN
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))		RETURN -- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))		RETURN -- run at dbcust only


-----------------------------------Check New Structure RepInHouse is Exists---------------------------------

	IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BetSetting3rd_Agent]') AND type in (N'U'))
		RETURN;

	IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BetSetting3rd_Member]') AND type in (N'U'))
		RETURN;

-----------------------------------Migrate Data ---------------------------------

	IF @ModeCode = 'BS_Agent_Migrate'
	BEGIN
		INSERT INTO BetSetting3rd_Agent
		(
			  CustID
			, SportType
			, BetType
			, MinBet
			, MaxBet
			, MaxPerMatch
			, MaxPerNumber
			, RepUpdateTime
		)
		SELECT
			CustID
		    , SportType
		    , BetType
		    , MinBet
		    , MaxBet
		    , MaxPerMatch
		    , MaxPerNumber
		    , NULL
		FROM OPENJSON(@JsonData) WITH (
			CustID				INT			'$.CustID', 
			SportType				SMALLINT		'$.SportType', 
			BetType				SMALLINT		'$.BetType', 
			MinBet				MONEY			'$.MinBet', 
			MaxBet				MONEY			'$.MaxBet', 
			MaxPerMatch				MONEY			'$.MaxPerMatch', 
			MaxPerNumber			MONEY			'$.MaxPerNumber'
		)
	END
	
	
	ELSE IF @ModeCode = 'BS_Member_Migrate' 
	BEGIN
		INSERT INTO BetSetting3rd_Member
		(
			  CustID
			, SportType
			, BetType
			, MinBet
			, MaxBet
			, MaxPerMatch
			, MaxPerNumber
			, RepUpdateTime
		)
		SELECT
			  CustID
			, SportType
			, BetType
			, MinBet
			, MaxBet
			, MaxPerMatch
			, MaxPerNumber
			, NULL
		FROM OPENJSON(@JsonData) WITH (
			CustID				INT			'$.CustID', 
			SportType				SMALLINT		'$.SportType', 
			BetType				SMALLINT		'$.BetType', 
			MinBet				MONEY			'$.MinBet', 
			MaxBet				MONEY			'$.MaxBet', 
			MaxPerMatch				MONEY			'$.MaxPerMatch', 
			MaxPerNumber			MONEY			'$.MaxPerNumber'
		)
	END

	ELSE IF @ModeCode = 'BS_SMA_Remove_On_UAT' 
	BEGIN
		DELETE bsa
		FROM BetSetting3rd_Agent bsa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
				CustID				INT			'$.CustID', 
				SportType				SMALLINT		'$.SportType', 
				BetType				SMALLINT		'$.BetType'
			)
		AS js ON bsa.CustID = js.CustID AND bsa.SportType = js.SportType AND bsa.BetType = js.BetType

	END

	ELSE IF @ModeCode = 'BS_Member_Remove_On_UAT'  
	BEGIN
		
		DELETE bsa
		FROM BetSetting3rd_Member bsa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
				CustID				INT			'$.CustID', 
				SportType				SMALLINT		'$.SportType', 
				BetType				SMALLINT		'$.BetType'
			)
		AS js ON bsa.CustID = js.CustID AND bsa.SportType = js.SportType AND bsa.BetType = js.BetType
	END
END
