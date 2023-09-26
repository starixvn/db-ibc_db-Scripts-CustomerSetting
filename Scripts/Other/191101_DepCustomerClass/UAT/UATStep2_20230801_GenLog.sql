/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: Winfred
	Date: 20230802
	Task:  Initial table Dep customer class UAT RedmineID:#191101
	DB: DBLOG/bodb_CustomerLog
	Step 2 : Generate log data from DBLog
*/

	USE [bodb_CustomerLog]
	GO

	IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;
	
	IF	OBJECT_ID('tempDep_CustomerClass') IS NOT NULL
		DROP TABLE	tempDep_CustomerClass;
	CREATE TABLE tempDep_CustomerClass (custid INT PRIMARY KEY,CustomerClass SMALLINT, ModifiedDate DATETIME, OldCustomerClass SMALLINT)

	DECLARE @max_custid INT, @MaxLogID BIGINT

	SELECT @max_custid = xxx, @MaxLogID = yyy

	CREATE TABLE #Cust (custid INT PRIMARY KEY,CustomerClass SMALLINT, CreatedDate DATETIME, isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpCust (custid INT PRIMARY KEY,CustomerClass SMALLINT, CreatedDate DATETIME, 
						OldCustomerClass SMALLINT, isfinished BIT DEFAULT(0))

	CREATE TABLE #supers (custid INT)
	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM bodb02.dbo.custInfo ci WITH (NOLOCK) 	
		INNER JOIN bodb02.dbo.Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'	
		AND ci.CustID <= @max_custid
		AND ci.Enabled=1
		AND cs.site IN('Athena000')
		AND ci.currency in (20) -- UUS
	ORDER BY ci.custid 

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM bodb02.dbo.custInfo WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

	INSERT INTO #Cust(CustID,CustomerClass)
	SELECT custid, CustomerClass
	FROM bodb02.dbo.Custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (1,2,3,4) 
	AND Enabled = 1 AND custid <= @max_custid 
	AND CustomerClass IS NOT NULL
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	DECLARE @fromdate DATETIME = '2022-10-10 03:39:17.157', @todate DATETIME 
	SELECT @todate = dateadd(day,1,GETDATE())

	DECLARE @batch int = 10000
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Cust)
	BEGIN	
	
		DELETE TOP (@batch) #Cust 
		OUTPUT DELETED.CustID,DELETED.CustomerClass 
		INTO #tmpCust(CustID,CustomerClass)

		IF @@ROWCOUNT=0
			BREAK		

		UPDATE a
		SET a.CreatedDate = b.LogDate,
			a.OldCustomerClass = CASE WHEN b.OldCustomerClass <> '' THEN b.OldCustomerClass ELSE NULL END
		FROM #tmpCust a
			CROSS APPLY (SELECT TOP 1 LogDate, 
							REVERSE(SUBSTRING(REVERSE(REPLACE(Doing,'38 - ','')), 0, CHARINDEX(' - ', REVERSE(REPLACE(Doing,'38 - ',''))))) AS OldCustomerClass
						FROM UserLog_UserControl WITH(NOLOCK) 
						WHERE CustID = a.CustID AND LogDate BETWEEN @fromdate AND @todate 
							AND ActionID = 5566 AND TypeID = 2 AND LogID <= @MaxLogID
						ORDER BY LogDate DESC) b

		INSERT INTO [tempDep_CustomerClass](custid,CustomerClass,ModifiedDate,OldCustomerClass)
		SELECT custid, CustomerClass, CreatedDate, OldCustomerClass
		FROM #tmpCust c
		
		TRUNCATE TABLE #tmpCust			
	END  

	DROP TABLE #Dummy
	DROP TABLE #supers
	DROP TABLE #Cust
	DROP TABLE #tmpCust