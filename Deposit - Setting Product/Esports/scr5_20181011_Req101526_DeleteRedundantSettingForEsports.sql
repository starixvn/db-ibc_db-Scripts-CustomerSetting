/*
	Created: Winnie
	Task: Delete redundant setting Deposit RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20181015
*/ 
USE CustDB
GO

DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
	
CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM Custinfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled=1

DELETE cg
FROM Dep_CustPTSetting_Agent cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType =43 AND cg.custid > @maxcustID
						
DELETE cg
FROM Dep_CustPTSetting_Member cg WITH(UPDLOCK,ROWLOCK)		
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType =43 AND cg.custid > @maxcustID
		
DELETE cg
FROM Dep_CustPTGroupSetting_Member cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType =43 AND c.custid > @maxcustID
				
DELETE cg
FROM Dep_CustBetSetting_Agent cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType =43 AND c.custid > @maxcustID

DELETE cg
FROM Dep_CustBetSetting_Member cg WITH(UPDLOCK,ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType =43 AND c.custid > @maxcustID

	