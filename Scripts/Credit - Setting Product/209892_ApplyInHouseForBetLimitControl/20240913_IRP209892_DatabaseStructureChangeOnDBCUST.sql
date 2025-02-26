/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240913@Johnson
	Task: Database structure change on DBCUST for Bet Limit Control [redmine: #209892]
	DB: DBCUST/CUSTDB	
*/ 
---------------------------------------------
--BetLimitControlCustSetting_Del_InHouse

CREATE TABLE [dbo].[BetLimitControlCustSetting_Del_InHouse](
	[CustID] [int] NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]

GO

ALTER TABLE [dbo].[BetLimitControlCustSetting_Del_InHouse] ADD  CONSTRAINT [DF_BetLimitControlCustSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_BetLimitControlCustSetting_Del_InHouse_RepUpdateTime] ON [dbo].[BetLimitControlCustSetting_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

---------------------------------------------
--BetLimitControlDefaultSetting
CREATE TABLE [dbo].[BetLimitControlDefaultSetting_Del_InHouse](
	[CustID] [int] NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]

GO

ALTER TABLE [dbo].[BetLimitControlDefaultSetting_Del_InHouse] ADD  CONSTRAINT [DF_BetLimitControlDefaultSetting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_BetLimitControlDefaultSetting_Del_InHouse_RepUpdateTime] ON [dbo].[BetLimitControlDefaultSetting_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

---------------------------------------------
--BetLimitControlProduct_Del_InHouse
CREATE TABLE [dbo].[BetLimitControlProduct_Del_InHouse](
	[ProductID] [int] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]

GO

ALTER TABLE [dbo].[BetLimitControlProduct_Del_InHouse] ADD  CONSTRAINT [DF_BetLimitControlProduct_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_BetLimitControlProduct_Del_InHouse_RepUpdateTime] ON [dbo].[BetLimitControlProduct_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

---------------------------------------------
--BetLimitControlType
CREATE TABLE [dbo].[BetLimitControlType_Del_InHouse](
	[BetLimitTypeID] [int] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]

GO

ALTER TABLE [dbo].[BetLimitControlType_Del_InHouse] ADD  CONSTRAINT [DF_BetLimitControlType_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_BetLimitControlType_Del_InHouse_RepUpdateTime] ON [dbo].[BetLimitControlType_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

---------------------------------------------
--BetLimitControlTypeDetails
CREATE TABLE [dbo].[BetLimitControlTypeDetails_Del_InHouse](
	[ID] [int] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NULL
) ON [DATA]

GO	

ALTER TABLE [dbo].[BetLimitControlTypeDetails_Del_InHouse] ADD  CONSTRAINT [DF_BetLimitControlTypeDetails_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_BetLimitControlTypeDetails_Del_InHouse_RepUpdateTime] ON [dbo].[BetLimitControlTypeDetails_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

---------------------------------------------
--BetRestriction_Currency_Del_InHouse
CREATE TABLE [dbo].[BetRestriction_Currency_Del_InHouse](
	[ExchangeID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[SportType] [smallint] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NULL
) ON DATA 
GO

ALTER TABLE [dbo].[BetRestriction_Currency_Del_InHouse] ADD  CONSTRAINT [DF_BetRestriction_Currency_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_BetRestriction_Currency_Del_InHouse_RepUpdateTime] ON [dbo].[BetRestriction_Currency_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO	

---------------------------------------------
--BetRestriction_Customer_Del_InHouse
CREATE TABLE [dbo].[BetRestriction_Customer_Del_InHouse](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NULL
) ON DATA
GO

ALTER TABLE [dbo].[BetRestriction_Customer_Del_InHouse] ADD  CONSTRAINT [DF_BetRestriction_Customer_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_BetRestriction_Customer_Del_InHouse_RepUpdateTime] ON [dbo].[BetRestriction_Customer_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

---------------------------------------------
--BetRestriction_Setting_Del_InHouse
CREATE TABLE [dbo].[BetRestriction_Setting_Del_InHouse](
	[SettingID] [smallint] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NULL
) ON DATA
GO

ALTER TABLE [dbo].[BetRestriction_Setting_Del_InHouse] ADD  CONSTRAINT [DF_BetRestriction_Setting_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_BetRestriction_Setting_Del_InHouse_RepUpdateTime] ON [dbo].[BetRestriction_Setting_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO
	
---------------------------------------------
--BetRestriction_Site_Del_InHouse
CREATE TABLE [dbo].[BetRestriction_Site_Del_InHouse](
	[SiteID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,	
	[RepUpdateTime] [datetime2](7) NULL
) ON DATA
GO

ALTER TABLE [dbo].[BetRestriction_Site_Del_InHouse] ADD  CONSTRAINT [DF_BetRestriction_Site_Del_InHouse_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

CREATE CLUSTERED INDEX [CIX_BetRestriction_Site_Del_InHouse_RepUpdateTime] ON [dbo].[BetRestriction_Site_Del_InHouse]
(
	[RepUpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO	
