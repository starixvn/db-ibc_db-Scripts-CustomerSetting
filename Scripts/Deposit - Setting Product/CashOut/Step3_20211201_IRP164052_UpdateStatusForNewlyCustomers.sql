/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211201@Johnson
	Task: Enable Cash Out for newly customers
	DB: DBCust/CustDB
*/

DECLARE @Custid INT, @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid INT, isfinished BIT DEFAULT (0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'		
	AND ci.Enabled=1
	AND cs.site NOT IN('Athena000')
	AND cs.site IN (SELECT LicenseeName FROM bodb_Licensee..Licensees WITH(NOLOCK) WHERE IsActive =1)
	
CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)	
CREATE TABLE #tblCust (CustID INT PRIMARY KEY)
DECLARE @tmp TABLE (custid INT PRIMARY KEY)

DECLARE @ProductID INT = 25
	
INSERT INTO #Dummy(CustID)
SELECT CustID 
FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88' + 'CAS%')

INSERT INTO #tblCust(CustID)
SELECT ci.CustID
FROM custInfo ci WITH(NOLOCK)
	LEFT JOIN Dep_CustProductSetting cs WITH(NOLOCK) ON ci.custid = cs.custid	
														AND cs.ProductID = @ProductID
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND ci.custid > @max_custid 		
	AND ci.Enabled=1	
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND roleid = 1
	AND (cs.custid IS NULL OR cs.IsEnabled = 0)
	
WHILE(1=1)
BEGIN
	DELETE TOP (500) t
	OUTPUT DELETED.custid INTO @tmp(custid)
	FROM #tblCust t
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	MERGE Dep_CustProductSetting target 
	USING (SELECT custid, @ProductId as ProductID, 1 as IsEnabled 
			FROM @tmp) as Source 
	ON target.CustID = Source.custid AND target.ProductId = Source.ProductID
	WHEN MATCHED AND Target.IsEnabled <> Source.IsEnabled THEN UPDATE SET Target.IsEnabled = Source.IsEnabled
	WHEN NOT MATCHED THEN INSERT(custid,ProductID,IsEnabled) VALUES(Source.custid,Source.ProductID,Source.IsEnabled);
			
	DELETE @tmp		
	
	WAITFOR DELAY '0:0:1'
END
	
DROP TABLE #tblCust	
DROP TABLE #Dummy