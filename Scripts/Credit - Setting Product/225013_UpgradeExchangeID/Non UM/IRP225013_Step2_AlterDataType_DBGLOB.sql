/*<info serverAlias="DBGLOB-GlobCustDB,IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250424@Johnson	
	Task: Upgrade ExchangeID data type for tables setting on DBGLOB [redmine:#225013]
	DB: DBGLOB-GlobCustDB,IRS_DBTP-bodb02
*/

--------------------------------------------------------------------------------------
--table MaxPayoutGlobalSetting
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] DROP CONSTRAINT [PK_MaxPayoutGlobalSetting]
GO

ALTER TABLE MaxPayoutGlobalSetting ALTER COLUMN Currency SMALLINT NOT NULL WITH(ONLINE = ON)
GO

ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [PK_MaxPayoutGlobalSetting] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[BetType] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

--table MaxPayoutGlobalSetting_Del_InHouse
IF DB_NAME()= 'GlobCustDB'-- run on DBGLOB only
BEGIN
    ALTER TABLE [dbo].[MaxPayoutGlobalSetting_Del_InHouse]  ALTER COLUMN Currency SMALLINT NOT NULL WITH(ONLINE = ON)
END
GO

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

--table ProductBetSetting_Del_InHouse
IF DB_NAME()= 'GlobCustDB' -- run on DBGLOB only
BEGIN   
    ALTER TABLE [dbo].[ProductBetSetting_Del_InHouse]  ALTER COLUMN Currency SMALLINT NOT NULL WITH(ONLINE = ON)
END
GO
--------------------------------------------------------------------------------------