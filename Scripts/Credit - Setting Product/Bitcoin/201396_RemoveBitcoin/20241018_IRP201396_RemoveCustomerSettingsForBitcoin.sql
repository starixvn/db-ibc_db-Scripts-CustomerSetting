/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20241018@Johnson
	Task: remove customer settings for bitcoin [redmine: #201396]
	DB: DBCUST/CUSTDB
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','DBSPARE','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','DBSPARE','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
	DECLARE @BatchCust TABLE (custid INT PRIMARY KEY)
	DECLARE @Sporttype INT = 175,
			@Bettype INT = 7901
			
	INSERT INTO #tblCust(custid,roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend 
		AND Enabled = 1 
		AND custid <= @maxcustid 
	
	DELETE cs
	FROM CustPTGroupSetting3rd_Member cs WITH(ROWLOCK)
	WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 2)
		AND Sporttype = @Sporttype
		AND Bettype = @Bettype
			
	WHILE (1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid INTO @BatchCust(custid)
		FROM #tblCust t
		WHERE roleid > 1
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		DELETE cs
		FROM CustBetSetting3rd_Agent cs WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
			AND Sporttype = @Sporttype
			AND Bettype = @Bettype
			
		DELETE cs
		FROM CustPTSetting3rd_Agent cs WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
			AND Sporttype = @Sporttype
			AND Bettype = @Bettype	
		
		DELETE cs
		FROM CustDiscount3rd_Agent cs WITH(ROWLOCK)
		WHERE custid IN (SELECT custid FROM @BatchCust)
			AND Sporttype = @Sporttype
			AND Bettype = @Bettype	
		
		DELETE @BatchCust	
	END
	
END	
