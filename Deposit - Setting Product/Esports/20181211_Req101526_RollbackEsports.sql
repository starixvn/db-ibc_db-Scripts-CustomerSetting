/*
	Created: Winnie
	Date: 20181211
	Task: Rollback Deposit Esports
	DB: DBCust/CustDB
*/
 
 -- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON	
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('Dep_CustSettingMode') = 0 RETURN
	
	UPDATE Dep_CustSettingMode WITH(ROWLOCK)
		SET IsGroupedPT=1
	WHERE IsGroupedPT=0

END	
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
EXEC Acc_DynamicCustSetting3rd_09 @target = 'REPLICATED'

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_DynamicCustSetting3rd_09 @target = 'DBCUST'
