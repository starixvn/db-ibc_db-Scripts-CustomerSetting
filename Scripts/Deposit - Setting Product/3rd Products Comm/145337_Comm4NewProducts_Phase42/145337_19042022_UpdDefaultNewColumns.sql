/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*
	Created: 20220419@Winfred
	Task: Update Creative Gaming, VS3 , AdvantPlay and AdvantPlay Mini  commission  for  LicenseeCustComm, LicenseeGroupComm  [Redmine: #145337]  
	DB: DBCUST/bodb_Licensee
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.bodb_Licensee --------
------------------------------------------------------	
ALTER PROCEDURE [dbo].[Lrf_ExecRep_09] 	 
	@target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('LicenseeGroupComm') = 0
		OR dbo.f_CheckRepTable('LicenseeCustComm') = 0		 		 
		)
	RETURN
	
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY)
	DECLARE @tmpCust TABLE (CustID INT)
	
	
	UPDATE dbo.LicenseeGroupComm WITH(UPDLOCK, ROWLOCK)
	SET CGComm = 0, AdvantComm = 0, AdvantMiniComm = 0, VS3Comm = 0
	
	INSERT INTO #tblCust (custid)
	SELECT custid 
	FROM LicenseeCustComm WITH(NOLOCK)
	
	WHILE(1=1)
	BEGIN
		DELETE @tmpCust 
		
		DELETE TOP (4500) t
		OUTPUT DELETED.custid
		INTO @tmpCust
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE ls 
		SET CGComm = 0, AdvantComm = 0, AdvantMiniComm = 0, VS3Comm = 0
		FROM dbo.LicenseeCustComm ls WITH(ROWLOCK)	
			INNER JOIN @tmpCust tc ON ls.custid = tc.custid 
		
		WAITFOR DELAY '00:00:0.280'
	END		
END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.bodb_Licensee --------
------------------------------------------------------	


-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
EXEC Lrf_ExecRep_09 'REPLICATED'
GO

-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) -----
-----------------------------------------------------------------------------------	


-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
EXEC Lrf_ExecRep_09 'DBCUST'

-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------

