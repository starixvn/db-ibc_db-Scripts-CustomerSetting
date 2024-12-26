/*<info serverAlias="DBCUST-CustDB,DBAGE-bodb02,DBACC-bodb02"></info>*/
/*
	Created by: Tacy@20240826
	Task: Create new tables - WhiteLabelInfo [Redmine:#209807] 
	DB:	DBCUST-CustDB,DBAGE-bodb02,DBACC-bodb02
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
 CONSTRAINT [PK_WhiteLabelInfo] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

--Default value
ALTER TABLE [dbo].[WhiteLabelInfo] ADD  CONSTRAINT [DF_WhiteLabelInfo_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_WhiteLabelInfo_RepUpdateTime] ON [dbo].[WhiteLabelInfo]
(
	[RepUpdateTime] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_WhiteLabelInfo_WhiteLabel] ON [dbo].[WhiteLabelInfo]
(
	[WhiteLabel] ASC
)
GO
