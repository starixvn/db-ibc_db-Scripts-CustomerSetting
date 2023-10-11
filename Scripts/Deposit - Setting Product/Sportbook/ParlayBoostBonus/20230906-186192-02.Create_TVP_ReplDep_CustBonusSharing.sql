/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20230906@Tacy
	Task: In-House
	DB: DBTP-bodb02
	
	Revisions:
		- 20230906@Tacy: Integration - Parlay Boost Bonus [RedmineID: #186192]
*/
--CHECK IF: ADD NEW COLUMN INTO EXISTED TABLE
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutDep_CustBonusSharing')
AND EXISTS (SELECT 1 FROM RepInfo WITH (NOLOCK)
			WHERE [name]='Dep_CustBonusSharing' AND active=0)
BEGIN
	DROP PROCEDURE Repl_PutDep_CustBonusSharing;
END

IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustBonusSharing' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].[TVP_ReplDep_CustBonusSharing];
END

CREATE TYPE [dbo].[TVP_ReplDep_CustBonusSharing] AS TABLE (
	[CustID] [int] NOT NULL,
	[BonusSharingRate] [money] NOT NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplDep_CustBonusSharing] TO [repl_ap] AS [dbo]
GO