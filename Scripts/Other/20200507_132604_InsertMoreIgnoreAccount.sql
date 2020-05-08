/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created: 20200507@Elodie
	DB: DBCHECK/CheckResultDB
	Task: Insert IgnoredCust
*/
USE CheckResultDB
GO

INSERT INTO dbo.IgnoredCust (CustID, RoleID, RuleID, Sporttype, Bettype, AllLine, ModifiedDate, Remark)
SELECT custid, ci.roleid, 0, 0, 0, 1, GETDATE(), 'Inactive Account'
FROM CheckCustDB.dbo.custInfo ci WITH (NOLOCK)
WHERE ci.custid IN (29572535)