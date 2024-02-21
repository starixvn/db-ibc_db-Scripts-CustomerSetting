/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240112@Luke
	Task: Spread MNG - Allow to add spread setting by Sport [Redmine: #195328]
	DB: DBCUST/CustDB
*/

CREATE TABLE [dbo].[CustomerClassSpreadDetail](
	[PolicyID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[Platform] [tinyint] NOT NULL,
	[SportType] [smallint] NOT NULL
 CONSTRAINT [PK_CustomerClassSpreadDetail] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[SiteID] ASC,
	[Currency] ASC,
	[Platform] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

CREATE TABLE [dbo].[CustomerClassSpreadDetail_UAT](
	[PolicyID] [int] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[Platform] [tinyint] NOT NULL,
	[SportType] [smallint] NOT NULL
 CONSTRAINT [PK_CustomerClassSpreadDetail_UAT] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[SiteID] ASC,
	[Currency] ASC,
	[Platform] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

