/*<info serverAlias="DBCust-CustDB,DBTP-bodb02"></info>*/

/*
	Created: 20220623@Tacy
	Task: https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCust/CustDB, DBTP/bodb02
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER TABLE [dbo].[CustMaxBetSetting_History]			ADD ID INT IDENTITY
ALTER TABLE [dbo].[Dep_CustMaxBetSetting_History]		ADD ID INT IDENTITY
ALTER TABLE [dbo].[StakeLevel_History]					ADD ID INT IDENTITY
ALTER TABLE [dbo].[Dep_StakeLevel_History]				ADD ID INT IDENTITY
ALTER TABLE [dbo].[StakeLevelGroupDetail_History]		ADD ID INT IDENTITY
ALTER TABLE [dbo].[Dep_StakeLevelGroupDetail_History]	ADD ID INT IDENTITY
GO