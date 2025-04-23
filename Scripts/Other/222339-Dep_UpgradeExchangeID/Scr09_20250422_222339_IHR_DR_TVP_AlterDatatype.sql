/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250422@Tacy	
	Task: Alter TVP - In-house on KL DBCUST
	DB: DBGLOB-GlobCustDB
	
	Revisions:
		- 20250422@Tacy: Created [RedmineID: #222339]
*/
IF EXISTS (SELECT 1 FROM RepInfo WITH (NOLOCK)
			WHERE [name]='Dep_ProductBetSetting' AND active=0)
BEGIN
	--Drop sp_put
	DROP PROCEDURE IF EXISTS DR_Repl_PutDep_ProductBetSetting_Dist;

	--Drop TVP
	DROP TYPE IF EXISTS [dbo].[TVP_ReplDep_ProductBetSetting];
END

----------------------------------------------------------------------------------
--Create TVP: column with new datatype
CREATE TYPE [dbo].TVP_ReplDep_ProductBetSetting AS TABLE (
	[Sporttype] [int] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[Currency] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[DefaultMinBet] [money] NULL,
	[DefaultMaxBet] [money] NULL,
	[DefaultMaxPerMatch] [money] NULL,
	[MaxPerBall] [decimal](19, 8) NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].TVP_ReplDep_ProductBetSetting TO [repl_ap] AS [dbo]
GO