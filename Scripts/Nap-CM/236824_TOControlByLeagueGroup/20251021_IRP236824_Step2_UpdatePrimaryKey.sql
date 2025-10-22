/*<info serverAlias="DBCUST-CustDB,IRS_DBAGE-bodb02"></info>*/
/*
	Created: 20251021@Johnson
	Task: Enhancement - TO Monitor Control By League [Redmine:#236824]	
	DB: DBCUST/CustDB
*/
--drop & re-create primary key constraint
ALTER TABLE [dbo].[TOControl_GlobalSetting] DROP CONSTRAINT [PK_TO_ControlglobalSetting]
GO

ALTER TABLE [dbo].[TOControl_GlobalSetting] ADD  CONSTRAINT [PK_TO_ControlglobalSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[LeagueGroupID] ASC,
	[Sporttype] ASC,    
	[IsGroupHeadLine] ASC,
	[ProfileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
