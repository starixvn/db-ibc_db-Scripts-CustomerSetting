/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20240604@Eden
	Task: add new TYPE for Rep-inhouse [#204358]
		BetSetting3rd_Agent
		BetSetting3rd_Member
	DB: DBACC-bodb02,DBTP-bodb02
*/
USE bodb02
GO
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutBetSetting3rd_Agent')
BEGIN
	DROP PROCEDURE Repl_PutBetSetting3rd_Agent;
END

IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutBetSetting3rd_Member')
BEGIN
	DROP PROCEDURE Repl_PutBetSetting3rd_Member;
END


IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplBetSetting3rd_Agent' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplBetSetting3rd_Agent;
END

CREATE TYPE [dbo].TVP_ReplBetSetting3rd_Agent AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[RepUpdateTime] [DATETIME2] NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplBetSetting3rd_Agent TO [repl_ap] AS [dbo]
GO
-------------------------
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplBetSetting3rd_Member' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplBetSetting3rd_Member;
END

CREATE TYPE [dbo].TVP_ReplBetSetting3rd_Member AS TABLE (
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[RepUpdateTime] [DATETIME2] NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplBetSetting3rd_Member TO [repl_ap] AS [dbo]
GO