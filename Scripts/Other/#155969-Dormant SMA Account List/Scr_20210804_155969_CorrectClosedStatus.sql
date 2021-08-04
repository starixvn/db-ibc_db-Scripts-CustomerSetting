/*<info serverAlias="DBCUST-CustDB"></info>*/  
/*
	Created: Tina@21210804
	Task: Correct data for archive customer [Redmine: #155969]  
	DB: DBCUST/CustDB
*/

CREATE TABLE #UpdateCloseInfo(CustID INT, RoleID TINYINT)
CREATE TABLE #UpdateClosedReason(CustID INT)
CREATE TABLE #AgentArchive(CustID INT)
DECLARE @Closed BIT = 1

INSERT INTO #AgentArchive(CustID)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK)
	INNER JOIN CustLoginInfo cl WITH (NOLOCK) ON cl.CustID = ci.custid
	INNER JOIN CustProductStatus cps WITH (NOLOCK) ON cps.CustID = ci.custid
WHERE ci.srecommend NOT IN (SELECT CustID FROM Dep_CustSuper WITH (NOLOCK))
	AND ci.roleid = 2
	AND cps.CloseInfo > 0
	AND cl.ClosedReason = 4 --Agent was closed by archive  process

--Member has CloseReason = 4 but Bit 1 is still zero. Should be 1
INSERT INTO #UpdateCloseInfo (CustID, RoleID)
SELECT ci.custid, ci.roleid
FROM CustInfo ci WITH (NOLOCK)
	INNER JOIN #AgentArchive alg WITH (NOLOCK) ON alg.CustID = ci.recommend
	INNER JOIN CustProductStatus cps WITH (NOLOCK) ON ci.custID = cps.CustID
	CROSS APPLY (SELECT MemberStatus FROM f_GetInfoStatus(cps.CloseInfo)) AS cl
WHERE  ci.roleid = 1 AND cl.MemberStatus = 0 --check member's bit = 0 

UPDATE cps
	SET CloseInfo = (SELECT suspendinfo FROM dbo.f_GenerateSuspendInfo(ci.RoleID,@Closed,ISNULL(CloseInfo,0))) -- turn on member's bit = 1
FROM #UpdateCloseInfo ci WITH (NOLOCK)
	INNER JOIN CustProductStatus cps WITH (UPDLOCK,ROWLOCK) ON cps.CustID = ci.custid

--Member was archived but closedReason <> 4
INSERT INTO #UpdateClosedReason (CustID)
SELECT ci.custid, ci.roleid
FROM CustInfo ci WITH (NOLOCK)
	INNER JOIN #AgentArchive alg WITH (NOLOCK) ON alg.CustID = ci.recommend
	INNER JOIN CustLoginInfo_Member cl WITH (NOLOCK) ON ci.custid = cl.CustID
WHERE  ci.roleid = 1 AND cl.ClosedReason <> 4

UPDATE cl SET ClosedReason = 4
FROM #UpdateClosedReason ci WITH (NOLOCK)
	INNER JOIN CustLoginInfo_Member cl WITH (UPDLOCK,ROWLOCK) ON cl.CustID = ci.custid