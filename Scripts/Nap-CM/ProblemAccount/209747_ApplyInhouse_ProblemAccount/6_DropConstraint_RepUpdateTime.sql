/*<info serverAlias="DBCust-CustDB,DBACC-bodb02,DBTP-bodb02,DBAGE-bodb02,DBLOG-bodb02"></info>*/
/*
	Created: Helios
	Date: 31/12/2024 2:24:04 
	Task: Scale Out DBCUST - Apply Inhouse replication for tables of problem account - DROP CONSTRAINT RepUpdateTime [Redmine: #209747]   
	DB: DBCust-CustDB

	ProblemAccount
      ProblemAccountAction
      ProblemAccountClassification
      ProblemAccountLimitDownline
      ProblemAccountReason
*/

IF EXISTS (SELECT 5 FROM sys.all_objects ao WITH (NOLOCK)  WHERE ao.name IN ('DF_ProblemAccount_RepUpdateTime','DF_ProblemAccountAction_RepUpdateTime','DF_ProblemAccountClassification_RepUpdateTime','DF_ProblemAccountLimitDownline_RepUpdateTime','DF_ProblemAccountReason_RepUpdateTime'))
BEGIN
	ALTER TABLE [dbo].[ProblemAccount]				DROP CONSTRAINT [DF_ProblemAccount_RepUpdateTime]
	ALTER TABLE [dbo].[ProblemAccountAction]			DROP CONSTRAINT [DF_ProblemAccountAction_RepUpdateTime]
	ALTER TABLE [dbo].[ProblemAccountClassification]	DROP CONSTRAINT [DF_ProblemAccountClassification_RepUpdateTime]
	ALTER TABLE [dbo].[ProblemAccountLimitDownline]		DROP CONSTRAINT [DF_ProblemAccountLimitDownline_RepUpdateTime]
	ALTER TABLE [dbo].[ProblemAccountReason]			DROP CONSTRAINT [DF_ProblemAccountReason_RepUpdateTime]
END


--SELECT * FROM sys.all_objects ao WHERE ao.name  IN ('DF_ProblemAccount_RepUpdateTime','DF_ProblemAccountAction_RepUpdateTime','DF_ProblemAccountClassification_RepUpdateTime','DF_ProblemAccountLimitDownline_RepUpdateTime','DF_ProblemAccountReason_RepUpdateTime')