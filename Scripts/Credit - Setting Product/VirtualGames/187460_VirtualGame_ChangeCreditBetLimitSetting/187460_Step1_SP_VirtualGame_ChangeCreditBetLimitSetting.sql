/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
Created by: Helios
Date: 2023/05/09
Task: Virtual Game - Change credit bet limit setting [redmine : #187460]
DB: DBCUST/CustDB
Revisions: Modified SP Upd StakeLevelList

	Param's Explanation:  
	@AffectedList:  
		<root>
		<r C="3" B="4601" SL="21819"/><r C="5" B="4601" SL="21838"/><r C="6" B="4601" SL="21970"/><r C="13" B="4601" SL="21839"/><r C="15" B="4601" SL="21891"/><r C="20" B="4601" SL="21821"/><r C="20" B="4602" SL="21910"/><r C="20" B="4605" SL="22700"/>
		<r C="72" B="4601" SL="22139"/><r C="1264" B="4601" SL="21838"/><r C="1266" B="4601" SL="21970"/><r C="1270" B="4601" SL="21839"/><r C="1412" B="4601" SL="21838"/><r C="2690" B="4601" SL="21838"/><r C="3802" B="4601" SL="21838"/><r C="4176" B="4601" SL="21819"/><r C="4178" B="4601" SL="21838"/><r C="4179" B="4601" SL="21970"/>
		<r C="33290645" B="4601" SL="21839"/><r C="33290664" B="4601" SL="21839"/><r C="33290666" B="4601" SL="21839"/><r C="33290668" B="4601" SL="21839"/><r C="33290673" B="4601" SL="21839"/><r C="33290675" B="4601" SL="21839"/><r C="33290678" B="4601" SL="21839"/><r C="33290682" B="4601" SL="21839"/><r C="33290686" B="4601" SL="21839"/>
		</root>
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]  

	@AffectedList	VARCHAR (MAX) ,
	@RoleCheck		SMALLINT  ,
	@target			VARCHAR(20)

AS

BEGIN
	SET NOCOUNT ON  

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','TESTDBCUST','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

-----------------------------------Check Replicate---------------------------------
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustStakeLevel_Agent') = 1
	   AND dbo.f_CheckRepTable('CustStakeLevel_Member') = 1
	   )
		RETURN

	--Convert XML format
	DECLARE @xml XML = NULL , @SportType SMALLINT = 245

	SET @xml = CONVERT(XML, @AffectedList)  
	
	--Parse XML   
	DECLARE @iDoc INT  
  
	EXEC sp_xml_preparedocument @iDoc OUTPUT , @xml

	CREATE TABLE #tmpCustList (  
	    CustID			INT  
	  , BetType			INT  
	  , StakeLevelID	VARCHAR (200)
	  , PRIMARY KEY CLUSTERED (CustID, BetType)  
	)  

	INSERT INTO #tmpCustList
	SELECT C , B , SL 
	FROM OPENXML(@iDoc, '/root/r', 1) WITH (  
	 C			INT					-- @AffectedList
	,B			INT					-- @BetType  
	,SL			VARCHAR (200)		-- @StakeLevelID
	)

	EXEC sp_xml_removedocument @iDoc  

	IF @RoleCheck = 2     -- RUN UPDATE FOR SMA
	BEGIN
			UPDATE c SET c.StakeLevelList = cust.StakeLevelID
			FROM CustStakeLevel_Agent c WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustList cust 
					ON  c.CustID = cust.CustID
					AND c.BetType = cust.BetType
			WHERE c.SportType = @SportType
	END

	IF @RoleCheck = 1     -- RUN UPDATE FOR MEMBER
	BEGIN
			UPDATE c 
				SET c.StakeLevelList = cust.StakeLevelID
				,	c.LastUpdated = GETDATE ()
			FROM CustStakeLevel_Member c WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustList cust 
					ON  c.CustID = cust.CustID
					AND c.BetType = cust.BetType
			WHERE c.SportType = @SportType
	END
	
	DROP TABLE #tmpCustList

END
GO
