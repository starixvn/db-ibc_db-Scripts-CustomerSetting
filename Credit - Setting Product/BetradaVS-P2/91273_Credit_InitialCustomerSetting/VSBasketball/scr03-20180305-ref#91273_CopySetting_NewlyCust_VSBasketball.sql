/*
    Created: 20180305@Vicky
    Task: Initial Customer setting for VSBasketball
    DB: DBCUST/CustDB
*/

    DECLARE @maxcustid INT = xxx
    CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED, currency INT)
    CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED, currency INT)

    DECLARE @ProductID INT, @Sporttype INT, @SporttypeDelegate INT,
            @SportTypeRef SMALLINT, @BetTypeRef SMALLINT, @IsLiveRef BIT
    
            
    SELECT  @ProductID      = 5, 
            @Sporttype      = 193, 
            @SporttypeDelegate    = 180,
            @SportTypeRef   = 180,    
            @BetTypeRef     = 1201,   
            @IsLiveRef      = 0
    

    SELECT t.* 
    INTO #SportBettypeFilter1
    FROM ProductSettingDetail t WITH (NOLOCK)
    WHERE t.SettingType = 1 AND t.ProductID = @ProductID AND t.SportType = @Sporttype

    SELECT t.* 
    INTO #SportBettypeFilter2
    FROM ProductSettingDetail t WITH (NOLOCK)
    WHERE t.SettingType = 2 AND t.ProductID = @ProductID AND t.SportType = @Sporttype

    SELECT t.* 
    INTO #SportBettypeFilter6
    FROM ProductSettingDetail t WITH (NOLOCK)
    WHERE t.SettingType = 6 AND t.ProductID = @ProductID AND t.SportType = @SporttypeDelegate

    
    INSERT INTO #MemberTemp (CustID, currency)
    SELECT custid, currency
    FROM Custinfo WITH (NOLOCK)
    WHERE roleid = 1 AND custid > @maxcustid
    
    INSERT INTO #SMATemp (CustID, currency)
    SELECT custid, currency
    FROM Custinfo WITH (NOLOCK)
    WHERE roleid IN (2,3,4) AND custid > @maxcustid 

    DECLARE @var_num_cust INT
    SET @var_num_cust = (SELECT COUNT(*) FROM #MemberTemp)
    SET @var_num_cust = @var_num_cust + (SELECT COUNT(*) FROM #MemberTemp)
    RAISERROR ('Total newly customer: %d', 0, 1, @var_num_cust) WITH NOWAIT
    
    --SMA LEVEL
    --------------------------------------PT Setting-------------------------------------------------   
    INSERT INTO dbo.CustPTSetting3rd_Agent (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT)
    SELECT ci.CustID, sb.SportType, sb.BetType, sb.IsLive, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT, cs.MinPT, cs.MaxPT
    FROM #SMATemp ci
        INNER JOIN dbo.CustPTSetting3rd_Agent cs WITH(NOLOCK) ON cs.custid = ci.custid
        CROSS APPLY #SportBettypeFilter1 sb
    WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef
    RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    
    --group
    INSERT INTO dbo.CustPTGroupSetting3rd_Member (AgentID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
    SELECT ci.CustID, sb.SportType, sb.BetType, sb.IsLive, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT
    FROM #SMATemp ci
        INNER JOIN dbo.CustPTGroupSetting3rd_Member cs WITH(NOLOCK) ON cs.agentid = ci.custid
        CROSS APPLY #SportBettypeFilter1 sb 
    WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef
    RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    
    ----------------------------------------Bet Game Setting-------------------------------------------------
    INSERT INTO dbo.CustBetSetting3rd_Agent (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
    SELECT ci.custid, sb.SportType, sb.BetType, cs.MinBet, MaxBet, MaxPerMatch
    FROM #SMATemp ci
        INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH(NOLOCK) ON cs.CustID = ci.custid
        CROSS APPLY #SportBettypeFilter2 sb
    WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef
    RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    
    ----------------------------------------WinLoss Limit Setting-------------------------------------------------      
    INSERT INTO dbo.CustWinLossLimit_Agent (CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
    SELECT ci.custid, sb.SportType, sb.BetType, 0, cs.MinLossLimit, 1
    FROM #SMATemp ci
        CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
        CROSS APPLY #SportBettypeFilter6 sb
    WHERE cs.ExchangeId = ci.currency AND cs.ProductId = @ProductID 
    RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
        
    
    
    --MEMBER LEVEL
    --------------------------------------PT Setting------------------------------------------------- 
    INSERT INTO dbo.CustPTSetting3rd_Member (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
    SELECT ci.CustID, sb.SportType, sb.BetType, sb.IsLive, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT
    FROM #MemberTemp ci
        INNER JOIN dbo.CustPTSetting3rd_Member cs WITH(NOLOCK) ON cs.CustID = ci.custid
        CROSS APPLY #SportBettypeFilter1 sb
    WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef
    RAISERROR ('Total affected row of PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    
    ----------------------------------------Bet Game Setting-------------------------------------------------
    INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
    SELECT ci.custid, sb.SportType, sb.BetType, MinBet, MaxBet, MaxPerMatch
    FROM #MemberTemp ci
        INNER JOIN dbo.CustBetSetting3rd_Member cs WITH(NOLOCK) ON cs.CustID = ci.custid
        CROSS APPLY #SportBettypeFilter2 sb
    WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef 
    RAISERROR ('Total affected row of BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    
    ----------------------------------------WinLoss Limit Setting-------------------------------------------------
    INSERT INTO dbo.CustWinLossLimit_Member(CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
    SELECT ci.custid, sb.SportType, sb.BetType, 0, cs.DefaultLossLimit, 1
    FROM #MemberTemp ci
        CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
        CROSS APPLY #SportBettypeFilter6 sb
    WHERE cs.ExchangeId = ci.currency AND cs.ProductId = @ProductID
    RAISERROR ('Total affected row Winloss: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
   

    DROP TABLE #SMATemp
    DROP TABLE #MemberTemp
    DROP TABLE #SportBettypeFilter1
    DROP TABLE #SportBettypeFilter2
    DROP TABLE #SportBettypeFilter6
