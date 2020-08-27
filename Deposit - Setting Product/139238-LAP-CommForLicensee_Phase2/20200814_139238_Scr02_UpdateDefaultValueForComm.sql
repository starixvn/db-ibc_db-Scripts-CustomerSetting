/*
	Created: Helen
	Date: 20200814
	Task: LAP - Offer commission to 3rd party products - Phase 2 - [Redmine: #139238]   
	DB: DBCUST/bodb_Licensee
*/

--Deploy this sp @DBCUST/bodb_Licensee	
ALTER PROCEDURE [dbo].[Lrf_ExecRep_09] 	 
	@target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('LicenseeGroupComm') = 0
		OR dbo.f_CheckRepTable('LicenseeCustComm') = 0		 		 
		)
	RETURN
	
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY)
	DECLARE @tmpCust TABLE (CustID INT)
	
	UPDATE dbo.LicenseeGroupComm with(UPDLOCK,ROWLOCK)
		SET SexyGamingComm = 0
			,SpadeGamingComm = 0
			,KenoComm = 0
			,LotteryComm = 0
			,VSComm = 0
			,VS2Comm = 0
			,TableGameComm = 0
			,CardClubComm = 0
			,SabaclubComm = 0
			,VirtualGamesComm = 0
	
	INSERT INTO #tblCust (custid)
	SELECT custid 
	FROM LicenseeCustComm WITH(NOLOCK)
	
	WHILE(1=1)
	BEGIN
		DELETE @tmpCust 
		
		DELETE TOP (5000) t
		OUTPUT DELETED.custid
		INTO @tmpCust
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE ls 
			SET  SexyGamingComm = 0
				,SpadeGamingComm = 0
				,KenoComm = 0
				,LotteryComm = 0
				,VSComm = 0
				,VS2Comm = 0
				,TableGameComm = 0
				,CardClubComm = 0
				,SabaclubComm = 0
				,VirtualGamesComm = 0
		FROM dbo.LicenseeCustComm ls WITH(ROWLOCK)	
			INNER JOIN @tmpCust tc ON ls.custid = tc.custid 
		
		WAITFOR DELAY '0:0:0.01'
	END		
END	
GO


-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
EXEC Lrf_ExecRep_09 'REPLICATED'


-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (/06/DBTP) -----
-----------------------------------------------------------------------------------	


---
---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
EXEC Lrf_ExecRep_09 'DBCUST'

-- END STEP 3: RUN THIS SCRIPT AT DBCUST -----
-----------------------------------------------------------------------------------
