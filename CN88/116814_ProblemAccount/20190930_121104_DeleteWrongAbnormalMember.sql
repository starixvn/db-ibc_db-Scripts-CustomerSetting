/*
	Created: 20190930@Elodie	
	Task: Remove wrong data
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT DISTINCT c.CustId
INTO #CustList
FROM DBACC.bodb02.dbo.TicketVoiding_VoidedTransaction v WITH (NOLOCK)
	INNER JOIN CS_ProblemAccount c WITH (ROWLOCK) ON c.custid = v.CustID
WHERE v.IssueTypeId = 11 AND c.IsAbnormalMember = 1

--30 affected rows
DELETE c
FROM DBACC.bodb02.dbo.TicketVoiding_VoidedTransaction v WITH (NOLOCK)
	INNER JOIN CS_ProblemAccount c WITH (ROWLOCK) ON c.custid = v.CustID
WHERE (v.IssueTypeId <> 11 OR v.IssueTypeId IS NULL) AND c.IsAbnormalMember = 1
	AND NOT EXISTS (SELECT 1 FROM #CustList t WHERE t.CustID = c.CustId)
