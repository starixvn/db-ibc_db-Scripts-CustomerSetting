/*<info serverAlias="DBACC-bodb02,DBTP-bodb02,DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20250113@Tacy
	Task: Service In-house - Add new column [redmine: #216609]
	DB: DBACC-bodb02,DBTP-bodb02,DBCustRepl-ReplCustDB
*/ 

--BetSetting_Agent
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutBetSetting_Agent')
AND EXISTS (SELECT 1 FROM RepInfo WITH (NOLOCK)
			WHERE [name]='BetSetting_Agent' AND active=0)
BEGIN
	DROP PROCEDURE Repl_PutBetSetting_Agent;

	IF EXISTS(SELECT 1 FROM sys.types 
			  WHERE name = 'TVP_ReplBetSetting_Agent' 
			  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
	BEGIN
		DROP TYPE [dbo].[TVP_ReplBetSetting_Agent];
	END
END

CREATE TYPE [dbo].TVP_ReplBetSetting_Agent AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[LeagueID] [int] NOT NULL,
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

--------------------------------------------------------------------------------
--BetSetting_Member
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutBetSetting_Member')
AND EXISTS (SELECT 1 FROM RepInfo WITH (NOLOCK)
			WHERE [name]='BetSetting_Member' AND active=0)
BEGIN
	DROP PROCEDURE Repl_PutBetSetting_Member;

	IF EXISTS(SELECT 1 FROM sys.types 
			  WHERE name = 'TVP_ReplBetSetting_Member' 
			  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
	BEGIN
		DROP TYPE [dbo].[TVP_ReplBetSetting_Member];
	END
END

CREATE TYPE [dbo].TVP_ReplBetSetting_Member AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[LeagueID] [int] NOT NULL,
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