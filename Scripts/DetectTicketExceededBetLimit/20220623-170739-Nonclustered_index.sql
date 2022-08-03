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


CREATE NONCLUSTERED INDEX IX_CustMaxBetSetting			ON [dbo].[CustMaxBetSetting_History]		(UpdateTime ASC)
CREATE NONCLUSTERED INDEX IX_Dep_CustMaxBetSetting		ON [dbo].[Dep_CustMaxBetSetting_History]	(UpdateTime ASC)
CREATE NONCLUSTERED INDEX IX_StakeLevel					ON [dbo].[StakeLevel_History]				(UpdateTime ASC)
CREATE NONCLUSTERED INDEX IX_Dep_StakeLevel				ON [dbo].[Dep_StakeLevel_History]			(UpdateTime ASC)
CREATE NONCLUSTERED INDEX IX_StakeLevelGroupDetail		ON [dbo].[StakeLevelGroupDetail_History]	(UpdateTime ASC)
CREATE NONCLUSTERED INDEX IX_Dep_StakeLevelGroupDetail	ON [dbo].[Dep_StakeLevelGroupDetail_History] (UpdateTime ASC)
GO