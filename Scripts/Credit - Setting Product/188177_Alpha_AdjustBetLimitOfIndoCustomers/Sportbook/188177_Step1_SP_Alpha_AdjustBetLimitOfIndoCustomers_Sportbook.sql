/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
  Created by: Helios
  Date: 2023/05/16
  Task: Alpha - Adjust bet limit of Indo customers [redmine : #188177]
  DB: DBCUST/CustDB

    Revisions: Modified SP Upd StakeLevelList

	Param's Explanation:  
  @AffectedList:  
	<root>
	<r C="185849" S="1" B="1"/>	<r C="185849" S="1" B="9"/><r C="185849" S="2" B="1"/><r C="185849" S="3" B="1"/><r C="185849" S="5" B="1"/><r C="185849" S="8" B="1"/><r C="185849" S="10" B="1"/><r C="185849" S="11" B="1"/>
	<r C="185849" S="99" B="1"/><r C="185849" S="99" B="9"/><r C="185849" S="161" B="81"/><r C="185849" S="164" B="8101"/><r C="510159" S="1" B="1"/><r C="510159" S="1" B="9"/><r C="510159" S="2" B="1"/><r C="510159" S="3" B="1"/>
	<r C="5543316" S="161" B="81"/><r C="5543316" S="164" B="8101"/><r C="6366423" S="161" B="81"/><r C="6366423" S="164" B="8101"/><r C="8263398" S="161" B="81"/><r C="8263398" S="164" B="8101"/><r C="8464455" S="161" B="81"/><r C="8464455" S="164" B="8101"/><r C="8536124" S="161" B="81"/>
	</root>
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]  

	@AffectedList	VARCHAR (MAX) ,
	@RoleCheck		SMALLINT ,
	@target			VARCHAR(20)

AS
BEGIN
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

-----------------------------------Check Replicate---------------------------------
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustBetSetting_Agent') = 1
	   AND dbo.f_CheckRepTable('CustBetSetting_Member') = 1
	   )
		RETURN

	--Convert XML format
	DECLARE @xml XML = NULL 
	,		@MinBet_new			MONEY = 10														-- MinBet adjusted : 10

	SET @xml = CONVERT(XML, @AffectedList)  
	
	--Parse XML   
	DECLARE @iDoc INT  
  
	EXEC sp_xml_preparedocument @iDoc OUTPUT , @xml

	CREATE TABLE #tmpCustList (  
	    CustID			INT ,
		SportType		INT ,
		BetType			INT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)  

	INSERT INTO #tmpCustList
	SELECT C , S , B
	FROM OPENXML(@iDoc, '/root/r', 1) WITH (  
	 C			INT					-- @CustID
	,S			INT					-- @SportType  
	,B			INT					-- @BetType
	)

	EXEC sp_xml_removedocument @iDoc  

	IF @RoleCheck = 2     -- RUN UPDATE FOR SMA
	BEGIN
			UPDATE c SET c.MinBet = @MinBet_new
			FROM CustBetSetting_Agent c WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustList cust 
					ON  c.CustID = cust.CustID
					AND c.SportType = cust.SportType
					AND c.BetType = cust.BetType
	END

	IF @RoleCheck = 1     -- RUN UPDATE FOR MEMBER
	BEGIN
			UPDATE c SET c.MinBet = @MinBet_new
			FROM CustBetSetting_Member c WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustList cust 
					ON  c.CustID = cust.CustID
					AND c.SportType = cust.SportType
					AND c.BetType = cust.BetType
	END
	
	DROP TABLE #tmpCustList

END
GO
