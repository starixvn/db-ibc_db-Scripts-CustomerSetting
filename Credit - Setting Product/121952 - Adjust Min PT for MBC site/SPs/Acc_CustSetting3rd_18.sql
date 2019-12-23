 /*
	Created: Eden
	Date: 2019/10/14
	Task: Adjust minpt = maxpt for MBC site for CustSettingGame
	Redmine: https://nexdev.net/issues/121952
	DB: DBCUST/CUSTDB
 */
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_18]
    @custid int,
	@PT smallmoney,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN	

	DECLARE @roleid int, @srecommend int, @mrecommend int, @recommend int
	SELECT @roleid = roleid, @srecommend=srecommend, @mrecommend=mrecommend, @recommend=recommend FROM customer WITH (NOLOCK) WHERE custid = @custid

	IF @roleid = 4
	BEGIN
		UPDATE cs 
		SET cs.spositiontaking = @PT,
			cs.mpositiontaking = @PT,
			cs.apositiontaking = @PT
		FROM CustSettingGame cs WITH (ROWLOCK)
		WHERE cs.custid = @custid
			  AND cs.sporttype = 202        
			  AND cs.Bettype IN (1501,1503,1504,1505,1507,1508,1509,1511,1513,1514,1515)      
	END

	IF @roleid = 3
	BEGIN
		UPDATE cs 
		SET cs.spositiontaking = @PT,
			cs.mpositiontaking = @PT,
			cs.apositiontaking = @PT
		FROM CustSettingGame cs WITH (ROWLOCK)
		WHERE cs.custid = @srecommend
			  AND cs.sporttype = 202        
			  AND cs.Bettype IN (1501,1503,1504,1505,1507,1508,1509,1511,1513,1514,1515)

		UPDATE cs 
		SET cs.mpositiontaking = @PT
		   ,cs.spositiontaking = 0
		FROM CustSettingGame cs WITH (ROWLOCK)
		WHERE cs.custid = @custid
			  AND cs.sporttype = 202        
			  AND cs.Bettype IN (1501,1503,1504,1505,1507,1508,1509,1511,1513,1514,1515)      
	END

	IF @roleid = 2
	BEGIN
		UPDATE cs 
		SET cs.spositiontaking = @PT,
			cs.mpositiontaking = @PT,
			cs.apositiontaking = @PT
		FROM CustSettingGame cs WITH (ROWLOCK)
		WHERE cs.custid = @srecommend
			  AND cs.sporttype = 202        
			  AND cs.Bettype IN (1501,1503,1504,1505,1507,1508,1509,1511,1513,1514,1515)
			  
		UPDATE cs 
		SET cs.mpositiontaking = @PT
		FROM CustSettingGame cs WITH (ROWLOCK)
		WHERE cs.custid = @mrecommend
			  AND cs.sporttype = 202        
			  AND cs.Bettype IN (1501,1503,1504,1505,1507,1508,1509,1511,1513,1514,1515) 
		
		UPDATE cs 
		SET cs.apositiontaking = @PT,
			cs.mpositiontaking = 0
		FROM CustSettingGame cs WITH (ROWLOCK)
		WHERE cs.custid = @custid
			  AND cs.sporttype = 202        
			  AND cs.Bettype IN (1501,1503,1504,1505,1507,1508,1509,1511,1513,1514,1515)       
	END
END    
GO