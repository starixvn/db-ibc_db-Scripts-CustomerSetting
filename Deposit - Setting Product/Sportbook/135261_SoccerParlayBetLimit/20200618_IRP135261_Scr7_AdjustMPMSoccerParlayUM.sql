/*
	Created: 20200618@Johnson
	Task: adjust bet limit from soccer hdp for soccer parlay in UM
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
------------------------------------------------------

ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_CustSuper') = 0 RETURN	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN	
	
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
	SELECT custid
	FROM custinfo WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tblCust)
		AND maxpermatch1mp <> maxpermatch
	
	DECLARE @rowcount INT 
	
	WHILE(1=1)
	BEGIN		
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @tmpCust
		FROM #tblAdjustCust t
		
		SELECT @rowcount = @@rowcount
		
		UPDATE ci
		SET maxpermatch1mp = maxpermatch
		FROM custinfo ci WITH(UPDLOCK,ROWLOCK)
		WHERE custid IN (SELECT custid FROM @tmpCust)													
		
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

EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
	@target = 'REPLICATED' 	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	

---
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------

EXEC dbo.[Acc_CustomerInfo_Execrep_09] 
	@target = 'DBCUST' 		

---
-- AND STEP 3: Run this SP at DBCust -----
-------------------------------------------------
	