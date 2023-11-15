/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231013@Johnson
	Task: delete redundant Saba Games settings
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROCEDURE [dbo].[Acc_CustSetting_19]
    @custid INT,
	@maxcustid INT,
    @Target VARCHAR(20) = ''
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('customer') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN	
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
	DECLARE @tmpCust TABLE(custid INT PRIMARY KEY)
	
	INSERT INTO #tblCust(custid,roleid)
	SELECT custid, roleid
	FROM custinfo WITH(NOLOCK) 
	WHERE srecommend = @custid
		AND enabled = 1
		AND custid <= @maxcustid
	
	DELETE CustPTGroupSetting3rd_Member WITH(ROWLOCK)
	WHERE SportType = 200
		AND AgentID IN (SELECT custid FROM #tblCust WHERE roleid = 2)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid into @tmpCust(custid)
		FROM #tblCust t
		WHERE roleid > 1
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		DELETE CustPTSetting3rd_Agent WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200
		
		DELETE CustWinLossLimit_Agent WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200
			
		DELETE CustStakeLevel_Agent WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200

		DELETE @tmpCust	
	END
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (5000) t
		OUTPUT DELETED.custid into @tmpCust(custid)
		FROM #tblCust t
		WHERE roleid = 1
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		DELETE CustPTSetting3rd_Member WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200
		
		DELETE CustWinLossLimit_Member WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200
			
		DELETE CustStakeLevel_Member WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200

		DELETE @tmpCust	
	END
END	
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @custid INT,		
		@maxcustid INT,
		@Target VARCHAR(20)

SELECT @maxcustid = xxx
	
CREATE TABLE #tblSuper(CustID INT, isfinished BIT DEFAULT(0))

IF @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SELECT @Target = 'DBCUST'
ELSE 	
	SELECT @Target = 'REPLICATED'

INSERT INTO #tblSuper(custid)	
SELECT DISTINCT ci.custid
FROM vw_customer ci WITH (NOLOCK) 
    INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
    INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site 
    INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	LEFT JOIN CustPTSetting3rd_Agent pt WITH(NOLOCK) ON ci.custid = pt.custid AND pt.SportType = 200  
	LEFT JOIN CustWinLossLimit_Agent wl WITH(NOLOCK) ON ci.custid = wl.custid AND wl.SportType = 200
	LEFT JOIN CustStakeLevel_Agent sl WITH(NOLOCK) ON ci.custid = sl.custid AND sl.SportType = 200
WHERE ci.roleid = 4     
    AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
    AND s.islicensee = 0    
    AND cs.IsInternal=0       
    AND ci.username not like '3rdSuper%'   
    AND s.siteLabel <> '789y' 
    AND cu.Enabled = 1
	AND (pt.custid IS NOT NULL OR wl.custid IS NOT NULL OR sl.custid IS NOT NULL)

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #tblSuper )

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, CustID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of SMA: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #tblSuper
	SET isfinished = 1
		,@custid = custid		
	WHERE isfinished = 0
			
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	--RAISERROR (@msg, 0, 1,@index, @custid) WITH NOWAIT
	DECLARE @__msgtemp VARCHAR(200) = @msg + '- curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)
	RAISERROR (@__msgtemp, 0, 1, @index, @custid) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting_19] 
			@custid = @custid,
			@maxcustid = @maxcustid,
			@target = @target	
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #tblSuper	
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	
			   