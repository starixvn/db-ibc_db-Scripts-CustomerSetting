/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Add more stakelevel for all currencies of Pragmatic Live Casino [ RedmineID:#165157]
	DB: DBCUST/CustDB
	P/s : Step 2 Add more stakelevel for all currencies SMA level
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN

	DECLARE @Sporttype INT = 170 ,@Bettype INT  = 3701
	DECLARE @Currency INT
	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)

	CREATE TABLE #tmpSTListSMA (BettypeID INT PRIMARY KEY, StakeLevelList VARCHAR(500))

	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

	
	INSERT INTO #tmpSTListSMA(BettypeID, StakelevelList)
	SELECT DISTINCT ST.GameTypeID, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) as StakeLevelList
	FROM #SMATemp SMA CROSS JOIN StakeLevel ST
	CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId=@Currency
			FOR XML PATH ('') ) AS A(STL)
	WHERE ST.GameTypeID = @Bettype
	ORDER BY ST.GameTypeID
	
--------------------------------------BetSetting-------------------------------------------------
	--Agent Level
	UPDATE cs
	SET cs.StakeLevelList = tb.StakeLevelList	
	FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #SMATemp ci ON cs.CustID = ci.CustID
	INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON TB.BettypeID = cs.BetType
	WHERE cs.SportType = @Sporttype AND cs.BetType = @Bettype
	

	DROP TABLE #SMATemp
	DROP TABLE #tmpSTListSMA

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS (06/DBTP) -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN Custinfo c WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND c.Enabled = 1
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND ci.Site<>'CN88'
	AND ci.currency IN (47        --DDD
						,33       --IDD
						,34       --IDR
						,15       --IN
						,22       --IND
						,12       --GBP
						,67       --HKK
						,51       --INH
						,2        --RM
						,5        --HK$
						,13       --RMB
						,43       --THB
						,45       --WON
						,35       --$US
						,3        --US$
						,95       --USD
						,64       --UT
						,16       --Yen
						,69       --MMK
						,6        --EURO
						) --testing currencies

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
			
			
	waitfor delay '00:00:0.100'
END
DROP TABLE #supers

GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN Custinfo c WITH (NOLOCK) ON c.custid = ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND c.Enabled = 1
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND ci.Site<>'CN88'
	AND ci.currency IN (47        --DDD
						,33       --IDD
						,34       --IDR
						,15       --IN
						,22       --IND
						,12       --GBP
						,67       --HKK
						,51       --INH
						,2        --RM
						,5        --HK$
						,13       --RMB
						,43       --THB
						,45       --WON
						,35       --$US
						,3        --US$
						,95       --USD
						,64       --UT
						,16       --Yen
						,69       --MMK
						,6        --EURO
						) --testing currencies

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'DBCUST'
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
