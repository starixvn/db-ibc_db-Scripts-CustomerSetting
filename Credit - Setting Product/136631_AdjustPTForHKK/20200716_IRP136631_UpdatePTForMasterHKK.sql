/*
	Created: 20200716@Johnson
	Task: update min/max pt for masters under GEH,GFH supers
	DB: DBCUST/CUSTDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
    @custid INT,
	@srecommend INT,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF NOT(dbo.f_CheckRepTable('custinfo') = 1 
		AND dbo.f_CheckRepTable('CustSetting') = 1 
	    AND dbo.f_CheckRepTable('CustOverride') = 1 
	    AND dbo.f_CheckRepTable('CustSettingGame') = 1 
	    AND dbo.f_CheckRepTable('CustOverrideGame') = 1 
	    AND dbo.f_CheckRepTable('CustSetting3rd') = 1 
	    AND dbo.f_CheckRepTable('CustOverride3rd') = 1 
		AND dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 1 	    		
		AND dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 1
	)
	RETURN
	
	DECLARE @PT SMALLMONEY
	
	SELECT @PT = 0.88
	
	UPDATE cs 
	SET cs.spositiontaking = @PT ,
		cs.mpositiontaking = cs.mpositiontaking + @PT - cs.spositiontaking ,
		cs.apositiontaking = cs.apositiontaking + @PT - cs.spositiontaking,
		
		cs.slivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE cs.slivepositiontaking END,
		cs.mlivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN cs.mlivepositiontaking + @PT - cs.slivepositiontaking ELSE cs.mlivepositiontaking END,
		cs.alivepositiontaking = CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) THEN cs.alivepositiontaking + @PT - cs.slivepositiontaking ELSE cs.alivepositiontaking END
	FROM CustSetting cs WITH (UPDLOCK,ROWLOCK)
	WHERE custid = @custid
		AND (cs.spositiontaking < @PT - 0.7
			OR 1= CASE WHEN sporttype = 1 and bettype IN (1,3,7,8) AND 
	
	UPDATE cs 
	SET maxpositiontaking = CASE WHEN @PT > maxpositiontaking THEN @PT ELSE maxpositiontaking END,			
		minpositiontaking = CASE WHEN @PT > minpositiontaking THEN @PT ELSE minpositiontaking END,			
		
		maxlivepositiontaking = CASE WHEN @PT > maxlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE maxlivepositiontaking END,
		minlivepositiontaking = CASE WHEN @PT > minlivepositiontaking AND sporttype = 1 and bettype IN (1,3,7,8) THEN @PT ELSE minlivepositiontaking END
	FROM custoverride cs WITH(ROWLOCK, UPDLOCK)				
	WHERE custid = @custid
	
	EXEC dbo.Acc_CustSetting_18 @srecommend = @custid, @roleid = 4, @Target = @Target						
	
	
	
END	
		
		
		