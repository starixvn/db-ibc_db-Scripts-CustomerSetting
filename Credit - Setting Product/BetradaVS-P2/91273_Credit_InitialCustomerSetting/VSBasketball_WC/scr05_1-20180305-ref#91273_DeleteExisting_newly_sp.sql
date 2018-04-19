/*
    Created: 20180305@Vicky
    Task: delete for newly Customer setting
    DB: DBCUST/CustDB
*/

-- DEPLOY THIS SP ON @DBCUST.CustDB ------
------------------------------------------------------
 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
        @target VARCHAR(20),
        @sporttype INT,
        @betType INT,
        @isLive INT = 0,
        @isDelPT TINYINT = 0,
        @isDelBetSetting TINYINT = 0,
        @isDelWinLoss TINYINT = 0,
        @MaxCustID INT
AS
BEGIN 
    SET NOCOUNT ON
    
    RAISERROR ('Run at server: %s;', 0, 1, @@SERVERNAME) WITH NOWAIT
    DECLARE @var_row_count INT       
     
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent')   = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
    IF dbo.f_CheckRepTable('CustWinLossLimit_Agent')   = 0 RETURN
    IF dbo.f_CheckRepTable('CustWinLossLimit_Member')  = 0 RETURN
    
    CREATE TABLE #Batch (CustID INTEGER PRIMARY KEY)
       
    --SMA LEVEL
    --------------------------------------PT Setting------------------------------------------------- 
    IF (@isDelPT = 1)
    BEGIN
        SELECT DISTINCT cg.custid  
        INTO #CustPT_Agent
        FROM CustPTSetting3rd_Agent cg WITH(NOLOCK)  
            INNER JOIN CustInfo ci ON ci.CustID = cg.CustID
        WHERE cg.SportType = @sporttype AND cg.CustID > @MaxCustID
    
        SELECT DISTINCT cg.custid  
        INTO #CustPT_Member
        FROM CustPTSetting3rd_Member cg WITH(NOLOCK)
             INNER JOIN CustInfo ci ON ci.CustID = cg.CustID
        WHERE cg.SportType = @sporttype  AND cg.CustID > @MaxCustID
    
        SELECT DISTINCT cg.AgentID AS CustID
        INTO #CustPTGroup_Member
        FROM CustPTGroupSetting3rd_Member cg WITH(NOLOCK)    
             INNER JOIN CustInfo ci ON ci.CustID = cg.AgentID        
        WHERE cg.SportType = @sporttype  AND cg.AgentID > @MaxCustID
    
        --Agent 
        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #CustPT_Agent
            OUTPUT DELETED.CustID INTO #Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
            
            DELETE cg
            FROM CustPTSetting3rd_Agent cg WITH (ROWLOCK)      
                  INNER JOIN #Batch ctemp ON ctemp.custid = cg.custid
             WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
            TRUNCATE TABLE #Batch
        END     
        
        
        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #CustPTGroup_Member
            OUTPUT DELETED.CustID INTO #Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
        
            DELETE cg
            FROM CustPTGroupSetting3rd_Member cg WITH (ROWLOCK)   
                   INNER JOIN #Batch ctemp ON ctemp.custid = cg.AgentID
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of SMA Group PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT

            TRUNCATE TABLE #Batch
        END         
        
        --Member
        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #CustPT_Member
            OUTPUT DELETED.CustID INTO #Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
            
            DELETE cg
            FROM CustPTSetting3rd_Member cg WITH (ROWLOCK)     
                   INNER JOIN #Batch ctemp ON ctemp.custid = cg.custid
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT

            TRUNCATE TABLE #Batch
        END 
    END
    
    ----------------------------------------Bet Game Setting-------------------------------------------------
    IF (@isDelBetSetting = 1)
    BEGIN
        
        SELECT DISTINCT cg.custid  
        INTO #CustBet_Agent
        FROM CustBetSetting3rd_Agent cg WITH(NOLOCK)   
            INNER JOIN CustInfo ci ON ci.CustID = cg.CustID
        WHERE cg.SportType = @sporttype AND cg.CustID > @MaxCustID
    
        SELECT DISTINCT cg.custid  
        INTO #CustBet_Member
        FROM CustBetSetting3rd_Member cg WITH(NOLOCK)   
            INNER JOIN CustInfo ci ON ci.CustID = cg.CustID        
        WHERE cg.SportType = @sporttype AND cg.CustID > @MaxCustID
    
        --Agent
        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #CustBet_Agent
            OUTPUT DELETED.CustID INTO #Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
            
            DELETE cg
            FROM dbo.CustBetSetting3rd_Agent cg WITH (ROWLOCK)     
                   INNER JOIN #Batch ctemp ON ctemp.custid = cg.custid
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of SMA BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
            
            TRUNCATE TABLE #Batch
        END 
 
        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #CustBet_Member
            OUTPUT DELETED.CustID INTO #Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
            
            DELETE cg
            FROM dbo.CustBetSetting3rd_Member cg WITH (ROWLOCK)      
                   INNER JOIN #Batch ctemp ON ctemp.custid = cg.custid     
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
            
            TRUNCATE TABLE #Batch
        END 
    END
    
    ----------------------------------------WinLoss Limit Setting-------------------------------------------------
    IF (@isDelWinLoss = 1)
    BEGIN
        
        SELECT DISTINCT cg.custid  
        INTO #CustWL_Agent
        FROM CustWinLossLimit_Agent cg WITH(NOLOCK) 
            INNER JOIN CustInfo ci ON ci.CustID = cg.CustID        
        WHERE cg.SportType = @sporttype AND cg.CustID > @MaxCustID
    
        SELECT DISTINCT cg.custid 
        INTO #CustWL_Member
        FROM CustWinLossLimit_Member cg WITH(NOLOCK)     
            INNER JOIN CustInfo ci ON ci.CustID = cg.CustID        
        WHERE cg.SportType = @sporttype AND cg.CustID > @MaxCustID
        
        --Agent
        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #CustWL_Agent
            OUTPUT DELETED.CustID INTO #Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
            
            DELETE cg
            FROM dbo.CustWinLossLimit_Agent cg WITH (ROWLOCK)
                    INNER JOIN #Batch ctemp ON ctemp.custid = cg.custid
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of SMA WinLoss: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
            
            TRUNCATE TABLE #Batch
        END 

        
        --Member
        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #CustWL_Member
            OUTPUT DELETED.CustID INTO #Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
            
            DELETE cg
            FROM dbo.CustWinLossLimit_Member cg WITH (ROWLOCK)
                    INNER JOIN #Batch ctemp ON ctemp.custid = cg.custid
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of Winloss: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
            
            TRUNCATE TABLE #Batch
        END 
    END
END