/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210507@Eden
	Task: https://nexdev.net/issues/125823
		Step 0: Config Agents whose members will be archived for Licensees: 'Indowin',,Allbetclub','GWORLD','Webet138','WeBet168','Win88'
	DB: DBCUST.CustDB
*/
USE CustDB
GO
--> Delete waiting agents before new scan
SELECT CustID
INTO #TempDeleted
FROM Dep_Customer_Archived WITH(NOLOCK) 
WHERE status = 'waiting'

DELETE d
FROM #TempDeleted t
	INNER JOIN  Dep_Customer_Archived d WITH(ROWLOCK)  
		ON t.CustID = d.CustID
-------------------------------------

DECLARE @MinBalance money = 2.00
		,@Mindays INT = 1095

CREATE TABLE #TempAgents (CustID INT PRIMARY KEY)

INSERT INTO #TempAgents
SELECT c.custid
FROM customer c(NOLOCK) 
WHERE c.site IN ('Indowin','Allbetclub','GWORLD','Webet138','WeBet168','Win88')
	AND c.roleid = 2
	AND c.username NOT LIKE '%ACC%'

SELECT c.custid AS Recommend,cu.site,@MinBalance AS MinBalance,@Mindays AS MinDays,ClearBal.CustID AS CustIDBalanceDummy, 0 AS Status, c.srecommend
INTO #Dep_Customer_Archived_Config
FROM custInfo c WITH(NOLOCK) 
	INNER JOIN Customer cu WITH(NOLOCK) ON c.custid = cu.custid
	OUTER APPLY (	SELECT TOP 1 Custid 
					FROM custInfo ClearBal WITH(NOLOCK) 
					WHERE ClearBal.srecommend = c.srecommend
						AND ClearBal.roleid = 1
						AND ClearBal.username LIKE '%01ClearBal'
						) ClearBal
WHERE c.srecommend IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND c.custid IN ( SELECT custid FROM #TempAgents)

IF EXISTS (	SELECT TOP 1 1
			FROM #Dep_Customer_Archived_Config
			WHERE CustIDBalanceDummy IS NULL
)
BEGIN
	SELECT c.Recommend,c.srecommend,ci.username as Super, 'This Line have not ClearBal account'
	FROM #Dep_Customer_Archived_Config c (NOLOCK)
	INNER JOIN Customer ci ON c.srecommend = ci.custid
	WHERE c.CustIDBalanceDummy IS NULL

	RETURN
END

--> Update another agents to pending (do not scan now)
UPDATE cf 
SET cf.Status = 2 --Pending
FROM Dep_Customer_Archived_Config cf WITH(ROWLOCK)
WHERE cf.Status = 0

--> INSERT/UPDATE agents ready to scan
INSERT INTO Dep_Customer_Archived_Config (Recommend,Site,MinBalance,MinDays,CustIDBalanceDummy,Status)
SELECT Recommend,Site,MinBalance,MinDays,CustIDBalanceDummy,Status
FROM #Dep_Customer_Archived_Config 
WHERE CustIDBalanceDummy IS NOT NULL
	AND Recommend NOT IN( SELECT Recommend FROM Dep_Customer_Archived_Config WITH(NOLOCK))

UPDATE cf
SET cf.MinDays = c.MinDays,
	cf.MinBalance = c.MinBalance,
	cf.CustIDBalanceDummy = c.CustIDBalanceDummy,
	cf.Status = c.Status
FROM #Dep_Customer_Archived_Config 	c
		 INNER JOIN Dep_Customer_Archived_Config cf WITH(ROWLOCK) ON c.Recommend = cf.Recommend
WHERE c.CustIDBalanceDummy IS NOT NULL

DROP TABLE #TempAgents
DROP TABLE #Dep_Customer_Archived_Config
DROP TABLE #TempDeleted