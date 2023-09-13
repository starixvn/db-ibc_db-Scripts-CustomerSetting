/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/09/21
	Task: Customer Setting - Migrate Sportsbook to DCS [redmine : #193083]  
		https://nexdev.net/issues/193083
	DB: DBCUST/CustDB
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_18] 
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
	   )
		RETURN

-----------------------------------Remove Data ---------------------------------

	IF @ModeCode = 'PTSMA_Remove' 
	BEGIN
		DELETE apt
		FROM CustPTSetting3rd_Agent apt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (CustID INT '$.CustID') AS js ON apt.CustID = js.CustID
		WHERE SportType IN (9913,9914,9915)
	END
	ELSE IF @ModeCode = 'PTMember_Remove' 
	BEGIN
		DELETE mpt
		FROM CustPTSetting3rd_Member mpt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (CustID INT '$.CustID') AS js ON mpt.CustID = js.CustID
		WHERE SportType IN (9913,9914,9915)
	END
	ELSE IF @ModeCode = 'PTGroup_Remove' 
	BEGIN
		DELETE gpt
		FROM CustPTGroupSetting3rd_Member gpt WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (CustID INT '$.CustID') AS js ON gpt.AgentID = js.CustID
		WHERE SportType IN (9913,9914,9915)
	END

	ELSE IF @ModeCode = 'Discount_SMA' 
	BEGIN
		DELETE cda
		FROM CustDiscount3rd_Agent cda WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (CustID INT '$.CustID') AS js ON cda.CustID = js.CustID
		WHERE SportType IN (1,2)
	END
	ELSE IF @ModeCode = 'Discount_Mem' 
	BEGIN
		DELETE cdm
		FROM CustDiscount3rd_Member cdm WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (CustID INT '$.CustID') AS js ON cdm.CustID = js.CustID
		WHERE SportType IN (1,2)
	END
	ELSE IF @ModeCode = 'BetSetting_SMA' 
	BEGIN
		DELETE cbsa
		FROM CustBetSetting_Agent cbsa WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (CustID INT '$.CustID') AS js ON cbsa.CustID = js.CustID
		WHERE SportType IN (43,44)
	END
	ELSE IF @ModeCode = 'BetSetting_Mem' 
	BEGIN
		DELETE cbsm
		FROM CustBetSetting_Member cbsm WITH (ROWLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (CustID INT '$.CustID') AS js ON cbsm.CustID = js.CustID
		WHERE SportType IN (43,44)
	END



END