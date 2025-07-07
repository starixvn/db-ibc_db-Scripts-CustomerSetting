/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20250702@Dave
	Task: Agency Cash Service - Customer Setting - Reset Banlace Cash Member [Redmine: #232054]
	DB: IRS_DBTP-bodb02
*/ 
USE [bodb02]
GO

IF EXISTS (SELECT 1 FROM RepInfo WITH (NOLOCK) WHERE [name]='CustWinLossLimit_Member' AND active=0)
BEGIN
	--Drop sp_put
	DROP PROCEDURE IF EXISTS [dbo].[Repl_PutCustWinLossLimit_Member_Dist];

	--Drop TVP
	DROP TYPE IF EXISTS [dbo].[TVP_ReplCustWinLossLimit_Member];
END

CREATE TYPE [dbo].[TVP_ReplCustWinLossLimit_Member] AS TABLE (
	[CustId] [INT] NOT NULL
	,[SportType] [SMALLINT] NOT NULL
	,[BetType] [SMALLINT] NOT NULL
	,[MaxWinLimit] [SMALLMONEY] NULL
	,[MaxLossLimit] [MONEY] NULL
	,[IsAutoReset] [BIT] NULL
	,[RestedDate] DATETIME2(7) NULL
	,[RepUpdateTime] [DATETIME2](7) NOT NULL
	,[isDeleted] [BIT]
	,[_FetchedTime] [DATETIME2](7)
)
GO
GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustWinLossLimit_Member] TO [repl_ap] AS [dbo]
GO

