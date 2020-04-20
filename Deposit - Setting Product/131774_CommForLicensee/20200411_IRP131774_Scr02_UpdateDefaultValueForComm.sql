/*
	Created: Johnson
	Date: 2020-04-11
	Task: update default value for allbet,Macau,PP,GD,AG
	DB: DBCUST/bodb_Licensee
*/

--Deploy this sp @DBCUST/bodb_Licensee	
ALTER PROCEDURE [dbo].[Lrf_ExecRep_09] 	 
	@target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at DBCUST only
	
	IF (dbo.f_CheckRepTable('LicenseeGroupComm') = 0
		OR dbo.f_CheckRepTable('LicenseeCustComm') = 0		 		 
		)
	RETURN
	
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY)
	DECLARE @tmpCust TABLE (CustID INT)
	
	UPDATE dbo.LicenseeGroupComm with(UPDLOCK,ROWLOCK)
	SET AllbetComm = 0,
		MacauComm = 0,
		PPComm = 0,
		GDComm = 0,
		AGComm = 0
	
	INSERT INTO #tblCust (custid)
	SELECT custid 
	FROM LicenseeCustComm WITH(NOLOCK)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid
		INTO @tmpCust
		FROM #tblCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE dbo.LicenseeCustComm with(UPDLOCK,ROWLOCK)
		SET AllbetComm=0,
			MacauComm = 0,
			PPComm = 0,
			GDComm = 0,
			AGComm = 0
		WHERE custid IN (SELECT custid FROM @tmpCust)
		
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
