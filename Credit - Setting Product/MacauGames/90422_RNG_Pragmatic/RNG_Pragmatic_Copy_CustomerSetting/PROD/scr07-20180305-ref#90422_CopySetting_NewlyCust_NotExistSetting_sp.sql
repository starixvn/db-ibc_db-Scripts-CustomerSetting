/*
    Created: Vicky
    Date: 20180412
    Task: Copy stake level for PP
    DB: DBCUST/CustDB
*/  
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
    @srecommendList VARCHAR(MAX)
    ,@maxcustid INT
    ,@sportType SMALLINT
    ,@betType SMALLINT

AS
BEGIN
    SET NOCOUNT ON
    
    IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
    IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
    

    ----------------------------------------------------------------------------------------------------------------------------
    CREATE TABLE #SuperTemp(CustID INT PRIMARY KEY CLUSTERED, Currency INT)
    CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED, StakeLevelList VARCHAR(50))
    CREATE TABLE #Batch(CustID INT PRIMARY KEY CLUSTERED, StakeLevelList VARCHAR(50))
    CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED, StakeLevelList VARCHAR(50))
    CREATE TABLE #StakeLevelList_SMA_6_7(Currency INT PRIMARY KEY CLUSTERED, StakeLevelList VARCHAR(50))

    
    INSERT INTO #SuperTemp (CustID)
    SELECT RTRIM(LTRIM(val)) FROM dbo.strSplit(@srecommendList,',')
    
    UPDATE st
    SET st.Currency = ci.Currency
    FROM #SuperTemp st
        INNER JOIN CustInfo ci ON ci.custid = st.custid
    
    INSERT INTO #StakeLevelList_SMA_6_7 (Currency, StakeLevelList)
    SELECT distinct sl2.ExchangeId, 
                    SUBSTRING(
                        (
                            SELECT ',' + CONVERT (VARCHAR(50), sl1.StakeLevelID)  AS [text()]
                            FROM dbo.StakeLevel sl1
                            WHERE sl1.ExchangeId = sl2.ExchangeId AND sl1.GameGroupID in (6,7)
                            ORDER BY sl1.ExchangeId
                            FOR XML PATH ('')
                        ), 2, 1000) [sll]
    FROM dbo.StakeLevel sl2
    
    --select member
    INSERT INTO #MemberTemp (CustID, StakeLevelList)
    SELECT ci.custid,  CONVERT (VARCHAR(50), sl.StakeLevelID)
    FROM Custinfo ci WITH (NOLOCK)
        INNER JOIN #SuperTemp s ON s.custid = ci.srecommend 
        INNER JOIN dbo.StakeLevel sl ON sl.ExchangeId = s.currency
    WHERE roleid = 1 AND sl.GameGroupID = 6 AND ci.custid > @maxcustid
    
    --select SMA
    INSERT INTO #SMATemp (CustID, StakeLevelList)
    SELECT ci.custid, sll.StakeLevelList
    FROM Custinfo ci WITH (NOLOCK)
        INNER JOIN #SuperTemp s ON s.custid = ci.srecommend
        INNER JOIN #StakeLevelList_SMA_6_7 sll ON sll.Currency = s.Currency
    WHERE roleid IN (2,3,4) AND ci.custid > @maxcustid 

    
    ------------------------------------------INSERT DATA-----------------------------
    --SMA LEVEL
    WHILE 1 = 1
    BEGIN
        DELETE TOP (4000) #SMATemp
        OUTPUT DELETED.CustID, DELETED.StakeLevelList INTO #Batch(CustID, StakeLevelList)
        
        IF @@ROWCOUNT = 0 BREAK
        
        INSERT INTO dbo.CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)    
        SELECT CustID, @SportType, @BetType, StakeLevelList
        FROM #Batch 
        RAISERROR ('Total affected row of SMA: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
        
        TRUNCATE TABLE #Batch
    END

    WHILE 1 = 1
    BEGIN
        DELETE TOP (4000) #MemberTemp
        OUTPUT DELETED.CustID, DELETED.StakeLevelList INTO #Batch(CustID, StakeLevelList)
        
        IF @@ROWCOUNT = 0 BREAK
        
        INSERT INTO dbo.CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList)   
        SELECT CustID, @SportType, @BetType, StakeLevelList
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

