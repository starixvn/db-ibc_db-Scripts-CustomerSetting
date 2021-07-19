/*
	Created: 20210222@Johnson
	Task: add new log action for problem account limit downline[redmine:#149477]
	DB: DBLOG/bodb_CustomerLog
*/

INSERT INTO [dbo].[LogAction]
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
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI]
           ,[ActionNameCN])
SELECT 31637,6,'Nap_ProblemAccountLimitDownlineIns',N'Enable Limit New Downline Per Day',N'Enable Limit New Downline Per Day',N'Enable Limit New Downline Per Day',N'Enable Limit New Downline Per Day',N'Enable Limit New Downline Per Day',N'Enable Limit New Downline Per Day',N'Enable Limit New Downline Per Day',NULL,1,N'Enable Limit New Downline Per Day',N'Enable Limit New Downline Per Day'
UNION SELECT 31638,6,'Nap_ProblemAccountLimitDownlineDel',N'Disable Limit New Downline Per Day',N'Disable Limit New Downline Per Day',N'Disable Limit New Downline Per Day',N'Disable Limit New Downline Per Day',N'Disable Limit New Downline Per Day',N'Disable Limit New Downline Per Day',N'Disable Limit New Downline Per Day',NULL,1,N'Disable Limit New Downline Per Day',N'Disable Limit New Downline Per Day'
