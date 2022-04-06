/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Insert Setting and update status for Saba Casino - Real Currency New Accs [#164280]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
-----------------------------------------------------
PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @maxcustid INT= xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled=1 
	AND (cs.site IN ('11bet'
					,'12Bet'
					,'368Cash'
					,'3star88'
					,'88Macao'
					,'9bet'
					,'9Club'
					,'9wickets'
					,'Ae88'
					,'AG'
					,'AOGcasino'
					,'Aoncash'
					,'asiabet88'
					--,'Athena000'
					,'BE7'
					,'Bolanation'
					,'Boma365'
					,'Dabet'
					,'DEWA'
					,'Fabet'
					,'FB88'
					,'Happy1668'
					,'Heaven'
					,'HonorW'
					,'iBET'
					,'IONclub'
					,'ISC888'
					,'ITCbet'
					,'Kbet'
					,'Liga'
					,'LIGAWLHKB'
					,'Lucky88'
					,'M8bola'
					,'Macaubet'
					,'N88'
					,'N8B'
					,'N8G'
					,'Nova88'
					,'OLE777'
					,'One88'
					,'OXbet'
					,'Q8bola'
					,'Red88'
					,'RICbet'
					,'Saba789'
					,'Senibet'
					,'Sin88'
					,'Sky88'
					--,'spondemo'
					,'TIC88'
					,'TLC'
					,'UN168'
					,'Unobet'
					,'Uwoniwin'
					,'webet88'
					,'XO88'
					,'Zbet'
					)
		OR (cs.site IN('spondemo','Athena000')	AND Ci.currency NOT IN (20)))
	AND Ci.currency IN (
							2	-- 	RM
						,	3	-- 	US$
						,	4	-- 	TB
						,	6	-- 	EURO
						,	12	-- 	GBP
						,	13	-- 	RMB
						,	15	-- 	IN
						,	45	-- 	WON
						,	51	-- 	INH
						,	61	-- 	INR
						,	66	-- 	YUN
						,	70	-- 	MKK
						,	96	-- 	USDT
						,   20  --	UUS
						)
ORDER BY ci.custid 

DECLARE @maxCustID2 INT 
SELECT @maxCustID2 = MAX(custid) FROM custinfo WITH(NOLOCK)
	
DECLARE @SuperPT_OtherSite SMALLMONEY = 93, @SuperPT_Saba789 SMALLMONEY = 80.5
DECLARE @currency INT, @BitOrder INT
DECLARE @SportType SMALLINT = 208, @BetType SMALLINT = 2101
DECLARE @BatchSize SMALLINT = 5000

----------------Delete exits data
DELETE cg
FROM Dep_CustPTSetting_Agent cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType =@SportType AND c.custid > @maxcustID AND c.custid <= @maxCustID2
						
DELETE cg
FROM Dep_CustPTSetting_Member cg WITH(UPDLOCK,ROWLOCK)		
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType =@SportType AND c.custid > @maxcustID AND c.custid <= @maxCustID2
		
DELETE cg
FROM Dep_CustPTGroupSetting_Member cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType =@SportType AND c.custid > @maxcustID AND c.custid <= @maxCustID2
				
DELETE cg
FROM Dep_CustStakeLevel_Agent cg WITH(UPDLOCK,ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid		
WHERE SportType =@SportType AND c.custid > @maxcustID AND c.custid <= @maxCustID2

DELETE cg
FROM Dep_CustStakeLevel_Member cg WITH(UPDLOCK,ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid			
WHERE SportType =@SportType AND c.custid > @maxcustID AND c.custid <= @maxCustID2

DELETE dl
FROM Dep_LicenseeProductSetting dl WITH(ROWLOCK,UPDLOCK)
		INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
		INNER JOIN CustInfo ci WITH(NOLOCK) ON dl.CustID = ci.custid
		INNER JOIN #supers s ON ci.srecommend = s.custid
WHERE dp.ProductID = 6
	AND ci.custid > @maxcustID AND ci.custid <= @maxCustID2
-------------------------------
	 
SELECT @BitOrder= bitmapOrder 
FROM Dep_ProductStatusProfile WITH(NOLOCK) 
WHERE SportType=@Sporttype AND Bettype = @BetType

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

-------------------------------------PT Setting-----------------------------------------------
--Agent Level
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
		ci.[CustID]
		,@Sporttype
		,@BetType
		,0
		,CASE WHEN c.site = 'Saba789' THEN @SuperPT_Saba789 ELSE @SuperPT_OtherSite END
		,CASE WHEN c.site = 'Saba789' THEN @SuperPT_Saba789 ELSE @SuperPT_OtherSite END
		,CASE WHEN c.site = 'Saba789' THEN @SuperPT_Saba789 ELSE @SuperPT_OtherSite END
FROM custInfo ci WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON ci.custid = c.custid
WHERE ci.srecommend IN(SELECT custid FROM #supers)
	AND ci.custid > @maxcustID AND ci.custid <= @maxCustID2 AND ci.Enabled=1 
	AND ci.RoleID=4
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	
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
		ci.[CustID]
		,@Sporttype
		,@BetType
		,0
		,0
		,CASE WHEN c.site = 'Saba789' THEN @SuperPT_Saba789 ELSE @SuperPT_OtherSite END
		,0	
FROM custInfo ci WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON ci.custid = c.custid
WHERE ci.srecommend IN(SELECT custid FROM #supers)
	AND ci.custid > @maxcustID AND ci.custid <= @maxCustID2 AND ci.Enabled=1 
	AND ci.RoleID=3
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

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
		ci.[CustID]
		,@Sporttype
		,@BetType
		,0
		,0
		,0
		,CASE WHEN c.site = 'Saba789' THEN @SuperPT_Saba789 ELSE @SuperPT_OtherSite END
FROM custInfo ci WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON ci.custid = c.custid
WHERE ci.srecommend IN(SELECT custid FROM #supers)
	AND ci.custid > @maxcustID AND ci.custid <= @maxCustID2 AND ci.Enabled=1 
	AND ci.RoleID=2
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

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
		ci.[CustID]
		,@Sporttype
		,@BetType
		,0
		,0
		,0
		,CASE WHEN c.site = 'Saba789' THEN @SuperPT_Saba789 ELSE @SuperPT_OtherSite END
FROM custInfo ci WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON ci.custid = c.custid
WHERE ci.srecommend IN(SELECT custid FROM #supers)
	AND ci.custid > @maxcustID AND ci.custid <= @maxCustID2 AND ci.Enabled=1 
	AND ci.RoleID=2
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

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
		ci.CustID
		,@Sporttype
		,@BetType
		,0
		,0
		,0
		,CASE WHEN c.site = 'Saba789' THEN @SuperPT_Saba789 ELSE @SuperPT_OtherSite END
FROM custInfo ci WITH(NOLOCK)
	INNER JOIN customer c WITH(NOLOCK) ON ci.custid = c.custid
	INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON ci.CustID=m.CustID
WHERE ci.srecommend IN(SELECT custid FROM #supers)
	AND ci.custid > @maxcustID AND ci.custid <= @maxCustID2 AND ci.Enabled=1 
	AND ci.RoleID=1
	AND m.IsGroupedPT=0
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
SELECT ci.CustID,1
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN(SELECT custid FROM #supers)
	AND ci.custid > @maxcustID AND ci.custid <= @maxCustID2 AND ci.Enabled=1 
	AND RoleID=1
	AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=ci.CustID)
	AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=ci.CustID)
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		
INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT t.custid,117
FROM #supers t
WHERE t.custid > @maxcustID AND t.custid <= @maxCustID2	
	AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=117)

-------------------------------------Betlimit Setting-----------------------------------------------
CREATE TABLE #MemberTemp  (CustID INT PRIMARY KEY,StakeLevelID VARCHAR(100),isfinished BIT DEFAULT(0))	
CREATE TABLE #SMATemp  (CustID INT PRIMARY KEY, RoleID INT,StakeLevelID VARCHAR(100))	

SELECT e.currency
	,CAST (STUFF (STL, 1,1, '') AS VARCHAR(500)) AS StakeLevelList
	,CAST (M.StakeLevelID AS VARCHAR(10)) AS Min_StakeLevel
INTO #StakeLevelList
FROM (VALUES (@BetType)) AS t(Bettype)
	CROSS APPLY (
					SELECT Currency 
					FROM ( VALUES
								(2)		-- 	RM
							,	(3)		-- 	US$
							,	(4)		-- 	TB
							,	(6)		-- 	EURO
							,	(12)	-- 	GBP
							,	(13)	-- 	RMB
							,	(15)	-- 	IN
							,	(45)	-- 	WON
							,	(51)	-- 	INH
							,	(61)	-- 	INR
							,	(66)	-- 	YUN
							,	(70)	-- 	MKK
							,	(96)	-- 	USDT
							,	(20)	--	UUS
					) exchange(Currency)
					) e
	CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
				FROM Dep_StakeLevel S WITH (NOLOCK)
				WHERE S.GameTypeID = t.BetType AND S.ExchangeId = e.Currency
				FOR XML PATH ('') 
				) AS A(STL)
	CROSS APPLY (SELECT TOP 1 StakeLevelID
				FROM Dep_StakeLevel S WITH (NOLOCK)
					LEFT JOIN GameGroup gg WITH(NOLOCK) 
						ON s.GameGroupID = gg.GameGroupID
				WHERE S.GameTypeID = t.BetType AND S.ExchangeId = e.Currency
				ORDER BY s.MaxStake ASC, s.MinStake ASC, gg.GroupName ASC
				) AS M

--Agent Level
INSERT INTO #SMATemp (CustID,StakeLevelID,RoleID)
SELECT CI.custid, sl.StakeLevelList,ci.roleid
FROM Custinfo CI WITH (NOLOCK)
	INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
	INNER JOIN #StakeLevelList sl ON c.currency= sl.Currency
WHERE ci.srecommend IN(SELECT CustID FROM #supers) 
	AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @maxcustID AND ci.custid <= @maxCustID2 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID],[SportType],[BetType],[StakeLevelList]) 
SELECT custid,@Sporttype, @BetType, StakeLevelID
FROM #SMATemp

--Member Level
INSERT INTO #MemberTemp (CustID,StakeLevelID) 
SELECT CI.custid, sl.Min_StakeLevel
FROM Custinfo CI WITH (NOLOCK)
	INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
	INNER JOIN #StakeLevelList sl ON c.currency= sl.Currency
WHERE ci.srecommend IN(SELECT CustID FROM #supers) AND ci.roleid IN (1) 
	AND Enabled = 1 AND ci.custid > @maxcustID AND ci.custid <= @maxCustID2 
	AND CI.mrecommend NOT IN (SELECT custid FROM #Dummy)
	
DECLARE @Cust_Temp TABLE(CustID INT,StakeLevelID VARCHAR(100))
	
WHILE(1 =1)
BEGIN
	UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
	SET c.isfinished = 1
	OUTPUT DELETED.CustID,DELETED.StakeLevelID INTO @Cust_Temp(CustID,StakeLevelID)
	FROM #MemberTemp c 
	WHERE isfinished = 0
		
	IF @@ROWCOUNT = 0
	BEGIN 
		BREAK
	END 	
			
	INSERT INTO dbo.Dep_CustStakeLevel_Member([CustID]
										,[SportType]
										,[BetType]
										,[StakeLevelList]
										,LastUpdated) 
	SELECT CustID , @SportType,@BetType,StakeLevelID as [StakeLevelList],GETDATE() as LastUpdated
	FROM @Cust_Temp	
		
	DELETE FROM @Cust_Temp
END
	
INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT t.custid,118
FROM #supers t
WHERE t.custid > @maxcustID AND t.custid <= @maxCustID2	
	AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=118)
--------------------------------------------Enable Status--------------------------------------------------
CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))
CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

INSERT INTO #AllUsers (CustID)
SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
UNION 
SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
SELECT c.CustID
	,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
	,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,ci.DisableCasino))
FROM Dep_CustProductStatus c WITH(NOLOCK)
	INNER JOIN custInfo ci WITH(NOLOCK) ON c.CustID = ci.custid
	INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
UNION ALL
SELECT c.CustID
	,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
	,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,ci.DisableCasino))
FROM Dep_CustProductStatus c WITH(NOLOCK)
	INNER JOIN custInfo ci WITH(NOLOCK) ON c.CustID = ci.custid
	INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

SET @BatchSize = 5000
WHILE 1 = 1 
BEGIN
	TRUNCATE TABLE #TempProductStatus

	UPDATE TOP (@BatchSize) a WITH (ROWLOCK)
	SET a.isfinished = 1
	OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,DELETED.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	FROM #Dep_CustProductStatus a 
	WHERE a.isfinished = 0
		 
	IF @@ROWCOUNT = 0 
		BREAK;

	UPDATE c 
	SET  c.bitmapIsHidden = tmp.bitmapIsHidden
		,c.bitmapIsDisabled = tmp.bitmapIsDisabled
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

	WAITFOR DELAY '00:00:00.100'
END

INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
SELECT	A.custid
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,ci.DisableCasino) AS bitmapIsDisabled
		, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
FROM #AllUsers A
	INNER JOIN custInfo ci WITH(NOLOCK) ON A.CustID = ci.custid
WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT t.custid,116
FROM #supers t
WHERE t.custid > @maxcustID AND t.custid <= @maxCustID2	
	AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=116)

----------Commm--------------------------
--insert group comm setting
INSERT INTO dbo.Dep_CustDiscountGroupSetting_Member 
	(AgentID
	,SportType
	,BetType
	,PlayerDiscount
	,AgentDiscount
	,MasterDiscount
	,SuperDiscount		
	)
SELECT t.custid, sb.Sporttype, sb.Bettype, 0, 0, 0, 0
FROM #SMATemp t	
	CROSS APPLY ( SELECT * FROM (VALUES (@SportType, @BetType)) AS sp(SportType, BetType)
				)sb
	LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
		ON dcs.AgentID = t.CustID and dcs.SportType = sb.sporttype
		AND dcs.BetType = sb.bettype	
WHERE t.roleid = 2 AND dcs.AgentID IS NULL

UPDATE #MemberTemp SET isfinished = 0
	
WHILE (1=1)
BEGIN
	UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
	SET c.isfinished = 1
	OUTPUT DELETED.CustID INTO @Cust_Temp(CustID)
	FROM #MemberTemp c 
	WHERE isfinished = 0
		
	IF @@ROWCOUNT = 0
		BREAK;
		
	-- UPDATE comm group for cust have not offered comm yet.
	UPDATE cs
		SET isGroupedComm = 1
	FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @Cust_Temp cb ON cb.CustID = cs.CustID
		OUTER APPLY (SELECT TOP 1 dcs_m.CustID FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
						WHERE dcs_m.CustID = cs.CustID
					) AS tmp
	WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
		
	-- insert private setting if already offered comm before and not belong to comm group
	INSERT INTO Dep_CustDiscountSetting_Member (CustID
						,SportType
						,BetType
						,PlayerDiscount
						,AgentDiscount
						,MasterDiscount
						,SuperDiscount)  	
	SELECT c.CustID, tmp.sporttype, tmp.bettype, 0,0,0,0
	FROM Dep_CustSettingMode c WITH (NOLOCK)
		INNER JOIN @Cust_Temp cb ON c.CustID = cb.CustID
		CROSS APPLY (SELECT * FROM (VALUES (@SportType, @BetType)) AS sp(SportType, BetType)
					) AS tmp
		LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
			ON dcs_m.CustID = c.CustID and dcs_m.SportType = tmp.sporttype
			AND dcs_m.BetType = tmp.bettype				
	WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
			
	DELETE FROM @Cust_Temp
END

INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT t.custid,119
FROM #supers t
WHERE t.custid > @maxcustID AND t.custid <= @maxCustID2	
	AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=119)

DROP TABLE #Dummy
DROP TABLE #MemberTemp
DROP TABLE #SMATemp
DROP TABLE #Dep_CustProductStatus
DROP TABLE #TempProductStatus
DROP TABLE #AllUsers
DROP TABLE #StakeLevelList
DROP TABLE #supers
PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

