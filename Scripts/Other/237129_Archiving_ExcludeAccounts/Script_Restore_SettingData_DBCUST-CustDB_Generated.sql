/*<info serverAlias="DBCUST-CustDB" executers="" viewers=""></info>*/
/*
      Task:         Restore customer setting data from DBAGE (_old tables) to DBCUST for selected customers/tables
      DB:           DBCUST-CustDB (target), DBAGE-bodb_Customer (source)
      Author:       Helios
      Created:      20250903@Helios
      Description:  This script migrates and restores old customer setting data for MS-USTM, AS-USTM, GEOUSD.
                    It uses temp tables, batch processing, and status tracking for safe, auditable migration.
*/

SET NOCOUNT ON;

-- Step 1: Get Customer List (example: all or by parameter)
DECLARE @IsAllLine BIT = 1; -- Set to 1 to Only restore downline
DECLARE @CustID INT = NULL; -- Set to specific CustID if needed
DECLARE @Stage INT = 3;     -- Set stage as needed


-- Step 1.2: Prepare #CustList
IF OBJECT_ID('tempdb..#CustList') IS NOT NULL DROP TABLE #CustList;
CREATE TABLE #CustList (
    CustID INT NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    TableSource NVARCHAR(100) NULL,
    TableTarget NVARCHAR(100) NULL,
    IsCollected BIT NOT NULL DEFAULT(0),
    IsRestored BIT NOT NULL DEFAULT(0)
);

DECLARE @RoleID INT
SELECT @RoleID = RoleID
FROM Customer c WITH (NOLOCK)
WHERE c.CustID = @CustID;

-- Step 1.3: Populate #CustList dynamically
IF @RoleID = 4 AND @IsAllLine = 1  -- Super
BEGIN
    INSERT INTO #CustList (CustID, Username, Role, TableSource, TableTarget, IsCollected, IsRestored)
    SELECT 
        c.CustID,
        c.Username,
        c.RoleID AS RoleID,
        tbl.TableSource,
        tbl.TableTarget,
        0, 0
    FROM dbo.customer c WITH (NOLOCK)
    CROSS APPLY dbo.Fn_Archive_RestoreData_GetTableListByStage(@Stage) tbl
    WHERE c.Srecommend = @CustID
    AND c.RoleID IN (1,2,3) -- Include all downline roles
    AND (
        (c.RoleID IN (2,3) AND tbl.RoleID = 2) OR
        (c.RoleID = 1 AND tbl.RoleID = 1) OR
        (tbl.RoleID = 0)
    );
END
IF @RoleID = 3 AND @IsAllLine = 1  -- Master
BEGIN
    INSERT INTO #CustList (CustID, Username, Role, TableSource, TableTarget, IsCollected, IsRestored)
    SELECT 
        c.CustID,
        c.Username,
        c.RoleID AS RoleID,
        tbl.TableSource,
        tbl.TableTarget,
        0, 0
    FROM dbo.customer c WITH (NOLOCK)
    CROSS APPLY dbo.Fn_Archive_RestoreData_GetTableListByStage(@Stage) tbl
    WHERE c.Mrecommend = @CustID
    AND c.RoleID IN (1,2) -- Include all downline roles
    AND (
        (c.RoleID = 2 AND tbl.RoleID = 2) OR
        (c.RoleID = 1 AND tbl.RoleID = 1) OR
        (tbl.RoleID = 0)
    );
END
IF @RoleID = 2 AND @IsAllLine = 1  -- Agent
BEGIN
    INSERT INTO #CustList (CustID, Username, Role, TableSource, TableTarget, IsCollected, IsRestored)
    SELECT 
        c.CustID,
        c.Username,
        c.RoleID AS RoleID,
        tbl.TableSource,
        tbl.TableTarget,
        0, 0
    FROM dbo.customer c WITH (NOLOCK)
    CROSS APPLY dbo.Fn_Archive_RestoreData_GetTableListByStage(@Stage) tbl
    WHERE c.Recommend = @CustID
    AND c.RoleID = 1 -- Only members under this agent
    AND (
        (c.RoleID = 1 AND tbl.RoleID = 1) OR
        (tbl.RoleID = 0)
    )
END

-- Data Collection 
select * FROM #CustList ORDER BY Role, TableTarget;

-- Step 2: Prepare Temp Tables for Each Target Table
-- 1. BetSetting_Agent
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'BetSetting_Agent')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_BetSetting_Agent') IS NOT NULL DROP TABLE #Temp_BetSetting_Agent;
    CREATE TABLE #Temp_BetSetting_Agent (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        MinBet MONEY NULL,
        MaxBet MONEY NULL,
        MaxPerMatch MONEY NULL,
        MaxPayoutPerMatch MONEY NULL
    );
END
-- 2. BetSetting3rd_Agent
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'BetSetting3rd_Agent')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_BetSetting3rd_Agent') IS NOT NULL DROP TABLE #Temp_BetSetting3rd_Agent;
    CREATE TABLE #Temp_BetSetting3rd_Agent (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        MinBet MONEY NULL,
        MaxBet MONEY NULL,
        MaxPerMatch MONEY NULL,
        MaxPerNumber MONEY NULL
    );
END
-- 3. CustDiscount3rd_Agent
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustDiscount3rd_Agent')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustDiscount3rd_Agent') IS NOT NULL DROP TABLE #Temp_CustDiscount3rd_Agent;
    CREATE TABLE #Temp_CustDiscount3rd_Agent (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        DisCount DECIMAL(9, 8) NOT NULL
    );
END
-- 4. CustMaxPayoutSetting_Agent
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustMaxPayoutSetting_Agent')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustMaxPayoutSetting_Agent') IS NOT NULL DROP TABLE #Temp_CustMaxPayoutSetting_Agent;
    CREATE TABLE #Temp_CustMaxPayoutSetting_Agent (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        SingleMatchParlay MONEY NULL,
        Combo2 MONEY NULL,
        Combo35 MONEY NULL,
        ComboOver6 MONEY NULL
    );
END

-- 5. CustPTSetting3rd_Agent
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustPTSetting3rd_Agent')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustPTSetting3rd_Agent') IS NOT NULL DROP TABLE #Temp_CustPTSetting3rd_Agent;
    CREATE TABLE #Temp_CustPTSetting3rd_Agent (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        IsLive BIT NOT NULL,
        IsAutoMasterPT BIT NOT NULL,
        IsAutoSuperPT BIT NOT NULL,
        SuperPT SMALLMONEY NOT NULL,
        MasterPT SMALLMONEY NOT NULL,
        AgentPT SMALLMONEY NOT NULL,
        AutoSuperPT SMALLMONEY NOT NULL,
        AutoMasterPT SMALLMONEY NOT NULL
    );
END
-- 6. CustStakeLevel_Agent
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustStakeLevel_Agent')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustStakeLevel_Agent') IS NOT NULL DROP TABLE #Temp_CustStakeLevel_Agent;
    CREATE TABLE #Temp_CustStakeLevel_Agent (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        StakeLevelList VARCHAR(200) NULL
    );
END
-- 7. CustVirtualSetting
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustVirtualSetting')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustVirtualSetting') IS NOT NULL DROP TABLE #Temp_CustVirtualSetting;
    CREATE TABLE #Temp_CustVirtualSetting (
        custid INT NOT NULL,
        seqNo TINYINT NOT NULL,
        bitmapVirtual BINARY(64) NOT NULL
    );
END
-- 8. CustWinLossLimit_Agent
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustWinLossLimit_Agent')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustWinLossLimit_Agent') IS NOT NULL DROP TABLE #Temp_CustWinLossLimit_Agent;
    CREATE TABLE #Temp_CustWinLossLimit_Agent (
        CustId INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        MaxWinLimit MONEY NULL,
        MaxLossLimit MONEY NULL,
        IsAutoReset BIT NULL
    );
END
-- 9. BetSetting_Member
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'BetSetting_Member')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_BetSetting_Member') IS NOT NULL DROP TABLE #Temp_BetSetting_Member;
    CREATE TABLE #Temp_BetSetting_Member (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        MinBet MONEY NULL,
        MaxBet MONEY NULL,
        MaxPerMatch MONEY NULL,
        MaxPayoutPerMatch MONEY NULL
    );
END
-- 10. BetSetting3rd_Member
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'BetSetting3rd_Member')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_BetSetting3rd_Member') IS NOT NULL DROP TABLE #Temp_BetSetting3rd_Member;
    CREATE TABLE #Temp_BetSetting3rd_Member (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        MinBet MONEY NULL,
        MaxBet MONEY NULL,
        MaxPerMatch MONEY NULL,
        MaxPerNumber MONEY NULL
    );
END
-- 11. CustDiscount3rd_Member
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustDiscount3rd_Member')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustDiscount3rd_Member') IS NOT NULL DROP TABLE #Temp_CustDiscount3rd_Member;
    CREATE TABLE #Temp_CustDiscount3rd_Member (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        PlayerDiscount DECIMAL(9, 8) NOT NULL,
        AgentDiscount DECIMAL(9, 8) NOT NULL,
        MasterDiscount DECIMAL(9, 8) NOT NULL,
        SuperDiscount DECIMAL(9, 8) NOT NULL
    );
END
-- 12. CustPTSetting3rd_Member
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustPTSetting3rd_Member')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustPTSetting3rd_Member') IS NOT NULL DROP TABLE #Temp_CustPTSetting3rd_Member;
    CREATE TABLE #Temp_CustPTSetting3rd_Member (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        IsLive BIT NOT NULL,
        IsAutoMasterPT BIT NOT NULL,
        IsAutoSuperPT BIT NOT NULL,
        SuperPT SMALLMONEY NOT NULL,
        MasterPT SMALLMONEY NOT NULL,
        AgentPT SMALLMONEY NOT NULL,
        AutoSuperPT SMALLMONEY NOT NULL,
        AutoMasterPT SMALLMONEY NOT NULL
    );
END
-- 13. CustMaxPayoutSetting_Member
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustMaxPayoutSetting_Member')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustMaxPayoutSetting_Member') IS NOT NULL DROP TABLE #Temp_CustMaxPayoutSetting_Member;
    CREATE TABLE #Temp_CustMaxPayoutSetting_Member (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        SingleMatchParlay MONEY NULL,
        Combo2 MONEY NULL,
        Combo35 MONEY NULL,
        ComboOver6 MONEY NULL
    );
END
-- 14. CustStakeLevel_Member
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustStakeLevel_Member')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustStakeLevel_Member') IS NOT NULL DROP TABLE #Temp_CustStakeLevel_Member;
    CREATE TABLE #Temp_CustStakeLevel_Member (
        CustID INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        StakeLevelList VARCHAR(200) NULL
    );
END
-- 15. CustWinLossLimit_Member
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustWinLossLimit_Member')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustWinLossLimit_Member') IS NOT NULL DROP TABLE #Temp_CustWinLossLimit_Member;
    CREATE TABLE #Temp_CustWinLossLimit_Member (
        CustId INT NOT NULL,
        SportType SMALLINT NOT NULL,
        BetType SMALLINT NOT NULL,
        MaxWinLimit MONEY NULL,
        MaxLossLimit MONEY NULL,
        IsAutoReset BIT NULL
    );
END

-- 16. CustSettingMode3rd
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustSettingMode3rd')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustSettingMode3rd') IS NOT NULL DROP TABLE #Temp_CustSettingMode3rd;
    CREATE TABLE #Temp_CustSettingMode3rd (
        CustID INT NOT NULL,
        IsGrouped BIT NOT NULL
    );
END

-- 17. custinfo
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'custinfo')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_custinfo') IS NOT NULL DROP TABLE #Temp_custinfo;
    CREATE TABLE #Temp_custinfo (
        custid INT NOT NULL,
        Enabled TINYINT NULL
    );
END

-- 18. CustProductStatus
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustProductStatus')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustProductStatus') IS NOT NULL DROP TABLE #Temp_CustProductStatus;
    CREATE TABLE #Temp_CustProductStatus (
        CustID INT NOT NULL,
        CloseInfo TINYINT NULL
    );
END

-- 19. CustLoginInfo
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustLoginInfo')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustLoginInfo') IS NOT NULL DROP TABLE #Temp_CustLoginInfo;
    CREATE TABLE #Temp_CustLoginInfo (
        CustID INT NOT NULL,
        ClosedReason TINYINT NULL
    );
END

-- 20. CustLoginInfo_Member
IF EXISTS (SELECT 1 FROM #CustList WHERE TableTarget = 'CustLoginInfo_Member')
BEGIN
    IF OBJECT_ID('tempdb..#Temp_CustLoginInfo_Member') IS NOT NULL DROP TABLE #Temp_CustLoginInfo_Member;
    CREATE TABLE #Temp_CustLoginInfo_Member (
        CustID INT NOT NULL,
        ClosedReason TINYINT NULL
    );
END

-- Step 3: Collect and Restore Data in a Single WHILE Loop
DECLARE @TableTarget NVARCHAR(100) = NULL;
DECLARE @Batch INT = 1000;
DECLARE @JsonData NVARCHAR(MAX);
DECLARE @ErrMsg NVARCHAR(200);
DECLARE @RowsInserted INT;

CREATE TABLE #CustBatch (CustID INT);

WHILE EXISTS (SELECT 1 FROM #CustList WHERE IsCollected = 0)
BEGIN
    SELECT TOP 1 @TableTarget = TableTarget FROM #CustList WITH (NOLOCK) WHERE IsCollected = 0;

    IF @TableTarget IS NULL
        BREAK;
    ---------------------------Restore Data Setting---------------------------
    -- 1. BetSetting_Agent
    IF @TableTarget = 'BetSetting_Agent'
    BEGIN
        TRUNCATE TABLE #Temp_BetSetting_Agent;

        -- Collect data for BetSetting_Agent
        INSERT INTO #Temp_BetSetting_Agent (
            CustID,
            SportType,
            BetType,
            MinBet,
            MaxBet,
            MaxPerMatch,
            MaxPayoutPerMatch
        )
        SELECT src.CustID,
               src.SportType,
               src.BetType,
               src.MinBet,
               src.MaxBet,
               src.MaxPerMatch,
               src.MaxPayoutPerMatch
        FROM DBAGE.bodb_Customer.dbo.BetSetting_Agent_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK)
            ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_BetSetting_Agent WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_BetSetting_Agent WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.BetSetting_Agent AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_BetSetting_Agent tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_BetSetting_Agent WITH (NOLOCK))
            BEGIN
                INSERT INTO BetSetting_Agent (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPayoutPerMatch, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       MinBet,
                       MaxBet,
                       MaxPerMatch,
                       MaxPayoutPerMatch,
                       dbo.f_GetDateTime2()
                FROM #Temp_BetSetting_Agent;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_BetSetting_Agent
                
                -- Batch insert into BetSetting_Agent
                -- DELETE TOP (@Batch)
                -- FROM #Temp_BetSetting_Agent
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.MinBet,
                --        DELETED.MaxBet,
                --        DELETED.MaxPerMatch,
                --        DELETED.MaxPayoutPerMatch
                -- INTO dbo.BetSetting_Agent (
                --     CustID,
                --     SportType,
                --     BetType,
                --     MinBet,
                --     MaxBet,
                --     MaxPerMatch,
                --     MaxPayoutPerMatch
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsRestored = 0;
    END
    -- 2. BetSetting3rd_Agent
    IF @TableTarget = 'BetSetting3rd_Agent'
    BEGIN
        TRUNCATE TABLE #Temp_BetSetting3rd_Agent;

        -- Collect data for BetSetting3rd_Agent
        INSERT INTO #Temp_BetSetting3rd_Agent (
            CustID,
            SportType,
            BetType,
            MinBet,
            MaxBet,
            MaxPerMatch,
            MaxPerNumber
        )
        SELECT src.CustID,
               src.SportType,
               src.BetType,
               src.MinBet,
               src.MaxBet,
               src.MaxPerMatch,
               src.MaxPerNumber
        FROM DBAGE.bodb_Customer.dbo.BetSetting3rd_Agent_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK)
            ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_BetSetting3rd_Agent WITH (NOLOCK))
                CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_BetSetting3rd_Agent WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.BetSetting3rd_Agent AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_BetSetting3rd_Agent tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_BetSetting3rd_Agent WITH (NOLOCK))
            BEGIN
                INSERT INTO BetSetting3rd_Agent (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPerNumber , RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       MinBet,
                       MaxBet,
                       MaxPerMatch,
                       MaxPerNumber,
                       dbo.f_GetDateTime2()
                FROM #Temp_BetSetting3rd_Agent;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_BetSetting3rd_Agent
                
                -- Batch insert into BetSetting3rd_Agent
                -- DELETE TOP (@Batch)
                -- FROM #Temp_BetSetting3rd_Agent
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.MinBet,
                --        DELETED.MaxBet,
                --        DELETED.MaxPerMatch,
                --        DELETED.MaxPerNumber
                -- INTO dbo.BetSetting3rd_Agent (
                --     CustID,
                --     SportType,
                --     BetType,
                --     MinBet,
                --     MaxBet,
                --     MaxPerMatch,
                --     MaxPerNumber
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsRestored = 0;
    END
    -- 3. CustDiscount3rd_Agent
    IF @TableTarget = 'CustDiscount3rd_Agent'
    BEGIN
        TRUNCATE TABLE #Temp_CustDiscount3rd_Agent;

        -- Collect data for CustDiscount3rd_Agent
        INSERT INTO #Temp_CustDiscount3rd_Agent (
            CustID,
            SportType,
            BetType,
            DisCount
        )
        SELECT src.CustID,
               src.SportType,
               src.BetType,
               src.DisCount
        FROM DBAGE.bodb_Customer.dbo.CustDiscount3rd_Agent_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK)
            ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustDiscount3rd_Agent WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustDiscount3rd_Agent WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustDiscount3rd_Agent AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustDiscount3rd_Agent tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustDiscount3rd_Agent WITH (NOLOCK))
            BEGIN
                INSERT INTO CustDiscount3rd_Agent (CustID, SportType, BetType, DisCount, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       DisCount,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustDiscount3rd_Agent;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustDiscount3rd_Agent
                
                -- Batch insert into CustDiscount3rd_Agent
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustDiscount3rd_Agent
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.DisCount
                -- INTO dbo.CustDiscount3rd_Agent (
                --     CustID,
                --     SportType,
                --     BetType,
                --     DisCount
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsRestored = 0;
    END
    -- 4. CustMaxPayoutSetting_Agent
    IF @TableTarget = 'CustMaxPayoutSetting_Agent'
    BEGIN
        TRUNCATE TABLE #Temp_CustMaxPayoutSetting_Agent;

        -- Collect data for CustMaxPayoutSetting_Agent
        INSERT INTO #Temp_CustMaxPayoutSetting_Agent (
            CustID,
            SportType,
            BetType,
            SingleMatchParlay,
            Combo2,
            Combo35,
            ComboOver6
        )
        SELECT src.CustID,
               src.SportType,
               src.BetType,
               src.SingleMatchParlay,
               src.Combo2,
               src.Combo35,
               src.ComboOver6
        FROM DBAGE.bodb_Customer.dbo.CustMaxPayoutSetting_Agent_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK)
            ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustMaxPayoutSetting_Agent WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustMaxPayoutSetting_Agent WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustMaxPayoutSetting_Agent AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustMaxPayoutSetting_Agent tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustMaxPayoutSetting_Agent WITH (NOLOCK))
            BEGIN
                INSERT INTO CustMaxPayoutSetting_Agent (CustID, SportType, BetType, SingleMatchParlay, Combo2, Combo35, ComboOver6, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       SingleMatchParlay,
                       Combo2,
                       Combo35,
                       ComboOver6,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustMaxPayoutSetting_Agent;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustMaxPayoutSetting_Agent
                
                -- Batch insert into CustMaxPayoutSetting_Agent
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustMaxPayoutSetting_Agent
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.SingleMatchParlay,
                --        DELETED.Combo2,
                --        DELETED.Combo35,
                --        DELETED.ComboOver6
                -- INTO dbo.CustMaxPayoutSetting_Agent (
                --     CustID,
                --     SportType,
                --     BetType,
                --     SingleMatchParlay,
                --     Combo2,
                --     Combo35,
                --     ComboOver6
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsRestored = 0;
    END
    -- 5. CustPTSetting3rd_Agent
    IF @TableTarget = 'CustPTSetting3rd_Agent'
    BEGIN
        TRUNCATE TABLE #Temp_CustPTSetting3rd_Agent;

        -- Collect data for CustPTSetting3rd_Agent
        INSERT INTO #Temp_CustPTSetting3rd_Agent (
            CustID,
            SportType,
            BetType,
            IsLive,
            IsAutoMasterPT,
            IsAutoSuperPT,
            SuperPT,
            MasterPT,
            AgentPT,
            AutoSuperPT,
            AutoMasterPT
        )
        SELECT src.CustID,
               src.SportType,
               src.BetType,
               src.IsLive,
               src.IsAutoMasterPT,
               src.IsAutoSuperPT,
               src.SuperPT,
               src.MasterPT,
               src.AgentPT,
               src.AutoSuperPT,
               src.AutoMasterPT
        FROM DBAGE.bodb_Customer.dbo.CustPTSetting3rd_Agent_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK)
            ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustPTSetting3rd_Agent WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustPTSetting3rd_Agent WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustPTSetting3rd_Agent AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustPTSetting3rd_Agent tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustPTSetting3rd_Agent WITH (NOLOCK))
            BEGIN
                INSERT INTO CustPTSetting3rd_Agent (CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       IsLive,
                       IsAutoMasterPT,
                       IsAutoSuperPT,
                       SuperPT,
                       MasterPT,
                       AgentPT,
                       AutoSuperPT,
                       AutoMasterPT,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustPTSetting3rd_Agent;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustPTSetting3rd_Agent
                
                -- Batch insert into CustPTSetting3rd_Agent
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustPTSetting3rd_Agent
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.IsLive,
                --        DELETED.IsAutoMasterPT,
                --        DELETED.IsAutoSuperPT,
                --        DELETED.SuperPT,
                --        DELETED.MasterPT,
                --        DELETED.AgentPT,
                --        DELETED.AutoSuperPT,
                --        DELETED.AutoMasterPT
                -- INTO dbo.CustPTSetting3rd_Agent (
                --     CustID,
                --     SportType,
                --     BetType,
                --     IsLive,
                --     IsAutoMasterPT,
                --     IsAutoSuperPT,
                --     SuperPT,
                --     MasterPT,
                --     AgentPT,
                --     AutoSuperPT,
                --     AutoMasterPT
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsRestored = 0;
    END
    -- 6. CustStakeLevel_Agent
    IF @TableTarget = 'CustStakeLevel_Agent'
    BEGIN
        TRUNCATE TABLE #Temp_CustStakeLevel_Agent;

        -- Collect data for CustStakeLevel_Agent
        INSERT INTO #Temp_CustStakeLevel_Agent (CustID, SportType, BetType, StakeLevelList)
        SELECT src.CustID, src.SportType, src.BetType, src.StakeLevelList
        FROM DBAGE.bodb_Customer.dbo.CustStakeLevel_Agent_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustStakeLevel_Agent WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustStakeLevel_Agent WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustStakeLevel_Agent AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustStakeLevel_Agent tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustStakeLevel_Agent WITH (NOLOCK))
            BEGIN
                INSERT INTO CustStakeLevel_Agent (CustID, SportType, BetType, StakeLevelList, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       StakeLevelList,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustStakeLevel_Agent;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustStakeLevel_Agent
                
                -- Batch insert into CustStakeLevel_Agent
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustStakeLevel_Agent
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.StakeLevelList
                -- INTO dbo.CustStakeLevel_Agent (
                --     CustID,
                --     SportType,
                --     BetType,
                --     StakeLevelList
                -- );
            END
        END
        
        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0;
    END
    -- 7. CustVirtualSetting
    IF @TableTarget = 'CustVirtualSetting'
    BEGIN
        TRUNCATE TABLE #Temp_CustVirtualSetting;

        -- Collect data for CustVirtualSetting
        INSERT INTO #Temp_CustVirtualSetting (custid, seqNo, bitmapVirtual)
        SELECT src.custid, src.seqNo, src.bitmapVirtual
        FROM DBAGE.bodb_Customer.dbo.CustVirtualSetting_Old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.custid = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustVirtualSetting WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustVirtualSetting WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustVirtualSetting AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustVirtualSetting tmp
                    ON tgt.custid = tmp.custid
                    AND tgt.seqNo = tmp.seqNo
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustVirtualSetting WITH (NOLOCK))
            BEGIN
                INSERT INTO CustVirtualSetting (custid, seqNo, bitmapVirtual, RepUpdateTime)
                SELECT TOP (@Batch)
                       custid,
                       seqNo,
                       bitmapVirtual,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustVirtualSetting;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustVirtualSetting
                
                -- Batch insert into CustVirtualSetting
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustVirtualSetting
                -- OUTPUT DELETED.custid,
                --        DELETED.seqNo,
                --        DELETED.bitmapVirtual
                -- INTO dbo.CustVirtualSetting (
                --     custid,
                --     seqNo,
                --     bitmapVirtual
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0;
    END
    -- 8. CustWinLossLimit_Agent
    IF @TableTarget = 'CustWinLossLimit_Agent'
    BEGIN
        TRUNCATE TABLE #Temp_CustWinLossLimit_Agent;

        -- Collect data for CustWinLossLimit_Agent
        INSERT INTO #Temp_CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
        SELECT src.CustId, src.SportType, src.BetType, src.MaxWinLimit, src.MaxLossLimit, src.IsAutoReset
        FROM DBAGE.bodb_Customer.dbo.CustWinLossLimit_Agent_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustId = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustWinLossLimit_Agent WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustWinLossLimit_Agent WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustWinLossLimit_Agent AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustWinLossLimit_Agent tmp
                    ON tgt.CustId = tmp.CustId
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustWinLossLimit_Agent WITH (NOLOCK))
            BEGIN
                INSERT INTO CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustId,
                       SportType,
                       BetType,
                       MaxWinLimit,
                       MaxLossLimit,
                       IsAutoReset,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustWinLossLimit_Agent;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustWinLossLimit_Agent
                
                -- Batch insert into CustWinLossLimit_Agent
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustWinLossLimit_Agent
                -- OUTPUT DELETED.CustId,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.MaxWinLimit,
                --        DELETED.MaxLossLimit,
                --        DELETED.IsAutoReset
                -- INTO dbo.CustWinLossLimit_Agent (
                --     CustId,
                --     SportType,
                --     BetType,
                --     MaxWinLimit,
                --     MaxLossLimit,
                --     IsAutoReset
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0;
    END
    -- 9. BetSetting_Member
    IF @TableTarget = 'BetSetting_Member'
    BEGIN
        TRUNCATE TABLE #Temp_BetSetting_Member;

        -- Collect data for BetSetting_Member
        INSERT INTO #Temp_BetSetting_Member (
            CustID,
            SportType,
            BetType,
            MinBet,
            MaxBet,
            MaxPerMatch,
            MaxPayoutPerMatch
        )
        SELECT src.CustID,
               src.SportType,
               src.BetType,
               src.MinBet,
               src.MaxBet,
               src.MaxPerMatch,
               src.MaxPayoutPerMatch
        FROM DBAGE.bodb_Customer.dbo.BetSetting_Member_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK)
            ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_BetSetting_Member WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_BetSetting_Member WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.BetSetting_Member AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_BetSetting_Member tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_BetSetting_Member WITH (NOLOCK))
            BEGIN
                INSERT INTO BetSetting_Member (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPayoutPerMatch, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       MinBet,
                       MaxBet,
                       MaxPerMatch,
                       MaxPayoutPerMatch,
                       dbo.f_GetDateTime2()
                FROM #Temp_BetSetting_Member;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_BetSetting_Member
                
                -- Batch insert into BetSetting_Member
                -- DELETE TOP (@Batch)
                -- FROM #Temp_BetSetting_Member
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.MinBet,
                --        DELETED.MaxBet,
                --        DELETED.MaxPerMatch,
                --        DELETED.MaxPayoutPerMatch
                -- INTO dbo.BetSetting_Member (
                --     CustID,
                --     SportType,
                --     BetType,
                --     MinBet,
                --     MaxBet,
                --     MaxPerMatch,
                --     MaxPayoutPerMatch
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsRestored = 0;
    END
    -- 10. BetSetting3rd_Member
    IF @TableTarget = 'BetSetting3rd_Member'
    BEGIN
        TRUNCATE TABLE #Temp_BetSetting3rd_Member;

        -- Collect data for BetSetting3rd_Member
        INSERT INTO #Temp_BetSetting3rd_Member (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPerNumber)
        SELECT src.CustID, src.SportType, src.BetType, src.MinBet, src.MaxBet, src.MaxPerMatch, src.MaxPerNumber
        FROM DBAGE.bodb_Customer.dbo.BetSetting3rd_Member_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_BetSetting3rd_Member WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_BetSetting3rd_Member WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.BetSetting3rd_Member AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_BetSetting3rd_Member tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_BetSetting3rd_Member WITH (NOLOCK))
            BEGIN
                INSERT INTO BetSetting3rd_Member (CustID, SportType, BetType, MinBet, MaxBet, MaxPerMatch, MaxPerNumber, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       MinBet,
                       MaxBet,
                       MaxPerMatch,
                       MaxPerNumber,
                       dbo.f_GetDateTime2()
                FROM #Temp_BetSetting3rd_Member;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_BetSetting3rd_Member
                
                -- Batch insert into BetSetting3rd_Member
                -- DELETE TOP (@Batch)
                -- FROM #Temp_BetSetting3rd_Member
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.MinBet,
                --        DELETED.MaxBet,
                --        DELETED.MaxPerMatch,
                --        DELETED.MaxPerNumber
                -- INTO dbo.BetSetting3rd_Member (
                --     CustID,
                --     SportType,
                --     BetType,
                --     MinBet,
                --     MaxBet,
                --     MaxPerMatch,
                --     MaxPerNumber
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0;
    END
    -- 11. CustDiscount3rd_Member
    IF @TableTarget = 'CustDiscount3rd_Member'
    BEGIN
        TRUNCATE TABLE #Temp_CustDiscount3rd_Member;

        -- Collect data for CustDiscount3rd_Member
        INSERT INTO #Temp_CustDiscount3rd_Member (CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
        SELECT src.CustID, src.SportType, src.BetType, src.PlayerDiscount, src.AgentDiscount, src.MasterDiscount, src.SuperDiscount
        FROM DBAGE.bodb_Customer.dbo.CustDiscount3rd_Member_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustDiscount3rd_Member WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustDiscount3rd_Member WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustDiscount3rd_Member AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustDiscount3rd_Member tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustDiscount3rd_Member WITH (NOLOCK))
            BEGIN
                INSERT INTO CustDiscount3rd_Member (CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       PlayerDiscount,
                       AgentDiscount,
                       MasterDiscount,
                       SuperDiscount,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustDiscount3rd_Member;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustDiscount3rd_Member
                
                -- Batch insert into CustDiscount3rd_Member
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustDiscount3rd_Member
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.PlayerDiscount,
                --        DELETED.AgentDiscount,
                --        DELETED.MasterDiscount,
                --        DELETED.SuperDiscount
                -- INTO dbo.CustDiscount3rd_Member (
                --     CustID,
                --     SportType,
                --     BetType,
                --     PlayerDiscount,
                --     AgentDiscount,
                --     MasterDiscount,
                --     SuperDiscount
                -- );

            END

        END
        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
        AND cl.IsRestored = 0;
    END
    -- 12. CustPTSetting3rd_Member
    IF @TableTarget = 'CustPTSetting3rd_Member'
    BEGIN
        TRUNCATE TABLE #Temp_CustPTSetting3rd_Member;

        -- Collect data for CustPTSetting3rd_Member
        INSERT INTO #Temp_CustPTSetting3rd_Member (CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT)
        SELECT src.CustID, src.SportType, src.BetType, src.IsLive, src.IsAutoMasterPT, src.IsAutoSuperPT, src.SuperPT, src.MasterPT, src.AgentPT, src.AutoSuperPT, src.AutoMasterPT
        FROM DBAGE.bodb_Customer.dbo.CustPTSetting3rd_Member_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustPTSetting3rd_Member WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustPTSetting3rd_Member WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustPTSetting3rd_Member AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustPTSetting3rd_Member tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustPTSetting3rd_Member WITH (NOLOCK))
            BEGIN
                INSERT INTO CustPTSetting3rd_Member (CustID, SportType, BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       IsLive,
                       IsAutoMasterPT,
                       IsAutoSuperPT,
                       SuperPT,
                       MasterPT,
                       AgentPT,
                       AutoSuperPT,
                       AutoMasterPT,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustPTSetting3rd_Member;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustPTSetting3rd_Member
                
                -- Batch insert into CustPTSetting3rd_Member
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustPTSetting3rd_Member
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.IsLive,
                --        DELETED.IsAutoMasterPT,
                --        DELETED.IsAutoSuperPT,
                --        DELETED.SuperPT,
                --        DELETED.MasterPT,
                --        DELETED.AgentPT,
                --        DELETED.AutoSuperPT,
                --        DELETED.AutoMasterPT
                -- INTO dbo.CustPTSetting3rd_Member (
                --     CustID,
                --     SportType,
                --     BetType,
                --     IsLive,
                --     IsAutoMasterPT,
                --     IsAutoSuperPT,
                --     SuperPT,
                --     MasterPT,
                --     AgentPT,
                --     AutoSuperPT,
                --     AutoMasterPT
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0;        
    END
    -- 13. CustMaxPayoutSetting_Member
    IF @TableTarget = 'CustMaxPayoutSetting_Member'
    BEGIN
        TRUNCATE TABLE #Temp_CustMaxPayoutSetting_Member;

        -- Collect data for CustMaxPayoutSetting_Member
        INSERT INTO #Temp_CustMaxPayoutSetting_Member (CustID, SportType, BetType, SingleMatchParlay, Combo2, Combo35, ComboOver6)
        SELECT src.CustID, src.SportType, src.BetType, src.SingleMatchParlay, src.Combo2, src.Combo35, src.ComboOver6
        FROM DBAGE.bodb_Customer.dbo.CustMaxPayoutSetting_Member_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustMaxPayoutSetting_Member WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustMaxPayoutSetting_Member WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustMaxPayoutSetting_Member AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustMaxPayoutSetting_Member tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustMaxPayoutSetting_Member WITH (NOLOCK))
            BEGIN
                INSERT INTO CustMaxPayoutSetting_Member (CustID, SportType, BetType, SingleMatchParlay, Combo2, Combo35, ComboOver6, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       SingleMatchParlay,
                       Combo2,
                       Combo35,
                       ComboOver6,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustMaxPayoutSetting_Member;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustMaxPayoutSetting_Member
                
                -- Batch insert into CustMaxPayoutSetting_Member
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustMaxPayoutSetting_Member
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.SingleMatchParlay,
                --        DELETED.Combo2,
                --        DELETED.Combo35,
                --        DELETED.ComboOver6
                -- INTO dbo.CustMaxPayoutSetting_Member (
                --     CustID,
                --     SportType,
                --     BetType,
                --     SingleMatchParlay,
                --     Combo2,
                --     Combo35,
                --     ComboOver6
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0;
    END
    -- 14. CustStakeLevel_Member
    IF @TableTarget = 'CustStakeLevel_Member'
    BEGIN
        TRUNCATE TABLE #Temp_CustStakeLevel_Member;

        -- Collect data for CustStakeLevel_Member
        INSERT INTO #Temp_CustStakeLevel_Member (CustID, SportType, BetType, StakeLevelList)
        SELECT src.CustID, src.SportType, src.BetType, src.StakeLevelList
        FROM DBAGE.bodb_Customer.dbo.CustStakeLevel_Member_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustStakeLevel_Member WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustStakeLevel_Member WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustStakeLevel_Member AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustStakeLevel_Member tmp
                    ON tgt.CustID = tmp.CustID
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustStakeLevel_Member WITH (NOLOCK))
            BEGIN
                INSERT INTO CustStakeLevel_Member (CustID, SportType, BetType, StakeLevelList, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       SportType,
                       BetType,
                       StakeLevelList,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustStakeLevel_Member;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustStakeLevel_Member
                
                -- Batch insert into CustStakeLevel_Member
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustStakeLevel_Member
                -- OUTPUT DELETED.CustID,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.StakeLevelList
                -- INTO dbo.CustStakeLevel_Member (
                --     CustID,
                --     SportType,
                --     BetType,
                --     StakeLevelList
                -- );
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0;
    END
    -- 15. CustWinLossLimit_Member
    IF @TableTarget = 'CustWinLossLimit_Member'
    BEGIN
        TRUNCATE TABLE #Temp_CustWinLossLimit_Member;

        -- Collect data for CustWinLossLimit_Member
        INSERT INTO #Temp_CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
        SELECT src.CustId, src.SportType, src.BetType, src.MaxWinLimit, src.MaxLossLimit, src.IsAutoReset
        FROM DBAGE.bodb_Customer.dbo.CustWinLossLimit_Member_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustId = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustWinLossLimit_Member WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustWinLossLimit_Member WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustWinLossLimit_Member AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustWinLossLimit_Member tmp
                    ON tgt.CustId = tmp.CustId
                    AND tgt.SportType = tmp.SportType
                    AND tgt.BetType = tmp.BetType
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustWinLossLimit_Member WITH (NOLOCK))
            BEGIN
                INSERT INTO CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustId,
                       SportType,
                       BetType,
                       MaxWinLimit,
                       MaxLossLimit,
                       IsAutoReset,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustWinLossLimit_Member;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustWinLossLimit_Member
                
                -- Batch insert into CustWinLossLimit_Member
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustWinLossLimit_Member
                -- OUTPUT DELETED.CustId,
                --        DELETED.SportType,
                --        DELETED.BetType,
                --        DELETED.MaxWinLimit,
                --        DELETED.MaxLossLimit,
                --        DELETED.IsAutoReset
                -- INTO dbo.CustWinLossLimit_Member (
                --     CustId,
                --     SportType,
                --     BetType,
                --     MaxWinLimit,
                --     MaxLossLimit,
                --     IsAutoReset
                -- );
            END
        END
        
        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0;
    END
    -- 16. CustSettingMode3rd
    IF @TableTarget = 'CustSettingMode3rd'
    BEGIN
        TRUNCATE TABLE #Temp_CustSettingMode3rd;

        -- Collect data for CustSettingMode3rd
        INSERT INTO #Temp_CustSettingMode3rd (CustID, IsGrouped)
        SELECT src.CustID, src.IsGrouped
        FROM DBAGE.bodb_Customer.dbo.CustSettingMode3rd_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustSettingMode3rd WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustSettingMode3rd WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustSettingMode3rd AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustSettingMode3rd tmp
                    ON tgt.CustID = tmp.CustID
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustSettingMode3rd WITH (NOLOCK))
            BEGIN
                INSERT INTO CustSettingMode3rd (CustID, IsGrouped, RepUpdateTime)
                SELECT TOP (@Batch)
                       CustID,
                       IsGrouped,
                       dbo.f_GetDateTime2()
                FROM #Temp_CustSettingMode3rd;

                IF @@ROWCOUNT = 0
                    BREAK;  

                DELETE TOP (@Batch) FROM #Temp_CustSettingMode3rd
                
                -- Batch insert into CustSettingMode3rd
                -- DELETE TOP (@Batch)
                -- FROM #Temp_CustSettingMode3rd
                -- OUTPUT DELETED.CustID,
                --        DELETED.IsGrouped
                -- INTO dbo.CustSettingMode3rd (
                --     CustID,
                --     IsGrouped
                -- );
            END
        END
        
        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' inserted successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0; 
    END
    ---------------------------Restore Status---------------------------
    -- 17. custinfo
    IF @TableTarget = 'custinfo'
    BEGIN
        TRUNCATE TABLE #Temp_custinfo;

        -- Collect data for custinfo
        INSERT INTO #Temp_custinfo (
            custid,
            Enabled
        )
        SELECT src.custid,
               src.Enabled
        FROM DBAGE.bodb_Customer.dbo.custinfo_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK)
            ON src.custid = cl.CustID
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_custinfo WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_custinfo WITH (NOLOCK))
           AND EXISTS (
                SELECT 1
                FROM dbo.custinfo AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_custinfo tmp
                    ON tgt.custid = tmp.custid
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_custinfo WITH (NOLOCK))
            BEGIN
            
                TRUNCATE TABLE #CustBatch;

                -- Batch insert into custinfo
                UPDATE TOP (@Batch) i
                    SET i.Enabled = t.Enabled,
                        i.RepUpdateTime = dbo.f_GetDateTime2()
                OUTPUT INSERTED.custid  INTO #CustBatch (CustID)
                FROM custinfo i WITH (ROWLOCK, UPDLOCK)
                INNER JOIN #Temp_custinfo t
                    ON i.custid = t.custid

                IF @@ROWCOUNT = 0
                    BREAK;

                DELETE ti
                FROM #Temp_custinfo ti
                INNER JOIN #CustBatch ce
                    ON ti.custid = ce.CustID;
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' updated successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsRestored = 0;
    END
    -- 18. CustProductStatus
    IF @TableTarget = 'CustProductStatus'
    BEGIN
        TRUNCATE TABLE #Temp_CustProductStatus;

        -- Collect data for CustProductStatus
        INSERT INTO #Temp_CustProductStatus (
            CustID,
            CloseInfo
        )
        SELECT src.CustID,
               src.CloseInfo
        FROM DBAGE.bodb_Customer.dbo.CustProductStatus_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK)
            ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustProductStatus WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustProductStatus WITH (NOLOCK))
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustProductStatus WITH (NOLOCK))
            BEGIN
                TRUNCATE TABLE #CustBatch;
                
                -- Batch insert into CustProductStatus
                UPDATE TOP (@Batch) i
                    SET i.CloseInfo = t.CloseInfo,
                        i.RepUpdateTime = dbo.f_GetDateTime2()
                OUTPUT INSERTED.custid  INTO #CustBatch (CustID)
                FROM CustProductStatus i WITH (ROWLOCK, UPDLOCK)
                INNER JOIN #Temp_CustProductStatus t
                    ON i.custid = t.custid

                IF @@ROWCOUNT = 0
                    BREAK;

                DELETE ti
                FROM #Temp_CustProductStatus ti
                INNER JOIN #CustBatch ce
                    ON ti.custid = ce.CustID;
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' updated successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsRestored = 0;
    END
    -- 19. CustLoginInfo
    IF @TableTarget = 'CustLoginInfo'
    BEGIN
        TRUNCATE TABLE #Temp_CustLoginInfo;

        -- Collect data for CustLoginInfo
        INSERT INTO #Temp_CustLoginInfo (
            CustID,
            ClosedReason
        )
        SELECT src.CustID,
               src.ClosedReason
        FROM DBAGE.bodb_Customer.dbo.CustLoginInfo_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK)
            ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustLoginInfo WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustLoginInfo WITH (NOLOCK))
           AND EXISTS (
                SELECT 1
                FROM dbo.CustLoginInfo AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustLoginInfo tmp
                    ON tgt.CustID = tmp.CustID
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustLoginInfo WITH (NOLOCK))
            BEGIN
                TRUNCATE TABLE #CustBatch;
                
                -- Batch insert into CustLoginInfo
                UPDATE TOP (@Batch) i
                    SET i.ClosedReason = t.ClosedReason,
                        i.RepUpdateTime = dbo.f_GetDateTime2()
                OUTPUT INSERTED.custid  INTO #CustBatch (CustID)
                FROM CustLoginInfo i WITH (ROWLOCK, UPDLOCK)
                INNER JOIN #Temp_CustLoginInfo t
                    ON i.custid = t.custid

                IF @@ROWCOUNT = 0
                    BREAK;

                DELETE ti
                FROM #Temp_CustLoginInfo ti
                INNER JOIN #CustBatch ce
                    ON ti.custid = ce.CustID;
            END
        END

        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' updated successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
          AND cl.IsRestored = 0;
    END    
    -- 20. CustLoginInfo_Member
    IF @TableTarget = 'CustLoginInfo_Member'
    BEGIN
        -- Collect
        INSERT INTO #Temp_CustLoginInfo_Member (CustID, ClosedReason)
        SELECT src.CustID, src.ClosedReason
        FROM DBAGE.bodb_Customer.dbo.CustLoginInfo_Member_old AS src WITH (NOLOCK)
        INNER JOIN #CustList cl WITH (NOLOCK) ON src.CustID = cl.CustID
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;

        UPDATE cl SET IsCollected = 1 FROM #CustList cl WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
        IF NOT EXISTS (SELECT 1 FROM #Temp_CustLoginInfo_Member WITH (NOLOCK))
            CONTINUE;

        -- Restore in batch
        IF EXISTS (SELECT 1 FROM #Temp_CustLoginInfo_Member WITH (NOLOCK))
           AND NOT EXISTS (
                SELECT 1
                FROM dbo.CustLoginInfo_Member AS tgt WITH (NOLOCK)
                INNER JOIN #Temp_CustLoginInfo_Member tmp
                    ON tgt.CustID = tmp.CustID
            )
        BEGIN
            WHILE EXISTS (SELECT 1 FROM #Temp_CustLoginInfo_Member WITH (NOLOCK))
            BEGIN
                TRUNCATE TABLE #CustBatch;
                
                -- Batch insert into CustLoginInfo_Member
                UPDATE TOP (@Batch) i
                    SET i.ClosedReason = t.ClosedReason,
                        i.RepUpdateTime = dbo.f_GetDateTime2()
                OUTPUT INSERTED.custid  INTO #CustBatch (CustID)
                FROM CustLoginInfo_Member i WITH (ROWLOCK, UPDLOCK)
                INNER JOIN #Temp_CustLoginInfo_Member t
                    ON i.custid = t.custid

                IF @@ROWCOUNT = 0
                    BREAK;

                DELETE ti
                FROM #Temp_CustLoginInfo_Member ti
                INNER JOIN #CustBatch ce
                    ON ti.custid = ce.CustID;
            END
        END
        
        WAITFOR DELAY '00:00:0.050';
        SET @ErrMsg = @TableTarget + ' updated successfully';
        RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget
            AND cl.IsRestored = 0;
        
    END
END

-- Step 4: Validation and Cleanup
PRINT 'Restore process completed:';

SELECT * FROM #CustList;

-- Cleanup all temp tables used in the restore process
DROP TABLE IF EXISTS #Temp_BetSetting_Agent;
DROP TABLE IF EXISTS #Temp_BetSetting3rd_Agent;
DROP TABLE IF EXISTS #Temp_CustDiscount3rd_Agent;
DROP TABLE IF EXISTS #Temp_CustMaxPayoutSetting_Agent;
DROP TABLE IF EXISTS #Temp_CustPTSetting3rd_Agent;
DROP TABLE IF EXISTS #Temp_CustStakeLevel_Agent;
DROP TABLE IF EXISTS #Temp_CustVirtualSetting;
DROP TABLE IF EXISTS #Temp_CustWinLossLimit_Agent;
DROP TABLE IF EXISTS #Temp_BetSetting_Member;
DROP TABLE IF EXISTS #Temp_BetSetting3rd_Member;
DROP TABLE IF EXISTS #Temp_CustDiscount3rd_Member;
DROP TABLE IF EXISTS #Temp_CustPTSetting3rd_Member;
DROP TABLE IF EXISTS #Temp_CustMaxPayoutSetting_Member;
DROP TABLE IF EXISTS #Temp_CustStakeLevel_Member;
DROP TABLE IF EXISTS #Temp_CustWinLossLimit_Member;
DROP TABLE IF EXISTS #Temp_CustSettingMode3rd;
---------------------------------------------------------------------------
DROP TABLE IF EXISTS #Temp_Custinfo;
DROP TABLE IF EXISTS #Temp_CustProductStatus;
DROP TABLE IF EXISTS #Temp_CustLoginInfo;
DROP TABLE IF EXISTS #Temp_CustLoginInfo_Member;
---------------------------------------------------------------------------
DROP TABLE IF EXISTS #CustList;
DROP TABLE IF EXISTS #CustBatch;