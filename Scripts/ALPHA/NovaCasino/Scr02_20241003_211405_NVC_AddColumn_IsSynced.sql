/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20241003
	Task: NovaCasino - Add column IsSynced [Redmine: #211405]
	DB: DBCust-CustDB
*/ 
USE CustDB
GO

ALTER TABLE CustSuper	ADD [IsSynced] [BINARY](2) NULL;
ALTER TABLE CustMaster	ADD [IsSynced] [BINARY](2) NULL;
ALTER TABLE CustAgent	ADD [IsSynced] [BINARY](2) NULL;


--Default value:
ALTER TABLE [dbo].[CustSuper] ADD  CONSTRAINT [DF_CustSuper_IsSynced]  DEFAULT (0x00) FOR [IsSynced]
GO
ALTER TABLE [dbo].[CustMaster] ADD  CONSTRAINT [DF_CustMaster_IsSynced]  DEFAULT (0x00) FOR [IsSynced]
GO
ALTER TABLE [dbo].[CustAgent] ADD  CONSTRAINT [DF_CustAgent_IsSynced]  DEFAULT (0x00) FOR [IsSynced]
GO