/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210301@Eden
	Task: Update data for VRCustLockStatus [RM#149370]
		-Correct Data for Check performance Job (China/desktop view and Agent Profiler)
		-Correct Data for SPU Job
		-Correct for VR Status : For current accounts with VR Status = 0, set VR Lock Soccer = 1 and VR Lock Other Sports = 1
	DB: DBCUST/CustDB
*/
USE CustDB
GO
DECLARE @MaxCustID INT = xxx -- get MaxCustID
CREATE TABLE #TmpCust (CustID INT, Type TINYINT, IsFinished BIT DEFAULT 0)
CREATE TABLE #TmpCust_Batch (CustID INT, Type TINYINT)
CREATE TABLE #TblType (Type TINYINT)

Print 'Begin Correct Data for Check performance Job (China/desktop view and Agent Profiler)'

INSERT INTO #TblType (Type)
SELECT 1  UNION ALL --soccer
SELECT 2  --Other sports

-------------Correct Data for Check performance Job (China/desktop view and Agent Profiler) --------------------------
-- For the current data of VRAgentAutoAdjustment.Status = 2 (include Downline) and VRCustAutoAdjustment.Status = 2, set Lock VR = 1
INSERT INTO #TmpCust (CustID,Type)
SELECT c.custid,tp.Type
FROM VRAgentAutoAdjustment a WITH(NOLOCK) 
	INNER JOIN custInfo c WITH(NOLOCK)
		ON a.AgentID = c.recommend
	CROSS JOIN #TblType tp
WHERE a.Status = 2
	AND c.Enabled = 1
UNION
SELECT a.CustID,tp.Type
FROM VRCustAutoAdjustment a WITH(NOLOCK) 
	INNER JOIN custInfo c WITH(NOLOCK)
		ON a.CustID = c.custid
	CROSS JOIN #TblType tp
WHERE Status = 2
	AND c.Enabled = 1
	AND a.SportType = 100 -- Soccer and Other sports
UNION
SELECT a.CustID,tp.Type
FROM VRCustAutoAdjustment a WITH(NOLOCK) 
	INNER JOIN custInfo c WITH(NOLOCK)
		ON a.CustID = c.custid
	CROSS JOIN #TblType tp
WHERE Status = 2
	AND c.Enabled = 1
	AND a.SportType = 99 -- Other sports
	AND tp.Type = 2

--> set Soccer VR Lock = 1 and Other Sports VR Lock = 1 
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #TmpCust_Batch

	UPDATE TOP(5000) a
	SET a.IsFinished = 1
	OUTPUT deleted.custid,deleted.Type INTO #TmpCust_Batch( CustID,Type)
	FROM #TmpCust a
	WHERE a.IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK;

	INSERT INTO VRCustLockStatus(CustID,Type)
	SELECT t.CustID,t.Type
	FROM #TmpCust_Batch t
		LEFT JOIN VRCustLockStatus v WITH(NOLOCK) ON t.CustID = v.CustID AND t.Type = v.Type
	WHERE v.CustID IS NULL
END

Print 'End Correct Data for Check performance Job (China/desktop view and Agent Profiler)'
Print '----------------------------------------------------------------------------------'
-------------Correct Data for SPU Job--------------------------
CREATE TABLE #SPUJob_Cust(CustID INT PRIMARY KEY)
CREATE TABLE #TmpUpdatedCust_Job2 (CustID INT, Type TINYINT, IsFinished BIT DEFAULT 0)

Print 'Begin Correct Data for SPU Job'

INSERT INTO #SPUJob_Cust(CustID)
SELECT DISTINCT CustID
FROM DBLOG.bodb_CustomerLog.dbo.UserLog_VirtualRateSettings WITH (NOLOCK)

INSERT INTO #TmpUpdatedCust_Job2(CustID,Type)
SELECT c.CustID
	,Type = CASE WHEN pvs.sporttype = 1 THEN 1 ELSE 2 END
FROM #SPUJob_Cust c
	INNER JOIN custinfo ci WITH(NOLOCK) on c.CustID = ci.custid
	INNER JOIN CustVirtualSetting cvs WITH(NOLOCK)
				ON cvs.custid = ci.custid
	INNER JOIN  ProfileVirtualSetting pvs WITH(NOLOCK)
		ON  cvs.seqNo = pvs.seqNo
WHERE pvs.isActive = 1
		AND pvs.sporttype IN (1,3) AND pvs.bettype = 1 AND pvs.islive = 1 --Check representative SportType (Soccer and OtherSport)
		AND dbo.f_GetVirtualSetting(cvs.bitmapVirtual, pvs.profileID) >= 1.0

--> set Soccer VR Lock = 1 and Other Sports VR Lock = 1 
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #TmpCust_Batch

	UPDATE TOP(5000) a
	SET a.IsFinished = 1
	OUTPUT deleted.custid,deleted.Type INTO #TmpCust_Batch( CustID,Type)
	FROM #TmpUpdatedCust_Job2 a
	WHERE a.IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK;

	INSERT INTO VRCustLockStatus(CustID,Type)
	SELECT t.CustID,t.Type
	FROM #TmpCust_Batch t
		LEFT JOIN VRCustLockStatus v WITH(NOLOCK) ON t.CustID = v.CustID AND t.Type = v.Type
	WHERE v.CustID IS NULL
END
Print 'End Correct Data for SPU Job'
Print '----------------------------------------------------------------------------------'
-------------Correct Data for VR status--------------------------
Print 'Begin Correct Data for VR status'

CREATE TABLE #DisbledVR_Cust (CustID INT PRIMARY KEY, IsFinished BIT DEFAULT 0)

INSERT INTO #DisbledVR_Cust(CustID)
SELECT custid
FROM custinfo d WITH(NOLOCK) 
WHERE VirtualMultiplier = 0	 
	AND Enabled = 1

--/*not update for dummy accs , Finance accs
--excluede Dummy
DELETE t
FROM CustDirectAccount dr WITH(NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON ci.custid = dr.CustID
	INNER JOIN custinfo dm WITH(NOLOCK) ON dm.custid IN (ci.recommend,ci.mrecommend,ci.srecommend)
	INNER JOIN #DisbledVR_Cust t ON dm.custid = t.CustID
WHERE ci.roleid < dm.roleid

--Exclude Finance
CREATE TABLE #FA_Cust (CustID INT PRIMARY KEY)
INSERT INTO #FA_Cust(CustID)
SELECT s.custid
FROM CustSuper s WITH(NOLOCK) 
	INNER JOIN #DisbledVR_Cust t ON s.custid = t.CustID
WHERE s.IsInternal = 1
UNION ALL
SELECT s.custid
FROM CustMaster s WITH(NOLOCK) 
	INNER JOIN #DisbledVR_Cust t ON s.custid = t.CustID
WHERE s.IsInternal = 1
UNION ALL
SELECT s.custid
FROM CustAgent s WITH(NOLOCK) 
	INNER JOIN #DisbledVR_Cust t ON s.custid = t.CustID
WHERE s.IsInternal = 1

DELETE t
FROM #DisbledVR_Cust t
	INNER JOIN  custInfo ci WITH(NOLOCK) ON t.CustID = ci.custid
	INNER JOIN  #FA_Cust d ON d.CustID = ci.srecommend

DELETE t
FROM #DisbledVR_Cust t
	INNER JOIN  custInfo ci WITH(NOLOCK) ON t.CustID = ci.custid
	INNER JOIN  #FA_Cust d ON d.CustID = ci.mrecommend

DELETE t
FROM #DisbledVR_Cust t
	INNER JOIN  custInfo ci WITH(NOLOCK) ON t.CustID = ci.custid
	INNER JOIN  #FA_Cust d ON d.CustID = ci.recommend

--*/not update for dummy accs, Finance accs - END 

--> set Soccer VR Lock = 1 and Other Sports VR Lock = 1 
WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #TmpCust_Batch

	UPDATE TOP(5000) a
	SET a.IsFinished = 1
	OUTPUT deleted.custid INTO #TmpCust_Batch( CustID)
	FROM #DisbledVR_Cust a
	WHERE a.IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK;

	INSERT INTO VRCustLockStatus(CustID,Type)
	SELECT t.CustID,tp.Type
	FROM #TmpCust_Batch t
		CROSS JOIN #TblType tp
		LEFT JOIN VRCustLockStatus v WITH(NOLOCK) ON t.CustID = v.CustID AND tp.Type = v.Type
	WHERE v.CustID IS NULL
END

Print 'End Correct Data for VR status'

DROP TABLE #TmpCust
DROP TABLE #TmpCust_Batch
DROP TABLE #TblType
DROP TABLE #SPUJob_Cust
DROP TABLE #TmpUpdatedCust_Job2
DROP TABLE #DisbledVR_Cust
DROP TABLE #FA_Cust
