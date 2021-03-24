/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210324@Eden
	Task: Update data for VRCustLockStatus [RM#152093]
		- Correct for VR Status : For current Members with VR Status = 0 --> remove VR lock status
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

--> use log table to get Members is manually locked
INSERT INTO #VRLock_manual(CustID) -- manual update VR status accounts
SELECT L.CUSTID -- get all Member locked/unlocked manually
FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
	INNER JOIN custinfo c (NOLOCK) ON l.custid = c.custid AND c.roleid = 1
WHERE L.ActionID in(829,830)
UNION -- All Member locked follow by their Agent
SELECT c.CUSTID
FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
	INNER JOIN custinfo c (NOLOCK) ON l.custid = c.recommend AND c.RoleID = 1
WHERE L.ActionID in(829,830)
	AND TrackingValue LIKE '%VRLock="1"%'
UNION -- All Member locked follow by their master
SELECT c.CUSTID
FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
	INNER JOIN custinfo c (NOLOCK) ON l.custid = c.mrecommend AND c.RoleID = 1
WHERE L.ActionID in(829,830)
	AND TrackingValue LIKE '%VRLock="1"%'
UNION -- All Member locked follow by their supers
SELECT c.custid
FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
	INNER JOIN custinfo c (NOLOCK) ON l.custid = c.srecommend AND c.roleid = 1
WHERE L.ActionID in(829,830)
	AND TrackingValue LIKE '%VRLock="1"%'

INSERT INTO #DisbledVR_Cust(CustID)
SELECT DISTINCT d.custid
FROM custinfo d WITH(NOLOCK) 
	INNER JOIN VRCustLockStatus lock WITH(NOLOCK)  ON d.custid = lock.CustID --AND lock.Type = 1
	INNER JOIN custinfo s WITH(NOLOCK) ON d.srecommend = s.custid AND s.VirtualMultiplier = 0 --Just correct for Accounts whose super is Disable VR
WHERE d.VirtualMultiplier = 0	 
	AND d.Enabled = 1
	AND d.roleid = 1
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

	WAITFOR DELAY '00:00:00.02'
END

Print 'End Correct Data for VR status'
DROP TABLE #TmpCust
DROP TABLE #TmpCust_Batch
DROP TABLE #DisbledVR_Cust
DROP TABLE #VRLock_manual