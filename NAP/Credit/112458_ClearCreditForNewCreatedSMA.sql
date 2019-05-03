/*
    Created: Elodie
    Date: 20190502
    Task: Clear given credit for new created SMA
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

--Get masters don't have downlines
SELECT c.mrecommend AS custid INTO #MasterList
FROM dbo.Custinfo c WITH (NOLOCK) 
WHERE NOT EXISTS (SELECT 1 FROM dbo.Dep_CustSuper s WITH (NOLOCK) WHERE s.custid = c.srecommend)
	AND c.roleid IN (2,3)
GROUP BY c.mrecommend 
HAVING COUNT(1) = 1

--Get agents don't have downlines
SELECT c.recommend AS custid INTO #AgentList
FROM dbo.Custinfo c WITH (NOLOCK) 
WHERE NOT EXISTS (SELECT 1 FROM dbo.Dep_CustSuper s WITH (NOLOCK) WHERE s.custid = c.srecommend)
	AND c.roleid IN (1,2)
GROUP BY c.recommend 
HAVING COUNT(1) = 1

--exclude masters/agent already login (CustLoginInfo.isFirstLogin=0)
--exclude internal accounts
DELETE m 
FROM #MasterList m 
	INNER JOIN dbo.CustLoginInfo li WITH (NOLOCK) ON li.CustID = m.custid
	INNER JOIN dbo.CustMaster cm WITH (NOLOCK) ON cm.custid = m.custid
WHERE li.isFirstLogin = 0
	OR cm.IsInternal = 1

DELETE m 
FROM #MasterList m 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = m.custid
	INNER JOIN dbo.CustSuper cs WITH (NOLOCK) ON cs.custid = ci.srecommend
WHERE cs.IsInternal = 1

DELETE m 
FROM #AgentList a
	INNER JOIN dbo.CustLoginInfo li WITH (NOLOCK) ON li.CustID = a.custid
	INNER JOIN dbo.CustMaster cm WITH (NOLOCK) ON cm.custid = a.custid
WHERE li.isFirstLogin = 0
	OR cm.IsInternal = 1

DELETE m 
FROM #AgentList a 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = a.custid
	INNER JOIN dbo.CustSuper cs WITH (NOLOCK) ON cs.custid = ci.srecommend
WHERE cs.IsInternal = 1

DELETE m 
FROM #AgentList a 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.CustID = a.custid
	INNER JOIN dbo.CustMaster cm WITH (NOLOCK) ON cm.custid = ci.mrecommend
WHERE cm.IsInternal = 1

--exclude direct accounts
DELETE m 
FROM #MasterList m 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = m.custid

DELETE m 
FROM #AgentList a 
	INNER JOIN dbo.CustDirectAccount da WITH (NOLOCK) ON da.CustID = a.custid

--exclude exception list used by OPS/Finance (bodb_report.dbo.Task_Cust_ArchiveAcc_Exception)
DELETE m 
FROM #MasterList m 
	INNER JOIN DBACC.bodb_report.dbo.Task_Cust_ArchiveAcc_Exception e WITH (NOLOCK) ON e.CustID = m.custid

DELETE m 
FROM #AgentList a 
	INNER JOIN DBACC.bodb_report.dbo.Task_Cust_ArchiveAcc_Exception e WITH (NOLOCK) ON e.CustID = a.custid

--exclude masters/agents whose creator is upline
--exclude masters/agents who created before xx days
DELETE m 
FROM #MasterList m 
	INNER JOIN Customer c WITH (NOLOCK) ON c.CustID = m.custid
WHERE c.creator = c.srecommend
	OR c.creatdate <= DATEADD(dd,-7, GETDATE())

DELETE m 
FROM #AgentList a 
	INNER JOIN Customer c WITH (NOLOCK) ON c.CustID = a.custid
WHERE c.creator = c.mrecommend
	OR c.creatdate <= DATEADD(dd,-7, GETDATE())

--Get member list
SELECT *
FROM Customer c WITH (NOLOCK)
	
