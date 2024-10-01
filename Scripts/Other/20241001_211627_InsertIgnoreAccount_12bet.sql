/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: Tacy@20241001
	Task: Insert IgnoredCust [Redmine:#211627]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

INSERT INTO dbo.IgnoredCust (CustID, RoleID, RuleID, Sporttype, Bettype, AllLine, ModifiedDate, Remark)
SELECT custid, ci.roleid, 0, 0, 0, 0, GETDATE(), 'Ignore Account'
FROM CheckCustDB.dbo.custInfo ci WITH (NOLOCK)
WHERE ci.custid IN (94768219, 94768220)
GO