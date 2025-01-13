/*<info serverAlias="DBCUST-CustDB,DBCustRepl-ReplCustDB,DBTP-bodb02,DBACC-bodb02"></info>*/
/*
	Created by: 20250113@Tacy
	Task: Tables BetSetting_xxx - Add column [LeagueID] [Redmine:#216609] 
	DB:	DBCUST-CustDB,DBCustRepl-ReplCustDB,DBTP-bodb02,DBACC-bodb02
*/
----------------------------------------------------------------------
----------------------------------------------------------------------
--BetSetting_Agent
ALTER TABLE [dbo].[BetSetting_Agent] ADD [LeagueID] [INT] NOT NULL DEFAULT (0)
GO

-- Fix constraint name
DECLARE @__Constraint VARCHAR(50), @SQL nvarchar(1000)

SELECT 
	@__Constraint=default_constraints.name
FROM sys.all_columns
	INNER JOIN sys.tables
        ON all_columns.object_id = tables.object_id
	INNER JOIN  sys.schemas
        ON tables.schema_id = schemas.schema_id
	INNER JOIN sys.default_constraints
        ON all_columns.default_object_id = default_constraints.object_id
WHERE 
        schemas.name = 'dbo'
    AND tables.name = 'BetSetting_Agent'
    AND all_columns.name = 'LeagueID'

SET @SQL = 'ALTER TABLE [dbo].[BetSetting_Agent] DROP CONSTRAINT ' + @__Constraint 

EXEC (@SQL)

ALTER TABLE [dbo].[BetSetting_Agent] ADD  CONSTRAINT [DF_BetSetting_Agent_LeagueID]  DEFAULT ((0)) FOR [LeagueID]
GO

----------------------------------------------------------------------
----------------------------------------------------------------------
--BetSetting_Member
ALTER TABLE [dbo].[BetSetting_Member] ADD [LeagueID] [INT] NOT NULL DEFAULT (0)
GO

-- Fix constraint name
DECLARE @__Constraint VARCHAR(50), @SQL nvarchar(1000)

SELECT 
	@__Constraint=default_constraints.name
FROM sys.all_columns
	INNER JOIN sys.tables
        ON all_columns.object_id = tables.object_id
	INNER JOIN  sys.schemas
        ON tables.schema_id = schemas.schema_id
	INNER JOIN sys.default_constraints
        ON all_columns.default_object_id = default_constraints.object_id
WHERE 
        schemas.name = 'dbo'
    AND tables.name = 'BetSetting_Member'
    AND all_columns.name = 'LeagueID'

SET @SQL = 'ALTER TABLE [dbo].[BetSetting_Member] DROP CONSTRAINT ' + @__Constraint 

EXEC (@SQL)

ALTER TABLE [dbo].[BetSetting_Member] ADD  CONSTRAINT [DF_BetSetting_Member_LeagueID]  DEFAULT ((0)) FOR [LeagueID]
GO