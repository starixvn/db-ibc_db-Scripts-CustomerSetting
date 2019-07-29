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

	CREATE TABLE #Supers(CustID INT, isfinished BIT DEFAULT(0))
						
	INSERT INTO #Supers(custid)
	SELECT ci.custid 
	FROM dbo.customer c WITH (Nolock) 
		INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	WHERE ci.roleid = 4
		AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND s.islicensee = 0
	
	CREATE TABLE #TempCust (CustID INT PRIMARY KEY)

	-->Hide ColossusBet
	WHILE(1=1)
	BEGIN
		TRUNCATE TABLE #TempCust

		INSERT INTO  #TempCust(CustID)
		SELECT TOP (5000) c.CustID
		FROM   custinfo c WITH(NOLOCK)
			JOIN #Supers s ON s.CustID = c.srecommend
		WHERE c.HideColossusBet = 0

		UPDATE c
		SET HideColossusBet = 1
		FROM Custinfo c WITH(ROWLOCK)
			JOIN #TempCust tmp ON c.custid = tmp.CustID
		
		IF @@ROWCOUNT = 0
			BREAK;

		WAITFOR DELAY '00:00:00.200'
	END
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------

EXEC dbo.Acc_CustomerInfo_Execrep_19 
			@target = 'REPLICATED' 
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	



-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
EXEC dbo.Acc_CustomerInfo_Execrep_19 
			@target = 'DBCUST' 
GO
		
-- END STEP 3: RUN THIS SCRIPT AT DBCUST SERVER  -----
-----------------------------------------------------------------------------------	