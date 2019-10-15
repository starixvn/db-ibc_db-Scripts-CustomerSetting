 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSettingGame
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
    @custid int,
	@PT smallmoney,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN	

	UPDATE cs 
	SET cs.spositiontaking = @PT,
		cs.mpositiontaking = cs.mpositiontaking + @PT - cs.spositiontaking,
		cs.apositiontaking = cs.apositiontaking + @PT - cs.spositiontaking
	FROM CustSettingGame cs WITH (ROWLOCK)
	WHERE cs.custid = @custid
		  AND sporttype = 202              
END    
GO