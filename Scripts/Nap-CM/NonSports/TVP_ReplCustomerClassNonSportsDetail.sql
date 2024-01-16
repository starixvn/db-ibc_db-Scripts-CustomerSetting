/*<info serverAlias="DBTP-bodb02"></info>*/

/*
     Created:  20231002@Winfred
     Task : In-House
     DB: DBTP-bodb02

     Revisions:
          - 20231002@Winfred: NAP CM Customer Class - Support for Non-Sports [RedmineID: #186116] 
*/
IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'Repl_PutCustomerClassNonSportsDetail')
BEGIN
     DROP PROCEDURE [dbo].[Repl_PutCustomerClassNonSportsDetail]
END

IF EXISTS(SELECT 1 FROM sys.types WHERE is_table_type = 1 AND schema_id = SCHEMA_ID('dbo') AND name = 'TVP_ReplCustomerClassNonSportsDetail')
BEGIN
     DROP TYPE [dbo].[TVP_ReplCustomerClassNonSportsDetail]
END

CREATE TYPE [dbo].[TVP_ReplCustomerClassNonSportsDetail] AS TABLE (
       [PolicyID] [int] NOT NULL,
          [SiteID] [int] NOT NULL,
          [CustomerClass] [smallint] NOT NULL,
          [RepUpdateTime] [datetime2](7) NOT NULL,
          [isDeleted] [bit] NOT NULL,
          [_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplCustomerClassNonSportsDetail] TO [repl_ap] AS [dbo]
GO