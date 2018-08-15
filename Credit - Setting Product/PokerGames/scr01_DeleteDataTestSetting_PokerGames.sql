/*
	Created: Elodie
	Date: 20180705
	Task: Delete existing data of Poker Games
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'SITDBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'SITDBCUST') RETURN -- run at dbcust only

	--IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DB233') RETURN	-- run at all replicated servers
	--IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DB233') RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN			

	DECLARE @Sporttype SMALLINT = 163

	SELECT DISTINCT custid 
	INTO #CustDiscount3rd_Agent
	FROM dbo.CustDiscount3rd_Agent cg WITH(NOLOCK)		
	WHERE SportType = @Sporttype

	SELECT DISTINCT custid 
	INTO #CustDiscount3rd_Member
	FROM dbo.CustDiscount3rd_Member cg WITH(NOLOCK)		
	WHERE SportType = @Sporttype

	SELECT DISTINCT custid 
	INTO #CustWinLoss_Agent
	FROM dbo.CustWinLossLimit_Agent cg WITH(NOLOCK)		
	WHERE SportType = @Sporttype

	SELECT DISTINCT custid 
	INTO #CustWinLoss_Member
	FROM dbo.CustWinLossLimit_Member cg WITH(NOLOCK)		
	WHERE SportType = @Sporttype

	DELETE cg
	FROM dbo.CustDiscount3rd_Agent cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustDiscount3rd_Agent ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype

	DELETE cg
	FROM dbo.CustDiscount3rd_Member cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustDiscount3rd_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype

	DELETE cg
	FROM dbo.CustWinLossLimit_Agent cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustWinLoss_Agent ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype

	DELETE cg
	FROM dbo.CustWinLossLimit_Member cg WITH(UPDLOCK,ROWLOCK)		
		INNER JOIN #CustWinLoss_Member ci ON ci.custid = cg.CustID	
	WHERE SportType = @Sporttype
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'

