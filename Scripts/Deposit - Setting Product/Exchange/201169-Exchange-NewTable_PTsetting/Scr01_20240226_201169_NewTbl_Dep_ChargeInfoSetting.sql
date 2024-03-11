/*<info serverAlias="DBCUST-CustDB, DBTP-bodb02, DBAGE-bodb02, DBTXN-CustDB"></info>*/
/*
	Created: Tacy@20240226
	Task: Create new table Dep_ChargeInfoSetting [redmine: #201169]
	DB: DBCUST-CustDB, DBTP-bodb02, DBAGE-bodb02, DBTXN-CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dep_ChargeInfoSetting](
	[ChargeId] [int] IDENTITY (1,1) NOT FOR REPLICATION NOT NULL,
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[PT] [smallmoney] NOT NULL,
	[FromDate] [date] NOT NULL,
	[ToDate] [date] NOT NULL,
	[RepUpdateTime] [datetime2](7) NOT NULL,
	[isDeleted] [bit] NOT NULL,

 CONSTRAINT [PK_Dep_ChargeInfoSetting] PRIMARY KEY NONCLUSTERED
(
	[ChargeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]

, CONSTRAINT [IX_Dep_ChargeInfoSetting] UNIQUE CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[FromDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]


) ON [DATA]
GO

ALTER TABLE [dbo].[Dep_ChargeInfoSetting] ADD  CONSTRAINT [DF_Dep_ChargeInfoSetting_FromDate]  DEFAULT (CAST(GETDATE() AS DATE)) FOR [FromDate]
GO

ALTER TABLE [dbo].[Dep_ChargeInfoSetting] ADD  CONSTRAINT [DF_Dep_ChargeInfoSetting_ToDate]  DEFAULT ('9999/12/31') FOR [ToDate]
GO

ALTER TABLE [dbo].[Dep_ChargeInfoSetting] ADD  CONSTRAINT [DF_Dep_ChargeInfoSetting_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO

ALTER TABLE [dbo].[Dep_ChargeInfoSetting] ADD  CONSTRAINT [DF_Dep_ChargeInfoSetting_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

--CREATE INDEX
CREATE NONCLUSTERED INDEX [IX_Dep_ChargeInfoSetting_RepUpdateTime] ON [dbo].[Dep_ChargeInfoSetting]
(
	[RepUpdateTime] ASC
)
GO
