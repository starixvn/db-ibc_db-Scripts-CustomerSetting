/*
	Created: 20210416@Eden
	Task: https://nexdev.net/issues/125823
		Step 0: Config Agents whose members will be archived 
	DB: DBCUST.CustDB
*/
USE CustDB
GO

DECLARE @Archive_Agents VARCHAR(MAX) = 'xxx,11232123' 
DECLARE @MinBalance money = 2.00
		,@Mindays INT = 1095

CREATE TABLE #TempAgents (CustID INT PRIMARY KEY)

INSERT INTO #TempAgents
SELECT DISTINCT LTRIM(val)
FROM f_StringSplit(@Archive_Agents,',')
WHERE LTRIM(val) <> '' 
	--AND ISNUMERIC(val) = 1

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
	AND Recommend NOT IN( SELECT Recommend FROM Dep_Customer_Archived_Config)

DROP TABLE #TempAgents
DROP TABLE #Dep_Customer_Archived_Config
