/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20211220
	Task:		Correct Data for super currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/

	DECLARE @Currency INT = 10 , @SiteID INT  = 1
	CREATE TABLE #Supers (custid INT)
	INSERT INTO #Supers(custid)				
	SELECT 58952555	AS custid UNION ALL SELECT 58956510	AS custid --'SRHB','HR'
	--Delete 
	DELETE FROM CustProductStatus WITH (ROWLOCK) WHERE custid IN (SELECT custid from #Supers)   
	DELETE FROM CustPTSetting3rd_Agent WITH (ROWLOCK) WHERE custid IN (SELECT custid from #Supers)  
    DELETE FROM CustBetSetting3rd_Agent WITH (ROWLOCK) WHERE custid IN (SELECT custid from #Supers) 
    DELETE FROM CustDiscount3rd_Agent WITH (ROWLOCK) WHERE custid IN (SELECT custid from #Supers)   
    DELETE FROM CustWinLossLimit_Agent WITH (ROWLOCK) WHERE custid IN (SELECT custid from #Supers) 
    DELETE FROM dbo.CustStakeLevel_Agent WITH (ROWLOCK) WHERE custid IN (SELECT custid from #Supers)	
	-----------MaxPayout
	
	UPDATE mpa
	SET mpa.SingleMatchParlay = cs.SingleMatchParlay,
		mpa.Combo2 = cs.Combo2,
		mpa.Combo35 = cs.Combo35,
		mpa.ComboOver6 = cs.ComboOver6
	FROM CustMaxPayoutSetting_Agent mpa  WITH(ROWLOCK, UPDLOCK) 
	INNER JOIN #Supers su ON Su.custid = mpa.CustID
	INNER JOIN MaxPayoutGlobalSetting cs WITH(NOLOCK)  ON cs.Currency = @Currency AND cs.SportType = mpa.SportType  AND cs.BetType = mpa.BetType
 
	-- Initial 58952555
	DECLARE @DCSErrCode INT = 0  
	EXEC dbo.Acc_DynamicCustomerInfo_00  
	   @CustID    = 58952555  
	   , @SuperID   = 58952555  
	   , @MasterID   = 0  
	   , @AgentID   = 0  
	   , @RoleID   = 4  
	   , @ProductID  = NULL  
	   , @isSearchAndCopy  = 0  
	   , @copyFromCustID  = 0  
	   , @ErrCode   = @DCSErrCode OUTPUT  
	   , @SettingStatus    = 0  
	
	-- Initial 58956510 
	EXEC dbo.Acc_DynamicCustomerInfo_00  
	   @CustID    = 58956510  
	   , @SuperID   = 58956510  
	   , @MasterID   = 0  
	   , @AgentID   = 0  
	   , @RoleID   = 4  
	   , @ProductID  = NULL  
	   , @isSearchAndCopy  = 0  
	   , @copyFromCustID  = 0  
	   , @ErrCode   = @DCSErrCode OUTPUT  
	   , @SettingStatus    = 0  
	
	
	DROP TABLE #SUPERS

