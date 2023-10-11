/*<info serverAlias="DBCUST-CustDB,DBTP-bodb02"></info>*/
/*
	Created by: Tacy@20230822
	Task: Create new Database Structure and add in house replication [Redmine:#186192] 
	DB:	DBCUST-CustDB,DBTP-bodb02
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dep_CustBonusSharing](
	[CustID] [int] NOT NULL,
	[BonusSharingRate] [money] NOT NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL
 CONSTRAINT [PK_Dep_CustBonusSharing] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[FromDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[Dep_CustBonusSharing] ADD  CONSTRAINT [DF_Dep_CustBonusSharing_ToDate]  DEFAULT ('9999/12/31') FOR [ToDate]
GO

ALTER TABLE [dbo].[Dep_CustBonusSharing] ADD  CONSTRAINT [DF_Dep_CustBonusSharing_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

ALTER TABLE [dbo].[Dep_CustBonusSharing] ADD  CONSTRAINT [DF_Dep_CustBonusSharing_isDeleted]  DEFAULT (0) FOR [isDeleted]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_Dep_CustBonusSharing_RepUpdateTime] ON [dbo].[Dep_CustBonusSharing]
(
	[RepUpdateTime] ASC
)
