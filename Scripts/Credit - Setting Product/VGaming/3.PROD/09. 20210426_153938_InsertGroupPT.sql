 /*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Group PT Setting for VGaming [#RM:153938]
	DB: DBCUST/CustDB And all subscriber of CustDB_Custsetting Publication
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE Acc_DynamicCustSetting3rd_09
	@target VARCHAR(20)
AS
BEGIN  
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1
	   AND dbo.f_CheckRepTable('CustSettingMode3rd') = 1
	   AND dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 1
	   AND dbo.f_CheckRepTable('ProductSettingDetail') = 1
	   )
	  RETURN	

	CREATE TABLE #AgentList (CustID INT)
	DECLARE @AgentTmp TABLE (CustID INT)

	DECLARE @ProductID TINYINT = 66
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	200, 1611, SportType, BetType, 0, SettingType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType IN (1)

	INSERT INTO #AgentList (CustID)
	SELECT DISTINCT AgentID
	FROM CustPTGroupSetting3rd_Member cs WITH (NOLOCK)
		INNER JOIN dbo.custInfo ci ON ci.custid = cs.AgentID
		INNER JOIN dbo.customer c ON ci.custid = c.custid
	WHERE ci.Enabled = 1 
		AND c.site IN ('BEST-ODDS', 'INDO', 'XYZBET', '611111', '722222', '733333', '222223', '755555', 'KORIBC', '7aa666', 'IBCIndo')
		AND c.currency IN (
							13, --CNY(RMB)
							6,  --EUR(EURO)
							12, --GBP(GBP)
							5,  --HKD(HK$)
							67, --HKD(HKK)
							47, --IDR(DDD)
							33, --IDR(IDD)
							34, --IDR(IDR)
							15, --IDR(IN)
							22, --IDR(IND)
							45, --KRW(Won)
							69, --MMK(MMK)
							2,  --MYR(RM)
							43 --THB(THB)
						
	)
	AND 1 = (CASE WHEN c.[site] = 'BEST-ODDS' AND ci.currency IN (43,47,33,34,15,22) THEN 0 ELSE 1 END) --exclude Site BEST-ODDS with currencies: THB(THB), IDR(DDD), IDR(IDR), IDR(IDR), IDR(IN), IDR(IND)


	DECLARE @fSportType SMALLINT, @fBetType SMALLINT
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 1

	WHILE (1=1)
	BEGIN
		DELETE TOP (4000) t 
		OUTPUT Deleted.custid
		INTO @AgentTmp
		FROM #AgentList t

		IF @@ROWCOUNT = 0 BREAK

		--MEMBER LEVEL
		INSERT INTO dbo.CustPTGroupSetting3rd_Member
			(	[AgentID]
				,	[sporttype]
				,	[bettype]
				,	[islive]
				,	[superPT]
				,	[masterPT]
				,	[agentPT]
				,	[IsAutoMasterPT]
				,	[AutoMasterPT]
				,	[IsAutoSuperPT]
				,	[AutoSuperPT])
		SELECT 
			cs.AgentID, dest.tSportType, dest.tBetType, dest.IsLive
			,cs.SuperPT
			,cs.MasterPT
			,cs.AgentPT
			,cs.IsAutoMasterPT
			,cs.AutoMasterPT
			,cs.IsAutoSuperPT
			,cs.AutoSuperPT
		FROM dbo.CustPTGroupSetting3rd_Member cs WITH(NOLOCK)
			INNER JOIN @AgentTmp a ON a.CustID = cs.AgentID
			CROSS APPLY #DestinationSportBetType dest
		WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
			AND dest.SettingType = 1

		DELETE @AgentTmp
	END

	DROP TABLE #AgentList
	DROP TABLE #DestinationSportBetType
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = @target

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'