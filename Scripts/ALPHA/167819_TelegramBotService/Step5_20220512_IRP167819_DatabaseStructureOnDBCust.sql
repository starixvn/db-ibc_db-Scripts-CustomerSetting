/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220512@Johnson
	Task: Database structure change for Member Win Loss Limit notification service [#RedmineID:#167819]
	DB: DBCUST/CustDB
*/


CREATE TABLE [dbo].[CustWinLossReachLimit_History](
	[LogID] [BIGINT] NOT NULL IDENTITY(1,1),
	[CustID] [INT] NOT NULL,	
	[Bettype] [INT] NOT NULL,		
	[WinlostDate] [SMALLDATETIME],
	[Winlost] [MONEY],
	[Credit] [MONEY],			
	[MaxLossLimit] [MONEY],
	[MaxWinLimit] [MONEY],
	[WinPercent] [MONEY],
	[LossPercent] [MONEY],
	[CreatedDate] [DATETIME],
 CONSTRAINT [PK_CustWinLossReachLimit_History] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO
