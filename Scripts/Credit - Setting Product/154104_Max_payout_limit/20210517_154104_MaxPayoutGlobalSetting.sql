/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210513@Winfred
	Task : Create table MaxPayoutGlobalSetting [Redmine:#154104]
	DB:  DBCUST/CustDB 
	Replication : add to CustDB_Custsetting publication
*/
USE CustDB
GO

CREATE TABLE [dbo].[MaxPayoutGlobalSetting](
	[SportType] [int] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[SingleMatchParlay] [money] NOT NULL ,
	[Combo2] [money] NOT NULL ,
	[Combo35] [money] NOT NULL ,
	[ComboOver6] [money] NOT NULL ,
	[SettingStatus] [tinyint] NOT NULL ,
 CONSTRAINT [PK_MaxPayoutGlobalSetting] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[BetType] ASC,
	[Currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_SingleMatchParlay]  DEFAULT ((0)) FOR [SingleMatchParlay]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_Combo2]  DEFAULT ((0)) FOR [Combo2]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_Combo35]  DEFAULT ((0)) FOR [Combo35]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_ComboOver6]  DEFAULT ((0)) FOR [ComboOver6]
GO
ALTER TABLE [dbo].[MaxPayoutGlobalSetting] ADD  CONSTRAINT [DF_MaxPayoutGlobalSetting_SettingStatus]  DEFAULT ((0)) FOR [SettingStatus]
GO