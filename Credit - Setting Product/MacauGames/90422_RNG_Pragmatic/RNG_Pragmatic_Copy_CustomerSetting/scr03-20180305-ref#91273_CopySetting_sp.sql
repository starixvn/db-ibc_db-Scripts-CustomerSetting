/*
    Created: 20180305@Vicky
    Task: Initial Customer setting
    DB: DBCUST/CustDB
*/

-- DEPLOY THIS SP ON @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
    @srecommendList VARCHAR(MAX) 
    ,@maxcustid INT
    ,@target VARCHAR(20)
    ,@productId INT
    ,@sportType INT
    ,@betType INT
    ,@isLive INT = 0
    ,@sportTypeRef INT
    ,@betTypeRef INT
    ,@isInsPT TINYINT = 0
    ,@isInsBetSetting TINYINT = 0
    ,@isInsWinLoss TINYINT = 0
AS
BEGIN
    SET NOCOUNT ON
    
    RAISERROR ('Run at server: %s; srecommend: %s', 0, 1, @@SERVERNAME, @srecommendList) WITH NOWAIT
    
    IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN  -- run at all replicated servers
    IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN     -- run at dbcust only
    
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent')   = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
    IF dbo.f_CheckRepTable('CustWinLossLimit_Agent')   = 0 RETURN
    IF dbo.f_CheckRepTable('CustWinLossLimit_Member')  = 0 RETURN
    
    CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED, currency INT)
    CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED, currency INT)
    CREATE TABLE #Batch (CustID INTEGER PRIMARY KEY, currency INT)
    
    
    DECLARE @strMaxCustId VARCHAR(20) = STR(@maxcustid)
    INSERT INTO #MemberTemp (CustID, currency)
    EXECUTE('SELECT custid, currency FROM Custinfo WITH (NOLOCK) WHERE roleid = 1 AND custid <='+ @strMaxCustId  + ' AND srecommend IN (' + @srecommendList + ')')

    INSERT INTO #SMATemp (CustID, currency)
    EXECUTE('SELECT custid, currency FROM Custinfo WITH (NOLOCK) WHERE roleid IN (2,3,4) AND custid <=' + @strMaxCustId + ' AND srecommend IN (' + @srecommendList + ')')


    DECLARE @var_num_cust INT
    SET @var_num_cust = (SELECT COUNT(*) FROM #MemberTemp)
    RAISERROR ('Total member: %d', 0, 1, @var_num_cust) WITH NOWAIT
    
    --SMA LEVEL
    WHILE 1 = 1
    BEGIN
        DELETE TOP (4000) #SMATemp
        OUTPUT DELETED.CustID, DELETED.currency INTO #Batch(CustID, currency)
        
        IF @@ROWCOUNT = 0 BREAK
        
        --------------------------------------PT Setting------------------------------------------------- 
        IF (@isInsPT = 1)
        BEGIN
            INSERT INTO dbo.CustPTSetting3rd_Agent (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT)
            SELECT ci.CustID, @Sporttype, @betType, @isLive, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT, cs.MinPT, cs.MaxPT
            FROM #Batch ci
                INNER JOIN dbo.CustPTSetting3rd_Agent cs WITH(NOLOCK) ON cs.custid = ci.custid
            WHERE cs.SportType = @sportTypeRef AND cs.BetType = @betTypeRef
            RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
            
            --group
            INSERT INTO dbo.CustPTGroupSetting3rd_Member (AgentID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
            SELECT ci.CustID, @Sporttype, @betType, @isLive, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT
            FROM #Batch ci
                INNER JOIN dbo.CustPTGroupSetting3rd_Member cs WITH(NOLOCK) ON cs.agentid = ci.custid
            WHERE cs.SportType = @sportTypeRef AND cs.BetType = @betTypeRef
            RAISERROR ('Total affected row of SMA GROUP PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        END
        
        
        ----------------------------------------Bet Game Setting-------------------------------------------------
        IF (@isInsBetSetting = 1)
        BEGIN
            INSERT INTO dbo.CustBetSetting3rd_Agent (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
            SELECT ci.custid, @Sporttype, @betType, cs.MinBet, MaxBet, MaxPerMatch
            FROM #Batch ci
                INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH(NOLOCK) ON cs.CustID = ci.custid
            WHERE cs.SportType = @sportTypeRef AND cs.BetType = @betTypeRef
            RAISERROR ('Total affected row of SMA BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        END
        
        
        ----------------------------------------WinLoss Limit Setting-------------------------------------------------
        IF (@isInsWinLoss = 1)
        BEGIN      
            INSERT INTO dbo.CustWinLossLimit_Agent (CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
            SELECT ci.custid, @Sporttype, @betType, 0, cs.DefaultLossLimit, 1
            FROM #Batch ci
                CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH(NOLOCK)
            WHERE cs.ExchangeId = ci.currency AND cs.ProductId = @ProductID   
            RAISERROR ('Total affected row of SMA WinLoss: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        END
        
        TRUNCATE TABLE #Batch
    END
    
    
    --MEMBER LEVEL
    WHILE 1 = 1
    BEGIN

        DELETE TOP (4000) #MemberTemp
        OUTPUT DELETED.CustID, DELETED.currency INTO #Batch(CustID, currency)
        
        IF @@ROWCOUNT = 0 BREAK
        
        --------------------------------------PT Setting------------------------------------------------- 
        IF (@isInsPT = 1)
        BEGIN
            INSERT INTO dbo.CustPTSetting3rd_Member (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
            SELECT ci.CustID, @Sporttype, @betType, @isLive, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT
            FROM #Batch ci
                INNER JOIN dbo.CustPTSetting3rd_Member cs WITH (NOLOCK) ON cs.CustID = ci.custid
            WHERE cs.SportType = @sportTypeRef AND cs.BetType = @betTypeRef
            RAISERROR ('Total affected row of PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        END
        
        ----------------------------------------Bet Game Setting-------------------------------------------------
        IF (@isInsBetSetting = 1)
        BEGIN
            INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
            SELECT ci.custid, @Sporttype, @betType, MinBet, MaxBet, MaxPerMatch
            FROM #Batch ci
                INNER JOIN dbo.CustBetSetting3rd_Member cs WITH(NOLOCK) ON cs.CustID = ci.custid
            WHERE cs.SportType = @sportTypeRef AND cs.BetType = @betTypeRef
            RAISERROR ('Total affected row of BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        END
        
        ----------------------------------------WinLoss Limit Setting-------------------------------------------------
        IF (@isInsWinLoss = 1)
        BEGIN 
            INSERT INTO dbo.CustWinLossLimit_Member(CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
            SELECT ci.custid,  @Sporttype, @betType, 0, cs.DefaultLossLimit, 1
            FROM #Batch ci
                CROSS APPLY dbo.LossLimit_GlobalSetting cs WITH (NOLOCK)
            WHERE cs.ExchangeId = ci.currency AND cs.ProductId = @ProductID
            RAISERROR ('Total affected row Winloss: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        END
        
        TRUNCATE TABLE #Batch
    END
    

    DROP TABLE #SMATemp
    DROP TABLE #MemberTemp
    DROP TABLE #Batch
END
GO

