/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20231002@Winfred
	Task: In-House
	DB: DBTP-bodb02
	
	Revisions:
		- 20231002@Winfred: NAP CM Customer Class - Allow to offer Parlay Boost on rule setting [RedmineID: #190607]
*/
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutCustomerClassUtilityOfferDetail')
BEGIN
	DROP PROCEDURE Repl_PutCustomerClassUtilityOfferDetail;
END

IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplCustomerClassUtilityOfferDetail' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].[TVP_ReplCustomerClassUtilityOfferDetail];
END

CREATE TYPE [dbo].[TVP_ReplCustomerClassUtilityOfferDetail] AS TABLE (
	[PolicyID] [smallint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[CustomerClass] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassUtilityOfferDetail] TO [repl_ap] AS [dbo]
GO
