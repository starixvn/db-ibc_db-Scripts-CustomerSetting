/*
    Created: Vicky
    Date: 20180412
    Task: delete existing setting
    DB: DBCUST/CustDB
*/  
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09_UAT3]
        @srecommendList VARCHAR(MAX)
        ,@sporttype INT
        ,@betType INT
        ,@isLive INT = 0
        ,@maxCustId INT
AS
BEGIN 
    SET NOCOUNT ON
    
    RAISERROR ('Run at server: %s;', 0, 1, @@SERVERNAME) WITH NOWAIT
    DECLARE @var_row_count INT
    
    
    IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
    
    CREATE TABLE #Batch (CustID INTEGER PRIMARY KEY)
    CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED)
    CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED)
    CREATE TABLE #SuperTemp(CustID INT PRIMARY KEY CLUSTERED)
    

    INSERT INTO #SuperTemp (CustID)
    SELECT RTRIM(LTRIM(val)) FROM dbo.strSplit(@srecommendList,',')
    
    
    --------------------------------------PT Setting------------------------------------------------- 
    BEGIN
        
        INSERT INTO #SMATemp(CustID)
        SELECT cg.custid  
        FROM CustStakeLevel_Agent cg WITH(NOLOCK)  
            INNER JOIN CustInfo ci ON ci.CustID = cg.CustID
            INNER JOIN #SuperTemp s ON s.CustId = ci.srecommend
        WHERE cg.SportType = @sporttype AND ci.custid > @maxCustId
        OPTION(RECOMPILE)
    
        
        INSERT INTO #MemberTemp(CustID)
        SELECT cg.custid
        FROM CustStakeLevel_member cg WITH(NOLOCK)
             INNER JOIN CustInfo ci ON ci.CustID = cg.CustID
             INNER JOIN #SuperTemp s ON s.CustId = ci.srecommend
        WHERE cg.SportType = @sporttype AND ci.custid > @maxCustId
        OPTION(RECOMPILE)
    

        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #SMATemp
            OUTPUT DELETED.CustID INTO #Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
            
            DELETE cg
            FROM CustStakeLevel_Agent cg WITH (ROWLOCK)      
                INNER JOIN #Batch ctemp ON ctemp.custid = cg.custid
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of SMA PT: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
            TRUNCATE TABLE #Batch
        END     
        
        
        WHILE 1 = 1
        BEGIN
            DELETE TOP (4000) #MemberTemp
            OUTPUT DELETED.CustID INTO #Batch(CustID)
        
            IF @@ROWCOUNT = 0 BREAK
        
            DELETE cg
            FROM CustStakeLevel_Member cg WITH (ROWLOCK)   
                INNER JOIN #Batch ctemp ON ctemp.custid = cg.custid
            WHERE cg.SportType = @sporttype AND cg.BetType = @betType
            RAISERROR ('Total affected row of member: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT

            TRUNCATE TABLE #Batch
        END         
    END
END
