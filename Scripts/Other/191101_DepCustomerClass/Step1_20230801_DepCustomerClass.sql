/*<info serverAlias="DBCUST-CustDB"></info>*/
--USE CustDB
--GO
/*
	Created: 20230802@Winfred
	DB: DBCUST/CustDB, DBACC-bodb02 and add pub CustDB_CustSetting
	Task:  Create table Dep customer class
	Revisions:
		- 20230802@Winfred:  LAP - Player Segmentation - Add Risk Level's last update time [RedmineID: #191101]
*/
--DROP TABLE [dbo].[Dep_CustomerClass]

CREATE TABLE [dbo].[Dep_CustomerClass](
	[CustID] [int] NOT NULL,
	[CustomerClass] [smallint]  NOT NULL,
	[CategoryID] [smallint] NULL,
	[ModifiedDate] [datetime] NULL,
	[OldCustomerClass] [smallint] NULL,
 CONSTRAINT [PK_Dep_CustomerClass] PRIMARY KEY 
(
	[CustID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [CIX_Dep_CustomerClass] ON [dbo].[Dep_CustomerClass] 
(
	[ModifiedDate] ASC,
	[CustID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO