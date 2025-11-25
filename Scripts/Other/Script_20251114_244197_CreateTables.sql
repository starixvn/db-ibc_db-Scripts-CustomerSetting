/*<info serverAlias="DBWH-bodb_account"></info>*/
/*      
	Created: 20251023@Eden
	Task: Alpha - Dashboard for Users Online [RedmineID: #244197]
	DB: DBWH-bodb_account
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

USE bodb_account
GO	

--DROP TABLE OnlineAgentDetail;

CREATE TABLE [dbo].OnlineAgentDetail(
	[CreatedDate] [smalldatetime] NOT NULL,
	[SiteId] [int] NOT NULL,
	[RoleId] [tinyint] NOT NULL,
	[UserCount] [int] NOT NULL,
CONSTRAINT [PK_OnlineAgentDetail] PRIMARY KEY CLUSTERED 
(
	[CreatedDate] ASC,
	[SiteId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

---Grant permission for vngrafana
USE [bodb02]
GO
GRANT SELECT ON Site TO vngrafana
GO
GRANT SELECT ON Customer TO vngrafana
GO