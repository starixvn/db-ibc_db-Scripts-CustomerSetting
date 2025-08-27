/*<info serverAlias="DBAGE-bodb_Customer" executers="" viewers=""></info>*/
/*
      Task:         Restore data for impacted customers in a list of setting tables
      DB:           DR_DB05-bodb_Customer
      Author:       Helios
      Created:      20250827@Helios
      Description:  This script restores data from _old tables to main tables for specific customers
                    Target customers: MS-USTM, AS-USTM, GEOUSD
*/
SET NOCOUNT ON;

-- Step 1: Create temp table for Username/CustID
IF OBJECT_ID('tempdb..#CustList') IS NOT NULL DROP TABLE #CustList;

CREATE TABLE #CustList (
    CustID INT NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    TableAfffted NVARCHAR(100) NULL,
    IsRestore BIT NOT NULL DEFAULT(0)
);

INSERT INTO #CustList (CustID, Username, Role, TableAfffted, IsRestore)
VALUES
    (160710961, 'MS-USTM', 'Master', 'BetSetting_Agent_old',           0),
    (160710961, 'MS-USTM', 'Master', 'BetSetting3rd_Agent_old',        0),
    (160710961, 'MS-USTM', 'Master', 'CustDiscount3rd_Agent_old',      0),
    (160710961, 'MS-USTM', 'Master', 'custinfo_old',                   0),
    (160710961, 'MS-USTM', 'Master', 'CustLoginInfo_old',              0),
    (160710961, 'MS-USTM', 'Master', 'CustMaster_old',                 0),
    (160710961, 'MS-USTM', 'Master', 'CustMaxPayoutSetting_Agent_old', 0),
    (160710961, 'MS-USTM', 'Master', 'customer_old',                   0),
    (160710961, 'MS-USTM', 'Master', 'CustProductStatus_old',          0),
    (160710961, 'MS-USTM', 'Master', 'CustPTSetting3rd_Agent_old',     0),
    (160710961, 'MS-USTM', 'Master', 'CustStakeLevel_Agent_old',       0),
    (160710961, 'MS-USTM', 'Master', 'CustVirtualSetting_Old',         0),
    (160710961, 'MS-USTM', 'Master', 'CustWinLossLimit_Agent_old',     0),
    (160711306, 'AS-USTM', 'Agent',  'BetSetting_Agent_old',           0),
    (160711306, 'AS-USTM', 'Agent',  'BetSetting3rd_Agent_old',        0),
    (160711306, 'AS-USTM', 'Agent',  'CustAgent_old',                  0),
    (160711306, 'AS-USTM', 'Agent',  'CustDiscount3rd_Agent_old',      0),
    (160711306, 'AS-USTM', 'Agent',  'custinfo_old',                   0),
    (160711306, 'AS-USTM', 'Agent',  'CustLoginInfo_old',              0),
    (160711306, 'AS-USTM', 'Agent',  'CustMaxPayoutSetting_Agent_old', 0),
    (160711306, 'AS-USTM', 'Agent',  'customer_old',                   0),
    (160711306, 'AS-USTM', 'Agent',  'CustProductStatus_old',          0),
    (160711306, 'AS-USTM', 'Agent',  'CustPTSetting3rd_Agent_old',     0),
    (160711306, 'AS-USTM', 'Agent',  'CustStakeLevel_Agent_old',       0),
    (160711306, 'AS-USTM', 'Agent',  'CustVirtualSetting_Old',         0),
    (160711306, 'AS-USTM', 'Agent',  'CustWinLossLimit_Agent_old',     0),
    (160711567, 'GEOUSD',  'Member', 'BetSetting_Member_old',          0),
    (160711567, 'GEOUSD',  'Member', 'BetSetting3rd_Member_old',       0),
    (160711567, 'GEOUSD',  'Member', 'CustDiscount3rd_Member_old',     0),
    (160711567, 'GEOUSD',  'Member', 'custinfo_old',                   0),
    (160711567, 'GEOUSD',  'Member', 'CustLoginInfo_Member_old',       0),
    (160711567, 'GEOUSD',  'Member', 'CustMaxPayoutSetting_Member_old',0),
    (160711567, 'GEOUSD',  'Member', 'customer_old',                   0),
    (160711567, 'GEOUSD',  'Member', 'CustProductStatus_old',          0),
    (160711567, 'GEOUSD',  'Member', 'CustSettingMode3rd_old',         0),
    (160711567, 'GEOUSD',  'Member', 'CustStakeLevel_Member_old',      0),
    (160711567, 'GEOUSD',  'Member', 'CustVirtualSetting_Old',         0),
    (160711567, 'GEOUSD',  'Member', 'CustWinLossLimit_Member_old',    0);

-- CREATE NONCLUSTERED INDEX IX_CustList_CustID ON #CustList(CustID);

-- Step 2: Restore data row by row from _old tables to main tables
DECLARE @CustID INT,
        @Username VARCHAR(50),
        @Role VARCHAR(20),
        @TableAfffted NVARCHAR(100),
        @MainTable NVARCHAR(100);

WHILE EXISTS (SELECT 1 FROM #CustList WHERE IsRestore = 0)
BEGIN
    SELECT TOP 1
        @CustID = CustID,
        @Username = Username,
        @Role = Role,
        @TableAfffted = TableAfffted
    FROM #CustList
    WHERE IsRestore = 0;
    
    -- Check if no more rows to process, then exit the loop
    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'No more rows to process. Breaking the loop.';
        BREAK;
    END

    -- Determine the main table name (remove _old suffix)
    SET @MainTable = LEFT(@TableAfffted, LEN(@TableAfffted) - 4);
    IF RIGHT(@MainTable, 1) = '_' -- Handle case where table name has _ before _old
        SET @MainTable = LEFT(@MainTable, LEN(@MainTable) - 1);
    
    -- Process specific tables based on TableAfffted
    -- Process BetSetting_Agent_old
    IF @TableAfffted = 'BetSetting_Agent_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM BetSetting_Agent_old WITH(NOLOCK) WHERE CustID = @CustID)
        BEGIN
            -- Insert into BetSetting_Agent with common columns and RepUpdateTime = dbo.f_GetDateTime2()
            INSERT INTO CUSTDB.dbo.BetSetting_Agent (
                CustID, 
                SportType, 
                BetType, 
                MinBet, 
                MaxBet, 
                MaxPerMatch, 
                MaxPayoutPerMatch,
                RepUpdateTime)
            SELECT 
                CustID, 
                SportType, 
                BetType, 
                MinBet, 
                MaxBet, 
                MaxPerMatch, 
                MaxPayoutPerMatch,
                dbo.f_GetDateTime2() 
            FROM BetSetting_Agent_old WITH(NOLOCK) 
            WHERE CustID = @CustID;
            
            -- Update status as success
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process BetSetting3rd_Agent_old
    ELSE IF @TableAfffted = 'BetSetting3rd_Agent_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM BetSetting3rd_Agent_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            -- Insert into BetSetting3rd_Agent with specific columns
            INSERT INTO CUSTDB.dbo.BetSetting3rd_Agent (
                CustID,
                VendorID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPayoutPerMatch,
                RepUpdateTime)
            SELECT
                CustID,
                VendorID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPayoutPerMatch,
                dbo.f_GetDateTime2()
            FROM BetSetting3rd_Agent_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            -- Update status as success
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process CustDiscount3rd_Agent_old
    ELSE IF @TableAfffted = 'CustDiscount3rd_Agent_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM CustDiscount3rd_Agent_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.CustDiscount3rd_Agent (
                CustID,
                VendorID,
                SportType,
                BetType,
                Discount,
                RepUpdateTime)
            SELECT
                CustID,
                VendorID,
                SportType,
                BetType,
                Discount,
                dbo.f_GetDateTime2()
            FROM CustDiscount3rd_Agent_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process custinfo_old
    ELSE IF @TableAfffted = 'custinfo_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM custinfo_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.custinfo (
                custid,
                preferlanguage,
                timezone,
                RefCustID,
                RepUpdateTime)
            SELECT
                custid,
                preferlanguage,
                timezone,
                RefCustID,
                dbo.f_GetDateTime2()
            FROM custinfo_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process CustLoginInfo_old
    ELSE IF @TableAfffted = 'CustLoginInfo_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM CustLoginInfo_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.CustLoginInfo (
                custid,
                LoginName,
                Password,
                Role,
                RegDate,
                Status,
                IPAddress,
                ModifyBy,
                ModifyDate,
                WrongCount,
                RepUpdateTime)
            SELECT
                custid,
                LoginName,
                Password,
                Role,
                RegDate,
                Status,
                IPAddress,
                ModifyBy,
                ModifyDate,
                WrongCount,
                dbo.f_GetDateTime2()
            FROM CustLoginInfo_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process CustMaster_old
    ELSE IF @TableAfffted = 'CustMaster_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM CustMaster_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.CustMaster (
                CustID,
                MasterCustID,
                RepUpdateTime)
            SELECT
                CustID,
                MasterCustID,
                dbo.f_GetDateTime2()
            FROM CustMaster_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process CustMaxPayoutSetting_Agent_old
    ELSE IF @TableAfffted = 'CustMaxPayoutSetting_Agent_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM CustMaxPayoutSetting_Agent_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.CustMaxPayoutSetting_Agent (
                CustID,
                SportType,
                MaxPayoutPerDay,
                RepUpdateTime)
            SELECT
                CustID,
                SportType,
                MaxPayoutPerDay,
                dbo.f_GetDateTime2()
            FROM CustMaxPayoutSetting_Agent_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process customer_old
    ELSE IF @TableAfffted = 'customer_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM customer_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.customer (
                CustID,
                CustName,
                Email,
                Phone,
                Status,
                ModifyBy,
                ModifyDate,
                RegDate,
                CurrencyID,
                RepUpdateTime)
            SELECT
                CustID,
                CustName,
                Email,
                Phone,
                Status,
                ModifyBy,
                ModifyDate,
                RegDate,
                CurrencyID,
                dbo.f_GetDateTime2()
            FROM customer_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process CustProductStatus_old
    ELSE IF @TableAfffted = 'CustProductStatus_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM CustProductStatus_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.CustProductStatus (
                CustID,
                ProductID,
                Status,
                RepUpdateTime)
            SELECT
                CustID,
                ProductID,
                Status,
                dbo.f_GetDateTime2()
            FROM CustProductStatus_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process CustPTSetting3rd_Agent_old
    ELSE IF @TableAfffted = 'CustPTSetting3rd_Agent_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM CustPTSetting3rd_Agent_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.CustPTSetting3rd_Agent (
                CustID,
                VendorID,
                PT,
                PTCust,
                PTAgent,
                PTCompany,
                RepUpdateTime)
            SELECT
                CustID,
                VendorID,
                PT,
                PTCust,
                PTAgent,
                PTCompany,
                dbo.f_GetDateTime2()
            FROM CustPTSetting3rd_Agent_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    -- Process CustStakeLevel_Agent_old
    ELSE IF @TableAfffted = 'CustStakeLevel_Agent_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM CustStakeLevel_Agent_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.CustStakeLevel_Agent (
                CustID,
                StakeLevel,
                RepUpdateTime)
            SELECT
                CustID,
                StakeLevel,
                dbo.f_GetDateTime2()
            FROM CustStakeLevel_Agent_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process CustVirtualSetting_Old
    ELSE IF @TableAfffted = 'CustVirtualSetting_Old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM CustVirtualSetting_Old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.CustVirtualSetting (
                CustID,
                VirtualType,
                MinBet,
                MaxBet,
                MaxBetPerDay,
                Status,
                RepUpdateTime)
            SELECT
                CustID,
                VirtualType,
                MinBet,
                MaxBet,
                MaxBetPerDay,
                Status,
                dbo.f_GetDateTime2()
            FROM CustVirtualSetting_Old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process CustWinLossLimit_Agent_old
    ELSE IF @TableAfffted = 'CustWinLossLimit_Agent_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM CustWinLossLimit_Agent_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.CustWinLossLimit_Agent (
                CustID,
                SportType,
                LimitPerDay,
                RepUpdateTime)
            SELECT
                CustID,
                SportType,
                LimitPerDay,
                dbo.f_GetDateTime2()
            FROM CustWinLossLimit_Agent_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- Process Member tables (for GEOUSD)
    ELSE IF @TableAfffted = 'BetSetting_Member_old'
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM BetSetting_Member_old WITH(NOLOCK) WHERE custid = @CustID)
        BEGIN
            INSERT INTO CUSTDB.dbo.BetSetting_Member (
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPayoutPerMatch,
                RepUpdateTime)
            SELECT
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPayoutPerMatch,
                dbo.f_GetDateTime2()
            FROM BetSetting_Member_old WITH(NOLOCK)
            WHERE custid = @CustID;
            
            UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
        END
    END
    
    -- If table has no specific handling
    ELSE
    BEGIN
        PRINT 'Skipped: ' + @TableAfffted + ' --> ' + @MainTable + ' (No specific handling defined)';
        -- Mark as processed to avoid repeating
        UPDATE #CustList SET IsRestore = 1 WHERE CustID = @CustID AND TableAfffted = @TableAfffted;
    END
END

-- Summary of restore results
SELECT 
    c.CustID,
    c.Username,
    c.Role,
    c.TableAfffted,
    CASE WHEN c.IsRestore = 1 THEN 'Success' ELSE 'Failed' END AS RestoreStatus
FROM #CustList c
ORDER BY c.CustID, c.TableAfffted;
