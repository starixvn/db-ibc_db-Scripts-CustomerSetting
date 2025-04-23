/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,DBACC-bodb02"></info>*/
/*
	Created: 20250415@Tacy	
	Task: Alter TVP - In-house on DBTP, Distributor, DBACC
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,DBACC-bodb02
	
	Revisions:
		- 20250415@Tacy: Created [RedmineID: #222339]
*/
IF EXISTS (SELECT 1 FROM RepInfo WITH (NOLOCK)
			WHERE [name]='Dep_ProductBetSetting' AND active=0)
BEGIN
	--Drop sp_put
	IF @@SERVERNAME IN ('DEVDB061','TESTDB061','SITDB06','DB061', 'DB062') -- on DBACC
		DROP PROCEDURE IF EXISTS Repl_PutDep_ProductBetSetting;
	ELSE
		DROP PROCEDURE IF EXISTS Repl_PutDep_ProductBetSetting_Dist;

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