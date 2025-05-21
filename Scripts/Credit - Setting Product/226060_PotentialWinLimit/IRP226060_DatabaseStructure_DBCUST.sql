/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250506@Johnson	
	Task: Database Structure for Potential Winning Limit/Threshold [redmine:#226060]
	DB: DBCUST-CustDB
*/
-- Add the filegroup
ALTER DATABASE [CustDB]
ADD FILEGROUP [CustPotentialWinLimit_table];
GO

-- Add a file to the filegroup
ALTER DATABASE [CustDB]
ADD FILE 
(
    NAME = N'CustPotentialWinLimit_table_01',
    FILENAME =  N'/mnt/DiskG/CustDB/CustPotentialWinLimit_table_01.ndf', -- Local path
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 1MB
) 
TO FILEGROUP [CustPotentialWinLimit_table];
GO

-- Create table CustPotentialWinLimit on filegroup CustPotentialWinLimit_table
CREATE TABLE [dbo].[CustPotentialWinLimit]
(
    CustID INT NOT NULL,
    Sporttype SMALLINT NOT NULL,
    Bettype INT NOT NULL,
    PotentialWinLimit MONEY NULL,
    IsAutoReset BIT NULL,
    RepUpdateTime DATETIME2(7) NULL,
    CONSTRAINT PK_CustPotentialWinLimit PRIMARY KEY (CustID, Sporttype, Bettype)
) ON [CustPotentialWinLimit_table];
GO

ALTER TABLE [dbo].[CustPotentialWinLimit] ADD  CONSTRAINT [DF_CustPotentialWinLimit_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_CustPotentialWinLimit_RepUpdateTime] ON [dbo].[CustPotentialWinLimit] 
(
    [RepUpdateTime] ASC
)ON [DATA]
GO

CREATE TABLE [dbo].[CustPotentialWinLimit_Del_Inhouse]
(
    CustID INT NOT NULL,
    Sporttype SMALLINT NOT NULL,
    Bettype INT NOT NULL,
    RepUpdateTime DATETIME2(7) NULL
) ON [DATA]

ALTER TABLE [dbo].[CustPotentialWinLimit_Del_Inhouse] ADD  CONSTRAINT [DF_CustPotentialWinLimit_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_CustPotentialWinLimit_Del_Inhouse_RepUpdateTime] ON [dbo].[CustPotentialWinLimit_Del_Inhouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO


