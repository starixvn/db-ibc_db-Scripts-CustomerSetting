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
	
	CREATE TABLE #TempCust (CustID INT PRIMARY KEY)

	-->Hide ColossusBet
	WHILE(1=1)
	BEGIN
		TRUNCATE TABLE #TempCust

		INSERT INTO  #TempCust(CustID)
		SELECT TOP (5000) CustID
		FROM   custinfo WITH(NOLOCK)
		WHERE HideColossusBet = 0

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

EXEC dbo.Acc_CustomerInfo_Execrep_19 @target = 'REPLICATED' 	

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
-----------------------------------------------------------------------------------	



-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------	
EXEC dbo.Acc_CustomerInfo_Execrep_19 @target = 'DBCUST' 
-- END STEP 3: RUN THIS SCRIPT AT DBCUST SERVER  -----
-----------------------------------------------------------------------------------	