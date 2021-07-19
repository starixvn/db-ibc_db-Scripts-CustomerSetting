/*
	Created: 20200728@Elodie
	DB: DBCHECK/CheckResultDB
	Task: Insert IgnoredCust
*/
USE CheckResultDB
GO

INSERT INTO dbo.IgnoredCust (CustID, RoleID, RuleID, Sporttype, Bettype, AllLine, ModifiedDate, Remark)
SELECT custid, ci.roleid, 0, 0, 0, 0, GETDATE(), 'Ignore Account'
FROM CheckCustDB.dbo.custInfo ci WITH (NOLOCK)
WHERE ci.custid IN (44394487,
					44394488,
					44394489,
					44394490,
					44394491,
					44394492,
					44394493,
					44394494,
					44394495,
					44394496,
					44394497,
					44394498,
					44394499,
					44394500,
					44394501,
					44394502,
					44394503,
					44394513,
					44394514,
					44394521,
					44394537,
					44394540,
					44394541,
					44394542,
					44394543,
					44394544,
					44394596,
					44394597,
					44394598,
					44394599,
					44394602,
					44394603,
					44394604,
					44394605,
					44394619,
					44394620,
					44394636,
					44394637,
					44394638,
					44394639)