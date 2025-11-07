/*<info serverAlias="DBACC-bodb02" executers="" viewers=""></info>*/
/*
      Task:         Upgrade SportType column from TINYINT to SMALLINT in BetMonitoring_CustTotalBet and BetMonitoring_CustTotalBet_History [#241501]
      DB:           DBACC-bodb02
      Created:      20251020@Helios 
*/
SET NOCOUNT ON;
SET XACT_ABORT ON;

-----------------BetMonitoring_CustTotalBet-----------------

-- 1. Drop PK on BetMonitoring_CustTotalBet if exists
IF EXISTS (
    SELECT TOP 1 1 FROM sys.key_constraints WHERE name = 'PK_BetMonitoring_CustTotalBet'
)
BEGIN
    PRINT 'Dropping PK_BetMonitoring_CustTotalBet...';
    ALTER TABLE dbo.BetMonitoring_CustTotalBet DROP CONSTRAINT PK_BetMonitoring_CustTotalBet;
END

-- 2. Alter column SportType to TINYINT
IF EXISTS (
    SELECT TOP 1 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BetMonitoring_CustTotalBet' AND COLUMN_NAME = 'SportType' -- AND DATA_TYPE = 'tinyint'
)
BEGIN
    PRINT 'Altering BetMonitoring_CustTotalBet.SportType from TINYINT to SMALLINT...';
    ALTER TABLE dbo.BetMonitoring_CustTotalBet ALTER COLUMN SportType SMALLINT NOT NULL;
    PRINT 'BetMonitoring_CustTotalBet.SportType altered successfully.';
END

-- 3. Recreate PK
IF NOT EXISTS (
    SELECT TOP 1 1 FROM sys.key_constraints WHERE name = 'PK_BetMonitoring_CustTotalBet'
)
BEGIN
    PRINT 'Recreating PK_BetMonitoring_CustTotalBet...';
   
    ALTER TABLE [dbo].[BetMonitoring_CustTotalBet] ADD  CONSTRAINT [PK_BetMonitoring_CustTotalBet] PRIMARY KEY CLUSTERED
    (
	[CustID] ASC,
	[SportType] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [BetMonitor]
END

-----------------BetMonitoring_CustTotalBet_History-----------------

-- 4. Drop PK on BetMonitoring_CustTotalBet_History if exists
IF EXISTS (
    SELECT TOP 1 1 FROM sys.key_constraints WHERE name = 'PK_BetMonitoring_CustTotalBet_History'
)
BEGIN
    PRINT 'Dropping PK_BetMonitoring_CustTotalBet_History...';
    ALTER TABLE dbo.BetMonitoring_CustTotalBet_History DROP CONSTRAINT PK_BetMonitoring_CustTotalBet_History;
END

-- 5. Alter column SportType to TINYINT
IF EXISTS (
    SELECT TOP 1 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BetMonitoring_CustTotalBet_History' AND COLUMN_NAME = 'SportType' -- AND DATA_TYPE = 'tinyint'
)
BEGIN
    PRINT 'Altering BetMonitoring_CustTotalBet_History.SportType from TINYINT to SMALLINT...';
    ALTER TABLE dbo.BetMonitoring_CustTotalBet_History ALTER COLUMN SportType SMALLINT NOT NULL;
    PRINT 'BetMonitoring_CustTotalBet_History.SportType altered successfully.';
END

-- 6. Recreate PK
IF NOT EXISTS (
    SELECT TOP 1 1 FROM sys.key_constraints WHERE name = 'PK_BetMonitoring_CustTotalBet_History'
)
BEGIN
    PRINT 'Recreating PK_BetMonitoring_CustTotalBet_History...';

    ALTER TABLE [dbo].[BetMonitoring_CustTotalBet_History] ADD  CONSTRAINT [PK_BetMonitoring_CustTotalBet_History] PRIMARY KEY CLUSTERED 
    (
	[CustID] ASC,
	[SportType] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [BetMonitor]

END

-- 7. Results Output
SELECT 
    'Script completed successfully' AS Result,
    GETDATE() AS CompletedAt;
