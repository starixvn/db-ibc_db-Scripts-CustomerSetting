/*<info serverAlias="IRS_DBACC-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250424@Johnson	
	Task: Upgrade ExchangeID data type for tables setting on DBGLOB [redmine:#225013]
	DB: IRS_DBACC-bodb02,DBCustRepl-ReplCustDB
*/

--------------------------------------------------------------------------------------
--table ProductBetSetting
ALTER TABLE [dbo].[ProductBetSetting] DROP CONSTRAINT [PK_ProductBetSetting]
GO

ALTER TABLE ProductBetSetting ALTER COLUMN Currency SMALLINT NOT NULL WITH(ONLINE = ON)
GO

ALTER TABLE [dbo].[ProductBetSetting] ADD  CONSTRAINT [PK_ProductBetSetting] PRIMARY KEY CLUSTERED 
(
	[Sporttype] ASC,
	[Bettype] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

--------------------------------------------------------------------------------------