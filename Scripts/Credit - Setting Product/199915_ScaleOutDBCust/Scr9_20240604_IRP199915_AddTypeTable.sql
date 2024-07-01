/*<info serverAlias="DBACC-bodb02,DBTP-bodb02,DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20240604@Johnson
	Task:add new type for rep in-house [redmine: #199915]
	DB: DBACC-bodb02,DBTP-bodb02,DBCustRepl-ReplCustDB
*/ 


IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplBetSetting_Agent' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplBetSetting_Agent;
END

CREATE TYPE [dbo].TVP_ReplBetSetting_Agent AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,	
	[MaxPayoutPerMatch] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplBetSetting_Agent TO [repl_ap] AS [dbo]
GO

IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplBetSetting_Member' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplBetSetting_Member;
END

CREATE TYPE [dbo].TVP_ReplBetSetting_Member AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,	
	[MaxPayoutPerMatch] [money] NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)


GRANT EXECUTE ON TYPE::[dbo].TVP_ReplBetSetting_Member TO [repl_ap] AS [dbo]
GO