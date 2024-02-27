/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/09/21
	Task: Customer Setting - Migrate Sportsbook to DCS [redmine : #193083] 
		https://nexdev.net/issues/193083 
	DB: DBCUST/CustDB 
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_17] 
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
	   AND dbo.f_CheckRepTable('CustDiscount3rd_Member') = 1
	   )
		RETURN

-----------------------------------Migrate Data ---------------------------------

	IF @ModeCode = 'Discount_Member'
	BEGIN
		UPDATE cdm SET BetType = 1
		FROM CustDiscount3rd_Member cdm WITH (ROWLOCK ,UPDLOCK)
		INNER JOIN OPENJSON(@JsonData) WITH (
			CustID INT '$.CustID',
			SportType SMALLINT '$.SportType',
			BetType SMALLINT '$.BetType'
		) AS js ON cdm.CustID = js.CustID AND cdm.SportType = js.SportType AND cdm.BetType = js.BetType

	END
END
    
