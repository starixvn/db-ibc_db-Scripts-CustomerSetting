/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211019@Johnson
	Task: update DangerLevel for saba
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]	
	@CustList VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY)
	DECLARE @tmp TABLE (custid INT PRIMARY KEY)
	
	DECLARE @xml XML = CAST (@CustList as XML)
	DECLARE @batchNo INT
	
	INSERT INTO #tblCustDangerLevel (custid, DangerLevel)
	SELECT t.c.value('@id[1]','int'),
		t.c.value('@level[1]','bigint')
	FROM @xml.nodes('Root/r')as t(c)
	
		
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------			