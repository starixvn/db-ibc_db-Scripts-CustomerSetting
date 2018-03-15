/*
    Created: 20180305@Vicky
    Task: delete Customer setting
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
        @isDelWinLoss TINYINT = 0
AS
BEGIN 
    SET NOCOUNT ON
    
    RAISERROR ('Run at server: %s;', 0, 1, @@SERVERNAME) WITH NOWAIT
    
    IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN  -- run at all replicated servers
    IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
     
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent')   = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent')  = 0 RETURN
    IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
    IF dbo.f_CheckRepTable('CustWinLossLimit_Agent')   = 0 RETURN
    IF dbo.f_CheckRepTable('CustWinLossLimit_Member')  = 0 RETURN
                
    
   --SMA LEVEL
    --------------------------------------PT Setting------------------------------------------------- 
    IF (@isDelPT = 1)
    BEGIN
	    --Agent
	    DELETE cg
	    FROM CustPTSetting3rd_Agent cg WITH (UPDLOCK,ROWLOCK)        
	    WHERE cg.SportType = @sporttype AND cg.BetType = @betType
	    RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
	    
	    DELETE cg
	    FROM CustPTGroupSetting3rd_Member cg WITH (UPDLOCK,ROWLOCK)        
	    WHERE cg.SportType = @sporttype AND cg.BetType = @betType
	    RAISERROR ('Total affected row of SMA Group PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
	    
	    --Member
	    DELETE cg
	    FROM CustPTSetting3rd_Member cg WITH (UPDLOCK,ROWLOCK)       
	    WHERE cg.SportType = @sporttype AND cg.BetType = @betType
	    RAISERROR ('Total affected row of PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    END
    
    ----------------------------------------Bet Game Setting-------------------------------------------------
    IF (@isDelBetSetting = 1)
    BEGIN
	    --Agent
	    DELETE cg
	    FROM dbo.CustBetSetting3rd_Agent cg WITH (UPDLOCK,ROWLOCK)       
	    WHERE cg.SportType = @sporttype AND cg.BetType = @betType
	    RAISERROR ('Total affected row of SMA BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
	    
	    DELETE cg
	    FROM dbo.CustBetSetting3rd_Member cg WITH (UPDLOCK,ROWLOCK)      
	    WHERE cg.SportType = @sporttype AND cg.BetType = @betType
	    RAISERROR ('Total affected row of BetSetting: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    END
    
    ----------------------------------------WinLoss Limit Setting-------------------------------------------------
    IF (@isDelWinLoss = 1)
    BEGIN
	    --Agent
	    DELETE cg
	    FROM dbo.CustWinLossLimit_Agent cg WITH(UPDLOCK,ROWLOCK)        
	    WHERE cg.SportType = @sporttype AND cg.BetType = @betType
	    RAISERROR ('Total affected row of SMA WinLoss: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
	    
	    --Member
	    DELETE cg
	    FROM dbo.CustWinLossLimit_Member cg WITH (UPDLOCK,ROWLOCK)       
	    WHERE cg.SportType = @sporttype AND cg.BetType = @betType
	    RAISERROR ('Total affected row of Winloss: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
    END
END