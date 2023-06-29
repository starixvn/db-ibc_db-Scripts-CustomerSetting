
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/06/01
	Task: RNG Slot - Fix missing bet limit setting for all accounts [redmine : #188949]
	DB: DBCUST/CustDB
	Revisions: Modified SP Upd BetLimit Setting
*/
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@AffectedList	VARCHAR (MAX) 
,	@RoleCheck		SMALLINT
,	@target			VARCHAR(20)

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
	DECLARE @xml XML = NULL 

	SET @xml = CONVERT(XML, @AffectedList)  
	
	--Parse XML   
	DECLARE @iDoc INT  
  
	EXEC sp_xml_preparedocument @iDoc OUTPUT , @xml

	CREATE TABLE #tmpCustList (  
	    CustID				INT ,
		SportType			INT ,
		BetType				INT ,
		StakeLevelList		VARCHAR (200) ,
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)  

	INSERT INTO #tmpCustList
	SELECT C , S , B , L
	FROM OPENXML(@iDoc, '/root/r', 1) WITH (  
	 C			INT					-- @CustID
	,S			INT					-- @SportType  
	,B			INT					-- @BetType
	,L			VARCHAR(200)		-- @StakeLevelList
	)

	EXEC sp_xml_removedocument @iDoc  

	
	IF @RoleCheck = 2     -- RUN UPDATE FOR SMA
		BEGIN
			-- Update CustStakeLevel_Agent
			UPDATE ca SET ca.StakeLevelList = sma.StakeLevelList
			FROM CustStakeLevel_Agent ca  WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustList sma 
					ON  ca.CustID = sma.CustID 
					AND ca.SportType = sma.SportType 
					AND ca.BetType = sma.BetType
		END
	
	IF @RoleCheck = 1     -- RUN UPDATE FOR MEMBER
		BEGIN
			-- Update CustStakeLevel_Member
			UPDATE cm SET cm.StakeLevelList = sm.StakeLevelList
			FROM CustStakeLevel_Member cm  WITH (ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustList sm 
					ON  cm.CustID = sm.CustID 
					AND cm.SportType = sm.SportType 
					AND cm.BetType = sm.BetType
		END
	DROP TABLE #tmpCustList
END
GO
