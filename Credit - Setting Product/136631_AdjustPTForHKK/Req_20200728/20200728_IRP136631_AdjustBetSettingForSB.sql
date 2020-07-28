/*
	Created: 20200728@Johnson
	Task: update minbet for HKK's supers
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting_18]	
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	IF NOT(dbo.f_CheckRepTable('custinfo') = 1 
		AND dbo.f_CheckRepTable('customer') = 1
		AND dbo.f_CheckRepTable('CustSetting') = 1
		AND dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
		AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1	
		)
	RETURN
		
	CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))
	CREATE TABLE #tblAdjust (custid INT, sporttype INT, Bettype INT)
		
	INSERT INTO #Supers(custid)
	SELECT custid
	FROM customer WITH(NOLOCK)
	WHERE currency = 67
		AND roleid = 4
		AND site IN ('733333','222223','722222')
	
	INSERT INTO #tblAdjust(custid,sporttype,bettype)
	SELECT cs.custid, sporttype, bettype
	FROM CustSetting cs WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)
		AND Enabled = 1
		AND minbet NOT IN (0,10)	
		AND MaxBet >= 10
	
	UPDATE cs
	SET MinBet = CASE WHEN MaxBet >= 10 THEN 10 ELSE MinBet END
	FROM CustSetting cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblAdjust t ON cs.custid = t.custid
								AND cs.sporttype = t.sporttype
								AND cs.bettype = t.bettype
	WHERE minbet NOT IN (0,10)
	
	--update SB2
	TRUNCATE TABLE #tblAdjust
	
	INSERT INTO #tblAdjust(custid,sporttype,bettype)
	SELECT cs.custid, sporttype, bettype
	FROM CustBetSetting3rd_Agent cs WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)
		AND Enabled = 1
		AND roleid IN (2,3,4)
		AND cs.sporttype IN (43,44)
		AND minbet NOT IN (0,10)	
		AND MaxBet >= 10
	
	UPDATE cs
	SET MinBet = CASE WHEN MaxBet >= 10 THEN 10 ELSE MinBet END
	FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblAdjust t ON cs.custid = t.custid
								AND cs.sporttype = t.sporttype
								AND cs.bettype = t.bettype
	WHERE minbet NOT IN (0,10)
	
	--update member SB2
	TRUNCATE TABLE #tblAdjust
	
	INSERT INTO #tblAdjust(custid,sporttype,bettype)
	SELECT cs.custid, sporttype, bettype
	FROM CustBetSetting3rd_Member cs WITH(NOLOCK)
		INNER JOIN custinfo ci WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)
		AND Enabled = 1
		AND roleid = 1
		AND cs.sporttype IN (43,44)
		AND minbet NOT IN (0,10)	
		AND MaxBet >= 10
	
	UPDATE cs
	SET MinBet = CASE WHEN MaxBet >= 10 THEN 10 ELSE MinBet END
	FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblAdjust t ON cs.custid = t.custid
								AND cs.sporttype = t.sporttype
								AND cs.bettype = t.bettype
	WHERE minbet NOT IN (0,10)

	DROP TABLE #supers
	DROP TABLE #tblAdjust
END	
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------

EXEC dbo.[Acc_CustSetting_18] @target = 'REPLICATED' 	

---
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------


---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------

EXEC dbo.[Acc_CustSetting_18] @target = 'DBCUST' 	

---
-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
