/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20231212@Johnson
	Task: Lite Mode - Separate PT for Live & RNG Casino products group - All Credits Except 789y [redmine : #197629]
	DB: DBCUST/CUSTDB
*/

DELETE t1
FROM CustPTTemplateDetail t1 WITH(ROWLOCK)
	INNER JOIN CustPTTemplate t WITH(NOLOCK) ON t.TemplateID = t1.TemplateID
	INNER JOIN customer ci WITH(NOLOCK) ON t.custid = ci.custid
WHERE 	GroupID = 3
	AND SubGroupID = 5
	AND ci.site IN (SELECT site FROM site (NOLOCK) WHERE SiteLabel = '789y')
	AND currency = 20