/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230802
	Task: Import DBCUST _ Dep customer class UAT RedmineID:#191101
	DB: DBCUST/CustDB
	Step 3 : Initial Dep customer class 
	
*/
-- BEGIN STEP 1.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST','TESTDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustomerClass') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	

	DECLARE @From INT = 0 , @To INT = 50000

	WHILE(1 =1)
	BEGIN
		
		INSERT INTO [Dep_CustomerClass](custid,CategoryID,CustomerClass,ModifiedDate,OldCustomerClass)
		SELECT custid, NULL AS CategoryID, CustomerClass, ModifiedDate, OldCustomerClass
		FROM tempDep_CustomerClass c 
		WHERE ID BETWEEN @From AND @To
			
		IF @@ROWCOUNT = 0 BREAK

		SET @From  = @To + 1
        SET @To    = @From + 50000
	END
END
GO
-- BEGIN STEP 1: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
	DECLARE @target VARCHAR(20)
	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	BEGIN
		SET @target = 'DBCUST'
	END
	ELSE 
	BEGIN	
		SET @target = 'REPLICATED'
	END
	PRINT 'Server Name : ' + @target

	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @target = @target

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

