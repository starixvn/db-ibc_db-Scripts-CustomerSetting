/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220706
	Task: WM - Remove highest bet limit of IDR currency (DDD, IDD, IND, IN, IDR) for IBCIndo and INDO RedmineID:#174840
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]	
	@srecommend INT
	, @maxcustid INT
	, @currency INT	
	, @target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB-60\DEVDBCUST','TESTDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB-60\DEVDBCUST','TESTDBCUST')) RETURN -- run at dbtrans only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	
	DECLARE @batch SMALLINT = 5000
	DECLARE @tmpStakeExcluded TABLE (StakeLevelID INT, GameTypeID INT)
	
	INSERT INTO @tmpStakeExcluded(StakeLevelID,GameTypeID)
	SELECT StakeLevelID,GameTypeID
	FROM StakeLevel WITH(NOLOCK)
	WHERE GameTypeID IN (3401) AND ExchangeId = @currency AND MinStake = 500 AND MaxStake = 50000
		
	CREATE TABLE #CustStakeLevelDownlines (
				CustID INT 
				,DirectUplineID INT		
				,roleid TINYINT
				,Bettype INT
				,StakeLevelList VARCHAR(100)
				,StakeLevelList_new VARCHAR(100)	
				,isfinished BIT DEFAULT(0)						
				, PRIMARY KEY CLUSTERED (CustID,Bettype)
		)

	CREATE TABLE #tmpCustTemp		(CustID INT ,Bettype INT,StakeLevelList VARCHAR(100),StakeLevelList_new VARCHAR(100), PRIMARY KEY CLUSTERED (CustID,Bettype))
	CREATE TABLE #tmpSMATemp		(CustID INT ,Bettype INT,StakeLevelList VARCHAR(100),StakeLevelList_new VARCHAR(100), PRIMARY KEY CLUSTERED (CustID,Bettype))
		
	INSERT INTO #CustStakeLevelDownlines (CustID,DirectUplineID, roleid ,Bettype ,StakeLevelList,StakeLevelList_new)
	SELECT ci.custid,
		  CASE 
				WHEN ci.roleid = 3 THEN srecommend
				WHEN ci.roleid = 2 THEN mrecommend				 	
		  END AS DirectUplineID,		
		 ci.roleid,cs.Bettype,cs.StakeLevelList,cs.StakeLevelList
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Agent cs WITH(NOLOCK) ON ci.custid = cs.custid			
	WHERE ci.srecommend = @srecommend
		AND roleid IN (2,3,4)
		AND Bettype IN (SELECT GameTypeID FROM @tmpStakeExcluded)
		AND ci.Enabled=1
		AND ci.custid<=@maxcustid
	UNION ALL
	SELECT ci.custid,
		  recommend as DirectUplineID,		
		 ci.roleid,cs.bettype,cs.StakeLevelList,cs.StakeLevelList
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Member cs WITH(NOLOCK) ON ci.custid = cs.custid			
	WHERE ci.srecommend = @srecommend
		AND ci.roleid = 1
		AND Bettype IN (SELECT GameTypeID FROM @tmpStakeExcluded)
		AND ci.custid<=@maxcustid 
		AND ci.Enabled=1
	
	--Remove exclude stakelevel for downlines
	UPDATE cs
	SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(t.StakeLevelID as VARCHAR(10))+',','')),1,1,'')),'')
	FROM #CustStakeLevelDownlines cs
		INNER JOIN @tmpStakeExcluded t ON cs.bettype = t.GameTypeID
	
	--Apply highest stakelevel if new stakelevel doesnt have any	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN @tmpStakeExcluded s ON t.Bettype = s.GameTypeID
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM dbo.StakeLevel SL WITH(NOLOCK) 
					WHERE SL.GameTypeID = s.GameTypeID
						AND exchangeid = @currency
						AND SL.StakeLevelID <> s.StakeLevelID
						AND MinStake <> 0 
						AND MaxStake <> 0
					ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 4
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining	
		
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND T.Bettype = Upline.Bettype
												AND Upline.StakeLevelList_new <> ''											
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(VALUE AS INT) AS val
						  FROM STRING_SPLIT(Upline.StakeLevelList_new,',')  WHERE VALUE <> '') cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 3
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining	
	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND Upline.StakeLevelList_new <> ''			 
												AND T.Bettype = Upline.Bettype
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(VALUE AS INT) AS val
						  FROM STRING_SPLIT(Upline.StakeLevelList_new,',')  WHERE VALUE <> '')  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 2
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining	
	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN #CustStakeLevelDownlines Upline ON t.DirectUplineID = Upline.CustID 
												AND Upline.StakeLevelList_new <> ''			 
												AND t.Bettype = Upline.Bettype
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM (SELECT CAST(VALUE AS INT) AS val
						  FROM STRING_SPLIT(Upline.StakeLevelList_new,',')  WHERE VALUE <> '')  cd
							INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						 WHERE MinStake <> 0 AND MaxStake <> 0
						ORDER BY maxstake DESC
					) T1 -- Direct Upline
	WHERE t.roleid = 1
		AND T.StakeLevelList_new = ''
		AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining
		
	DELETE #CustStakeLevelDownlines WHERE StakeLevelList = StakeLevelList_new
	
	WHILE (1 = 1) 
	BEGIN
		TRUNCATE TABLE #tmpSMATemp

		UPDATE TOP (@batch) a WITH (ROWLOCK)
		SET a.isfinished = 1
		OUTPUT deleted.CustID,deleted.Bettype,deleted.StakeLevelList,deleted.StakeLevelList_new INTO #tmpSMATemp(CustID,Bettype,StakeLevelList,StakeLevelList_new)
		FROM #CustStakeLevelDownlines a 
		WHERE roleid IN (2,3,4) AND isfinished = 0

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE cs
		SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
		FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tmpSMATemp dl ON cs.CustID = dl.CustID AND cs.bettype = dl.bettype
		WHERE dl.StakeLevelList <> dl.StakeLevelList_new

		WAITFOR DELAY '00:00:00.100'
	END

	WHILE (1 = 1) 
	BEGIN
		TRUNCATE TABLE #tmpCustTemp

		UPDATE TOP (@batch) a WITH (ROWLOCK)
		SET a.isfinished = 1
		OUTPUT deleted.CustID,deleted.Bettype,deleted.StakeLevelList,deleted.StakeLevelList_new INTO #tmpCustTemp(CustID,Bettype,StakeLevelList,StakeLevelList_new)
		FROM #CustStakeLevelDownlines a 
		WHERE roleid = 1 AND isfinished = 0

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE cs
		SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
		FROM dbo.CustStakeLevel_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tmpCustTemp dl ON cs.CustID = dl.CustID AND cs.bettype = dl.bettype
		WHERE dl.StakeLevelList <> dl.StakeLevelList_new

		WAITFOR DELAY '00:00:00.100'
	END

	DROP TABLE #CustStakeLevelDownlines
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------			

---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

DECLARE @srecommend INT, @currency INT,	@super_cnt INT, @index INT = 0, @max_custid INT
SELECT @max_custid = xxx
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
CREATE TABLE #tmpCust (custid INT, currency INT)
--get affected stakelevel will be removed				
SELECT * 
INTO #StakeLevel
FROM StakeLevel WITH(NOLOCK)
WHERE GameTypeID IN (3401) AND ExchangeId IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD
AND MinStake = 500 AND MaxStake = 50000

INSERT INTO #tmpCust(custid,currency)
SELECT ci.custid, ci.currency 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND ci.CustID <= @max_custid
	AND ci.currency IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD
	
INSERT INTO #supers(custid,currency)
SELECT DISTINCT cs.custid, t.currency
FROM dbo.CustStakeLevel_Agent cs WITH(NOLOCK)
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	INNER JOIN #StakeLevel s ON cs.Bettype = s.GameTypeID AND cs.SportType = 233
	CROSS APPLY strSplit(ISNULL(StakeLevelList,''),',') st
WHERE st.val IN (SELECT stakelevelid FROM #StakeLevel)	

SELECT @super_cnt = @@ROWCOUNT

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@currency = currency
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@srecommend = @srecommend, 
			@currency = @currency,
			@maxcustid = @max_custid,
			@target = @target
			
	WAITFOR DELAY '00:00:00.280'			
END		

DROP TABLE #tmpCust
DROP TABLE #supers
DROP TABLE #StakeLevel
GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	
		