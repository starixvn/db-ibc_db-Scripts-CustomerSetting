/*
    Created: 20180305@Vicky
    Task: Initial Customer setting for WC
    DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
    @srecommend INT 
    ,@maxcustid INT
    ,@target VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON
    
    RAISERROR ('Run at server: %s', 0, 1, @@SERVERNAME) WITH NOWAIT
    
    IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN   -- run at all replicated servers
    IF (@target = 'DBCUST'     AND @@SERVERNAME<> 'DBCUST') RETURN -- run at dbcust only
    
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent')   = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
    IF dbo.f_CheckRepTable('CustWinLossLimit_Agent')   = 0 RETURN
    IF dbo.f_CheckRepTable('CustWinLossLimit_Member')  = 0 RETURN
    
    CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED)
    CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED)
    CREATE TABLE #Batch (CustID INTEGER PRIMARY KEY)
    DECLARE @ProductID INT, @currency INT, @SporttypeWC INT, 
            @SportTypeRef SMALLINT, @BetTypeRef SMALLINT, @IsLiveRef BIT
    
            
    SELECT  @ProductID      = 5, 
            @SporttypeWC = 192, 
            @SportTypeRef   = 191,    
            @BetTypeRef     = 2701,   
            @IsLiveRef      = 0
    
    SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

    SELECT t.* 
    INTO #SportBettypeFilter1
    FROM ProductSettingDetail t WITH (NOLOCK)
    WHERE t.SettingType = 1 AND t.ProductID = @ProductID AND t.SportType = @SporttypeWC

    SELECT t.* 
    INTO #SportBettypeFilter2
    FROM ProductSettingDetail t WITH (NOLOCK)
    WHERE t.SettingType = 2 AND t.ProductID = @ProductID AND t.SportType = @SporttypeWC

    
    INSERT INTO #MemberTemp (CustID)
    SELECT custid
    FROM Custinfo WITH (NOLOCK)
    WHERE srecommend = @srecommend AND roleid = 1 AND custid <= @maxcustid
    
    INSERT INTO #SMATemp (CustID)
    SELECT custid
    FROM Custinfo WITH (NOLOCK)
    WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND custid <= @maxcustid 

    DECLARE @var_num_cust INT
    SET @var_num_cust = (SELECT COUNT(*) FROM #MemberTemp)
    RAISERROR ('Total member: %d', 0, 1, @var_num_cust) WITH NOWAIT
    
    --SMA LEVEL
    WHILE 1 = 1
    BEGIN
        DELETE TOP (5000) #SMATemp
        OUTPUT DELETED.CustID INTO #Batch
        
        IF @@ROWCOUNT = 0 BREAK
        
        --------------------------------------PT Setting-------------------------------------------------   
        INSERT INTO dbo.CustPTSetting3rd_Agent (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT, MinPT, MaxPT)
        SELECT ci.CustID, sb.SportType, sb.BetType, sb.IsLive, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT, cs.MinPT, cs.MaxPT
        FROM #Batch ci
            INNER JOIN dbo.CustPTSetting3rd_Agent cs WITH(NOLOCK) ON cs.custid = ci.custid
            CROSS APPLY #SportBettypeFilter1 sb
        WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef
        RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
        --group
        INSERT INTO dbo.CustPTGroupSetting3rd_Member (AgentID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
        SELECT ci.CustID, sb.SportType, sb.BetType, sb.IsLive, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT
        FROM #Batch ci
            INNER JOIN dbo.CustPTGroupSetting3rd_Member cs WITH(NOLOCK) ON cs.agentid = ci.custid
            CROSS APPLY #SportBettypeFilter1 sb
        WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef
        RAISERROR ('Total affected row of SMA Group PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
        ----------------------------------------Bet Game Setting-------------------------------------------------
        INSERT INTO dbo.CustBetSetting3rd_Agent (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
        SELECT ci.custid, sb.SportType, sb.BetType, cs.MinBet, MaxBet, MaxPerMatch
        FROM #Batch ci
            INNER JOIN dbo.CustBetSetting3rd_Agent cs WITH(NOLOCK) ON cs.CustID = ci.custid
            CROSS APPLY #SportBettypeFilter2 sb
        WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef
        RAISERROR ('Total affected row of SMA Betsetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
       
        TRUNCATE TABLE #Batch
    END
    
    
    --MEMBER LEVEL
    WHILE 1 = 1
    BEGIN

        DELETE TOP (5000) #MemberTemp
        OUTPUT DELETED.CustID INTO #Batch
        
        IF @@ROWCOUNT = 0 BREAK
        
        --------------------------------------PT Setting------------------------------------------------- 
        INSERT INTO dbo.CustPTSetting3rd_Member (CustID, SportType, BetType, IsLive, SuperPT, MasterPT, AgentPT, IsAutoMasterPT, AutoMasterPT, IsAutoSuperPT, AutoSuperPT)
        SELECT ci.CustID, sb.SportType, sb.BetType, sb.IsLive, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT
        FROM #Batch ci
            INNER JOIN dbo.CustPTSetting3rd_Member cs WITH(NOLOCK) ON cs.CustID = ci.custid
            CROSS APPLY #SportBettypeFilter1 sb
        WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef
        RAISERROR ('Total affected row of PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
        ----------------------------------------Bet Game Setting-------------------------------------------------
        INSERT INTO dbo.CustBetSetting3rd_Member(CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch)
        SELECT ci.custid, sb.SportType, sb.BetType, MinBet, MaxBet, MaxPerMatch
        FROM #Batch ci
            INNER JOIN dbo.CustBetSetting3rd_Member cs WITH(NOLOCK) ON cs.CustID = ci.custid
            CROSS APPLY #SportBettypeFilter2 sb
        WHERE cs.SportType = @SportTypeRef AND cs.BetType = @BetTypeRef
        RAISERROR ('Total affected row of BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
       
        TRUNCATE TABLE #Batch
    END
    

    DROP TABLE #SMATemp
    DROP TABLE #MemberTemp
    DROP TABLE #SportBettypeFilter1
    DROP TABLE #SportBettypeFilter2
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------  


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx
DECLARE @var_target VARCHAR(20) = 'REPLICATED'

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))
DECLARE @srecommend INT

DECLARE @var_msg_index INT = 0, @var_msg_super_total INT = 0

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c             WITH (NOLOCK) 
    INNER JOIN site s       WITH (NOLOCK) ON c.site = s.site
    INNER JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.username NOT LIKE '3rdSuper%'
    AND cs.isinternal = 0
    AND s.islicensee = 0
    AND c.custid <= @max_custid

SET @var_msg_super_total = (SELECT COUNT(*) FROM #supers )
RAISERROR ('Total of supers: %d.', 0, 1, @var_msg_super_total) WITH NOWAIT

WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) #Supers
    SET isfinished = 1, @srecommend = custid   
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @var_msg_index = @var_msg_index + 1
    RAISERROR ('Currently at order %d, SuperID: %d.', 0, 1, @var_msg_index, @srecommend) WITH NOWAIT
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09
            @srecommend = @srecommend
            ,@maxcustid = @max_custid
            ,@target    = @var_target
            
    WAITFOR DELAY '00:00:0.100'
    BREAK
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT = xxx
DECLARE @var_target VARCHAR(20) = 'DBCUST'

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT(0))

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c             WITH (NOLOCK) 
    INNER JOIN site s       WITH (NOLOCK) ON c.site = s.site
    INNER JOIN custsuper cs WITH (NOLOCK) ON c.custid = cs.custid
WHERE c.username NOT LIKE '3rdSuper%'
    AND cs.isinternal = 0
    AND s.islicensee = 0
    AND c.custid <= @max_custid

WHILE (1 = 1)
BEGIN
    UPDATE TOP (1) #Supers
    SET isfinished = 1, @srecommend = custid   
    WHERE isfinished = 0
    
    IF @@ROWCOUNT = 0 BREAK
    
    SET @var_msg_index = @var_msg_index + 1
    RAISERROR ('Currently at order %d, SuperID: %d.', 0, 1, @var_msg_index, @srecommend) WITH NOWAIT
    
    EXEC dbo.Acc_DynamicCustSetting3rd_09
            @srecommend = @srecommend
            ,@maxcustid = @max_custid
            ,@target    = @var_target
            
    WAITFOR DELAY '00:00:0.100'
    BREAK
END
GO