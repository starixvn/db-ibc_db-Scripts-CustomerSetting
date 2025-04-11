/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20250411@Helios
	Task: Prepare script for quick check: list out direct member real currency, check their customer setting... [Redmine: #213267]
	Database:	DBCUST-CustDB
	Clone From DBA_CheckComm_DCS
*/

SELECT custid FROM Customer WITH (NOLOCK) WHERE username  ='8UF91921995'

SELECT MAX(c.custid)
FROM custInfo c WITH (NOLOCK)
WHERE c.recommend IN (-3,-4)
AND c.roleid = 1
AND c.currency  NOT IN (20,27,28)
AND c.Enabled = 1
