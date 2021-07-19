/*
	Created: 20200227@Elodie	
	Task: Prepare structure for auto notify suspicious
	DB: DBCUST/CustDB and all replicated server of CustDB_CustSetting pub
*/
USE CustDB
GO

INSERT INTO dbo.SuspiciousCust (CustID, NotifyStatus1, NotifyStatus2)
SELECT CustID, 1, 0
FROM dbo.custInfo ci WITH (NOLOCK)
	INNER JOIN dbo.Exchange e WITH (NOLOCK) ON e.exchangeid = ci.currency
WHERE ci.credit * e.actualrate >= 300000
	AND roleid BETWEEN 2 AND 4
