 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for DynamicCustSetting3rd.
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
    @custid int,
    @Target VARCHAR(20) = '',
	@PT tinyint,
	@SportBettypeXML NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	

	UPDATE cs 
	SET cs.SuperPT = @PT,
		cs.MasterPT = cs.MasterPT + @PT - cs.SuperPT,
		cs.AgentPT = cs.AgentPT + @PT - cs.SuperPT,
		MaxPT = @PT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	WHERE cs.custid = @custid
		AND sporttype IN (248,212,220,180,181,182,183,184,185,186,190,191,192,193,199) --PP, Macau, Lottery, Virtual Sports
	              
END    
GO