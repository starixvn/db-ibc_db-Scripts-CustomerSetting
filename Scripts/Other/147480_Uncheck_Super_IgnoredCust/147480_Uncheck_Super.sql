/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201202
	Task:  Del setting in Dep_LicenseeProductSetting  [RedmineID:#147480]
	DB: DBCust/CustDB
*/
USE CustDB
GO

CREATE TABLE #temp (custid INT)
INSERT INTO #temp (custid)
VALUES  (41767024),(45937363)


DELETE m FROM Dep_LicenseeProductSetting m WITH (ROWLOCK) 	
	INNER JOIN custInfo ci WITH (NOLOCK) ON ci.custid = m.custid	
	INNER JOIN #temp t ON m.custid = t.custid
WHERE ci.roleid =  4 AND m.ProductSettingID = 28
