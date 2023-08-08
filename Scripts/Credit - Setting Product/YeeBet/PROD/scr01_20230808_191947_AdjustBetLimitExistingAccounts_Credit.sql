/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: 20230808@Luke
	Task: YeeBet - Change Bet Limit [Redmine: #191947]
	DB: DBCust/CustDB and all replicated server
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]	
	@mode TINYINT	-- 1 ~ SMA; 2 ~ Member
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON;

	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at DBCUST only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	
	-- checking dependency        
	IF OBJECT_ID('tempdb..#CustStakeLevel_Batch') IS NULL
	BEGIN  
		RETURN
	END
	
	--Update
	IF @mode=1
	BEGIN
	UPDATE cs
		SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
		FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #CustStakeLevel_Batch dl ON cs.CustID = dl.CustID 
												AND cs.SportType=dl.SportType
												AND cs.bettype = dl.bettype
		WHERE dl.StakeLevelList <> dl.StakeLevelList_new
	END
	ELSE IF @mode=2
	BEGIN
		UPDATE cs
		SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
		FROM dbo.CustStakeLevel_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #CustStakeLevel_Batch dl ON cs.CustID = dl.CustID 
												AND cs.SportType=dl.SportType
												AND cs.bettype = dl.bettype
		WHERE dl.StakeLevelList <> dl.StakeLevelList_new	
	END
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------			

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST-----
--------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
----------------------------------------------------------------------------------------------

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

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

CREATE TABLE #CustStakeLevel_Agent (
	CustID				INT	
	,currency			INT
	,DirectUplineID		INT		
	,roleid				TINYINT
	,Sporttype			SMALLINT
	,Bettype			INT
	,StakeLevelList		VARCHAR(100)
	,StakeLevelList_new	VARCHAR(100)	
	,PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
)

CREATE TABLE #CustStakeLevel_Member (
	CustID				INT	
	,currency			INT
	,DirectUplineID		INT		
	,Sporttype			SMALLINT
	,Bettype			INT
	,StakeLevelList		VARCHAR(100)
	,StakeLevelList_new	VARCHAR(100)	
	,PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
)

CREATE TABLE #CustStakeLevel_Batch (
	CustID				INT 
	,Sporttype			SMALLINT
	,Bettype			INT
	,StakeLevelList		VARCHAR(100)
	,StakeLevelList_new VARCHAR(100)	
	,PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
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
WHERE ExchangeId IN (67, 5, 2, 13, 16, 64, 3, 69, 45, 43)
	AND OfferSite <> 2 
	AND IsActive = 1

--get affected stakelevel will be removed	
INSERT INTO #tmpStakeExcluded ([StakeLevelID], [GameTypeID], [ExchangeId])
SELECT StakeLevelID, GameTypeID, sl.ExchangeId
FROM dbo.StakeLevel sl WITH(NOLOCK)	
	INNER JOIN #Exchange e WITH (NOLOCK) ON sl.ExchangeId = e.ExchangeId
WHERE 
	sl.GameTypeID = 3151
	AND sl.MinStake = CASE WHEN sl.exchangeid IN (67, 5, 2, 13) THEN 100	--HKK, HK$, RM, RMB
						WHEN sl.exchangeid IN (16, 64, 3, 69) THEN 50	--Yen, UT, US$, MMK
						WHEN sl.exchangeid = 45 THEN 30000 			--Won
						WHEN sl.exchangeid = 43 THEN 800 END			--THB
	AND sl.MaxStake = CASE WHEN sl.exchangeid IN (67, 5, 2, 13) THEN 40000
						WHEN sl.exchangeid IN (16, 64, 3, 69) THEN 10000 
						WHEN sl.exchangeid = 45 THEN 10000000
						WHEN sl.exchangeid = 43 THEN 200000 END

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
	AND ci.custid <= @max_custid

-- #CustStakeLevel_Agent
INSERT INTO #CustStakeLevel_Agent(CustID, DirectUplineID, currency, roleid, Sporttype, Bettype, StakeLevelList, StakeLevelList_new)
SELECT DISTINCT 
		t.custid,
		CASE 
			WHEN t.roleid = 3 THEN t.srecommend
			WHEN t.roleid = 2 THEN t.mrecommend				 	
		END AS DirectUplineID,		
		t.currency, t.roleid,
		cs.SportType, cs.Bettype,
		cs.StakeLevelList, cs.StakeLevelList
FROM dbo.CustStakeLevel_Agent cs WITH(NOLOCK)			
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	INNER JOIN #tmpStakeExcluded s ON cs.Bettype = s.GameTypeID
	CROSS APPLY (SELECT TOP 1 1 val FROM STRING_SPLIT(ISNULL(cs.StakeLevelList,''),',') sl 
				 WHERE TRIM(sl.value)=s.StakeLevelID
				 ) sl
WHERE roleid IN (2,3,4)

-- #CustStakeLevel_Member
INSERT INTO #CustStakeLevel_Member(CustID, DirectUplineID, currency, Sporttype, Bettype, StakeLevelList, StakeLevelList_new)
SELECT DISTINCT 
		t.custid,
		t.recommend as DirectUplineID,		
		t.currency,cs.SportType,cs.Bettype,
		cs.StakeLevelList,cs.StakeLevelList
FROM dbo.CustStakeLevel_Member cs WITH(NOLOCK)			
	INNER JOIN #tmpCust t ON cs.custid = t.custid
	INNER JOIN #tmpStakeExcluded s ON cs.Bettype = s.GameTypeID
	CROSS APPLY (SELECT TOP 1 1 val FROM STRING_SPLIT(ISNULL(cs.StakeLevelList,''),',') sl 
				 WHERE TRIM(sl.value)=s.StakeLevelID
				 ) sl
WHERE roleID=1 

--Remove exclude stakelevel
	--agent
UPDATE cs
SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(t.StakeLevelID as VARCHAR(10))+',','')),1,1,'')),'')
FROM #CustStakeLevel_Agent cs
	INNER JOIN #tmpStakeExcluded t ON cs.bettype = t.GameTypeID
									AND cs.currency=t.ExchangeId
	--member
UPDATE cs
SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(t.StakeLevelID as VARCHAR(10))+',','')),1,1,'')),'')
FROM #CustStakeLevel_Member cs
	INNER JOIN #tmpStakeExcluded t ON cs.bettype = t.GameTypeID
									AND cs.currency=t.ExchangeId

--Apply highest stakelevel if new stakelevel doesnt have any	
UPDATE T
	SET t.StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevel_Agent T
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
	SET t.StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevel_Agent T
	INNER JOIN #CustStakeLevel_Agent Upline ON t.DirectUplineID = Upline.CustID 
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
	SET t.StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevel_Agent T
	INNER JOIN #CustStakeLevel_Agent Upline ON t.DirectUplineID = Upline.CustID 
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
	SET t.StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevel_Member T
	INNER JOIN #CustStakeLevel_Agent Upline ON t.DirectUplineID = Upline.CustID 
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
WHERE T.StakeLevelList_new = ''
	AND T.StakeLevelList <> T.StakeLevelList_new--not empty at the begining

-- Delete unchanged
DELETE #CustStakeLevel_Agent
WHERE StakeLevelList = StakeLevelList_new

DELETE #CustStakeLevel_Member
WHERE StakeLevelList = StakeLevelList_new

------------------------------------------------------
SELECT @Cust_cnt = COUNT(1)
FROM #CustStakeLevel_Agent

SELECT @Cust_cnt += COUNT(1)
FROM #CustStakeLevel_Member

DECLARE @msg_total NVARCHAR(200) = 'Total of Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

--Update for SMA
WHILE (1=1)
BEGIN
	DELETE FROM #CustStakeLevel_Batch

	DELETE TOP (5000) T
	OUTPUT deleted.CustID, deleted.Sporttype, deleted.Bettype, deleted.StakeLevelList, deleted.StakeLevelList_new
		INTO #CustStakeLevel_Batch(CustID, Sporttype, Bettype, StakeLevelList, StakeLevelList_new)
	FROM #CustStakeLevel_Agent t 

	IF @@ROWCOUNT = 0 BREAK
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@mode=1,
			@target = @target
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'SMA - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

--Update for Member
WHILE (1=1)
BEGIN
	DELETE FROM #CustStakeLevel_Batch

	DELETE TOP (5000) T
	OUTPUT deleted.CustID, deleted.Sporttype, deleted.Bettype, deleted.StakeLevelList, deleted.StakeLevelList_new
		INTO #CustStakeLevel_Batch(CustID, Sporttype, Bettype, StakeLevelList, StakeLevelList_new)
	FROM #CustStakeLevel_Member t 

	IF @@ROWCOUNT = 0 BREAK
	
	EXEC dbo.[Acc_DynamicCustSetting3rd_09] 
			@mode=2,
			@target = @target
	
	WAITFOR DELAY '00:00:0.050'

	SET @msg_total = 'Member - curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

	RAISERROR (@msg_total, 0, 1) WITH NOWAIT
END	

DROP TABLE #tmpCust, #CustStakeLevel_Agent, #CustStakeLevel_Member, #CustStakeLevel_Batch, #tmpStakeExcluded, #Exchange
GO	

PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	
 