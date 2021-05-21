/*
	Created: 20210521@Johnson
	Task: NAP - Update all ABI 50 to Ori 50
	DB: DBCust-CustDB
*/

ALTER PROCEDURE [dbo].[Acc_ExecRep_Cust_19]
	@Target VARCHAR(20) = ''	
AS
BEGIN
    SET NOCOUNT ON
    
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('custinfo') <> 1 	  
	   RETURN
	   
	CREATE TABLE #tblCust (custid INT PRIMARY KEY)
	
	INSERT INTO #tblCust (custid)
	SELECT custid
	FROM custinfo WITH(NOLOCK)
	WHERE danger2 = 50
		AND enabled = 1
	
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.CustID INTO @tmpCust(custid)
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		UPDATE custinfo WITH(ROWLOCK)
		SET danger2 =0,
			danger = 50
		WHERE custid IN (SELECT custid FROM @tmpCust)
		
		DELETE @tmpCust
		
		WAITFOR DELAY '0:0:0.28'
	END
	
END   
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_ExecRep_Cust_19 @target = 'REPLICATED' 


-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CustDB SERVER -----
--------------------------------------------------------------------------------------
EXEC Acc_ExecRep_Cust_19 @target = 'DBCUST' 


-- END STEP 2: RUN THIS SCRIPT AT DBCUST/CustDB SERVER -----
--------------------------------------------------------------------


