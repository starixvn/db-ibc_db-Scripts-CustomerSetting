/*<info serverAlias="DBTP-bodb02,DBACC-bodb02"></info>*/
/*
	Created by: Tacy@20231018
	Task: in-house [Redmine:#194024] 
	DB:	DBTP-bodb02,DBACC-bodb02
*/
--CHECK IF: ADD NEW COLUMN INTO EXISTED TABLE
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutDomainManagement')
AND EXISTS (SELECT 1 FROM RepInfo WITH (NOLOCK)
			WHERE [name]='DomainManagement' AND active=0)
BEGIN
	DROP PROCEDURE Repl_PutDomainManagement;

	IF EXISTS(SELECT 1 FROM sys.types 
			  WHERE name = 'TVP_ReplDomainManagement' 
			  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
	BEGIN
		DROP TYPE [dbo].[TVP_ReplDomainManagement];
	END
END

CREATE TYPE [dbo].[TVP_ReplDomainManagement] AS TABLE (
	[DomainID] [smallint] NOT NULL,
	[Domain] [varchar](50) NOT NULL,
	[System] [varchar](20) NOT NULL,
	[Site] [varchar](500) NOT NULL,
	[BrandName] [varchar](10) NULL,
	[Status] [tinyint] NOT NULL,
	[ExpiredDate] [datetime] NULL,
	[LastUpdateTime] [datetime] NOT NULL,
	[RestrictedCountries] [varchar](4000) NULL,
	[Remark] [nvarchar](2000) NULL,
	[isDeleted] [bit] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[_FetchedTime] [datetime2](7) NULL
)
GO

GRANT EXECUTE ON TYPE::[dbo].[TVP_ReplDomainManagement] TO [repl_ap] AS [dbo]
GO

--Grant permission to set IDENTITY_INSERT on/off
GRANT ALTER ON [dbo].[DomainManagement] TO [repl_ap];
GO