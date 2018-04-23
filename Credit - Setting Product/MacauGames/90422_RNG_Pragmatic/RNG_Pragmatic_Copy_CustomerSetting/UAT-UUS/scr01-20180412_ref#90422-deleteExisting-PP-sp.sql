/*
    Created: Vicky
    Date: 20180412
    Task: delete existing setting
    DB: DBCUST/CustDB
*/  
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
        @srecommendList VARCHAR(MAX),
        @target VARCHAR(20),
        @sporttype INT,
        @betType INT,
        @isLive INT = 0
        
AS
BEGIN 
    SET NOCOUNT ON
    
    RAISERROR ('Run at server: %s;', 0, 1, @@SERVERNAME) WITH NOWAIT
    DECLARE @var_row_count INT
    
    IF (@target = 'REPLICATED' AND @@SERVERNAME = 'SITDBCUST') RETURN  -- run at all replicated servers
    IF (@target = 'DBCUST' AND @@SERVERNAME <> 'SITDBCUST') RETURN -- run at dbcust only
    
    IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
    
    DECLARE @Batch TABLE (CustID INT)
    CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED)
    CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT)
    DECLARE @SuperTemp TABLE (CustID INT)
    

    INSERT INTO @SuperTemp (CustID)
    SELECT RTRIM(LTRIM(val)) FROM dbo.strSplit(@srecommendList,',')
    
    
    --------------------------------------PT Setting------------------------------------------------- 
    BEGIN
        
        INSERT INTO #SMATemp (CustID)
        SELECT cg.custid
        FROM CustStakeLevel_Agent cg WITH(NOLOCK)  
            INNER JOIN CustInfo ci ON ci.CustID = cg.CustID
            INNER JOIN @SuperTemp s ON s.CustId = ci.srecommend
        WHERE cg.SportType = @sporttype
    
        
        INSERT INTO #MemberTemp(CustID)
        SELECT cg.custid
        FROM CustStakeLevel_member cg WITH(NOLOCK)
             INNER JOIN CustInfo ci ON ci.CustID = cg.CustID
             INNER JOIN @SuperTemp s ON s.CustId = ci.srecommend
        WHERE cg.SportType = @sporttype
    

        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #SMATemp
            OUTPUT DELETED.CustID INTO @Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
            
            DELETE cg
            FROM CustStakeLevel_Agent cg WITH (ROWLOCK)      
                INNER JOIN @Batch ctemp ON ctemp.custid = cg.custid
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of SMA: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
            DELETE FROM @Batch
        END     
        
        
        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #MemberTemp
            OUTPUT DELETED.CustID INTO @Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
        
            DELETE cg
            FROM CustStakeLevel_Member cg WITH (ROWLOCK)   
                INNER JOIN @Batch ctemp ON ctemp.custid = cg.custid
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of Member: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT

            DELETE FROM @Batch
        END         
    END
END
