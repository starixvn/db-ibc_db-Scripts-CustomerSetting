/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created by: Helios
	Date: 09/18/2025
	Task: Insert IgnoredCust [Redmine:#239288]	
	DB: DBCHECK/CheckResultDB
*/
USE CheckResultDB
GO

INSERT INTO dbo.IgnoredCust (CustID, RoleID, RuleID, Sporttype, Bettype, AllLine, ModifiedDate, Remark)
SELECT custid, ci.roleid, 0, 0, 0, 1, GETDATE(), 'Internal Account'
FROM CheckCustDB.dbo.custInfo ci WITH (NOLOCK)
WHERE ci.username = 'S6RUP' 


