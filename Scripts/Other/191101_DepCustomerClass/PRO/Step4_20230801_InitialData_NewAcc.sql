/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230802
	Task:  Initial table Dep customer class - New acc  RedmineID:#191101
	DB: DBCUST/CustDB
*/
	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
	DROP TABLE	#supers;

	DECLARE @MaxLogID BIGINT
	SELECT @MaxLogID = xxxx

	DECLARE @fromdate DATETIME = '2023-08-31 00:00:00.000', @todate DATETIME 
	SELECT @todate = dateadd(day,1,GETDATE())

	CREATE TABLE #supers (custid INT)	
	CREATE TABLE #Cust (custid INT PRIMARY KEY,CustomerClass SMALLINT, CreatedDate DATETIME, CategoryID	SMALLINT, OldCustomerClass	SMALLINT, IsUpdate BIT DEFAULT(0))

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1
		AND ((cs.site NOT IN('Athena000')) OR (cs.site IN('Athena000') AND ci.currency NOT IN (20)))
	ORDER BY ci.custid 

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM custInfo WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

	INSERT INTO #Cust(CustID,CustomerClass,CreatedDate, OldCustomerClass)
	SELECT DISTINCT u.CustID, c.CustomerClass, b.LogDate , CASE WHEN b.OldCustomerClass <> '' THEN b.OldCustomerClass ELSE NULL END AS OldCustomerClass
	FROM DBLOG.bodb_CustomerLog.dbo.UserLog_UserControl u WITH(NOLOCK) 
		CROSS APPLY (SELECT TOP 1 LogDate, 
							REVERSE(SUBSTRING(REVERSE(REPLACE(Doing,'38 - ','')), 0, CHARINDEX(' - ', REVERSE(REPLACE(Doing,'38 - ',''))))) AS OldCustomerClass
						FROM DBLOG.bodb_CustomerLog.dbo.UserLog_UserControl WITH(NOLOCK) 
						WHERE CustID = u.CustID AND LogDate BETWEEN @fromdate AND @todate 
							AND ActionID = 5566 AND TypeID = 2 AND LogID > @MaxLogID
						ORDER BY LogDate DESC ) b
		CROSS APPLY (SELECT TOP 1  CustomerClass  FROM Custinfo WITH (NOLOCK) 
					 WHERE custid = u.CustID AND CustomerClass IS NOT NULL
					 AND srecommend IN (SELECT custid FROM #supers) AND roleid IN (1,2,3,4) 
					 AND Enabled = 1 AND mrecommend NOT IN (SELECT custid FROM #Dummy) ) c
	WHERE u.LogDate BETWEEN @fromdate AND @todate AND ActionID = 5566 AND TypeID = 2 AND u.LogID > @MaxLogID

	UPDATE c 
	SET c.ModifiedDate = t.CreatedDate,
		c.CategoryID = t.CategoryID,
		c.CustomerClass = t.CustomerClass,
		c.OldCustomerClass = t.OldCustomerClass
	FROM Dep_CustomerClass c WITH(UPDLOCK)
		INNER JOIN #Cust t ON c.CustID = t.custid

	INSERT INTO [Dep_CustomerClass](custid,CategoryID,CustomerClass,ModifiedDate,OldCustomerClass)
	SELECT custid, CategoryID, CustomerClass, CreatedDate, OldCustomerClass
	FROM #Cust c
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM Dep_CustomerClass WITH(NOLOCK) WHERE custid = c.custid)

	DROP TABLE #supers
	DROP TABLE #Dummy
	DROP TABLE #Cust
