/*
	Created: 20200706@Johnson
	Task: Adjust IBCBet Live Casino winlimit setting for INDOBS
	DB: DBCUST/CUSTDB	
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]		
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
		AND dbo.f_CheckRepTable('Acc_CustGroup') = 1
		AND dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 1	   		
		AND dbo.f_CheckRepTable('CustWinLossLimit_Member') = 1	   		
	   )
	RETURN
		
	CREATE TABLE #tblCust(custid INT PRIMARY KEY, roleid TINYINT, isFinished BIT DEFAULT 0)	
	CREATE TABLE #tblCustWinLossLimit TABLE(custid INT PRIMARY KEY, MaxWinLimit SMALLMONEY, MaxLossLimit MONEY,IsAutoReset BIT)
	
	INSERT INTO #tblCust(custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH (NOLOCK)
	WHERE srecommend IN (SELECT custid
						FROM Acc_CustGroup g WITH(NOLOCK)
						WHERE groupname = 'indobs'	
						)
		AND Enabled = 1
	
	--winlimit on Agent
	INSERT INTO #tblCustWinLossLimit (custid,MaxWinLimit,MaxLossLimit,IsAutoReset)
	SELECT cs1.custid, cs1.MaxWinLimit,cs1.MaxLossLimit,cs1.IsAutoReset
	FROM CustWinLossLimit_Agent cs1 WITH(NOLOCK)
		INNER JOIN CustWinLossLimit_Agent cs2 WITH(NOLOCK) ON cs1.custid = cs2.custid 		
	WHERE cs1.custid IN (SELECT custid FROM #tblCust WHERE roleid > 1)
		AND cs1.sporttype = 243
		AND cs2.sporttype = 242
		AND (cs1.MaxWinLimit <> cs2.MaxWinLimit
			OR cs1.MaxLossLimit <> cs2.MaxLossLimit
			OR cs1.IsAutoReset <> cs2.IsAutoReset
		)
	
	UPDATE cs
	SET cs.MaxWinLimit = t.MaxWinLimit,
		cs.MaxLossLimit = t.MaxLossLimit,
		cs.IsAutoReset = t.IsAutoReset
	FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCustWinLossLimit t ON cs.custid = t.custid
	WHERE cs.sporttype = 242
	
	TRUNCATE TABLE #tblCustWinLossLimit
	
	INSERT INTO #tblCustWinLossLimit (custid,MaxWinLimit,MaxLossLimit,IsAutoReset)
	SELECT cs1.custid, cs1.MaxWinLimit,cs1.MaxLossLimit,cs1.IsAutoReset
	FROM CustWinLossLimit_Member cs1 WITH(NOLOCK)
		INNER JOIN CustWinLossLimit_Member cs2 WITH(NOLOCK) ON cs1.custid = cs2.custid 		
	WHERE cs1.custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
		AND cs1.sporttype = 243
		AND cs2.sporttype = 242
		AND (cs1.MaxWinLimit <> cs2.MaxWinLimit
			OR cs1.MaxLossLimit <> cs2.MaxLossLimit
			OR cs1.IsAutoReset <> cs2.IsAutoReset
		)
	
	UPDATE cs
	SET cs.MaxWinLimit = t.MaxWinLimit,
		cs.MaxLossLimit = t.MaxLossLimit,
		cs.IsAutoReset = t.IsAutoReset
	FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCustWinLossLimit t ON cs.custid = t.custid
	WHERE cs.sporttype = 242
	
	DROP TABLE #tblCustWinLossLimit
	DROP TABLE #tblCust	
END
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_CustSetting3rd_19 @target = 'REPLICATED'	


---
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------



---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB -----
--------------------------------------------------------------------------------------
EXEC dbo.Acc_CustSetting3rd_19 @target = 'DBCUST'	

---
-- END STEP 3: RUN THIS SCRIPT AT DBCUST/CUSTDB ------
--------------------------------------------------------------------------------------
