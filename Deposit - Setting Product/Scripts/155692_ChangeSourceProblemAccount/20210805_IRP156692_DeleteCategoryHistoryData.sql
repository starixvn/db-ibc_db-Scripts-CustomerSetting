/*
	Created: 20210805@Johnson
	Task: Delete Dep_CustCategoryHistory to re-import 
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	
ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
 	@target VARCHAR(20)	
AS
BEGIN	
	SET NOCOUNT ON;
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB230\SQLSERVER2008R2','DB233')) RETURN -- run at dbcust only
	
	IF (dbo.f_CheckRepTable('Dep_CustCategoryHistory') = 0		 		 		
		)
	RETURN
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) Dep_CustCategoryHistory WITH(UPDLOCK)
		WHERE createddate <= '2021-07-29 22:52:48.000' --maxdate of last scan from CTS
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		WAITFOR DELAY '0:0:0.28'
	END
END	
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_CustSetting_19 @target = 'REPLICATED'
--END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_CustSetting_19 @target = 'DBCUST'
--END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
