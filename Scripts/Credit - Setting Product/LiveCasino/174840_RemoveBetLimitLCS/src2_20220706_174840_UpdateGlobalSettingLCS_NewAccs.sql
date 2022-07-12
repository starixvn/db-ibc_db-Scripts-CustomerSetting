/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220706
	Task: WM - Remove highest bet limit of IDR currency (DDD, IDD, IND, IN, IDR) for IBCIndo and INDO new acc RedmineID:#174840
	DB: DBCUST/CustDB
	
	P/s : Step 2 Remove highest bet limit of IDR new acc
*/
-- BEGIN STEP 2.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
(@max_custid INT)
AS
BEGIN			
	
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN

	DECLARE @batch int = 3000
	DECLARE @tmpStakeExcluded TABLE (StakeLevelID INT, GameTypeID INT,ExchangeId	INT)
	
	INSERT INTO @tmpStakeExcluded(StakeLevelID,GameTypeID, ExchangeId)
	SELECT StakeLevelID,GameTypeID , ExchangeId
	FROM StakeLevel WITH(NOLOCK)
	WHERE GameTypeID IN (3401) AND MinStake = 500 AND MaxStake = 50000 
		AND ExchangeId IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD) 
	
	CREATE TABLE #supers (custid INT PRIMARY KEY CLUSTERED)
	CREATE TABLE #CustStakeLevelDownlines (
				CustID INT 
				,DirectUplineID INT	
				,currency INT
				,roleid TINYINT
				,Bettype INT
				,StakeLevelList VARCHAR(100)
				,StakeLevelList_new VARCHAR(100)	
				,isfinished BIT DEFAULT(0)						
				, PRIMARY KEY CLUSTERED (CustID,Bettype)
		)

	CREATE TABLE #tmpCustTemp(CustID INT ,Bettype INT,StakeLevelList VARCHAR(100),StakeLevelList_new VARCHAR(100), PRIMARY KEY CLUSTERED (CustID,Bettype))
	CREATE TABLE #tmpSMATemp(CustID INT ,Bettype INT,StakeLevelList VARCHAR(100),StakeLevelList_new VARCHAR(100), PRIMARY KEY CLUSTERED (CustID,Bettype))

	INSERT INTO #supers(custid)
	SELECT ci.custid 
	FROM dbo.customer c WITH (Nolock) 
		INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
		INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	WHERE ci.roleid = 4
		AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
		AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
		AND ci.Enabled = 1
		AND s.islicensee = 0
		AND c.username NOT LIKE '3rdSuper%'
		AND ci.currency IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD

	INSERT INTO #CustStakeLevelDownlines (CustID,DirectUplineID, roleid ,Bettype ,StakeLevelList,StakeLevelList_new,currency)
	SELECT ci.custid,
		  CASE 
				WHEN ci.roleid = 3 THEN srecommend
				WHEN ci.roleid = 2 THEN mrecommend				 	
		  END AS DirectUplineID,		
		 ci.roleid,cs.Bettype,cs.StakeLevelList,cs.StakeLevelList,ci.currency
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Agent cs WITH(NOLOCK) ON ci.custid = cs.custid	
		INNER JOIN #supers s WITH(NOLOCK) ON s.custid = ci.srecommend
	WHERE  roleid IN (2,3,4)
		AND Bettype IN (SELECT GameTypeID FROM @tmpStakeExcluded)
		AND ci.Enabled=1
		AND ci.custid > @max_custid
	UNION ALL
	SELECT ci.custid,
		  recommend as DirectUplineID,		
		 ci.roleid,cs.bettype,cs.StakeLevelList,cs.StakeLevelList,ci.currency
	FROM dbo.custinfo ci WITH(NOLOCK)
		INNER JOIN dbo.CustStakeLevel_Member cs WITH(NOLOCK) ON ci.custid = cs.custid			
		INNER JOIN #supers s WITH(NOLOCK) ON s.custid = ci.srecommend
	WHERE  roleid = 1
		AND Bettype IN (SELECT GameTypeID FROM @tmpStakeExcluded)
		AND ci.custid > @max_custid 
		AND ci.Enabled=1
	
	--Remove exclude stakelevel for downlines
	UPDATE cs
	SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(t.StakeLevelID as VARCHAR(10))+',','')),1,1,'')),'')
	FROM #CustStakeLevelDownlines cs
		INNER JOIN @tmpStakeExcluded t ON cs.bettype = t.GameTypeID AND cs.currency = t.ExchangeId
	
	--Apply highest stakelevel if new stakelevel doesnt have any	
	UPDATE T
		SET StakeLevelList_new = T1.DownlineStakeLevelList_new
	FROM #CustStakeLevelDownlines T
		INNER JOIN @tmpStakeExcluded s ON t.Bettype = s.GameTypeID AND T.currency = s.ExchangeId
		CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
					FROM dbo.StakeLevel SL WITH(NOLOCK) 
					WHERE SL.GameTypeID = s.GameTypeID
						AND exchangeid = T.currency
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
						  FROM STRING_SPLIT(Upline.StakeLevelList_new,',')  WHERE VALUE <> '')  cd
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
						  FROM STRING_SPLIT(Upline.StakeLevelList_new,',')  WHERE VALUE <> '') cd
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
						  FROM STRING_SPLIT(Upline.StakeLevelList_new,',')  WHERE VALUE <> '') cd
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
		OUTPUT deleted.CustID,deleted.Bettype,deleted.StakeLevelList,deleted.StakeLevelList_new 
		INTO #tmpSMATemp(CustID,Bettype,StakeLevelList,StakeLevelList_new)
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
		OUTPUT deleted.CustID,deleted.Bettype,deleted.StakeLevelList,deleted.StakeLevelList_new 
		INTO #tmpCustTemp(CustID,Bettype,StakeLevelList,StakeLevelList_new)
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
-- END STEP 3.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 3.2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @max_custid INT
	
SELECT @max_custid = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @max_custid=@max_custid
