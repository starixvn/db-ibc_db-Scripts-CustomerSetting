 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSetting (SportBook and SportBook2)
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid int,
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
	
	UPDATE custoverride WITH(ROWLOCK, UPDLOCK)
	SET minpositiontaking = maxpositiontaking, 
		minlivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN maxlivepositiontaking ELSE minlivepositiontaking END
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
	UPDATE cs 
	SET MinPT = CASE WHEN @roleid = 4 THEN CS.SuperPT
					 WHEN @roleid = 3 THEN CS.MasterPT
					 WHEN @roleid = 2 THEN CS.AgentPT
				END
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