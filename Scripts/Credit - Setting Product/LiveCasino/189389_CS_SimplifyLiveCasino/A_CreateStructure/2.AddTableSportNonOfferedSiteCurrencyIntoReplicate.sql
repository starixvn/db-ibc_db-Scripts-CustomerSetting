/*<info serverAlias="DBTXN-CustDB"></info>*/
/*
	Created: 20230804@Helios
	Task: Add table SportNonOfferedSiteCurrency to replications  [#189389]
	DB: Current state table SportNonOfferedSiteCurrency is existing on pub: CustDB_Customer_Info. Need add table into pub: CustDB_DBTrans_CustInfo 
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SportNonOfferedSiteCurrency](
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
 CONSTRAINT [PK_SportNonOfferedSiteCurrency] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[BetType] ASC,
	[Currency] ASC,
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO


