 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSetting (SportBook and SportBook2)
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid int,
	@PT smallmoney,
	@SportBettypeXML NVARCHAR(MAX),
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustOverride') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	
		
	DECLARE @roleid int, @srecommend int, @mrecommend int, @recommend int
	SELECT @roleid = roleid, @srecommend=srecommend, @mrecommend=mrecommend, @recommend=recommend FROM customer WITH (NOLOCK) WHERE custid = @custid

	--> FOR SportBook
	UPDATE cs 
	SET cs.spositiontaking = @PT,
		cs.mpositiontaking = cs.mpositiontaking + @PT - cs.spositiontaking,
		cs.apositiontaking = cs.apositiontaking + @PT - cs.spositiontaking
	FROM CustSetting cs WITH (ROWLOCK)
	WHERE cs.custid = @custid

	UPDATE custoverride WITH(ROWLOCK, UPDLOCK)
	SET minpositiontaking = @PT, 
		minlivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE minlivepositiontaking END,
		maxpositiontaking = @PT,
		maxlivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE maxlivepositiontaking END
	WHERE custoverride.custid = @custid
	
	IF @roleid = 2
	BEGIN
		EXEC dbo.Acc_CustSetting_18 @recommend = @recommend, @mrecommend = @mrecommend, @srecommend = @srecommend, @roleid = @roleid, @Target = @Target				
	END
	ELSE IF @roleid = 3
	BEGIN
		EXEC dbo.Acc_CustSetting_18 @mrecommend = @mrecommend, @srecommend = @srecommend, @roleid = @roleid, @Target = @Target					
	END
	ELSE IF @roleid= 4 
	BEGIN
		EXEC dbo.Acc_CustSetting_18 @srecommend = @srecommend, @roleid = @roleid, @Target = @Target						
	END		

	--> FOR Muay Thai, E-Sports
	DECLARE @DCS_PT tinyint
	SET @DCS_PT = @PT * 100

	UPDATE cs 
	SET cs.SuperPT = @DCS_PT,
		cs.MasterPT = cs.MasterPT + @DCS_PT - cs.SuperPT,
		cs.AgentPT = cs.AgentPT + @DCS_PT - cs.SuperPT,
		MinPT = @DCS_PT
	FROM CustPTSetting3rd_Agent cs WITH (ROWLOCK)
	WHERE cs.custid = @custid
		AND SportType IN (43,44)

	EXEC dbo.Acc_DynamicCustSetting3rd_08 
				@AgentID = @recommend
				,@MasterID = @mrecommend
				,@SuperID = @srecommend
				,@roleid = @roleid
				,@SportBettypeXML = @SportBettypeXML
				,@Target = @Target
	              
END    
GO