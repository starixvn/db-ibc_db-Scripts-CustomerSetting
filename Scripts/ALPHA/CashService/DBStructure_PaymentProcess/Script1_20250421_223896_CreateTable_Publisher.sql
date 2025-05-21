/*<info serverAlias="DBSIC-bodb02"></info>*/
/*
	Created: 20250421@Eden
	Task: Create Table stored cash member credit [#RedmineID:#223896]
	DB: DBSIC-bodb02
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CashAccumCredit]') AND type in (N'U'))
	DROP TABLE [dbo].[CashAccumCredit]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE CashAccumCredit (
    CustID INT NOT NULL,
    recommend INT NOT NULL,
    mrecommend INT NOT NULL,
    srecommend INT NOT NULL,
    AccumCreditReturn MONEY NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    RepUpdateTime DATETIME2 NULL
CONSTRAINT [PK_CashAccumCredit] PRIMARY KEY CLUSTERED 
(
	CustID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA] 
GO

-------------------------------------------------------------------------------------------------------------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CashTransaction]') AND type in (N'U'))
DROP TABLE [dbo].[CashTransaction]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashTransaction](
	[TransId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustId] [int] NOT NULL,
	[TransactionTypeID] [tinyint] NOT NULL,
	[StatusId] [tinyint] NOT NULL,
	[Amount] [money] NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[Creator] [int] NOT NULL,
	[Remark] [nvarchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[SiteDBGroupID] [smallint] NULL,
	[TransferRefNo] [bigint] NULL,
	[OperatedBy] [int] NULL,
	[OperatedTime] [datetime] NULL,
	[SubAccID] [int] NULL,
	[PaymentType] [tinyint] NULL,
	[PaymentMethod] [tinyint] NULL,
	[PaymentFrom] [varchar](100) MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,
	[PaymentTo] [varchar](100) MASKED WITH (FUNCTION = 'partial(0,"***",0)') NULL,
	[PaySlip] [varbinary](max) NULL,
	[ExtraInfo] [nvarchar](1000) NULL,
	[AdjustCreditAmt] [money] NULL
	CONSTRAINT [PK_CashTransaction] PRIMARY KEY CLUSTERED 
(
	[TransId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]

GO

-- Sub-table for CashAccumCredit
IF OBJECT_ID(N'[dbo].[CashAccumCredit_Del_InHouse]', N'U') IS NOT NULL
    DROP TABLE [dbo].[CashAccumCredit_Del_InHouse];
GO

CREATE TABLE [dbo].[CashAccumCredit_Del_InHouse] (
    CustID INT NOT NULL,
    RepUpdateTime DATETIME2 NULL
);
GO

-- Sub-table for CashTransaction
IF OBJECT_ID(N'[dbo].[CashTransaction_Del_InHouse]', N'U') IS NOT NULL
    DROP TABLE [dbo].[CashTransaction_Del_InHouse];
GO

CREATE TABLE [dbo].[CashTransaction_Del_InHouse] (
    TransId BIGINT NOT NULL,
    RepUpdateTime DATETIME2(7) NULL
);
GO

-- Index for CashAccumCredit
/*
DROP INDEX IX_RepUpdateTime ON [dbo].[CashAccumCredit];
DROP INDEX IX_Recommend ON [dbo].[CashAccumCredit];
DROP INDEX IX_RepUpdateTime ON [dbo].[CashTransaction];
*/
CREATE NONCLUSTERED INDEX IX_RepUpdateTime ON [dbo].[CashAccumCredit] (RepUpdateTime ASC) ON [DATA];
GO
CREATE NONCLUSTERED INDEX IX_Recommend ON CashAccumCredit(recommend ASC) INCLUDE (AccumCreditReturn)
GO
-- Index for CashTransaction
CREATE NONCLUSTERED INDEX IX_RepUpdateTime ON [dbo].[CashTransaction] (RepUpdateTime ASC) ON [DATA];
GO
-- Index for Del_inhouse Table
CREATE CLUSTERED INDEX IX_RepUpdateTime ON [dbo].CashAccumCredit_Del_InHouse (RepUpdateTime ASC) ON [DATA];
CREATE CLUSTERED INDEX IX_RepUpdateTime ON [dbo].CashTransaction_Del_InHouse (RepUpdateTime ASC) ON [DATA];

-----------GRANT UNMASK----------
IF EXISTS( SELECT 1 FROM sys.database_principals  WHERE name = 'asv_CashService')
	GRANT UNMASK TO asv_CashService;

IF EXISTS( SELECT 1 FROM sys.database_principals  WHERE name = 'wsv_CashService')
	GRANT UNMASK TO wsv_CashService;

IF EXISTS( SELECT 1 FROM sys.database_principals  WHERE name = 'repl_ap')
	GRANT UNMASK TO repl_ap;
--REVOKE UNMASK FROM asv_CashService;
--REVOKE UNMASK FROM wsv_CashService;
--REVOKE UNMASK FROM repl_ap;
