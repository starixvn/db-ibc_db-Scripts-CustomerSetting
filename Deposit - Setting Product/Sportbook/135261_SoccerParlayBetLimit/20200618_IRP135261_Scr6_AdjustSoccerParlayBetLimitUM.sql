/*
	Created: 20200618@Johnson
	Task: adjust bet limit from soccer hdp for soccer parlay in UM
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------

ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSetting') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, mrecommend INT)
	CREATE TABLE #tblAdjustCust (custid INT PRIMARY KEY)
	DECLARE @tmpCust TABLE(Custid INT PRIMARY KEY)
	CREATE TABLE #Supers (custid INT, isFinished BIT DEFAULT(0))

	INSERT INTO #supers(custid)
	SELECT s.custid
	FROM Dep_CustSuper s WITH(NOLOCK)
	
	INSERT INTO #tblCust (custid,mrecommend)			
	SELECT custid,mrecommend
	FROM dbo.Customer WITH(NOLOCK)
	WHERE srecommend IN (SELECT custid FROM #Supers)

	DELETE #tblCust 
	WHERE mrecommend IN (SELECT custid 
						FROM dbo.custinfo WITH(NOLOCK)
						WHERE srecommend IN (SELECT custid FROM #Supers)
						AND(username like '%Acc%'  OR username like '%AFF%' OR username like '%LocalBank%')
						AND roleid=3)
	
	INSERT INTO #tblAdjustCust(custid)
	SELECT cs.custid
	FROM Dep_CustSetting cs WITH(NOLOCK)
			INNER JOIN Dep_CustSetting cs2 WITH(NOLOCK) ON cs.custid = cs2.custid 
															AND cs.sporttype = 1 AND cs.bettype = 9 AND cs.islive = 0
															AND cs2.sporttype = 1 AND cs2.bettype = 1 AND cs2.islive = 0
	WHERE cs.custid IN (SELECT custid FROM #tblCust)
		AND (cs.Minbet <> cs2.MinBet OR cs.MaxBet <> cs2.MaxBet)
	
	DECLARE @rowcount INT 
	
	WHILE(1=1)
	BEGIN		
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmpCust
		FROM #tblCustAdjust t
		
		SELECT @rowcount = @@rowcount
		
		UPDATE cs
		SET cs.MinBet = cs2.MinBet,
			cs.MaxBet = cs2.MaxBet
		FROM Dep_CustSetting cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN Dep_CustSetting cs2 WITH(NOLOCK) ON cs.custid = cs2.custid 
															AND cs.sporttype = 1 AND cs.bettype = 9 AND cs.islive = 0
															AND cs2.sporttype = 1 AND cs2.bettype = 1  AND cs2.islive = 0
		WHERE cs.custid IN (SELECT custid FROM @tmpCust)													
		
		IF @rowcount < 5000 
			BREAK;
		
		DELETE @tmpCust
		
		WAITFOR DELAY '0:0:0.01'
	END	
END	
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB -----
--------------------------------------------------------------------------------------

EXEC dbo.[Acc_CustSetting3rd_19] 
	@target = 'REPLICATED' 	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------

EXEC dbo.[Acc_CustSetting3rd_19] 
	@target = 'DBCUST' 		

---
-- AND STEP 3: Run this SP at DBCust -----
-------------------------------------------------
	