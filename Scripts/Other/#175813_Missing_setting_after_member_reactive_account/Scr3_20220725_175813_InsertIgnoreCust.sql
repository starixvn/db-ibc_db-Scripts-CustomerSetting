/*<info serverAlias="DBCheck-CheckResultDB"></info>*/
/*
	Created: Eden@20220725
	Task:  Ignore Account member  [RedmineID:#175813]
	DB: DBCheck/CheckResultDB
*/
USE CheckResultDB
GO

CREATE TABLE #temp (custid INT)
INSERT INTO #temp (custid)
VALUES  (66263270),(66263271),(66263379)

INSERT INTO [dbo].[IgnoredCust]
           ([CustID]
           ,[RoleID]
           ,[RuleID]
           ,[Sporttype]
           ,[Bettype]
           ,[AllLine]
           ,[ModifiedDate]
           ,[Remark])
SELECT CustID
           ,1
           ,0
           ,0
           ,0
           ,0
           ,GETDATE()
           ,'Ignore Account'
FROM #temp
