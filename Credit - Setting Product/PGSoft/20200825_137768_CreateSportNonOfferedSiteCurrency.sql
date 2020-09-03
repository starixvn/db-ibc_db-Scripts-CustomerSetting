/*
	Created: 20200819@Elodie
	Task : Create table SportNonOfferedSiteCurrency
	DB:  DBCUST/CustDB and all replicated server 
*/
USE CustDB
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
