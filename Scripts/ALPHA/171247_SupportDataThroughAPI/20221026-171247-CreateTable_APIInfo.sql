/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20221026@Tacy
	Task: Create table APIInfo
		 https://nexdev.net/issues/171247 [RedmineID: #171247]
	Database: DBCUST-CustDB
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[APIInfo](
	[KeyID] [int] NOT NULL IDENTITY,
	[CustID] [int] NOT NULL,
	[APIName] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ExpiredDate] [datetime] NULL,
	[ScopeIDList] [varchar](100) NOT NULL,
	[APIKey] [varchar](200) NOT NULL,
	[APISecret] [varchar](200) NOT NULL,
	[Passphrase] [varchar](200) NOT NULL
CONSTRAINT [PK_APIInfo] PRIMARY KEY NONCLUSTERED 
(
	[KeyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

CREATE CLUSTERED	INDEX IX_APIInfo_APIKey ON [dbo].[APIInfo] ([APIKey])
CREATE NONCLUSTERED INDEX IX_APIInfo_CustID ON [dbo].[APIInfo] ([CustID],[APIName])
