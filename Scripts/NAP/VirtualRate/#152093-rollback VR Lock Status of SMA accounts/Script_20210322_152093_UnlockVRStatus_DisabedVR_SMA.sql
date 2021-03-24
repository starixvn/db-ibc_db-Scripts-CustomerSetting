/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210301@Eden
	Task: Update data for VRCustLockStatus [RM#152093]
		- Correct for VR Status : For current SMAs with VR Status = 0 --> remove VR lock status
	DB: DBCUST/CustDB
*/
USE CustDB
GO
CREATE TABLE #TmpCust (CustID INT, Type TINYINT, IsFinished BIT DEFAULT 0)
CREATE TABLE #TmpCust_Batch (CustID INT, Type TINYINT)
CREATE TABLE #VRLock_manual (CustID INT PRIMARY KEY)
CREATE TABLE #DisbledVR_Cust (CustID INT PRIMARY KEY, IsFinished BIT DEFAULT 0)
-------------Correct Data for VR status--------------------------
Print 'Begin Correct Data for VR status'

--> use log table to get SMA is manually locked
INSERT INTO #VRLock_manual(CustID) -- manual update VR status accounts
SELECT L.CUSTID -- get all SMA locked/unlocked manually
FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
	INNER JOIN custinfo c (NOLOCK) ON l.custid = c.custid AND c.roleid IN(2,3,4)
WHERE L.ActionID in(829,830)
UNION -- All Agents locked follow by their master
SELECT c.CUSTID
FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
	INNER JOIN custinfo c (NOLOCK) ON l.custid = c.mrecommend AND c.custid <> l.custid AND c.RoleID = 2
WHERE L.ActionID in(829,830)
	AND TrackingValue LIKE '%VRLock="1"%'
UNION -- All Agents and masters locked follow by their supers
SELECT c.custid
FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
	INNER JOIN custinfo c (NOLOCK) ON l.custid = c.srecommend AND c.custid <> l.custid	 AND c.roleid IN(2,3)
WHERE L.ActionID in(829,830)
	AND TrackingValue LIKE '%VRLock="1"%'

INSERT INTO #DisbledVR_Cust(CustID)
SELECT DISTINCT d.custid
FROM custinfo d WITH(NOLOCK) 
	INNER JOIN VRCustLockStatus lock WITH(ROWLOCK)  ON d.custid = lock.CustID --AND lock.Type = 1
	INNER JOIN custinfo s WITH(NOLOCK) ON d.srecommend = s.custid AND s.VirtualMultiplier = 0 --Just correct for Accounts whose super is Disable VR
WHERE d.VirtualMultiplier = 0	 
	AND d.Enabled = 1
	AND d.roleid IN (2,3,4)
	AND d.custid NOT IN(SELECT CustID FROM #VRLock_manual)

--> set Soccer VR Lock = 1 and Other Sports VR Lock = 1 
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #TmpCust_Batch

	UPDATE TOP(2000) a
	SET a.IsFinished = 1
	OUTPUT deleted.custid INTO #TmpCust_Batch( CustID)
	FROM #DisbledVR_Cust a
	WHERE a.IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK;

	DELETE c
	FROM #TmpCust_Batch t
		INNER JOIN VRCustLockStatus c WITH(ROWLOCK) 
			ON t.CustID = c.CustID
END

--> Export exclude list
--SELECT v.CustID,c.username
--	,Level = CASE	WHEN c.roleid = 2 THEN 'Agent' 
--					WHEN c.roleid = 3 THEN 'Master'
--					WHEN c.roleid = 4 THEN 'Super' END
--FROM #VRLock_manual v
--	INNER JOIN custinfo c WITH(NOLOCK)
--		ON v.CustID = c.custid
--ORDER BY c.srecommend,c.mrecommend,c.username

Print 'End Correct Data for VR status'
DROP TABLE #TmpCust
DROP TABLE #TmpCust_Batch
DROP TABLE #DisbledVR_Cust
DROP TABLE #VRLock_manual