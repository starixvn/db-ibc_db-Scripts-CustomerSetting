/*
	Created: Winnie
	Date: 20190108
	Task: BetBuilder [RedmineID: #105664]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

ALTER TABLE ProductLaunchedSiteCurrency ADD BetType SMALLINT  NULL 
ALTER TABLE ProductLaunchedSiteCurrency ADD LaunchedLevel TINYINT  NULL

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET BetType=0

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
	SET LaunchedLevel=0

ALTER TABLE ProductLaunchedSiteCurrency ALTER COLUMN BetType SMALLINT NOT NULL 
ALTER TABLE ProductLaunchedSiteCurrency ALTER COLUMN LaunchedLevel SMALLINT NOT NULL 

ALTER TABLE ProductLaunchedSiteCurrency ADD  CONSTRAINT [DF_ProductLaunchedSiteCurrency_BetType]  DEFAULT ((0)) FOR [BetType]
ALTER TABLE ProductLaunchedSiteCurrency ADD  CONSTRAINT [DF_ProductLaunchedSiteCurrency_LaunchedLevel]  DEFAULT ((0)) FOR [LaunchedLevel]

/****** Object:  Index [PK_ProductLaunchedSiteCurrency]    Script Date: 2/21/2019 2:17:21 PM ******/
ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] DROP CONSTRAINT [PK_ProductLaunchedSiteCurrency]
GO

/****** Object:  Index [PK_ProductLaunchedSiteCurrency]    Script Date: 2/21/2019 2:17:21 PM ******/
ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] ADD  CONSTRAINT [PK_ProductLaunchedSiteCurrency] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[Currency] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[LaunchedLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO


