/*<info serverAlias="DBCUST-CustDB,DBTP-bodb02,DBACC-bodb02"></info>*/
/*
	Created by: Tacy@20231101
	Task: Create new table [Redmine:#194024] 
	DB:	DBCUST-CustDB,DBTP-bodb02,DBACC-bodb02
*/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DomainManagement](
	[DomainID] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Domain] [varchar](50) NOT NULL,
	[System] [varchar](20) NOT NULL,
	[Site] [varchar](500) NOT NULL,
	[BrandName] [varchar](10) NULL,
	[Status] [tinyint] NOT NULL,
	[ExpiredDate] [datetime] NULL,
	[LastUpdateTime] [datetime] NOT NULL,
	[RestrictedCountries] [varchar](4000) NULL,
	[Remark] [nvarchar](2000) NULL,
	[isDeleted] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DomainManagement] PRIMARY KEY CLUSTERED 
(
	[DomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[DomainManagement] ADD  CONSTRAINT [DF_DomainManagement_LastUpdateTime]  DEFAULT (getdate()) FOR [LastUpdateTime]
GO

ALTER TABLE [dbo].[DomainManagement] ADD  CONSTRAINT [DF_DomainManagement_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[DomainManagement] ADD  CONSTRAINT [DF_DomainManagement_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_DomainManagement_RepUpdateTime] ON [dbo].[DomainManagement]
(
	[RepUpdateTime] ASC
)
GO