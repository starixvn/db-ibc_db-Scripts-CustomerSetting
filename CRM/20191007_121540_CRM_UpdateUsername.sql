/*
	Created: 20191007@Winnie
	DB: DBCRM/bodb_CRM
	Task: CRM - Create multiple logs got inconsistency between username and custid [#121540]
*/


UPDATE cr
	SET cr.UserName=c.username
FROM crmCustomer cr WITH(ROWLOCK,UPDLOCK)
	INNER JOIN bodb02.dbo.Customer c WITH(NOLOCK) ON cr.CustID=c.CustID
WHERE c.CustID IN(35558160,
					33869470,
					17524782,
					23285728
					)