/*
	Created: Winnie
	Task: Initial PT setting on BMAIO - UUS - [Redimine:#119713]
	DB: DBCUST/CustDB
	Date: 20190913
*/ 

ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('custsetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custoverride') = 0 RETURN

	CREATE TABLE #DownlineListTemp
	(
		CustID	INT PRIMARY KEY CLUSTERED
	)
	CREATE TABLE #TempBatch
	(
		CustID	INT PRIMARY KEY CLUSTERED	
	)	

	INSERT INTO #DownlineListTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND custid <= @maxcustid
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #DownlineListTemp)
	BEGIN
		DELETE TOP (2000) #DownlineListTemp OUTPUT DELETED.* INTO #TempBatch

		IF @@ROWCOUNT=0
			BREAK		

		INSERT INTO custsetting (custid, sporttype,Bettype,apositiontaking, mpositiontaking, spositiontaking, alivepositiontaking, mlivepositiontaking, slivepositiontaking
					, playerdiscount, discount, adiscount, sdiscount, groupa, groupb, groupc, groupd, groupe, groupf, minbet, maxbet
					, autopositiontaking, autolivepositiontaking, isautopositiontaking, isautolivepositiontaking, autompositiontaking, autolivempositiontaking, isautompositiontaking, isautolivempositiontaking	)
	
		SELECT t.custid, cs.sporttype,9999,cs.apositiontaking, cs.mpositiontaking, cs.spositiontaking, cs.alivepositiontaking, cs.mlivepositiontaking, cs.slivepositiontaking
					, csb.playerdiscount, csb.discount, csb.adiscount, csb.sdiscount, 0, 0, 0, 0, 0, 0, csb.minbet,csb.maxbet
					, cs.autopositiontaking, cs.autolivepositiontaking, cs.isautopositiontaking, cs.isautolivepositiontaking, cs.autompositiontaking, cs.autolivempositiontaking, 
					cs.isautompositiontaking, cs.isautolivempositiontaking
			FROM #TempBatch t
				INNER JOIN custsetting cs (NOLOCK) ON t.CustID = cs.custid AND cs.bettype = 1 AND cs.sporttype = 99 
				INNER JOIN custsetting csb (NOLOCK) ON t.CustID = csb.custid AND csb.bettype = 20 AND csb.sporttype = 99 	
	
		INSERT INTO custoverride (custid, bettype, sporttype, minpositiontaking, maxpositiontaking, minlivepositiontaking, maxlivepositiontaking)
		SELECT temp_pt.custid, 9999, sporttype, minpositiontaking, maxpositiontaking, minlivepositiontaking, maxlivepositiontaking
		FROM #TempBatch temp_pt
			INNER JOIN custoverride cs (NOLOCK) ON temp_pt.CustID = cs.custid		
		WHERE  cs.bettype = 1 AND cs.sporttype = 99 			 

		TRUNCATE TABLE #TempBatch
	END
	
	DROP TABLE #DownlineListTemp
	
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND ci.currency=20

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

	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.100'
END
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'	
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND ci.currency=20

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
			
	EXEC dbo.[Acc_CustSetting3rd_19] @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
			
			
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
