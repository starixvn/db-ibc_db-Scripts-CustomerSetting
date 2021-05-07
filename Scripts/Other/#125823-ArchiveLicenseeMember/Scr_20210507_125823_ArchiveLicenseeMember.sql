/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210507@Eden
	Task: https://nexdev.net/issues/125823
		Step 0: Config Agents whose members will be archived for Licensees: Indowin" & "Allbetclub
	DB: DBCUST.CustDB
*/
USE CustDB
GO
--DECLARE @Archive_Agents VARCHAR(MAX) = 'xxx,11232123' 
DECLARE @MinBalance money = 2.00
		,@Mindays INT = 1095

CREATE TABLE #TempAgents (CustID INT PRIMARY KEY)

INSERT INTO #TempAgents
SELECT c.custid
FROM customer c(NOLOCK) 
WHERE c.site IN ('Indowin','Allbetclub')
	AND c.roleid = 2

SELECT c.custid AS Recommend,cu.site,@MinBalance AS MinBalance,@Mindays AS MinDays,ClearBal.CustID AS CustIDBalanceDummy, 0 AS Status
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
	SELECT Recommend, 'This Line have not ClearBal account'
	FROM #Dep_Customer_Archived_Config
	WHERE CustIDBalanceDummy IS NULL

	RETURN
END

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
		 INNER JOIN Dep_Customer_Archived_Config cf WITH(NOLOCK) ON c.Recommend = cf.Recommend
WHERE c.CustIDBalanceDummy IS NOT NULL

DROP TABLE #TempAgents
DROP TABLE #Dep_Customer_Archived_Config
