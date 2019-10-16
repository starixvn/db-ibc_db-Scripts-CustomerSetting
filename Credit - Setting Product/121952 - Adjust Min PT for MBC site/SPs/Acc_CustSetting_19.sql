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
	
	IF @roleid = 4
	BEGIN
		
	
	IF @roleid = 2
	BEGIN
		UPDATE co
		SET minpositiontaking = cs.apositiontaking,
			minlivepositiontaking = CASE WHEN co.sporttype = 1 and co.bettype IN (1,3,7,8) THEN alivepositiontaking ELSE minlivepositiontaking END
		FROM custoverride co WITH(ROWLOCK)
			INNER JOIN dbo.custSetting cs WITH (NOLOCK) ON co.custid = cs.custid AND cs.sporttype = cs.sporttype AND cs.bettype = co.bettype
		WHERE co.custid = @custid

		EXEC dbo.Acc_CustSetting_18 @recommend = @recommend, @mrecommend = @mrecommend, @srecommend = @srecommend, @roleid = @roleid, @Target = @Target				
	END
	ELSE IF @roleid = 3
	BEGIN
		UPDATE co
		SET minpositiontaking = cs.mpositiontaking,
			minlivepositiontaking = CASE WHEN co.sporttype = 1 and co.bettype IN (1,3,7,8) THEN mlivepositiontaking ELSE minlivepositiontaking END
		FROM custoverride co WITH(ROWLOCK)
			INNER JOIN dbo.custSetting cs WITH (NOLOCK) ON co.custid = cs.custid AND cs.sporttype = cs.sporttype AND cs.bettype = co.bettype
		WHERE co.custid = @custid

		EXEC dbo.Acc_CustSetting_18 @mrecommend = @mrecommend, @srecommend = @srecommend, @roleid = @roleid, @Target = @Target					
	END
	ELSE IF @roleid= 4 
	BEGIN
		UPDATE co
		SET minpositiontaking = co.maxpositiontaking,
			minlivepositiontaking = CASE WHEN co.sporttype = 1 and co.bettype IN (1,3,7,8) THEN maxlivepositiontaking ELSE minlivepositiontaking END
		FROM custoverride co WITH(ROWLOCK)		
		WHERE co.custid = @custid

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