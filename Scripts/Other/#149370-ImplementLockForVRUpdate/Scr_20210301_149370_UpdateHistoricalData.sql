/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210301@Eden
	Task: Update data for VRCustLockStatus [RM#149370]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE #TmpCust (CustID INT, IsFinished BIT DEFAULT 0)
CREATE TABLE #TmpCust_Batch (CustID INT PRIMARY KEY)

-- For the current data of VRAgentAutoAdjustment.Status = 2 (include Downline) and VRCustAutoAdjustment.Status = 2, set Lock VR = 1
INSERT INTO #TmpCust (CustID)
SELECT c.custid
FROM VRAgentAutoAdjustment a WITH(NOLOCK) 
	INNER JOIN custInfo c WITH(NOLOCK)
		ON a.AgentID = c.recommend
WHERE a.Status = 2
	AND c.Enabled = 1
UNION
SELECT a.CustID
FROM VRCustAutoAdjustment a WITH(NOLOCK) 
	INNER JOIN custInfo c WITH(NOLOCK)
		ON a.CustID = c.custid
WHERE Status = 2
	AND c.Enabled = 1

WHILE 1 = 1
BEGIN
	UPDATE TOP(5000) a
	SET a.IsFinished = 1
	OUTPUT deleted.custid INTO #TmpCust_Batch( CustID)
	FROM #TmpCust a
	WHERE a.IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK;

	INSERT INTO VRCustLockStatus(CustID)
	SELECT t.CustID 
	FROM #TmpCust_Batch t
		LEFT JOIN VRCustLockStatus v WITH(NOLOCK) ON t.CustID = v.CustID
	WHERE v.CustID IS NULL

END

DROP TABLE #TmpCust
DROP TABLE #TmpCust_Batch


