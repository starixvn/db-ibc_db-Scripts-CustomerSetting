/*
    Created: Vicky
    Date: 20180412
    Task: delete existing setting
    DB: DBCUST/CustDB
*/  
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
    @srecommend INT 
    ,@maxcustid INT
    --,@target VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON
    --IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN  -- run at all replicated servers
    --IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only
    
    IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
    IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN

    ----------------------------------------------------------------------------------------------------------------------------
    DECLARE @SportType INT = 248,
            @BetType INT = 4101

    CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED)
    CREATE TABLE #SMATemp(CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT)
    
    
    -------------------------------------------------------------------------------------------------
    --select SMA
    INSERT INTO #SMATemp (CustID, roleid)
    SELECT custid, roleid
    FROM Custinfo WITH (NOLOCK)
    WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

    --select member
    INSERT INTO #MemberTemp (CustID)
    SELECT custid
    FROM Custinfo WITH (NOLOCK)
    WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
    ------------------------------------------DELETE DATA-----------------------------


    DELETE cg
    FROM CustStakeLevel_Agent cg WITH (ROWLOCK)      
          INNER JOIN #SMATemp ctemp ON ctemp.custid = cg.custid
    WHERE cg.SportType = @sporttype AND cg.BetType = @betType
    RAISERROR ('Total affected row of SMA: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT
             
    DELETE cg
    FROM CustStakeLevel_Member cg WITH (ROWLOCK)      
          INNER JOIN #MemberTemp ctemp ON ctemp.custid = cg.custid
    WHERE cg.SportType = @sporttype AND cg.BetType = @betType
    RAISERROR ('Total affected row of Member: %d', 0, 1, @@ROWCOUNT) WITH NOWAIT

    
    DROP TABLE #SMATemp
    DROP TABLE #MemberTemp
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------  

