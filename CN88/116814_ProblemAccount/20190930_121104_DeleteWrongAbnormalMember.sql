/*
	Created: 20190930@Elodie	
	Task: Remove wrong data
	DB: DBCUST/CustDB
*/
USE CustDB
GO

--42 affected rows
DELETE c
FROM DBACC.bodb02.dbo.TicketVoiding_VoidedTransaction v WITH (NOLOCK)
	INNER JOIN CS_ProblemAccount c WITH (ROWLOCK) ON c.custid = v.CustID
WHERE (v.IssueTypeId <> 11 OR v.IssueTypeId IS NULL) AND c.IsAbnormalMember = 1

/*
--check data
SELECT c.*, ci.username, ci.roleid
FROM DBACC.bodb02.dbo.TicketVoiding_VoidedTransaction v WITH (NOLOCK)
	INNER JOIN CS_ProblemAccount c WITH (NOLOCK) ON c.custid = v.CustID
	INNER JOIN CustInfo ci WITH (NOLOCK) ON c.custid = ci.CustID
WHERE (v.IssueTypeId <> 11 OR v.IssueTypeId IS NULL) AND c.IsAbnormalMember = 1
*/