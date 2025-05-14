/*<info serverAlias="DBCUST-CustDB,DBAGE-bodb02,DBACC-bodb02"></info>*/
/*
	Created by: Tacy@20241220
	Task: Create new table - Dep_CustSabaInfo [Redmine:#215807] 
	DB:	DBCUST-CustDB,DBAGE-bodb02,DBACC-bodb02

	Revision:
		- 20250217@Tacy: create Clutered idx for [Dep_CustSabaInfo_Del_InHouse]
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--[Dep_CustSabaInfo]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dep_CustSabaInfo](
	[CustID] [int] NOT NULL,
	[CustType] [tinyint] NOT NULL,
	[SabaID] [bigint] NOT NULL,
	[RepUpdateTime] [datetime2](7) NULL,
 CONSTRAINT [PK_Dep_CustSabaInfo] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

--Default value
ALTER TABLE [dbo].[Dep_CustSabaInfo] ADD  CONSTRAINT [DF_Dep_CustSabaInfo_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_Dep_CustSabaInfo_RepUpdateTime] ON [dbo].[Dep_CustSabaInfo]
(
	[RepUpdateTime] ASC
)
GO

CREATE NONCLUSTERED INDEX [IX_Dep_CustSabaInfo_SabaID] ON [dbo].[Dep_CustSabaInfo]
(
	[SabaID] ASC
)
GO

----------------------------------------------------------------------------------------------------------------
--[Dep_CustSabaInfo_Del_InHouse]
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
BEGIN
	CREATE TABLE [dbo].[Dep_CustSabaInfo_Del_InHouse](
		[CustID] [int] NOT NULL,
		[RepUpdateTime] [datetime2](7) NOT NULL
	) ON [DATA]

	--CREATE INDEX
	CREATE CLUSTERED INDEX [CIX_Dep_CustSabaInfo_Del_InHouse_RepUpdateTime] ON [dbo].[Dep_CustSabaInfo_Del_InHouse]
	(
		[RepUpdateTime] ASC
	)
END
GO