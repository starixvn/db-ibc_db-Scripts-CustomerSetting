/*<info serverAlias="DBCUST-CustDB,DBAGE-bodb02"></info>*/
/*
	Created by: Tacy@20240826
	Task: Create new table - WhiteLabelSetting [Redmine:#209807] 
	DB:	DBCUST-CustDB,DBAGE-bodb02
*/
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
 CONSTRAINT [PK_WhiteLabelSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[FromDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

--Default value
ALTER TABLE [dbo].[WhiteLabelSetting] ADD  CONSTRAINT [DF_WhiteLabelSetting_FromDate]  DEFAULT (CONVERT(DATE, GETDATE())) FOR [FromDate]
GO

ALTER TABLE [dbo].[WhiteLabelSetting] ADD  CONSTRAINT [DF_WhiteLabelSetting_ToDate]  DEFAULT ('9999/12/31') FOR [ToDate]
GO

ALTER TABLE [dbo].[WhiteLabelSetting] ADD  CONSTRAINT [DF_WhiteLabelSetting_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_WhiteLabelSetting_RepUpdateTime] ON [dbo].[WhiteLabelSetting]
(
	[RepUpdateTime] ASC
)
GO
