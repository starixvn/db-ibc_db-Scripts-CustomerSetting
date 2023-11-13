/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20231002@Winfred
	Task: In-House
	DB: DBTP-bodb02
	
	Revisions:
		- 20231002@Winfred: NAP CM Customer Class - Allow to offer Parlay Boost on rule setting [RedmineID: #190607]
*/
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutCustomerClassUtilityOffer')
BEGIN
	DROP PROCEDURE Repl_PutCustomerClassUtilityOffer;
END

IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplCustomerClassUtilityOffer' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].[TVP_ReplCustomerClassUtilityOffer];
END

CREATE TYPE [dbo].[TVP_ReplCustomerClassUtilityOffer] AS TABLE (
	[PolicyID] [smallint] NOT NULL,
	[PolicyTitle] [varchar](500) NOT NULL,
	[UtilityOffering] [smallint] NOT NULL,
	[IsTest] [TINYINT] NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
	[isDeleted] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassUtilityOffer] TO [repl_ap] AS [dbo]
GO
