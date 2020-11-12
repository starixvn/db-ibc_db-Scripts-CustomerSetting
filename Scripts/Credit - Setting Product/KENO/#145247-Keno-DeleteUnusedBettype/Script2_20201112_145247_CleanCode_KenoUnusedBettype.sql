/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02"></info>*/
/*
	Created: 20201112@Eden
	Task: Clean code for un-used bettype of Keno [#145247]
	DB: DBCUST/CUSTDB and DBCUST_custsetting publication
*/	
-----------------------------------------BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST.CUSTDB-----------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_18]
	@srecommend INT, 
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
				
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN
	IF dbo.f_CheckRepTable('CustOverrideGame') = 0 RETURN
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN

	CREATE TABLE #Tempcustsetting (CustID INT)
	CREATE TABLE #TempCust(CustID INT)

	INSERT INTO  #TempCust(CustID)
	SELECT c.custid
	FROM Custinfo c WITH (NOLOCK)
	WHERE c.srecommend = @srecommend

	DECLARE @Batch INT  = 500

	WHILE(1=1)
	BEGIN
		TRUNCATE TABLE #Tempcustsetting

		DELETE TOP (@Batch) a
		OUTPUT deleted.CustID INTO #Tempcustsetting(CustID)
		FROM #TempCust a
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		DELETE a
		FROM CustOverrideGame a WITH(ROWLOCK) 
			INNER JOIN #Tempcustsetting temp ON a.CustId = temp.CustID 
		WHERE  a.sporttype = 202 AND a.BetType BETWEEN 1502 AND 1514
		
		DELETE a
		FROM CustSettingGame a WITH(ROWLOCK) 
			INNER JOIN #Tempcustsetting temp ON a.CustId = temp.CustID 
		WHERE  a.sporttype = 202 AND a.BetType BETWEEN 1502 AND 1514

		DELETE a
		FROM CustGameType a WITH(ROWLOCK) 
			INNER JOIN #Tempcustsetting temp ON a.CustId = temp.CustID 
		WHERE a.GameTypeID BETWEEN 2 AND 14
	END

	DROP TABLE #Tempcustsetting
	DROP TABLE #TempCust
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
BEGIN
	DECLARE @srecommend INT
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isfinished bit default(0))
	CREATE TABLE #Keno_srecommend(CustID INT PRIMARY KEY)

	INSERT INTO #Keno_srecommend(CustID)
	SELECT srecommend 
	FROM custinfo ci WITH(NOLOCK) 
		INNER JOIN CustSettingGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
	WHERE ac.Sporttype = 202 AND ac.Bettype BETWEEN 1502 AND 1514
	UNION 		
	SELECT srecommend 
	FROM custinfo ci WITH(NOLOCK) 
		INNER JOIN CustOverrideGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
	WHERE ac.Sporttype = 202 AND ac.Bettype  BETWEEN 1502 AND 1514
	UNION
	SELECT ci.srecommend 
	FROM custinfo ci WITH(NOLOCK) 
		INNER JOIN CustGameType c WITH(NOLOCK) ON ci.CustID = c.CustId
	WHERE c.GameTypeID  BETWEEN 2 AND 14

	INSERT INTO #Supers(custid)
	SELECT ci.custid
	FROM dbo.customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH(NOLOCK) ON s.site = ci.site
	WHERE ci.roleid = 4
		AND ci.custid NOT IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.custid IN ( SELECT CustID FROM #Keno_srecommend )
		AND s.isLicensee = 0

	-- For deployer info
	DECLARE @super_cnt INT, @index INT = 0
	DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
	DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

	SET @super_cnt = (SELECT COUNT(*) FROM #supers )
	RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		UPDATE TOP (1) #Supers
		SET isfinished = 1
			,@srecommend = custid
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_CustSetting3rd_18 
				 @srecommend = @srecommend
				,@target = 'REPLICATED'
						
		WAITFOR DELAY '00:00:0.020'
	END

	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DROP TABLE #Supers
	DROP TABLE #Keno_srecommend
END
GO

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
BEGIN
	DECLARE @srecommend INT
	CREATE TABLE #Supers(CustID INT PRIMARY KEY,isfinished bit default(0))
	CREATE TABLE #Keno_srecommend(CustID INT PRIMARY KEY)

	INSERT INTO #Keno_srecommend(CustID)
	SELECT srecommend 
	FROM custinfo ci WITH(NOLOCK) 
		INNER JOIN CustSettingGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
	WHERE ac.Sporttype = 202 AND ac.Bettype BETWEEN 1502 AND 1514
	UNION 		
	SELECT srecommend 
	FROM custinfo ci WITH(NOLOCK) 
		INNER JOIN CustOverrideGame ac WITH(NOLOCK) ON ci.CustID = ac.CustId
	WHERE ac.Sporttype = 202 AND ac.Bettype  BETWEEN 1502 AND 1514
	UNION
	SELECT ci.srecommend 
	FROM custinfo ci WITH(NOLOCK) 
		INNER JOIN CustGameType c WITH(NOLOCK) ON ci.CustID = c.CustId
	WHERE c.GameTypeID  BETWEEN 2 AND 14

	INSERT INTO #Supers(custid)
	SELECT ci.custid
	FROM dbo.customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH(NOLOCK) ON s.site = ci.site
	WHERE ci.roleid = 4
		AND ci.custid NOT IN ( SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.custid IN ( SELECT CustID FROM #Keno_srecommend )
		AND s.isLicensee = 0

	-- For deployer info
	DECLARE @super_cnt INT, @index INT = 0
	DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
	DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

	SET @super_cnt = (SELECT COUNT(*) FROM #supers )
	RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		UPDATE TOP (1) #Supers
		SET isfinished = 1
			,@srecommend = custid
		WHERE isfinished = 0
	
		IF @@ROWCOUNT = 0 BREAK

		SET @index = @index + 1
		RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

		EXEC dbo.Acc_CustSetting3rd_18 
				 @srecommend = @srecommend
				,@target = 'DBCUST'
						
		WAITFOR DELAY '00:00:0.100'
	END

	PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
	DROP TABLE #Supers
	DROP TABLE #Keno_srecommend
END
GO
----------------------------------------------------------------
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----