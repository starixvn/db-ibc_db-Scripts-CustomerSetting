/*
	Created: 20200626@Johnson
	Task: update PT for ION, BBIN, SA Gaming for INDOBS
	DB: DBCUST/CUSTDB	
*/

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
	@srecommend INT,	
	@maxcustid INT,	
	@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
	   AND dbo.f_CheckRepTable('CustProductStatus') = 1	   
	   )
		RETURN
		
		
		
END		