/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2024/04/08
	Task: Customer Setting - Migrate Sportsbook to DCS [redmine : #198960]  
		https://nexdev.net/issues/198960
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE dbo.Acc_DynamicCustSetting3rd_18
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
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 1
	   AND dbo.f_CheckRepTable('CustWinLossLimit_Member') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Agent') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Member') = 1
	   )
		RETURN

-----------------------------------Remove Data ---------------------------------

	IF @ModeCode = 'PT_SMA' 
	BEGIN
		DELETE apt
		FROM CustPTSetting3rd_Agent apt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID	INT '$.CustID',
			SportType	INT '$.SportType',
			BetType	INT '$.BetType'
			) AS js ON apt.CustID = js.CustID AND apt.SportType = js.SportType AND apt.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'PT_Member' 
	BEGIN
		DELETE apt
		FROM CustPTSetting3rd_Member apt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID	INT '$.CustID',
			SportType	INT '$.SportType',
			BetType	INT '$.BetType'
			) AS js ON apt.CustID = js.CustID AND apt.SportType = js.SportType AND apt.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'PTGroup_Remove' 
	BEGIN
		DELETE apt
		FROM CustPTGroupSetting3rd_Member apt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID	INT '$.CustID',
			SportType	INT '$.SportType',
			BetType	INT '$.BetType'
			) AS js ON apt.AgentID = js.CustID AND apt.SportType = js.SportType AND apt.BetType = js.BetType
	END

	ELSE IF @ModeCode = 'WL_SMA' 
	BEGIN
		DELETE apt
		FROM CustWinLossLimit_Agent apt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID	INT '$.CustID',
			SportType	INT '$.SportType',
			BetType	INT '$.BetType'
			) AS js ON apt.CustID = js.CustID AND apt.SportType = js.SportType AND apt.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'WL_Member' 
	BEGIN
		DELETE apt
		FROM CustWinLossLimit_Member apt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID	INT '$.CustID',
			SportType	INT '$.SportType',
			BetType	INT '$.BetType'
			) AS js ON apt.CustID = js.CustID AND apt.SportType = js.SportType AND apt.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'StakeLevel_SMA' 
	BEGIN
		DELETE apt
		FROM CustStakeLevel_Agent apt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID	INT '$.CustID',
			SportType	INT '$.SportType',
			BetType	INT '$.BetType'
			) AS js ON apt.CustID = js.CustID AND apt.SportType = js.SportType AND apt.BetType = js.BetType
	END
	ELSE IF @ModeCode = 'StakeLevel_Member' 
	BEGIN
		DELETE apt
		FROM CustStakeLevel_Member apt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) 
		WITH (
			CustID	INT '$.CustID',
			SportType	INT '$.SportType',
			BetType	INT '$.BetType'
			) AS js ON apt.CustID = js.CustID AND apt.SportType = js.SportType AND apt.BetType = js.BetType
	END
	
END

GO