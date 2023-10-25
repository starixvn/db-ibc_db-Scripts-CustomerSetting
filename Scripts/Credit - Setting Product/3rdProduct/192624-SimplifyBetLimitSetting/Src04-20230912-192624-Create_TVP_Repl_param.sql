/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20230912@Tacy
	Task: In-House (https://nexdev.net/issues/192624)
	DB: DBACC-bodb02, DBTP-bodb02
	
	Revisions:
		- 20230906@Tacy: 3rd Products - Simplify RNG Games bet limit setting [RedmineID: #192624]
*/

-- ProductStakeLevelGroup
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplProductStakeLevelGroup' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].[TVP_ReplProductStakeLevelGroup];
END

CREATE TYPE [dbo].[TVP_ReplProductStakeLevelGroup] AS TABLE (
	[Sporttype] [smallint] NOT NULL,
	[GameGroupID] [tinyint] NOT NULL,
	[MinBet] [money] NOT NULL,
	[MaxBet] [money] NOT NULL,
	[CreditGroupID] [tinyint] NOT NULL,
	[Remark] [varchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplProductStakeLevelGroup] TO [repl_ap] AS [dbo]
GO

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Dep_ProductStakeLevelGroup
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_ProductStakeLevelGroup' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].[TVP_ReplDep_ProductStakeLevelGroup];
END

CREATE TYPE [dbo].[TVP_ReplDep_ProductStakeLevelGroup] AS TABLE (
	[Sporttype] [smallint] NOT NULL,
	[GameGroupID] [tinyint] NOT NULL,
	[MinBet] [money] NOT NULL,
	[MaxBet] [money] NOT NULL,
	[LicenseeGroupID] [tinyint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Remark] [varchar](1000) NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplDep_ProductStakeLevelGroup] TO [repl_ap] AS [dbo]
GO
