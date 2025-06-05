/*<info serverAlias="DBCUST-CustDB,IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250424@Johnson	
	Task: Upgrade ExchangeID data type for tables setting on DBCUST [redmine:#225013]
	DB: DBCUST-CustDB
*/
--LimitPTDailySetting
ALTER TABLE [dbo].[LimitPTDailySetting] DROP CONSTRAINT [PK_LimitPTDailySetting]
GO

ALTER TABLE [dbo].[LimitPTDailySetting] DROP CONSTRAINT [DF_LimitPTDailySetting_Currency]
GO

ALTER TABLE LimitPTDailySetting ALTER COLUMN Currency SMALLINT NOT NULL WITH(ONLINE = ON)
GO

ALTER TABLE [dbo].[LimitPTDailySetting] ADD  CONSTRAINT [PK_LimitPTDailySetting] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CustID] ASC,
	[Currency] ASC,
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

ALTER TABLE [dbo].[LimitPTDailySetting] ADD  CONSTRAINT [DF_LimitPTDailySetting_Currency]  DEFAULT ((0)) FOR [Currency]
GO

--LimitPTDailySetting_Del_InHouse
IF DB_NAME()= 'CustDB' --run on DBCUST only
BEGIN
    ALTER TABLE LimitPTDailySetting_Del_InHouse ALTER COLUMN Currency SMALLINT NOT NULL WITH(ONLINE = ON)
END 
GO
