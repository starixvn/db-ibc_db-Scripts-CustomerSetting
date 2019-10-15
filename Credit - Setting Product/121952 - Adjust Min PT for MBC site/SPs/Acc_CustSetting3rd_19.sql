 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSettingGame
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
    @custid int,
	@PT smallint,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustOverrideGame') = 0 RETURN	
		
	DECLARE @roleid int, @srecommend int, @mrecommend int, @recommend int
	SELECT @roleid = roleid, @srecommend=srecommend, @mrecommend=mrecommend, @recommend=recommend FROM customer WITH (NOLOCK) WHERE custid = @custid

	UPDATE cs 
	SET cs.spositiontaking = @PT,
		cs.mpositiontaking = cs.mpositiontaking + @PT - cs.spositiontaking,
		cs.apositiontaking = cs.apositiontaking + @PT - cs.spositiontaking
	FROM CustSettingGame cs WITH (ROWLOCK)
	WHERE cs.custid = @custid
		  AND sporttype = 202

	UPDATE CustOverrideGame WITH(ROWLOCK, UPDLOCK)
	SET minpositiontaking = @PT
	WHERE custid = @custid
		AND sporttype = 202
	
	IF @roleid = 2
	BEGIN
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1501, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1503, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1504, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1505, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1507, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1508, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1509, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1511, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1513, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @srecommend = @srecommend, @mrecommend = @mrecommend, @custid = @recommend, @mode = 'Keno', @sporttype=202, @bettype = 1514, @roleid = @roleid, @Target = @Target		
	END
	ELSE IF @roleid = 3
	BEGIN
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1501, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1503, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1504, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1505, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1507, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1508, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1509, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1511, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1513, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @mrecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1514, @roleid = @roleid, @Target = @Target					
	END
	ELSE IF @roleid= 4 
	BEGIN
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1501, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1503, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1504, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1505, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1507, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1508, @roleid = @roleid, @Target = @Target		
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1509, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1511, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1513, @roleid = @roleid, @Target = @Target	
		EXEC Acc_CustSetting3rd_18 @custid = @srecommend, @srecommend = @srecommend, @mode = 'Keno', @sporttype=202, @bettype = 1514, @roleid = @roleid, @Target = @Target						
	END		
	              
END    
GO