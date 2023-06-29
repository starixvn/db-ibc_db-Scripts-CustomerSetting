/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: Helios
	Date: 22/06/2023
	Task: Insert IgnoredCust [Redmine:#189799]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

INSERT INTO dbo.IgnoredCust (CustID, RoleID, RuleID, Sporttype, Bettype, AllLine, ModifiedDate, Remark)
SELECT custid, ci.roleid, 0, 0, 0, 1, GETDATE(), 'Internal testing'
FROM CheckCustDB.dbo.custInfo ci WITH (NOLOCK)
WHERE ci.username = 'StarixSCYEN'

INSERT INTO dbo.IgnoredCust (CustID, RoleID, RuleID, Sporttype, Bettype, AllLine, ModifiedDate, Remark)
SELECT custid, ci.roleid, 0, 0, 0, 1, GETDATE(), 'Internal Account'
FROM CheckCustDB.dbo.custInfo ci WITH (NOLOCK)
WHERE ci.username IN ('S52RMB','M16RMB')



