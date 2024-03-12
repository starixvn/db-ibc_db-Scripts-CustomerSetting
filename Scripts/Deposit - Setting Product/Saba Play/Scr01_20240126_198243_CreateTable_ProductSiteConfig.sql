/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBTXN-CustDB,DBBOF-bodb02,DBTP-bodb02"></info>*/
/*
	Created: Tacy@20240126 
	Task: Create new table ProductSiteConfig [redmine: #198243]
	DB: All servers belong to publications:
		CustDB_DBTrans_CustInfo -> ReplicatedServers@custdb
		CustDB_Login_Exchange	-> ReplicatedServers@bodb02
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProductSiteConfig](
	[SiteID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[RefProductID] [tinyint] NOT NULL,
	[AffectedDate] [date] NOT NULL,
	[Environment] [tinyint] NOT NULL,
 CONSTRAINT [PK_ProductSiteConfig] PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

--Default value
ALTER TABLE [dbo].[ProductSiteConfig] ADD  CONSTRAINT [DF_ProductSiteConfig_AffectedDate]  DEFAULT (CAST(GETDATE() AS DATE)) FOR [AffectedDate]
GO

ALTER TABLE [dbo].[ProductSiteConfig] ADD  CONSTRAINT [DF_ProductSiteConfig_Environment]  DEFAULT (1) FOR [Environment]
GO