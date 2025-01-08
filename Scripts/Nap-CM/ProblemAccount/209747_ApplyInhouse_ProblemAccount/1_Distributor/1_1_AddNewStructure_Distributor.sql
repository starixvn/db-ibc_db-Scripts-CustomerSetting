/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: Helios
	Date: 9/9/2024 2:24:04 
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - Create new structure Distributor [Redmine: #209747]   
	DB: DBCustRepl-ReplCustDB
*/
USE ReplCustDB

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-----------------[ProblemAccount]-----------------
CREATE TABLE [dbo].[ProblemAccount](
	[CustId] [int] NOT NULL,
	[ProblemStatus] [binary](1) NOT NULL,
	[ReasonId] [tinyint] NULL,
	[IsAbnormalMember] [bit] NOT NULL,
	[Comment] [nvarchar](300) NULL,
	[MaxBet] [money] NULL,
	[MaxPerEvent] [money] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[IsReviewed] [bit] NOT NULL,
	[Informed1By] [int] NULL,
	[Informed2By] [int] NULL,
	[ActionId] [tinyint] NULL,
	[isMarkVoid] [bit] NULL,
	[Matchid1] [int] NULL,
	[Matchid2] [int] NULL,
	[SubIssueTypeId] [tinyint] NULL,
	[VoidTime] [varchar](50) NULL,
	[LimitAmount] [money] NULL,
	[Creator] [int] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ProblemAccount] PRIMARY KEY CLUSTERED 
(
	[CustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProblemAccount] ADD  CONSTRAINT [DF_ProblemAccount_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[ProblemAccount] ADD  CONSTRAINT [DF_ProblemAccount_isMarkVoid]  DEFAULT ((0)) FOR [isMarkVoid]
GO

ALTER TABLE [dbo].[ProblemAccount] ADD  CONSTRAINT [DF_ProblemAccount_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[ProblemAccount] ADD  CONSTRAINT [DF_ProblemAccount_isDeleted]   DEFAULT ((0)) FOR [isDeleted]
GO

-----------------[ProblemAccountReason]-----------------
CREATE TABLE [dbo].[ProblemAccountReason](
	[ReasonID] [tinyint] NOT NULL,
	[ReasonName] [varchar](100) NOT NULL,
	[IsCN88] [bit] NOT NULL,
	[IsCredit] [bit] NOT NULL,
	[IsLicensee] [bit] NOT NULL,
	[ReasonNameCS] [nvarchar](100) NULL,
	[ReasonGroupID] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ProblemAccountReason] PRIMARY KEY CLUSTERED 
(
	[ReasonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProblemAccountReason] ADD  CONSTRAINT [DF_ProblemAccountReason_IsCN88]  DEFAULT ((0)) FOR [IsCN88]
GO

ALTER TABLE [dbo].[ProblemAccountReason] ADD  CONSTRAINT [DF_ProblemAccountReason_IsCredit]  DEFAULT ((0)) FOR [IsCredit]
GO

ALTER TABLE [dbo].[ProblemAccountReason] ADD  CONSTRAINT [DF_ProblemAccountReason_IsLicensee]  DEFAULT ((0)) FOR [IsLicensee]
GO

ALTER TABLE [dbo].[ProblemAccountReason] ADD  CONSTRAINT [DF_ProblemAccountReason_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[ProblemAccountReason] ADD  CONSTRAINT [DF_ProblemAccountReason_isDeleted]   DEFAULT ((0)) FOR [isDeleted]
GO

-----------------[ProblemAccountReason]-----------------

CREATE TABLE [dbo].[ProblemAccountClassification](
	[custid] [int] NOT NULL,
	[IsReviewed] [bit] NULL,
	[ModifiedDate] [datetime] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ProblemAccountClassification] PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProblemAccountClassification] ADD  CONSTRAINT [DF_ProblemAccountClassification_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[ProblemAccountClassification] ADD  CONSTRAINT [DF_ProblemAccountClassification_isDeleted]   DEFAULT ((0)) FOR [isDeleted]
GO

-----------------[ProblemAccountAction]-----------------

CREATE TABLE [dbo].[ProblemAccountAction](
	[ActionID] [tinyint] NOT NULL,
	[ActionName] [varchar](100) NOT NULL,
	[IsActive] [bit] NULL,
	[SubIssueTypeId] [tinyint] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ProblemAccountAction] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProblemAccountAction] ADD  CONSTRAINT [DF_ProblemAccountAction_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[ProblemAccountAction] ADD  CONSTRAINT [DF_ProblemAccountAction_isDeleted]   DEFAULT ((0)) FOR [isDeleted]
GO


-----------------[ProblemAccountLimitDownline]-----------------

CREATE TABLE [dbo].[ProblemAccountLimitDownline](
	[custid] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[UserID] [int] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[custid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[ProblemAccountLimitDownline] ADD  CONSTRAINT [DF_ProblemAccountLimitDownline_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
ALTER TABLE [dbo].[ProblemAccountLimitDownline] ADD  CONSTRAINT [DF_ProblemAccountLimitDownline_isDeleted]   DEFAULT ((0)) FOR [isDeleted]
GO