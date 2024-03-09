/*<info serverAlias="DBCUST-CustDB"></info>*/
ALTER PROC Acc_DynamicCustSetting3rd_19
	@custid INT
AS
BEGIN
	IF @@servername <> 'DBCUST'
		RETURN;
		
	INSERT INTO Dep_CustSettingMode
			   ([CustID]
			   ,[IsGroupedPT]
			   ,[IsGroupedComm]
			   ,[IsGroupedBetLimit]
			   ,[IsGroupedStakeLevel])
    SELECT [CustID]
	   ,[IsGroupedPT]
	   ,[IsGroupedComm]
	   ,[IsGroupedBetLimit]
	   ,[IsGroupedStakeLevel]
	FROM tmpDep_CustSettingMode cs WITH(NOLOCK)
	WHERE custid = @custid
		AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode cs2 (NOLOCK) WHERE cs2.custid = cs.custid)
		
	INSERT INTO Dep_CustPTSetting_Member
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT])
    SELECT [CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
	FROM tmpDep_CustPTSetting_Member cs WITH(NOLOCK)
	WHERE custid = @custid	
		AND NOT EXISTS (SELECT 1 FROM Dep_CustPTSetting_Member cs2 (NOLOCK) 
						WHERE cs2.custid = cs.custid
							AND cs2.sporttype = cs.sporttype
							AND cs2.bettype = cs.bettype
						)
						
	INSERT INTO Dep_CustBetSetting_Member
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[MinBet]
           ,[MaxBet]
           ,[MaxPerMatch])
    SELECT [CustID]
           ,[SportType]
           ,[BetType]
           ,[MinBet]
           ,[MaxBet]
           ,[MaxPerMatch]
	FROM tmpDep_CustBetSetting_Member cs WITH(NOLOCK)
	WHERE custid = @custid	
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBetSetting_Member cs2 (NOLOCK) 
						WHERE cs2.custid = cs.custid
							AND cs2.sporttype = cs.sporttype
							AND cs2.bettype = cs.bettype
						)
							
	INSERT INTO Dep_CustStakeLevel_Member
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList]
           ,[LastUpdated])
    SELECT [CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList]
           ,[LastUpdated]
	FROM tmpDep_CustStakeLevel_Member cs WITH(NOLOCK)
	WHERE custid = @custid
		AND NOT EXISTS (SELECT 1 FROM Dep_CustStakeLevel_Member cs2 (NOLOCK) 
						WHERE cs2.custid = cs.custid
							AND cs2.sporttype = cs.sporttype
							AND cs2.bettype = cs.bettype
						)
					
	INSERT INTO Dep_CustProductStatus
           ([CustID]
           ,[bitmapIsHidden]
           ,[bitmapIsDisabled])
	SELECT [CustID]
           ,[bitmapIsHidden]
           ,[bitmapIsDisabled]
	FROM tmpDep_CustProductStatus cs WITH(NOLOCK)
	WHERE custid = @custid	
		AND NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus cs2 (NOLOCK) 
						WHERE cs2.custid = cs.custid							
						)
						
	INSERT INTO Dep_CustBetSettingGame_Member
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[MinBet]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[MaxPerNumber]
           ,[MaxPayoutPerMatch])
    SELECT [CustID]
           ,[SportType]
           ,[BetType]
           ,[MinBet]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[MaxPerNumber]
           ,[MaxPayoutPerMatch]	
	FROM tmpDep_CustBetSettingGame_Member cs WITH(NOLOCK)
	WHERE custid = @custid	 
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBetSettingGame_Member cs2 (NOLOCK) 
						WHERE cs2.custid = cs.custid
							AND cs2.sporttype = cs.sporttype
							AND cs2.bettype = cs.bettype
						)	
END		