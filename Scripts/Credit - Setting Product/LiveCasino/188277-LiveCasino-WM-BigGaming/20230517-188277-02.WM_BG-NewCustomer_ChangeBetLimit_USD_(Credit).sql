/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230517@Tacy
	Task: WM, BG Live Casino - Support to change bet limit range for USD code
		Step 02. Update new customers' stakelevel list
		https://nexdev.net/issues/188277
	DB: DBCust/CustDB
*/
----------------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
----------------------------------------------------------------------------------------------

DECLARE @Cust_cnt	INT,
		@max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #tmpCust(
	CustID		INT PRIMARY KEY
	,currency	INT
	,roleID		TINYINT NOT NULL
	,srecommend INT	NOT NULL
	,mrecommend INT	NULL
	,recommend	INT	NULL
)

CREATE TABLE #CustStakeLevel (
	CustID				INT 
	,currency			INT
	,DirectUplineID		INT		
	,roleid				TINYINT
	,Bettype			INT
	,Sporttype			SMALLINT
	,StakeLevelList		VARCHAR(100)
	,StakeLevelList_new	VARCHAR(100)	
	,PRIMARY KEY CLUSTERED (CustID,Bettype)
)

CREATE TABLE #tmpStakeExcluded(
	[StakeLevelID]	[int] NOT NULL,
	[GameTypeID]	[int] NULL,
	[ExchangeId]	[int] NULL)

CREATE TABLE #Exchange (ExchangeId INT)

------------------------------------------------------
INSERT INTO #Exchange (ExchangeId)
SELECT ExchangeId
FROM exchange WITH (NOLOCK)
WHERE Code='USD' AND OfferSite<>2 AND IsActive=1

--get affected stakelevel will be removed	
INSERT INTO #tmpStakeExcluded ([StakeLevelID], [GameTypeID], [ExchangeId])
SELECT [StakeLevelID], [GameTypeID], sl.[ExchangeId]
FROM StakeLevel sl WITH(NOLOCK)
INNER JOIN #Exchange e ON e.ExchangeId=sl.ExchangeId
WHERE (GameTypeID = 3401 AND MinStake = 50 AND MaxStake = 5000)
OR (GameTypeID = 3501 AND MinStake = 3 AND MaxStake = 5000)

-- #tmpCust
INSERT INTO #tmpCust (CustID, currency, roleID, srecommend, mrecommend, recommend)
SELECT ci.custid, ci.currency, ci.roleid, ci.srecommend, ci.mrecommend, ci.recommend
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
	INNER JOIN #Exchange e WITH(NOLOCK) ON e.ExchangeId=c.currency
WHERE ci.srecommend NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.srecommend NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND c.username NOT LIKE '3rdSuper%'
	AND ci.custid > @max_custid

-- #CustStakeLevel
INSERT INTO #CustStakeLevel(CustID, DirectUplineID, currency, roleid, Sporttype, Bettype, StakeLevelList, StakeLevelList_new)
SELECT DISTINCT 
		t.custid,
		CASE 
			WHEN t.roleid = 3 THEN t.srecommend
			WHEN t.roleid = 2 THEN t.mrecommend				 	
		END AS DirectUplineID,		
		t.currency, t.roleid, 
		cs.SportType,cs.Bettype,
		cs.StakeLevelList,cs.StakeLevelList
FROM dbo.CustStakeLevel_Agent cs WITH(NOLOCK)
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	INNER JOIN #tmpStakeExcluded s ON cs.Bettype = s.GameTypeID
	CROSS APPLY (SELECT TOP 1 1 val FROM STRING_SPLIT(ISNULL(cs.StakeLevelList,''),',') sl 
				 WHERE TRIM(sl.value)=s.StakeLevelID
				 ) sl
WHERE roleid IN (2,3,4)
UNION
SELECT DISTINCT 
		t.custid,
		t.recommend as DirectUplineID,		
		t.currency,t.roleid, 
		cs.SportType,cs.Bettype,
		cs.StakeLevelList,cs.StakeLevelList
FROM dbo.CustStakeLevel_Member cs WITH(NOLOCK)
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	INNER JOIN #tmpStakeExcluded s ON cs.Bettype = s.GameTypeID
	CROSS APPLY (SELECT TOP 1 1 val FROM STRING_SPLIT(ISNULL(cs.StakeLevelList,''),',') sl 
				 WHERE TRIM(sl.value)=s.StakeLevelID
				 ) sl
WHERE roleID=1

--Remove exclude stakelevel
UPDATE cs
SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(t.StakeLevelID as VARCHAR(10))+',','')),1,1,'')),'')
FROM #CustStakeLevel cs
	INNER JOIN #tmpStakeExcluded t ON cs.bettype = t.GameTypeID
									AND cs.currency=t.ExchangeId
	
--Apply highest stakelevel if new stakelevel doesnt have any	
UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevel T
	INNER JOIN #tmpStakeExcluded s ON t.Bettype = s.GameTypeID AND t.currency=s.ExchangeId
	CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
				FROM dbo.StakeLevel SL WITH(NOLOCK) 
				WHERE SL.GameTypeID = s.GameTypeID
					AND sl.exchangeid = t.currency
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
FROM #CustStakeLevel T
	INNER JOIN #CustStakeLevel Upline ON t.DirectUplineID = Upline.CustID 
											AND T.Bettype = Upline.Bettype
											AND T.Sporttype = Upline.Sporttype
											AND Upline.StakeLevelList_new <> ''											
	CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
				FROM (SELECT CAST(value AS INT) AS val
						FROM string_split(Upline.StakeLevelList_new,','))  cd
						INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						WHERE MinStake <> 0 AND MaxStake <> 0
					ORDER BY maxstake DESC
				) T1 -- Direct Upline
WHERE t.roleid = 3
	AND T.StakeLevelList_new = ''
	AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining	
	
UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevel T
	INNER JOIN #CustStakeLevel Upline ON t.DirectUplineID = Upline.CustID 
											AND Upline.StakeLevelList_new <> ''			 
											AND T.Bettype = Upline.Bettype
											AND T.Sporttype = Upline.Sporttype
	CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
				FROM (SELECT CAST(value AS INT) AS val
						FROM string_split(Upline.StakeLevelList_new,','))  cd
						INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						WHERE MinStake <> 0 AND MaxStake <> 0
					ORDER BY maxstake DESC
				) T1 -- Direct Upline
WHERE t.roleid = 2
	AND T.StakeLevelList_new = ''
	AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining	
	
UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevel T
	INNER JOIN #CustStakeLevel Upline ON t.DirectUplineID = Upline.CustID 
											AND Upline.StakeLevelList_new <> ''			 
											AND t.Bettype = Upline.Bettype
											AND T.Sporttype = Upline.Sporttype
	CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
				FROM (SELECT CAST(value AS INT) AS val
						FROM string_split(Upline.StakeLevelList_new,','))  cd
						INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID
						WHERE MinStake <> 0 AND MaxStake <> 0
					ORDER BY maxstake DESC
				) T1 -- Direct Upline
WHERE t.roleid = 1
	AND T.StakeLevelList_new = ''
	AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining

DELETE #CustStakeLevel
WHERE StakeLevelList = StakeLevelList_new

----------------------------------------------------------------------------------------------
SELECT @Cust_cnt = COUNT(1)
FROM #CustStakeLevel

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--Update
UPDATE cs
SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #CustStakeLevel dl ON cs.CustID = dl.CustID
								  AND cs.SportType=dl.SportType
								  AND cs.bettype = dl.bettype
WHERE dl.StakeLevelList <> dl.StakeLevelList_new
	
UPDATE cs
SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
FROM dbo.CustStakeLevel_Member cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #CustStakeLevel dl ON cs.CustID = dl.CustID 
								  AND cs.SportType=dl.SportType
								  AND cs.bettype = dl.bettype
WHERE dl.StakeLevelList <> dl.StakeLevelList_new	

DROP TABLE #tmpCust
DROP TABLE #CustStakeLevel
DROP TABLE #tmpStakeExcluded
DROP TABLE #Exchange

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

GO	
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	