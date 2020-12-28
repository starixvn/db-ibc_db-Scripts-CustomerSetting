/*<info serverAlias="DBCheck-CheckResultDB"></info>*/
/*
	Created: Winfred
	Date: 20201202
	Task:  Ignore Account member  [RedmineID:#147480]
	DB: DBCheck/CheckResultDB
*/
USE CheckResultDB
GO

CREATE TABLE #temp (custid INT)
INSERT INTO #temp (custid)
VALUES  (47218617),(47218640),(47218690)


DELETE m FROM Dep_LicenseeProductSetting m WITH (ROWLOCK) 	
	INNER JOIN custInfo ci WITH (NOLOCK) ON ci.custid = m.custid	
	INNER JOIN #temp t ON m.custid = t.custid
WHERE ci.roleid =  4 AND m.ProductSettingID = 28


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
