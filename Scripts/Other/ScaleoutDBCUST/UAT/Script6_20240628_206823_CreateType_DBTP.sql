/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: Eden@20240628
	Task: Create Type [Redmine: #206823]  
	DB: DBTP-bodb02
*/

USE bodb02
GO
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutCustInfoMini_Dist')
BEGIN
	DROP PROCEDURE Repl_PutCustInfoMini_Dist;
END

IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutCustSubMini_Dist')
BEGIN
	DROP PROCEDURE Repl_PutCustSubMini_Dist;
END

----------------------
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplCustInfoMini' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplCustInfoMini;
END

CREATE TYPE [dbo].TVP_ReplCustInfoMini AS TABLE (
	[CustID] [int] NOT NULL,
	[username] [varchar](30) NULL,
	[username2] [varchar](50) NULL,
	[recommend] [int] NULL,
	[mrecommend] [int] NULL,
	[srecommend] [int] NULL,
	[roleid] [tinyint] NULL,
	[SiteDBGroupID]	[smallint] NULL,
	[RepUpdateTime] [datetime2] NULL,
	[Site] [VARCHAR](10) NULL,	
	[Currency] [int] NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)

GO

IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplCustSubMini' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].TVP_ReplCustSubMini;
END

CREATE TYPE [dbo].TVP_ReplCustSubMini AS TABLE (
	[subaccid] [int] NOT NULL,
	[CustID] [int] NULL,
	[username] [varchar](30) NULL,
	[username2] [varchar](50) NULL,
	[SiteDBGroupID]	[smallint] NULL,
	[RepUpdateTime] [datetime2] NULL,
	[isDeleted] [bit] NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO