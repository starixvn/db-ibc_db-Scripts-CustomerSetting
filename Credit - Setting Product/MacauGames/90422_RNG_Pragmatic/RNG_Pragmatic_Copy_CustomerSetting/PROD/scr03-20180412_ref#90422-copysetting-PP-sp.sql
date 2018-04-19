/*
    Created: Vicky
    Date: 20180412
    Task: Copy stake level for PP
    DB: DBCUST/CustDB
*/  
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
    @srecommend INT 
    ,@maxcustid INT
    ,@target VARCHAR(20)
    ,@sportType SMALLINT
    ,@betType SMALLINT
AS
BEGIN
    SET NOCOUNT ON
    IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN  -- run at all replicated servers
    IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
    
    IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
    IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
    

    ----------------------------------------------------------------------------------------------------------------------------
    DECLARE @exchangeID INT
    DECLARE @StakeLevelList_SMA VARCHAR(100)
    DECLARE @StakeLevelList_member VARCHAR(100)


    CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED)
    CREATE TABLE #Batch(CustID INT PRIMARY KEY CLUSTERED)
    CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT)
    
    
    -------------------------------------------------------------------------------------------------
    ---select exchangeID
    SELECT @exchangeID = currency FROM dbo.custinfo WITH(NOLOCK) WHERE custid = @srecommend
    
    --select member
    INSERT INTO #MemberTemp (CustID)
    SELECT custid
    FROM Custinfo WITH (NOLOCK)
    WHERE srecommend = @srecommend AND roleid = 1  AND custid <= @maxcustid
    
    --select SMA
    INSERT INTO #SMATemp (CustID, roleid)
    SELECT custid, roleid
    FROM Custinfo WITH (NOLOCK)
    WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND custid <= @maxcustid 

    --select stake level of SMA
    SELECT @StakeLevelList_SMA = COALESCE(@StakeLevelList_SMA + ',','') +  CONVERT(VARCHAR(12),StakeLevelID) 
    FROM dbo.StakeLevel WITH(NOLOCK) 
    WHERE ExchangeId = @exchangeID AND GameGroupID IN (6, 7)
    
    --select stake level of Member
    SELECT @StakeLevelList_member = StakeLevelID 
    FROM dbo.StakeLevel WITH(NOLOCK) 
    WHERE ExchangeId = @exchangeID AND GameGroupID  = 6

    
    ------------------------------------------INSERT DATA-----------------------------
    --SMA LEVEL
    WHILE 1 = 1
    BEGIN
        DELETE TOP (4000) #SMATemp
        OUTPUT DELETED.CustID INTO #Batch(CustID)
        
        IF @@ROWCOUNT = 0 BREAK
        
	    INSERT INTO dbo.CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)    
	    SELECT CustID, @SportType, @BetType, @StakeLevelList_SMA
	    FROM #Batch 
	    RAISERROR ('Total affected row of Member: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
	    
	    TRUNCATE TABLE #Batch
	END

	WHILE 1 = 1
    BEGIN
        DELETE TOP (4000) #MemberTemp
        OUTPUT DELETED.CustID INTO #Batch(CustID)
        
        IF @@ROWCOUNT = 0 BREAK
        
	    INSERT INTO dbo.CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList)   
	    SELECT CustID, @SportType, @BetType, @StakeLevelList_member
	    FROM #Batch
	    RAISERROR ('Total affected row of Member: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
	    
	   TRUNCATE TABLE #Batch
    END
    -----------------------------------------------------------------------------------
    
    DROP TABLE #SMATemp
    DROP TABLE #MemberTemp
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------  

