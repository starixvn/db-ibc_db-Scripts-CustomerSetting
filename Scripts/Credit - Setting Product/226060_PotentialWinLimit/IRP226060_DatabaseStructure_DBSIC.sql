/*<info serverAlias="IRS_DBSIC-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250612@Johnson	
	Task: Database Structure for Potential Winning Limit/Threshold [redmine:#226060]
	DB: IRS_DBSIC-CustDB
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


