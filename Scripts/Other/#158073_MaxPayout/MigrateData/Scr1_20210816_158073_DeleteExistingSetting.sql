/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210816
	Task: Delete existing data of CustBetSetting_Agent and CustBetSetting_Member tables [Redmine: #154048]   
	DB: DBCUST/CUSTDB and all subscribers of CustDB_CustSetting publication
*/

-- STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	 @target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting_Member') = 0 RETURN

	--Delete SMA Setting
	WHILE 1 = 1
	BEGIN
		DELETE TOP (5000)
		FROM CustBetSetting_Agent WITH(ROWLOCK,UPDLOCK)

		IF @@ROWCOUNT < 5000
			BREAK

		WAITFOR DELAY '00:00:0.01'
	END

	--Delete Member Setting
	WHILE 1 = 1
	BEGIN
		DELETE TOP (5000)
		FROM CustBetSetting_Member WITH(ROWLOCK,UPDLOCK)

		IF @@ROWCOUNT < 5000
			BREAK

		WAITFOR DELAY '00:00:0.01'
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

EXEC dbo.Acc_DynamicCustSetting3rd_09 @target = @target

GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------