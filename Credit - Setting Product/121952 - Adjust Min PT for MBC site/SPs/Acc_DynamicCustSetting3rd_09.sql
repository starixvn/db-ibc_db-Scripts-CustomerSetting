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
	@PT tinyint
AS
BEGIN
	SET NOCOUNT ON
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	

	DECLARE @roleid int, @srecommend int, @mrecommend int, @recommend int
	SELECT @roleid = roleid, @srecommend=srecommend, @mrecommend=mrecommend, @recommend=recommend FROM customer WITH (NOLOCK) WHERE custid = @custid

	IF @roleid = 4
	BEGIN
		UPDATE cs 
		SET cs.MaxPT = @PT,
			cs.SuperPT  =  @PT ,
			cs.MasterPT =  cs.MasterPT + @PT - cs.SuperPT ,
			cs.AgentPT  =  cs.AgentPT + @PT - cs.SuperPT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype IN (212,220,180,181,182,183,184,185,186,190,191,192,193) -- Macau, Lottery, Virtual Sports
			  AND cs.CustID = @custid
	END

	IF @roleid = 3
	BEGIN
		UPDATE cs 
		SET cs.SuperPT = @PT,
			cs.MasterPT = @PT,					
			cs.AgentPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype IN (212,220,180,181,182,183,184,185,186,190,191,192,193) -- Macau, Lottery, Virtual Sports
			AND cs.CustID = @srecommend
	
		UPDATE cs 
		SET cs.MasterPT = @PT,
			cs.MaxPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype IN (212,220,180,181,182,183,184,185,186,190,191,192,193) -- Macau, Lottery, Virtual Sports
			AND cs.CustID = @custid
	END

	IF @roleid = 2
	BEGIN
		UPDATE cs 
		SET cs.SuperPT = @PT,
			cs.MasterPT = @PT,					
			cs.AgentPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype IN (212,220,180,181,182,183,184,185,186,190,191,192,193) -- Macau, Lottery, Virtual Sports
			AND cs.CustID = @srecommend

		UPDATE cs 
		SET cs.MasterPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype IN (212,220,180,181,182,183,184,185,186,190,191,192,193) -- Macau, Lottery, Virtual Sports
			AND cs.CustID = @mrecommend
	
		UPDATE cs 
		SET cs.AgentPT = @PT,
			cs.MaxPT = @PT
		FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
		WHERE cs.sporttype IN (212,220,180,181,182,183,184,185,186,190,191,192,193) -- Macau, Lottery, Virtual Sports
			AND cs.CustID = @custid
	END            
END    
GO