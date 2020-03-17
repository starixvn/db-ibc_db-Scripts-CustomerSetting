USE CustDB
GO

/*
	Created: 20200310@Percy
	DB: DBCUST.CustDB
	Task: Initialize data for new column IsAllDayBalTransfer on CustMaster
	RedmineID: #130091

	--- check row count
	SELECT COUNT(1)
	FROM dbo.CustMaster m WITH (NOLOCK)
		INNER JOIN dbo.Customer c WITH (NOLOCK) ON c.custid = m.custid
		INNER JOIN dbo.CustSuper s WITH (NOLOCK) ON s.custid = c.srecommend
	WHERE s.IsAllDayBalTransfer = 1
*/


UPDATE m WITH (ROWLOCK)
SET m.IsAllDayBalTransfer = s.IsAllDayBalTransfer
FROM dbo.CustMaster m
	INNER JOIN dbo.Customer c WITH (NOLOCK) ON c.custid = m.custid
	INNER JOIN dbo.CustSuper s WITH (NOLOCK) ON s.custid = c.srecommend
WHERE s.IsAllDayBalTransfer = 1
GO