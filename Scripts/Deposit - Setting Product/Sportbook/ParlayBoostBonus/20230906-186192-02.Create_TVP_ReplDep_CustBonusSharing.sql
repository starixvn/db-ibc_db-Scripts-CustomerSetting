/*<info serverAlias="DBBOF-bodb02,DBEXT-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20230906@Tacy
	Task: In-House
	DB: DB05x-bodb02,DBTP-bodb02
	
	Revisions:
		- 20230906@Tacy: Integration - Parlay Boost Bonus [RedmineID: #186192]
*/
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