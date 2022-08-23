/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220823@Tacy
	Task: Update Danger's BA member follow upline [redmine:#176518]
	DB: DBCust/CustDB
*/

UPDATE ci
SET ci.danger=ag.danger
FROM custInfo ci WITH (UPDLOCK, ROWLOCK)
	INNER JOIN Dep_CustBAActive ba WITH (NOLOCK) ON ba.CustId=ci.custid
	INNER JOIN custInfo ag WITH (NOLOCK) ON ag.custid=ci.recommend
