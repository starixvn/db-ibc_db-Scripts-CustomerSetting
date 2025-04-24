/*<info serverAlias="IRS_DBACC-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250424@Johnson	
	Task: Upgrade ExchangeID data type for tables setting [redmine:#225013]
	DB: IRS_DBACC-bodb02,DBCustRepl-ReplCustDB
*/

IF DB_NAME()= 'ReplCustDB' 
	DROP PROCEDURE IF EXISTS [Repl_PutProductBetSetting_Dist] -- run on DBDist
ELSE
	DROP PROCEDURE IF EXISTS [Repl_PutProductBetSetting] -- run on DBACC
GO

DROP TYPE [dbo].[TVP_ReplProductBetSetting]
GO

CREATE TYPE [dbo].[TVP_ReplProductBetSetting] AS TABLE(
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[IsDep] [bit] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[DefaultMinBet] [money] NULL,
	[DefaultMaxBet] [money] NULL,
	[DefaultMaxPerMatch] [money] NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductBetSetting] TO [repl_ap] AS [dbo]
GO