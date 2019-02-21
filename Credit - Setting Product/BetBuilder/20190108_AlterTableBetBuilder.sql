/*
	Created: Winnie
	Date: 20190108
	Task: BetBuilder [RedmineID: #105664]
	DB: DBCust/CustDB
*/
USE [CustDB]
GO

ALTER TABLE ProductLaunchedSiteCurrency ADD BetType SMALLINT NOT NULL DEFAULT(0)
ALTER TABLE ProductLaunchedSiteCurrency ADD LaunchedLevel TINYINT NOT NULL DEFAULT(0)


/****** Object:  Index [PK_ProductLaunchedSiteCurrency]    Script Date: 2/21/2019 2:17:21 PM ******/
ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] DROP CONSTRAINT [PK_ProductLaunchedSiteCurrency]
GO

/****** Object:  Index [PK_ProductLaunchedSiteCurrency]    Script Date: 2/21/2019 2:17:21 PM ******/
ALTER TABLE [dbo].[ProductLaunchedSiteCurrency] ADD  CONSTRAINT [PK_ProductLaunchedSiteCurrency] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[Currency] ASC,
	[SportType] ASC,
	[LaunchedLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO


