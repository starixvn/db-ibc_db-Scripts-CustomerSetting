/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created: 20240424@Johnson
	Task: Add IgnoredCust for job check setting [Redmine: #201044]
	DB: DBCHECK/CheckResultDB
*/ 

USE [CheckResultDB]
GO

INSERT INTO [dbo].[IgnoredCust]
           ([CustID]
           ,[RoleID]
           ,[RuleID]
           ,[Sporttype]
           ,[Bettype]
           ,[AllLine]
           ,[ModifiedDate]
           ,[Remark])
SELECT custid, roleid, 0, 0, 0, 1, GETDATE(), 'Internal Account'
FROM [CheckCustDB].dbo.custinfo WITH(NOLOCK)
WHERE username IN ('SH-EURO','SH-HK$','SH-RM','SH-RMB','SH-RUP','SS-RMB','SS-RM')

