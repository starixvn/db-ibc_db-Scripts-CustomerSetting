/*
	Created by: Eden
	Date: 2019-07-24
	Task: Hide ColossusBet
*/ 
---------------------------------------------------------------
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].Acc_CustomerInfo_Execrep_19
	@target VARCHAR(20)	
AS
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
				
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	
	-->Hide ColossusBet
	UPDATE c
	SET HideColossusBet = 1
	FROM Custinfo c WITH(ROWLOCK)
		JOIN #TempCust tmp ON c.custid = tmp.CustID

END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
BEGIN
	CREATE TABLE #Supers(CustID INT PRIMARY KEY)
	CREATE TABLE #TempUpdateCustList (CustID INT ,ID INT IDENTITY(1,1) PRIMARY KEY)		
	CREATE TABLE #TempCust(CustID INT PRIMARY KEY)

	INSERT INTO #Supers(custid)
	SELECT ci.custid 
	FROM dbo.customer c WITH (NOLOCK) 
		INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	WHERE ci.roleid = 4
		AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND s.islicensee = 0

	INSERT INTO  #TempUpdateCustList(CustID)
	SELECT c.CustID
	FROM   custinfo c WITH(NOLOCK)
		INNER JOIN #Supers s ON s.CustID = c.srecommend
	WHERE c.HideColossusBet = 0

	DECLARE @TotalRow INT = 0
	DECLARE @Threshold INT = 2000
	DECLARE @FromID INT = 1
	DECLARE @ToID INT = @Threshold
	

	SELECT @TotalRow = ISNULL(MAX(ID),0) FROM #TempUpdateCustList

	WHILE(1=1)
	BEGIN
		TRUNCATE TABLE #TempCust

		INSERT INTO  #TempCust(CustID)
		SELECT c.CustID
		FROM  #TempUpdateCustList c
		WHERE ID BETWEEN @FromID AND @ToID

		EXEC dbo.Acc_CustomerInfo_Execrep_19 
			@target = 'REPLICATED' 
			
		SELECT @FromID = @FromID + @Threshold
		SELECT @ToID = @ToID + @Threshold

		IF @FromID > @TotalRow
			BREAK;

		WAITFOR DELAY '00:00:00.200'	
	END

	DROP TABLE #Supers
	DROP TABLE #TempCust
	DROP TABLE #TempUpdateCustList
END
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	



-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
BEGIN
	CREATE TABLE #Supers(CustID INT PRIMARY KEY)
	CREATE TABLE #TempUpdateCustList (CustID INT ,ID INT IDENTITY(1,1) PRIMARY KEY)		
	CREATE TABLE #TempCust(CustID INT PRIMARY KEY)

	INSERT INTO #Supers(custid)
	SELECT ci.custid 
	FROM dbo.customer c WITH (NOLOCK) 
		INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	WHERE ci.roleid = 4
		AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND s.islicensee = 0

	INSERT INTO  #TempUpdateCustList(CustID)
	SELECT c.CustID
	FROM   custinfo c WITH(NOLOCK)
		INNER JOIN #Supers s ON s.CustID = c.srecommend
	WHERE c.HideColossusBet = 0

	DECLARE @TotalRow INT = 0
	DECLARE @Threshold INT = 2000
	DECLARE @FromID INT = 1
	DECLARE @ToID INT = @Threshold
	

	SELECT @TotalRow = ISNULL(MAX(ID),0) FROM #TempUpdateCustList

	WHILE(1=1)
	BEGIN
		TRUNCATE TABLE #TempCust

		INSERT INTO  #TempCust(CustID)
		SELECT c.CustID
		FROM  #TempUpdateCustList c
		WHERE ID BETWEEN @FromID AND @ToID

		EXEC dbo.Acc_CustomerInfo_Execrep_19 
			@target = 'DBCUST' 
			
		SELECT @FromID = @FromID + @Threshold
		SELECT @ToID = @ToID + @Threshold

		IF @FromID > @TotalRow
			BREAK;

		WAITFOR DELAY '00:00:00.200'	
	END

	DROP TABLE #Supers
	DROP TABLE #TempCust
	DROP TABLE #TempUpdateCustList
END
GO
-- END STEP 3: RUN THIS SCRIPT AT DBCUST SERVER  -----
-----------------------------------------------------------------------------------	
