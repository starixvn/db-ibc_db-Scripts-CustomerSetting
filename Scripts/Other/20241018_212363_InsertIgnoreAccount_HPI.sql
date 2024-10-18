/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: Tacy@20241018
	Task: Insert IgnoredCust [Redmine:#212363]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

INSERT INTO dbo.IgnoredCust (CustID, RoleID, RuleID, Sporttype, Bettype, AllLine, ModifiedDate, Remark)
SELECT custid, ci.roleid, 0, 0, 0, 1, GETDATE(), 'Ignore Account'
FROM CheckCustDB.dbo.custInfo ci WITH (NOLOCK)
WHERE ci.custid IN (5215598)
GO