/*<info serverAlias="DBTP-bodb02,DBCustRepl-ReplCustDB"></info>*/
/*
	Created by: Tacy@20240826
	Task: Create new tables - WhiteLabel [Redmine:#209807] 
	DB:	DBTP-bodb02,DBCustRepl-ReplCustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--WhiteLabelInfo
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WhiteLabelInfo](
	[CustID] [int] NOT NULL,
	[WhiteLabel] [char](16) NOT NULL,
	[LaunchedDate] [smalldatetime] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsDeleted]		[bit] NOT NULL
 CONSTRAINT [PK_WhiteLabelInfo] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

--Default value
ALTER TABLE [dbo].[WhiteLabelInfo] ADD  CONSTRAINT [DF_WhiteLabelInfo_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[WhiteLabelInfo] ADD  CONSTRAINT [DF_WhiteLabelInfo_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_WhiteLabelInfo_RepUpdateTime] ON [dbo].[WhiteLabelInfo]
(
	[RepUpdateTime] ASC
)
GO

----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--WhiteLabelSetting
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WhiteLabelSetting](
	[GroupID] [int] NULL,
	[CustID] [int] NOT NULL,
	[HeadlineRate] [smallmoney] NOT NULL,
	[SuperRate] [smallmoney] NOT NULL,
	[MasterRate] [smallmoney] NOT NULL,
	[AgentRate] [smallmoney] NOT NULL,
	[FromDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
	[Remark] [varchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[IsDeleted]		[bit] NOT NULL,
 CONSTRAINT [PK_WhiteLabelSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[FromDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

--Default value
ALTER TABLE [dbo].[WhiteLabelSetting] ADD  CONSTRAINT [DF_WhiteLabelSetting_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[WhiteLabelSetting] ADD  CONSTRAINT [DF_WhiteLabelSetting_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_WhiteLabelSetting_RepUpdateTime] ON [dbo].[WhiteLabelSetting]
(
	[RepUpdateTime] ASC
)
GO