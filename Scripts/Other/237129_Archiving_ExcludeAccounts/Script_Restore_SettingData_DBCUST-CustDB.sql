/*<info serverAlias="DBCUST-CustDB" executers="" viewers=""></info>*/
/*
      Task:         Collect data from _old tables in DBAGE into temp tables in DBCUST
      DB:           DBCUST-CustDB (target), DBAGE-bodb_Customer (source)
      Author:       Helios
      Created:      20250828@Helios
      Description:  This script collects data from _old tables in DBAGE-bodb_Customer 
                    and stores it in temp tables in DBCUST-CustDB.
                    The temp tables have the same structure as the target tables.
                    Target customers: MS-USTM, AS-USTM, GEOUSD
*/
SET NOCOUNT ON;

-- Step 1: Create temp table for Username/CustID with TableTarget
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

-- Insert data with TableSource (was TableAffected) and calculate TableTarget (remove _old suffix)
INSERT INTO #CustList (CustID, Username, Role, TableSource, TableTarget, IsCollected, IsRestored)
VALUES
    (160710961, 'MS-USTM', 'Master', 'BetSetting_Agent_old',           'BetSetting_Agent',           0, 0),
    (160710961, 'MS-USTM', 'Master', 'BetSetting3rd_Agent_old',        'BetSetting3rd_Agent',        0, 0),
    (160710961, 'MS-USTM', 'Master', 'CustDiscount3rd_Agent_old',      'CustDiscount3rd_Agent',      0, 0),
    (160710961, 'MS-USTM', 'Master', 'custinfo_old',                   'custinfo',                   0, 0),
    (160710961, 'MS-USTM', 'Master', 'CustLoginInfo_old',              'CustLoginInfo',              0, 0),
    (160710961, 'MS-USTM', 'Master', 'CustMaxPayoutSetting_Agent_old', 'CustMaxPayoutSetting_Agent', 0, 0),
    -- (160710961, 'MS-USTM', 'Master', 'customer_old',                   'customer',                   0, 0),
    (160710961, 'MS-USTM', 'Master', 'CustProductStatus_old',          'CustProductStatus',          0, 0),
    (160710961, 'MS-USTM', 'Master', 'CustPTSetting3rd_Agent_old',     'CustPTSetting3rd_Agent',     0, 0),
    (160710961, 'MS-USTM', 'Master', 'CustStakeLevel_Agent_old',       'CustStakeLevel_Agent',       0, 0),
    (160710961, 'MS-USTM', 'Master', 'CustVirtualSetting_Old',         'CustVirtualSetting',         0, 0),
    (160710961, 'MS-USTM', 'Master', 'CustWinLossLimit_Agent_old',     'CustWinLossLimit_Agent',     0, 0),
    (160711306, 'AS-USTM', 'Agent',  'BetSetting_Agent_old',           'BetSetting_Agent',           0, 0),
    (160711306, 'AS-USTM', 'Agent',  'BetSetting3rd_Agent_old',        'BetSetting3rd_Agent',        0, 0),
    (160711306, 'AS-USTM', 'Agent',  'CustDiscount3rd_Agent_old',      'CustDiscount3rd_Agent',      0, 0),
    (160711306, 'AS-USTM', 'Agent',  'custinfo_old',                   'custinfo',                   0, 0),
    (160711306, 'AS-USTM', 'Agent',  'CustLoginInfo_old',              'CustLoginInfo',              0, 0),
    (160711306, 'AS-USTM', 'Agent',  'CustMaxPayoutSetting_Agent_old', 'CustMaxPayoutSetting_Agent', 0, 0),
    -- (160711306, 'AS-USTM', 'Agent',  'customer_old',                   'customer',                   0, 0),
    (160711306, 'AS-USTM', 'Agent',  'CustProductStatus_old',          'CustProductStatus',          0, 0),
    (160711306, 'AS-USTM', 'Agent',  'CustPTSetting3rd_Agent_old',     'CustPTSetting3rd_Agent',     0, 0),
    (160711306, 'AS-USTM', 'Agent',  'CustStakeLevel_Agent_old',       'CustStakeLevel_Agent',       0, 0),
    (160711306, 'AS-USTM', 'Agent',  'CustVirtualSetting_Old',         'CustVirtualSetting',         0, 0),
    (160711306, 'AS-USTM', 'Agent',  'CustWinLossLimit_Agent_old',     'CustWinLossLimit_Agent',     0, 0),
    (160711567, 'GEOUSD',  'Member', 'BetSetting_Member_old',          'BetSetting_Member',          0, 0),
    (160711567, 'GEOUSD',  'Member', 'BetSetting3rd_Member_old',       'BetSetting3rd_Member',       0, 0),
    (160711567, 'GEOUSD',  'Member', 'CustDiscount3rd_Member_old',     'CustDiscount3rd_Member',     0, 0),
    (160711567, 'GEOUSD',  'Member', 'CustPTSetting3rd_Member_old',    'CustPTSetting3rd_Member',    0, 0),
    (160711567, 'GEOUSD',  'Member', 'custinfo_old',                   'custinfo',                   0, 0),
    (160711567, 'GEOUSD',  'Member', 'CustLoginInfo_Member_old',       'CustLoginInfo_Member',       0, 0),
    (160711567, 'GEOUSD',  'Member', 'CustMaxPayoutSetting_Member_old','CustMaxPayoutSetting_Member',0, 0),
    -- (160711567, 'GEOUSD',  'Member', 'customer_old',                   'customer',                   0, 0),
    (160711567, 'GEOUSD',  'Member', 'CustProductStatus_old',          'CustProductStatus',          0, 0),
    (160711567, 'GEOUSD',  'Member', 'CustSettingMode3rd_old',         'CustSettingMode3rd',         0, 0),
    (160711567, 'GEOUSD',  'Member', 'CustStakeLevel_Member_old',      'CustStakeLevel_Member',      0, 0),
    (160711567, 'GEOUSD',  'Member', 'CustVirtualSetting_Old',         'CustVirtualSetting',         0, 0),
    (160711567, 'GEOUSD',  'Member', 'CustWinLossLimit_Member_old',    'CustWinLossLimit_Member',    0, 0);



-- Step 2: Get distinct TableTarget values and create temp tables with matching structure
-- Step 2.1: Clear any existing temp tables
IF OBJECT_ID('tempdb..#Temp_BetSetting_Agent') IS NOT NULL DROP TABLE #Temp_BetSetting_Agent;
IF OBJECT_ID('tempdb..#Temp_BetSetting3rd_Agent') IS NOT NULL DROP TABLE #Temp_BetSetting3rd_Agent;
IF OBJECT_ID('tempdb..#Temp_CustDiscount3rd_Agent') IS NOT NULL DROP TABLE #Temp_CustDiscount3rd_Agent;
IF OBJECT_ID('tempdb..#Temp_custinfo') IS NOT NULL DROP TABLE #Temp_custinfo;
IF OBJECT_ID('tempdb..#Temp_CustLoginInfo') IS NOT NULL DROP TABLE #Temp_CustLoginInfo;
IF OBJECT_ID('tempdb..#Temp_CustMaxPayoutSetting_Agent') IS NOT NULL DROP TABLE #Temp_CustMaxPayoutSetting_Agent;
IF OBJECT_ID('tempdb..#Temp_CustProductStatus') IS NOT NULL DROP TABLE #Temp_CustProductStatus;
IF OBJECT_ID('tempdb..#Temp_CustPTSetting3rd_Agent') IS NOT NULL DROP TABLE #Temp_CustPTSetting3rd_Agent;
IF OBJECT_ID('tempdb..#Temp_CustStakeLevel_Agent') IS NOT NULL DROP TABLE #Temp_CustStakeLevel_Agent;
IF OBJECT_ID('tempdb..#Temp_CustVirtualSetting') IS NOT NULL DROP TABLE #Temp_CustVirtualSetting;
IF OBJECT_ID('tempdb..#Temp_CustWinLossLimit_Agent') IS NOT NULL DROP TABLE #Temp_CustWinLossLimit_Agent;
IF OBJECT_ID('tempdb..#Temp_BetSetting_Member') IS NOT NULL DROP TABLE #Temp_BetSetting_Member;
IF OBJECT_ID('tempdb..#Temp_BetSetting3rd_Member') IS NOT NULL DROP TABLE #Temp_BetSetting3rd_Member;
IF OBJECT_ID('tempdb..#Temp_CustDiscount3rd_Member') IS NOT NULL DROP TABLE #Temp_CustDiscount3rd_Member;
IF OBJECT_ID('tempdb..#Temp_CustMaxPayoutSetting_Member') IS NOT NULL DROP TABLE #Temp_CustMaxPayoutSetting_Member;
IF OBJECT_ID('tempdb..#Temp_CustPTSetting3rd_Member') IS NOT NULL DROP TABLE #Temp_CustPTSetting3rd_Member;
IF OBJECT_ID('tempdb..#Temp_CustStakeLevel_Member') IS NOT NULL DROP TABLE #Temp_CustStakeLevel_Member;
IF OBJECT_ID('tempdb..#Temp_CustWinLossLimit_Member') IS NOT NULL DROP TABLE #Temp_CustWinLossLimit_Member;
IF OBJECT_ID('tempdb..#Temp_CustLoginInfo_Member') IS NOT NULL DROP TABLE #Temp_CustLoginInfo_Member;
IF OBJECT_ID('tempdb..#Temp_CustSettingMode3rd') IS NOT NULL DROP TABLE #Temp_CustSettingMode3rd;

-- Step 2.2: Create temp tables with schema matching target tables
-- BetSetting_Agent
CREATE TABLE #Temp_BetSetting_Agent (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    MinBet MONEY NULL,
    MaxBet MONEY NULL,
    MaxPerMatch MONEY NULL,
    MaxPayoutPerMatch MONEY NULL
);

-- BetSetting3rd_Agent
CREATE TABLE #Temp_BetSetting3rd_Agent (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    MinBet MONEY NULL,
    MaxBet MONEY NULL,
    MaxPerMatch MONEY NULL,
    MaxPerNumber MONEY NULL
);

-- CustDiscount3rd_Agent
CREATE TABLE #Temp_CustDiscount3rd_Agent (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    DisCount DECIMAL(9, 8) NOT NULL
);

-- custinfo
CREATE TABLE #Temp_custinfo (
    custid INT NOT NULL,
    Enabled TINYINT NULL
);

-- CustLoginInfo
CREATE TABLE #Temp_CustLoginInfo (
    CustID INT NOT NULL,
    ClosedReason TINYINT NULL
);

-- CustMaxPayoutSetting_Agent
CREATE TABLE #Temp_CustMaxPayoutSetting_Agent (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    SingleMatchParlay MONEY NULL,
    Combo2 MONEY NULL,
    Combo35 MONEY NULL,
    ComboOver6 MONEY NULL
);

-- CustProductStatus
CREATE TABLE #Temp_CustProductStatus (
    CustID INT NOT NULL,
    ProductID TINYINT NOT NULL,
    Status TINYINT NULL,
    CloseInfo TINYINT NULL
);

-- CustPTSetting3rd_Agent
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

-- CustStakeLevel_Agent
CREATE TABLE #Temp_CustStakeLevel_Agent (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    StakeLevelList VARCHAR(200) NULL
);

-- CustVirtualSetting
CREATE TABLE #Temp_CustVirtualSetting (
    custid INT NOT NULL,
    seqNo TINYINT NOT NULL,
    bitmapVirtual BINARY(64) NOT NULL
);

-- CustWinLossLimit_Agent
CREATE TABLE #Temp_CustWinLossLimit_Agent (
    CustId INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    MaxWinLimit MONEY NULL,
    MaxLossLimit MONEY NULL,
    IsAutoReset BIT NULL
);

-- BetSetting_Member
CREATE TABLE #Temp_BetSetting_Member (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    MinBet MONEY NULL,
    MaxBet MONEY NULL,
    MaxPerMatch MONEY NULL,
    MaxPayoutPerMatch MONEY NULL
);

-- BetSetting3rd_Member
CREATE TABLE #Temp_BetSetting3rd_Member (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    MinBet MONEY NULL,
    MaxBet MONEY NULL,
    MaxPerMatch MONEY NULL,
    MaxPerNumber MONEY NULL
);

-- CustDiscount3rd_Member
CREATE TABLE #Temp_CustDiscount3rd_Member (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    PlayerDiscount DECIMAL(9, 8) NOT NULL,
    AgentDiscount DECIMAL(9, 8) NOT NULL,
    MasterDiscount DECIMAL(9, 8) NOT NULL,
    SuperDiscount DECIMAL(9, 8) NOT NULL
);

-- CustMaxPayoutSetting_Member
CREATE TABLE #Temp_CustMaxPayoutSetting_Member (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    SingleMatchParlay MONEY NULL,
    Combo2 MONEY NULL,
    Combo35 MONEY NULL,
    ComboOver6 MONEY NULL
);

-- CustPTSetting3rd_Member
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

-- CustStakeLevel_Member
CREATE TABLE #Temp_CustStakeLevel_Member (
    CustID INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    StakeLevelList VARCHAR(200) NULL,
);

-- CustWinLossLimit_Member
CREATE TABLE #Temp_CustWinLossLimit_Member (
    CustId INT NOT NULL,
    SportType SMALLINT NOT NULL,
    BetType SMALLINT NOT NULL,
    MaxWinLimit MONEY NULL,
    MaxLossLimit MONEY NULL,
    IsAutoReset BIT NULL
);

-- CustLoginInfo_Member
CREATE TABLE #Temp_CustLoginInfo_Member (
    CustID INT NOT NULL,
    ClosedReason TINYINT NULL
);

-- CustSettingMode3rd
CREATE TABLE #Temp_CustSettingMode3rd (
    CustID INT NOT NULL,
    IsGrouped BIT NOT NULL
);

-- Step 3: Collect data from DBAGE-bodb_Customer into temp tables
DECLARE @TableTarget NVARCHAR(100) = NULL;

WHILE EXISTS (SELECT 1 FROM #CustList WHERE IsCollected = 0)
BEGIN
    -- Step 3.1: Get TableTarget that needs to be processed
    SELECT @TableTarget = TableTarget
                FROM (
                    SELECT DISTINCT TableTarget
                    FROM #CustList
                    WHERE IsCollected = 0
                ) t;
    
    IF @@ROWCOUNT = 0
        BREAK; -- Exit if no more tables to process

    -- Step 3.2: Check if there is data to collect AND Insert data into temp table with RepUpdateTime
    IF @TableTarget = 'BetSetting_Agent'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.BetSetting_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_BetSetting_Agent (
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPayoutPerMatch
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.MinBet,
                src.MaxBet,
                src.MaxPerMatch,
                src.MaxPayoutPerMatch
            FROM DBAGE.bodb_Customer.dbo.BetSetting_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'BetSetting3rd_Agent'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.BetSetting3rd_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_BetSetting3rd_Agent (
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPerNumber
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.MinBet,
                src.MaxBet,
                src.MaxPerMatch,
                src.MaxPerNumber
            FROM DBAGE.bodb_Customer.dbo.BetSetting3rd_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustDiscount3rd_Agent'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustDiscount3rd_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustDiscount3rd_Agent (
                CustID,
                SportType,
                BetType,
                DisCount
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.DisCount
            FROM DBAGE.bodb_Customer.dbo.CustDiscount3rd_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'custinfo'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.custinfo_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.custid = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_custinfo (
                custid,
                Enabled
            )
            SELECT 
                src.custid,
                ISNULL(src.Enabled, 0)
            FROM DBAGE.bodb_Customer.dbo.custinfo_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.custid = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustLoginInfo'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustLoginInfo_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustLoginInfo (
                CustID,
                ClosedReason
            )
            SELECT 
                src.CustID,
                ISNULL(src.ClosedReason, 0)
            FROM DBAGE.bodb_Customer.dbo.CustLoginInfo_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END



    IF @TableTarget = 'CustMaxPayoutSetting_Agent'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustMaxPayoutSetting_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustMaxPayoutSetting_Agent (
                CustID,
                SportType,
                BetType,
                SingleMatchParlay,
                Combo2,
                Combo35,
                ComboOver6
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.SingleMatchParlay,
                src.Combo2,
                src.Combo35,
                src.ComboOver6
            FROM DBAGE.bodb_Customer.dbo.CustMaxPayoutSetting_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustProductStatus'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustProductStatus_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustProductStatus (
                CustID,
                ProductID,
                Status,
                CloseInfo
            )
            SELECT 
                src.CustID,
                src.ProductID,
                src.Status,
                ISNULL(src.CloseInfo, 0)
            FROM DBAGE.bodb_Customer.dbo.CustProductStatus_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustPTSetting3rd_Agent'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustPTSetting3rd_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
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
            SELECT 
                src.CustID,
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
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustStakeLevel_Agent'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustStakeLevel_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustStakeLevel_Agent (
                CustID,
                SportType,
                BetType,
                StakeLevelList
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.StakeLevelList
            FROM DBAGE.bodb_Customer.dbo.CustStakeLevel_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustVirtualSetting'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustVirtualSetting_Old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustVirtualSetting 
		(
			custid
		    , seqNo
		    , bitmapVirtual
	 
		)
            SELECT 
                src.CustID,
                src.seqNo,
                src.bitmapVirtual
            FROM DBAGE.bodb_Customer.dbo.CustVirtualSetting_Old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustWinLossLimit_Agent'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustWinLossLimit_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustId = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustWinLossLimit_Agent (
                CustId,
                SportType,
                BetType,
                MaxWinLimit,
                MaxLossLimit,
                IsAutoReset
            )
            SELECT 
                src.CustId,
                src.SportType,
                src.BetType,
                src.MaxWinLimit,
                src.MaxLossLimit,
                src.IsAutoReset
            FROM DBAGE.bodb_Customer.dbo.CustWinLossLimit_Agent_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustId = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;
        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END



    IF @TableTarget = 'BetSetting_Member'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.BetSetting_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_BetSetting_Member (
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPayoutPerMatch
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.MinBet,
                src.MaxBet,
                src.MaxPerMatch,
                src.MaxPayoutPerMatch
            FROM DBAGE.bodb_Customer.dbo.BetSetting_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;

        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'BetSetting3rd_Member'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.BetSetting3rd_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_BetSetting3rd_Member (
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPerNumber
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.MinBet,
                src.MaxBet,
                src.MaxPerMatch,
                src.MaxPerNumber
            FROM DBAGE.bodb_Customer.dbo.BetSetting3rd_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;

        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustDiscount3rd_Member'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustDiscount3rd_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustDiscount3rd_Member (
                CustID,
                SportType,
                BetType,
                PlayerDiscount,
                AgentDiscount,
                MasterDiscount,
                SuperDiscount
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.PlayerDiscount,
                src.AgentDiscount,
                src.MasterDiscount,
                src.SuperDiscount
            FROM DBAGE.bodb_Customer.dbo.CustDiscount3rd_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;

        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustMaxPayoutSetting_Member'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustMaxPayoutSetting_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustMaxPayoutSetting_Member (
                CustID,
                SportType,
                BetType,
                SingleMatchParlay,
                Combo2,
                Combo35,
                ComboOver6
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.SingleMatchParlay,
                src.Combo2,
                src.Combo35,
                src.ComboOver6
            FROM DBAGE.bodb_Customer.dbo.CustMaxPayoutSetting_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;

        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustPTSetting3rd_Member'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustPTSetting3rd_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustPTSetting3rd_Member (
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
            SELECT 
                src.CustID,
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
            FROM DBAGE.bodb_Customer.dbo.CustPTSetting3rd_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;

        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustStakeLevel_Member'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustStakeLevel_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustStakeLevel_Member (
                CustID,
                SportType,
                BetType,
                StakeLevelList
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.StakeLevelList
            FROM DBAGE.bodb_Customer.dbo.CustStakeLevel_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;

        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustWinLossLimit_Member'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustWinLossLimit_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustId = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustWinLossLimit_Member (
                CustId,
                SportType,
                BetType,
                MaxWinLimit,
                MaxLossLimit,
                IsAutoReset
            )
            SELECT 
                src.CustId,
                src.SportType,
                src.BetType,
                src.MaxWinLimit,
                src.MaxLossLimit,
                src.IsAutoReset
            FROM DBAGE.bodb_Customer.dbo.CustWinLossLimit_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustId = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;

        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustLoginInfo_Member'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustLoginInfo_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustLoginInfo_Member (
                CustID,
                ClosedReason
            )
            SELECT 
                src.CustID,
                ISNULL(src.ClosedReason, 0)
            FROM DBAGE.bodb_Customer.dbo.CustLoginInfo_Member_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;

        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END

    IF @TableTarget = 'CustSettingMode3rd'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM DBAGE.bodb_Customer.dbo.CustSettingMode3rd_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0
        )
        BEGIN
            INSERT INTO #Temp_CustSettingMode3rd (
                CustID,
                IsGrouped
            )
            SELECT 
                src.CustID,
                src.IsGrouped
            FROM DBAGE.bodb_Customer.dbo.CustSettingMode3rd_old AS src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID 
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsCollected = 0;

        END
        
        -- Update collection status regardless of whether data was found
        UPDATE cl
        SET IsCollected = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsCollected = 0;
    END
END

-- Step 3.3: Select All Data Collected
IF EXISTS (SELECT 1 FROM #CustList WHERE IsCollected = 0)
BEGIN   
    PRINT 'Some data collection failed. Please check the log for details.';
    SELECT * FROM #CustList WHERE IsCollected = 0
    RETURN;
END

-- Step 4: Restore Data to Target Table
SELECT @TableTarget  = NULL;
DECLARE @RowsAffected INT; -- Variable to store rows affected
DECLARE @ErrMsg NVARCHAR(500); -- Variable for error messages

WHILE EXISTS (SELECT 1 FROM #CustList WHERE IsRestored = 0)
BEGIN
    -- Step 4.1: Get TableTarget that needs to be processed for restoration
    SELECT @TableTarget = TableTarget
                FROM (
                    SELECT DISTINCT TableTarget
                    FROM #CustList
                    WHERE IsRestored = 0
                ) t;
    
    IF @@ROWCOUNT = 0
        BREAK; -- Exit if no more tables to process

    -- Step 4.2: Check if there is data to restore AND Insert data into target tables
    IF @TableTarget = 'BetSetting_Agent'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.BetSetting_Agent AS src WITH (NOLOCK)
            INNER JOIN #Temp_BetSetting_Agent cl ON src.CustID = cl.CustID
        )
        BEGIN
            -- Insert records from temp table to main table
            INSERT INTO dbo.BetSetting_Agent (
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPayoutPerMatch,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.MinBet,
                src.MaxBet,
                src.MaxPerMatch,
                src.MaxPayoutPerMatch,
                dbo.f_GetDateTime2()
            FROM #Temp_BetSetting_Agent src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;
        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'BetSetting3rd_Agent'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.BetSetting3rd_Agent AS src WITH (NOLOCK)
            INNER JOIN #Temp_BetSetting3rd_Agent cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.BetSetting3rd_Agent (
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPerNumber,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.MinBet,
                src.MaxBet,
                src.MaxPerMatch,
                src.MaxPerNumber,
                dbo.f_GetDateTime2()
            FROM #Temp_BetSetting3rd_Agent src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END

    IF @TableTarget = 'CustDiscount3rd_Agent'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustDiscount3rd_Agent AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustDiscount3rd_Agent cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustDiscount3rd_Agent (
                CustID,
                SportType,
                BetType,
                PlayerDiscount,
                AgentDiscount,
                MasterDiscount,
                SuperDiscount,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.PlayerDiscount,
                src.AgentDiscount,
                src.MasterDiscount,
                src.SuperDiscount,
                dbo.f_GetDateTime2()
            FROM #Temp_CustDiscount3rd_Agent src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'custinfo'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM dbo.custinfo AS src WITH (NOLOCK)
            INNER JOIN #Temp_custinfo cl ON src.custid = cl.custid
        )
        BEGIN
            UPDATE src
                SET src.Enabled = cl.Enabled,
                    src.RepUpdateTime = dbo.f_GetDateTime2()
            FROM dbo.custinfo AS src WITH (NOLOCK)
            INNER JOIN #Temp_custinfo cl ON src.custid = cl.custid
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

            UPDATE cl
            SET IsRestored = 1
            FROM #CustList cl
            WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
        END
    END
    
    IF @TableTarget = 'CustLoginInfo'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustLoginInfo AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustLoginInfo cl ON src.CustID = cl.CustID 
        )
        BEGIN
            UPDATE src
                SET ClosedReason = cl.ClosedReason,
                    RepUpdateTime = dbo.f_GetDateTime2()
            FROM dbo.CustLoginInfo src WITH (ROWLOCK, UPDLOCK)
            INNER JOIN #Temp_CustLoginInfo cl ON src.CustID = cl.CustID 
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    

    
    IF @TableTarget = 'CustMaxPayoutSetting_Agent'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustMaxPayoutSetting_Agent AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustMaxPayoutSetting_Agent cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustMaxPayoutSetting_Agent (
                CustID,
                SportType,
                BetType,
                SingleMatchParlay,
                Combo2,
                Combo35,
                ComboOver6,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.SingleMatchParlay,
                src.Combo2,
                src.Combo35,
                src.ComboOver6,
                dbo.f_GetDateTime2()
            FROM #Temp_CustMaxPayoutSetting_Agent src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustProductStatus'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustProductStatus AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustProductStatus cl ON src.CustID = cl.CustID 
        )
        BEGIN
            UPDATE cps
            SET 
                cps.CloseInfo = cl.CloseInfo,
                cps.RepUpdateTime = dbo.f_GetDateTime2()
            FROM CustProductStatus cps WITH (NOLOCK)
            INNER JOIN #Temp_CustProductStatus cl ON src.CustID = cl.CustID 
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustPTSetting3rd_Agent'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustPTSetting3rd_Agent AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustPTSetting3rd_Agent cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustPTSetting3rd_Agent (
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
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.IsLive,
                src.IsAutoMasterPT,
                src.IsAutoSuperPT,
                src.SuperPT,
                src.MasterPT,
                src.AgentPT,
                src.AutoSuperPT,
                src.AutoMasterPT,
                dbo.f_GetDateTime2()
            FROM #Temp_CustPTSetting3rd_Agent src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustStakeLevel_Agent'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustStakeLevel_Agent AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustStakeLevel_Agent cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustStakeLevel_Agent (
                CustID,
                SportType,
                BetType,
                StakeLevelList,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.StakeLevelList,
                dbo.f_GetDateTime2()
            FROM #Temp_CustStakeLevel_Agent src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustVirtualSetting'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustVirtualSetting AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustVirtualSetting cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustVirtualSetting 
		(
			custid
		    , seqNo
		    , bitmapVirtual
		    , RepUpdateTime
		)
            SELECT 
                src.CustID,
                src.seqNo,
                src.bitmapVirtual,
                dbo.f_GetDateTime2()
            FROM #Temp_CustVirtualSetting src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustWinLossLimit_Agent'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustWinLossLimit_Agent AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustWinLossLimit_Agent cl ON src.CustId = cl.CustId
        )
        BEGIN
            INSERT INTO dbo.CustWinLossLimit_Agent (
                CustId,
                SportType,
                BetType,
                MaxWinLimit,
                MaxLossLimit,
                IsAutoReset,
                RepUpdateTime
            )
            SELECT 
                src.CustId,
                src.SportType,
                src.BetType,
                src.MaxWinLimit,
                src.MaxLossLimit,
                src.IsAutoReset,
                dbo.f_GetDateTime2()
            FROM #Temp_CustWinLossLimit_Agent src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustId = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    

    
    IF @TableTarget = 'BetSetting_Member'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.BetSetting_Member AS src WITH (NOLOCK)
            INNER JOIN #Temp_BetSetting_Member cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.BetSetting_Member (
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPayoutPerMatch,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.MinBet,
                src.MaxBet,
                src.MaxPerMatch,
                src.MaxPayoutPerMatch,
                dbo.f_GetDateTime2()
            FROM #Temp_BetSetting_Member src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'BetSetting3rd_Member'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.BetSetting3rd_Member AS src WITH (NOLOCK)
            INNER JOIN #Temp_BetSetting3rd_Member cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.BetSetting3rd_Member (
                CustID,
                SportType,
                BetType,
                MinBet,
                MaxBet,
                MaxPerMatch,
                MaxPerNumber,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.MinBet,
                src.MaxBet,
                src.MaxPerMatch,
                src.MaxPerNumber,
                dbo.f_GetDateTime2()
            FROM #Temp_BetSetting3rd_Member src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustDiscount3rd_Member'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustDiscount3rd_Member AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustDiscount3rd_Member cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustDiscount3rd_Member (
                CustID,
                SportType,
                BetType,
                PlayerDiscount,
                AgentDiscount,
                MasterDiscount,
                SuperDiscount,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.PlayerDiscount,
                src.AgentDiscount,
                src.MasterDiscount,
                src.SuperDiscount,
                dbo.f_GetDateTime2()
            FROM #Temp_CustDiscount3rd_Member src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustPTSetting3rd_Member'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustPTSetting3rd_Member AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustPTSetting3rd_Member cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustPTSetting3rd_Member (
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
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.IsLive,
                src.IsAutoMasterPT,
                src.IsAutoSuperPT,
                src.SuperPT,
                src.MasterPT,
                src.AgentPT,
                src.AutoSuperPT,
                src.AutoMasterPT,
                dbo.f_GetDateTime2()
            FROM #Temp_CustPTSetting3rd_Member src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustMaxPayoutSetting_Member'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustMaxPayoutSetting_Member AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustMaxPayoutSetting_Member cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustMaxPayoutSetting_Member (
                CustID,
                SportType,
                BetType,
                SingleMatchParlay,
                Combo2,
                Combo35,
                ComboOver6,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.SingleMatchParlay,
                src.Combo2,
                src.Combo35,
                src.ComboOver6,
                dbo.f_GetDateTime2()
            FROM #Temp_CustMaxPayoutSetting_Member src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustStakeLevel_Member'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustStakeLevel_Member AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustStakeLevel_Member cl ON src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustStakeLevel_Member (
                CustID,
                SportType,
                BetType,
                StakeLevelList,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.SportType,
                src.BetType,
                src.StakeLevelList,
                dbo.f_GetDateTime2()
            FROM #Temp_CustStakeLevel_Member src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustWinLossLimit_Member'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustWinLossLimit_Member AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustWinLossLimit_Member cl ON src.CustId = cl.CustId
        )
        BEGIN
            INSERT INTO dbo.CustWinLossLimit_Member (
                CustId,
                SportType,
                BetType,
                MaxWinLimit,
                MaxLossLimit,
                IsAutoReset,
                RepUpdateTime
            )
            SELECT 
                src.CustId,
                src.SportType,
                src.BetType,
                src.MaxWinLimit,
                src.MaxLossLimit,
                src.IsAutoReset,
                dbo.f_GetDateTime2()
            FROM #Temp_CustWinLossLimit_Member src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustId = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustLoginInfo_Member'
    BEGIN
        IF EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustLoginInfo_Member AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustLoginInfo_Member cl ON src.CustID = cl.CustID
        )
        BEGIN
            UPDATE src
            SET ClosedReason = cl.ClosedReason,
                RepUpdateTime = dbo.f_GetDateTime2()
            FROM CustLoginInfo_Member src WITH (ROWLOCK, UPDLOCK)
            INNER JOIN #Temp_CustLoginInfo_Member cl ON src.CustID = cl
            
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
    IF @TableTarget = 'CustSettingMode3rd'
    BEGIN
        IF NOT EXISTS (
            SELECT TOP 1 1
            FROM dbo.CustSettingMode3rd AS src WITH (NOLOCK)
            INNER JOIN #Temp_CustSettingMode3rd cl ON src.CustID = cl.CustID 
            WHERE src.CustID = cl.CustID
        )
        BEGIN
            INSERT INTO dbo.CustSettingMode3rd (
                CustID,
                IsGrouped,
                RepUpdateTime
            )
            SELECT 
                src.CustID,
                src.IsGrouped,
                dbo.f_GetDateTime2()
            FROM #Temp_CustSettingMode3rd src WITH (NOLOCK)
            INNER JOIN #CustList cl ON src.CustID = cl.CustID
            WHERE 
                cl.TableTarget = @TableTarget AND
                cl.IsRestored = 0;
                
            WAITFOR DELAY '00:00:0.050';
            SET @RowsAffected = @@ROWCOUNT;
            SET @ErrMsg = CAST(@RowsAffected AS NVARCHAR) + ' record(s) inserted successfully into ' + @TableTarget;
            RAISERROR(@ErrMsg, 0, 1) WITH NOWAIT;

        END
        
        -- Update restoration status regardless of whether data was inserted
        UPDATE cl
        SET IsRestored = 1
        FROM #CustList cl
        WHERE cl.TableTarget = @TableTarget AND cl.IsRestored = 0;
    END
    
END -- End of WHILE loop

-- Print summary of restoration process
SELECT 
    CustID,
    Username,
    Role,
    TableSource,
    TableTarget,
    IsCollected,
    IsRestored
FROM #CustList
ORDER BY Role, CustID, TableTarget;

-- Clean up temporary tables to free memory
PRINT 'Cleaning up temporary tables...';

IF OBJECT_ID('tempdb..#Temp_BetSetting_Agent') IS NOT NULL DROP TABLE #Temp_BetSetting_Agent;
IF OBJECT_ID('tempdb..#Temp_BetSetting3rd_Agent') IS NOT NULL DROP TABLE #Temp_BetSetting3rd_Agent;
IF OBJECT_ID('tempdb..#Temp_CustDiscount3rd_Agent') IS NOT NULL DROP TABLE #Temp_CustDiscount3rd_Agent;
IF OBJECT_ID('tempdb..#Temp_custinfo') IS NOT NULL DROP TABLE #Temp_custinfo;
IF OBJECT_ID('tempdb..#Temp_CustLoginInfo') IS NOT NULL DROP TABLE #Temp_CustLoginInfo;
IF OBJECT_ID('tempdb..#Temp_CustMaxPayoutSetting_Agent') IS NOT NULL DROP TABLE #Temp_CustMaxPayoutSetting_Agent;
IF OBJECT_ID('tempdb..#Temp_CustProductStatus') IS NOT NULL DROP TABLE #Temp_CustProductStatus;
IF OBJECT_ID('tempdb..#Temp_CustPTSetting3rd_Agent') IS NOT NULL DROP TABLE #Temp_CustPTSetting3rd_Agent;
IF OBJECT_ID('tempdb..#Temp_CustStakeLevel_Agent') IS NOT NULL DROP TABLE #Temp_CustStakeLevel_Agent;
IF OBJECT_ID('tempdb..#Temp_CustVirtualSetting') IS NOT NULL DROP TABLE #Temp_CustVirtualSetting;
IF OBJECT_ID('tempdb..#Temp_CustWinLossLimit_Agent') IS NOT NULL DROP TABLE #Temp_CustWinLossLimit_Agent;
IF OBJECT_ID('tempdb..#Temp_BetSetting_Member') IS NOT NULL DROP TABLE #Temp_BetSetting_Member;
IF OBJECT_ID('tempdb..#Temp_BetSetting3rd_Member') IS NOT NULL DROP TABLE #Temp_BetSetting3rd_Member;
IF OBJECT_ID('tempdb..#Temp_CustDiscount3rd_Member') IS NOT NULL DROP TABLE #Temp_CustDiscount3rd_Member;
IF OBJECT_ID('tempdb..#Temp_CustMaxPayoutSetting_Member') IS NOT NULL DROP TABLE #Temp_CustMaxPayoutSetting_Member;
IF OBJECT_ID('tempdb..#Temp_CustPTSetting3rd_Member') IS NOT NULL DROP TABLE #Temp_CustPTSetting3rd_Member;
IF OBJECT_ID('tempdb..#Temp_CustStakeLevel_Member') IS NOT NULL DROP TABLE #Temp_CustStakeLevel_Member;
IF OBJECT_ID('tempdb..#Temp_CustWinLossLimit_Member') IS NOT NULL DROP TABLE #Temp_CustWinLossLimit_Member;
IF OBJECT_ID('tempdb..#Temp_CustLoginInfo_Member') IS NOT NULL DROP TABLE #Temp_CustLoginInfo_Member;
IF OBJECT_ID('tempdb..#Temp_CustSettingMode3rd') IS NOT NULL DROP TABLE #Temp_CustSettingMode3rd;
IF OBJECT_ID('tempdb..#CustList') IS NOT NULL DROP TABLE #CustList;

PRINT 'All temporary tables have been dropped.';
