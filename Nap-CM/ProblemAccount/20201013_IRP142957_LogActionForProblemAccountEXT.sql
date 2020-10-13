/*
	Created: 20201013@Johnson
	Task: EXT - Log Action Problem Account for headlines
	DB: DBLOG/bodb_CustomerLog
*/


USE bodb_CustomerLog
GO
INSERT INTO [bodb_CustomerLog].[dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]           
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT 31634,6,'EAS_ProblemAccount_ReviewStatusUpd',N'Set to Reviewed Status for Master',N'Set to Reviewed Status for Master',N'Set to Reviewed Status for Master',N'Set to Reviewed Status for Master',N'Set to Reviewed Status for Master',N'Set to Reviewed Status for Master',N'Set to Reviewed Status for Master',1,N'Set to Reviewed Status for Master',N'Set to Reviewed Status for Master'
UNION ALL SELECT 31635,6,'EAS_ProblemAccount_ReviewStatusUpd',N'Set to Reviewed Status for Agent',N'Set to Reviewed Status for Agent',N'Set to Reviewed Status for Agent',N'Set to Reviewed Status for Agent',N'Set to Reviewed Status for Agent',N'Set to Reviewed Status for Agent',N'Set to Reviewed Status for Agent',1,N'Set to Reviewed Status for Agent',N'Set to Reviewed Status for Agent'
UNION ALL SELECT 31636,6,'EAS_ProblemAccount_ReviewStatusUpd',N'Set to Reviewed Status for Member',N'Set to Reviewed Status for Member',N'Set to Reviewed Status for Member',N'Set to Reviewed Status for Member',N'Set to Reviewed Status for Member',N'Set to Reviewed Status for Member',N'Set to Reviewed Status for Member',1,N'Set to Reviewed Status for Member',N'Set to Reviewed Status for Member'
