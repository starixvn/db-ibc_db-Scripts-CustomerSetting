/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210301@Eden
	Task: Correct for VR Status ( New accounts)
			For current accounts with VR Status = 0, set VR Lock Soccer = 1 and VR Lock Other Sports = 1 
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @MaxCustID INT = xxx

CREATE TABLE #TmpCust_Batch (CustID INT, Type TINYINT)
CREATE TABLE #TblType (Type TINYINT)
INSERT INTO #TblType (Type)
SELECT 1  UNION ALL --soccer
SELECT 2  --Other sports
-------------Correct Data for VR status--------------------------
Print 'Begin Correct Data for VR status'

CREATE TABLE #DisbledVR_Cust (CustID INT PRIMARY KEY, IsFinished BIT DEFAULT 0)

INSERT INTO #DisbledVR_Cust(CustID)
SELECT custid
FROM custinfo d WITH(NOLOCK) 
WHERE VirtualMultiplier = 0	 
	AND Enabled = 1
	AND custid > @MaxCustID

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

DROP TABLE #TmpCust_Batch
DROP TABLE #TblType
DROP TABLE #DisbledVR_Cust
DROP TABLE #FA_Cust
