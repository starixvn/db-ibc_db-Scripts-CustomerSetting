/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250506@Johnson	
	Task: Database Structure for Potential Winning Limit/Threshold [redmine:#226060]
	DB: IRS_DBTP-bodb02
*/
-- Add the filegroup
ALTER DATABASE [bodb02]
ADD FILEGROUP [CustPotentialWinLimit_table];
GO

-- Add a file to the filegroup
ALTER DATABASE [bodb02]
ADD FILE 
(
    NAME = N'CustPotentialWinLimit_table_01',
    FILENAME =  N'D:\SQLSERVER2019_TESTDBTP\bodb02\CustPotentialWinLimit_table_01.ndf', -- Local path
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 1MB
) 
TO FILEGROUP [CustPotentialWinLimit_table];
GO

-- Create table CustPotentialWinLimit on filegroup CustPotentialWinLimit_table
CREATE TABLE [dbo].[CustPotentialWinLimit]
	(
		[CustID] [INT] NOT NULL
		,[Sporttype] [SMALLINT] NOT NULL
		,[Bettype] [INT] NOT NULL
		,[PotentialWinLimit] [MONEY] NULL
		,[IsAutoReset] [BIT] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustPotentialWinLimit] PRIMARY KEY CLUSTERED ([CustID],[Sporttype],[Bettype]) ON [CustPotentialWinLimit_table]
	) ON [CustPotentialWinLimit_table]

ALTER TABLE [dbo].[CustPotentialWinLimit] ADD CONSTRAINT [DF_CustPotentialWinLimit_isDeleted]  DEFAULT ((0)) FOR [isDeleted]

ALTER TABLE [dbo].[CustPotentialWinLimit] ADD CONSTRAINT [DF_CustPotentialWinLimit_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]

CREATE NONCLUSTERED INDEX [IX_CustPotentialWinLimit_RepUpdateTime] ON [dbo].[CustPotentialWinLimit] 
(
    [RepUpdateTime] ASC
)ON [DATA]

