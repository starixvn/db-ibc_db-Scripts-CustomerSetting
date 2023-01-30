/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20221205
	Created: Johnson 
	Task: Seal Entertainment - Incorporate to Licensee Sites for real licensees [redmine : #180380]
	DB: DBCUST/CUSTDB
*/

--select max(custid) from custinfo 	
CREATE TABLE #supers (custid int, currency int, isfinished bit default(0))

DECLARE @max_custid INT = xxx

INSERT INTO #supers(custid, currency)
SELECT c.custid, c.currency
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1	
	AND c.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)
					WHERE currency IN (2,3,4,6,12,13,15,20,32,45,46,49,51,61,70,82,96,97,121,123))
	AND ((s.site IN ('spondemo','Athena000','SampleSite') AND c.currency <> 20)
		OR s.site NOT IN ('spondemo','Athena000','SampleSite')
		)
	
CREATE TABLE #tblCust (CustID INT PRIMARY KEY, currency INT, isfinished BIT DEFAULT(0))
CREATE TABLE #tblSMA (CustID INT PRIMARY KEY,RoleID INT, currency INT)
CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)	

DECLARE @PT SMALLINT = 93
DECLARE @currency INT, @StakeLevelID INT
DECLARE @SportType SMALLINT = 156, @BetType SMALLINT = 8900	 ,@GameGroupID INT = 42 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

INSERT INTO #tblSMA(CustID,RoleID,currency)
SELECT CustID,RoleID,currency
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND ci.custid > @max_custid 
	AND roleid IN (2,3,4)
	AND ci.Enabled=1
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #tblCust(CustID,currency)
SELECT ci.CustID, ci.currency
FROM custInfo ci WITH(NOLOCK)		
WHERE ci.srecommend IN (SELECT custid FROM #Supers)
	AND ci.custid > @max_custid 
	AND roleid = 1 
	AND ci.Enabled=1
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)	
	
DECLARE @BitmapOrder INT = 36

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT custid, t.ProductSettingID
FROM #tblSMA 
	CROSS APPLY (SELECT 159 ProductSettingID UNION SELECT 160 UNION SELECT 161) t
WHERE roleid = 4

-------------------------------------PT Setting-----------------------------------------------
INSERT INTO dbo.Dep_CustPTSetting_Agent
	(	[CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[IsLive]
	   ,[SuperPT]
	   ,[MasterPT]
	   ,[AgentPT]
	 )
SELECT 
		[CustID]
	   ,@Sporttype
	   ,@BetType
	   ,0
	   ,CASE WHEN roleid IN (4) THEN @PT ELSE 0 END
	   ,CASE WHEN roleid IN (4,3) THEN @PT ELSE 0 END
	   ,CASE WHEN roleid IN (4,2) THEN @PT ELSE 0 END
FROM #tblSMA t WITH(NOLOCK)
WHERE NOT EXISTS(SELECT 1 FROM Dep_CustPTSetting_Agent c WITH(NOLOCK) 
				WHERE t.custid = c.custid 
					AND c.sporttype = @sporttype 
					AND c.bettype = @bettype)
		
INSERT INTO dbo.Dep_CustPTGroupSetting_Member
	(	AgentID
	   ,[SportType]
	   ,[BetType]
	   ,[IsLive]
	   ,[SuperPT]
	   ,[MasterPT]
	   ,[AgentPT]
	 )
SELECT 
		[CustID]
	   ,@Sporttype
	   ,@BetType
	   ,0
	   ,0
	   ,0
	   ,@PT
FROM #tblSMA t
WHERE RoleID=2	
	AND NOT EXISTS(SELECT 1 FROM Dep_CustPTGroupSetting_Member c WITH(NOLOCK) 
					WHERE t.custid = c.AgentID 
					AND c.sporttype = @sporttype 
					AND c.bettype = @bettype)

--Member Level
INSERT INTO dbo.Dep_CustPTSetting_Member
	(	CustID
	   ,[SportType]
	   ,[BetType]
	   ,[IsLive]
	   ,[SuperPT]
	   ,[MasterPT]
	   ,[AgentPT]
	 )
SELECT 
		t.CustID
	   ,@Sporttype
	   ,@BetType
	   ,0
	   ,0
	   ,0
	   ,@PT
FROM #tblCust t
	INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON t.CustID=m.CustID
WHERE m.IsGroupedPT= 0
	AND NOT EXISTS(SELECT 1 FROM Dep_CustPTSetting_Member c WITH(NOLOCK) 
					WHERE t.custid = c.custid 
					AND c.sporttype = @sporttype 
					AND c.bettype = @bettype)

INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT t.CustID,1
FROM #tblCust t WITH(NOLOCK)
WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=t.CustID)
	AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)

-------------------------------------Betlimit Setting-----------------------------------------------
SELECT @StakeLevelID = sl.StakeLevelID 
FROM dbo.DEP_StakeLevel sl WITH (NOLOCK) 
WHERE sl.GameTypeID = @BetType
	AND sl.GameGroupID = @GameGroupID
	AND sl.ExchangeId = @Currency

--Agent Level
INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID],[SportType],[BetType],[StakeLevelList]) 
SELECT s.custid,@Sporttype, @BetType, t.StakeLevelID
FROM #tblSMA S 
	CROSS APPLY (SELECT StakeLevelID 
				FROM DEP_StakeLevel sl WITH (NOLOCK) 
				WHERE sl.GameTypeID = @BetType
					AND sl.GameGroupID = @GameGroupID
					AND sl.ExchangeId = s.Currency
				)t
WHERE NOT EXISTS (SELECT 1 FROM Dep_CustStakeLevel_Agent c WITH(NOLOCK)
				WHERE c.custid = s.custid
					AND c.sporttype = @sporttype
					AND c.bettype = @bettype
				)	

--Member Level
DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY, currency INT)

WHILE(1 =1)
BEGIN
	UPDATE TOP (500) c WITH (ROWLOCK)
	SET c.isfinished = 1
	OUTPUT DELETED.CustID, DELETED.currency INTO @tmpCust(CustID,currency)
	FROM #tblCust c 
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0		
		BREAK;
				
	INSERT INTO dbo.Dep_CustStakeLevel_Member([CustID]
									   ,[SportType]
									   ,[BetType]
									   ,[StakeLevelList]
									   ,LastUpdated) 
	SELECT CustID , @SportType,@BetType,t.StakeLevelID as [StakeLevelList],GETDATE() as LastUpdated
	FROM @tmpCust s
		CROSS APPLY (SELECT StakeLevelID 
				FROM DEP_StakeLevel sl WITH (NOLOCK) 
				WHERE sl.GameTypeID = @BetType
					AND sl.GameGroupID = @GameGroupID
					AND sl.ExchangeId = s.Currency
				)t
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustStakeLevel_Member c WITH(NOLOCK)
					WHERE c.custid = s.custid
						AND c.sporttype = @sporttype
						AND c.bettype = @bettype
					)
	
	DELETE @tmpCust
END
			
CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))
CREATE TABLE #tmpCustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))

INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
SELECT c.CustID
	,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder,0)
	,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder,0)
FROM Dep_CustProductStatus c WITH(NOLOCK)		
	INNER JOIN  #tblSMA temp ON temp.CustID = c.custid
UNION ALL
SELECT c.CustID
	,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder,0)
	,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder,0)
FROM Dep_CustProductStatus c WITH(NOLOCK)		
	INNER JOIN  #tblCust temp ON temp.CustID = c.custid

WHILE 1 = 1 
BEGIN
	TRUNCATE TABLE #tmpCustProductStatus

	UPDATE TOP (500) t WITH (ROWLOCK)
	SET isfinished = 1
	OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,DELETED.bitmapIsDisabled INTO #tmpCustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	FROM #Dep_CustProductStatus t 
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 
		BREAK;

	UPDATE c 
	SET  c.bitmapIsHidden = tmp.bitmapIsHidden
		,c.bitmapIsDisabled = tmp.bitmapIsDisabled
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #tmpCustProductStatus tmp ON c.CustID = tmp.CustID
END

INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
SELECT	t.custid
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitmapOrder,0) AS bitmapIsDisabled
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitmapOrder,0)  AS bitmapIsHidden
FROM (
	SELECT custid FROM #tblCust
	UNION ALL SELECT custid FROM #tblSMA
) t
WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)

DROP TABLE #tblCust
DROP TABLE #tblSMA
DROP TABLE #tmpCustProductStatus	
DROP TABLE #Dep_CustProductStatus		