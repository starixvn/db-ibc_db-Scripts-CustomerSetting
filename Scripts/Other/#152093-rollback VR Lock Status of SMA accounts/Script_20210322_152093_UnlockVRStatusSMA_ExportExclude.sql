/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210301@Eden
	Task: 
		- Correct for VR Status : For current SMAs with VR Status = 0 --> remove VR lock status --> Export exclude Data [RM#149370]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

;WITH Tmp AS(
	SELECT L.CUSTID , Reason = 1 --'Locked'-- get all SMA locked/unlocked manually
	FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
		INNER JOIN custinfo c (NOLOCK) ON l.custid = c.custid AND c.roleid IN(2,3,4)
	WHERE L.ActionID in(829,830)
		AND TrackingValue LIKE '%VRLock="1"%'
	UNION
	SELECT L.CUSTID, Reason =  2--'UnLocked' -- get all SMA locked/unlocked manually
	FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
		INNER JOIN custinfo c (NOLOCK) ON l.custid = c.custid AND c.roleid IN(2,3,4)
	WHERE L.ActionID in(829,830)
		AND TrackingValue LIKE '%VRLock="0"%'
	UNION -- All Agents locked follow by their master
	SELECT c.CUSTID , Reason = 1--'Locked By Master'
	FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
		INNER JOIN custinfo c (NOLOCK) ON l.custid = c.mrecommend AND c.custid <> l.custid AND c.RoleID = 2
	WHERE L.ActionID in(829,830)
		AND TrackingValue LIKE '%VRLock="1"%'
	UNION -- All Agents and masters locked follow by their supers
	SELECT c.custid, Reason = 1 --'Locked By Super'
	FROM dblog.bodb_CustomerLog.dbo.UserLog_RunSP l WITH(NOLOCK)
		INNER JOIN custinfo c (NOLOCK) ON l.custid = c.srecommend AND c.custid <> l.custid	 AND c.roleid IN(2,3)
	WHERE L.ActionID in(829,830)
		AND TrackingValue LIKE '%VRLock="1"%'
	UNION
	SELECT d.custid, Reason = 4
	FROM custinfo d WITH(NOLOCK) 
		INNER JOIN VRCustLockStatus lock WITH(ROWLOCK)  ON d.custid = lock.CustID --AND lock.Type = 1
		INNER JOIN custinfo s WITH(NOLOCK) ON d.srecommend = s.custid AND s.VirtualMultiplier = 1 --Just correct for Accounts whose super is Disable VR
	WHERE d.VirtualMultiplier = 0	 
		AND d.Enabled = 1
		AND d.roleid IN (2,3,4)
		AND d.currency <> 20
)
SELECT tmp.custid,MAX(c.username) username,
	Level = CASE	WHEN MAX(c.roleid) = 2 THEN 'Agent' 
					WHEN MAX(c.roleid) = 3 THEN 'Master'
					WHEN MAX(c.roleid) = 4 THEN 'Super' END,
	Reason1 = CASE SUM(tmp.Reason)
					WHEN 1 THEN 'Locked' 
					WHEN 2 THEN 'Unlocked' 
					WHEN 3 THEN 'Both' 
				END,
	Reason2 = CASE WHEN Max(tmp.Reason) = 4 THEN 'Super Enable' ELSE '' END
FROM Tmp
	INNER JOIN custInfo c(NOLOCK)
	ON tmp.custid = c.custid
WHERE c.currency <> 20
GROUP BY tmp.custid
ORDER BY Max(c.srecommend), Max(c.mrecommend),2,3 DESC