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
)
SELECT tmp.custid,MAX(c.username) username,
	Level = CASE	WHEN MAX(c.roleid) = 2 THEN 'Agent' 
					WHEN MAX(c.roleid) = 3 THEN 'Master'
					WHEN MAX(c.roleid) = 4 THEN 'Super' END,
	Reason = CASE SUM(tmp.Reason)
		WHEN 1 THEN 'Locked' 
		WHEN 3 THEN 'Unlocked' 
		WHEN 2 THEN 'Both' 
		END
FROM Tmp
	INNER JOIN custInfo c(NOLOCK)
	ON tmp.custid = c.custid
WHERE c.currency <> 20
GROUP BY tmp.custid
ORDER BY 2,3 DESC