/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: @Helios
	Date: 2024/06/26
	Task: Customer Setting - Unify RNG Lottery and Virtual Sports - Remove Data Redundant [redmine : #204358] 
		https://nexdev.net/issues/204358
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_17] 
  @ModeCode			VARCHAR(50)
, @JsonData			VARCHAR(MAX)
, @target			VARCHAR (20)
AS

BEGIN
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))		RETURN -- run at all replicated servers
	IF (@target = 'DBCUST'     AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2'))		RETURN -- run at dbcust only

-----------------------------------Check Replicate---------------------------------

	IF NOT (dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1

	   AND dbo.f_CheckRepTable('CustBetSetting_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Member') = 1

	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   )
		RETURN

-----------------------------------Remove Data ---------------------------------

	IF @ModeCode = 'BS_Agent_Remove'
	BEGIN
		DELETE cs
		FROM CustBetSetting_Agent cs WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
			CustID				INT			'$.CustID', 
			SportType				SMALLINT		'$.SportType', 
			BetType				SMALLINT		'$.BetType'
		) js ON cs.CustID = js.CustID AND cs.SportType = js.SportType AND cs.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'BS_3rdAgent_Remove' 
	BEGIN
		DELETE cs
		FROM CustBetSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
			CustID				INT			'$.CustID', 
			SportType				SMALLINT		'$.SportType', 
			BetType				SMALLINT		'$.BetType'
		) js ON cs.CustID = js.CustID AND cs.SportType = js.SportType AND cs.BetType = js.BetType
	END

	ELSE IF @ModeCode = 'BS_Member_Remove' 
	BEGIN
		DELETE cs
		FROM CustBetSetting_Member cs WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
			CustID				INT			'$.CustID', 
			SportType				SMALLINT		'$.SportType', 
			BetType				SMALLINT		'$.BetType'
		) js ON cs.CustID = js.CustID AND cs.SportType = js.SportType AND cs.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'BS_3rdMember_Remove' 
	BEGIN
		DELETE cs
		FROM CustBetSetting3rd_Member cs WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
			CustID				INT			'$.CustID', 
			SportType				SMALLINT		'$.SportType', 
			BetType				SMALLINT		'$.BetType'
		) js ON cs.CustID = js.CustID AND cs.SportType = js.SportType AND cs.BetType = js.BetType
	END


	ELSE IF @ModeCode = 'PT_Agent_Remove' 
	BEGIN
		DELETE cs
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
			CustID				INT			'$.CustID', 
			SportType				SMALLINT		'$.SportType', 
			BetType				SMALLINT		'$.BetType'
		) js ON cs.CustID = js.CustID AND cs.SportType = js.SportType AND cs.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'PT_GroupMember_Remove' 
	BEGIN
		DELETE cs
		FROM CustPTGroupSetting3rd_Member cs WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
			CustID				INT			'$.CustID', 
			SportType				SMALLINT		'$.SportType', 
			BetType				SMALLINT		'$.BetType'
		) js ON cs.AgentID = js.CustID AND cs.SportType = js.SportType AND cs.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'PT_Member_Remove' 
	BEGIN
		DELETE cs
		FROM CustPTSetting3rd_Member cs WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
			CustID				INT			'$.CustID', 
			SportType				SMALLINT		'$.SportType', 
			BetType				SMALLINT		'$.BetType'
		) js ON cs.CustID = js.CustID AND cs.SportType = js.SportType AND cs.BetType = js.BetType
	END
END
