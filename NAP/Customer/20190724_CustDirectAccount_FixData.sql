/*
	Created: 20190724@Elodie
	Task: Fix data for CustDirectAccount
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT hl.custid INTO #tmp
FROM dbo.CustGroupHeadline hl WITH (NOLOCK)
	INNER JOIN CustInfo ci WITH (NOLOCK) ON hl.custid = ci.custid
	LEFT JOIN dbo.CustDirectAccount ca WITH (NOLOCK) ON ca.CustID = hl.CustID
WHERE ca.CustID IS NULL AND hl.GroupID <> 0
	AND NOT EXISTS (SELECT 1 FROM dbo.Dep_CustSuper s WITH (NOLOCK) WHERE ci.srecommend = s.CustID ) 
	AND roleid <> 0

--61 affected rows
INSERT INTO CustDirectAccount (CustID, ProcessedBy, Boss, RequestedBy, ApprovedBy, Coll_Status)
SELECT CustID, '', '', '', '', 0
FROM #tmp