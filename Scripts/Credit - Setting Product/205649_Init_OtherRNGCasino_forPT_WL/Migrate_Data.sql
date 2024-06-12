/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 2024-05-31
	Created: @Helios
	Task: Database - Initialize Other RNG Casino for PT and Win Loss Limit [#205649]
	DB: dbspare.custDB_20240513_0200
*/

DECLARE 
	@bitmapOrder_SabaCasino		 TINYINT,
	@SportType_SabaCasino		 SMALLINT	= 208,  -- SportType of Saba Casino
	@BetType_SabaCasino		 SMALLINT	= 2101, -- BetType of Saba Casino
	
	@bitmapOrder_OtherRNGCasino	 TINYINT,
	@SportType_OtherRNGCasino	 SMALLINT	= 9918, -- SportType of Other RNG Casino
	@BetType_OtherRNGCasino		 SMALLINT	= 4601  -- BetType of Other RNG Casino


SELECT @bitmapOrder_SabaCasino = (SELECT psp.bitmapOrder FROM ProductStatusProfile psp WITH(NOLOCK)  WHERE psp.Sporttype = @SportType_SabaCasino)


--Get Super Account Affect
CREATE TABLE #SuperID (SuperID INT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid FROM Customer c WITH (NOLOCK) WHERE c.username IN ('SA-US$','SA-IN','SWU','SVUS','SATU','SAS','OPS-US$')


--Get Downline Account Affect
CREATE TABLE #TmpSuperAffected
		(
			Site		VARCHAR(10),
			ExchangeId	TINYINT,
			UserName	VARCHAR(30),
			RoleID	TINYINT,
			CustID	INT,
			srecommend	INT,
			mrecommend	INT,
			recommend	INT,
			IsHidden	BIT,
			IsDisable	BIT,
			PRIMARY KEY CLUSTERED (CustID)
		)

INSERT INTO #TmpSuperAffected 
	(
		Site
	    , ExchangeId
	    , UserName
	    , RoleID
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
	)
SELECT	Site
	    , currency
	    , UserName
	    , cu.roleid
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
FROM Customer cu WITH (NOLOCK)
INNER JOIN #SuperID c ON cu.srecommend = c.SuperID

--Get ProductStatus Of SabaCasino
UPDATE temCust
	SET 
		IsHidden = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsHidden,  @bitmapOrder_SabaCasino))
	,	IsDisable = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsDisabled,  @bitmapOrder_SabaCasino))
FROM #TmpSuperAffected temCust
INNER JOIN CustProductStatus cs WITH(NOLOCK) ON cs.CustID = temCust.CustID

--SELECT *
--FROM #TmpSuperAffected tsa
--WHERE tsa.IsHidden = 0 AND tsa.IsDisable IN (0,1) AND tsa.CustID =4315079
--ORDER BY tsa.srecommend , tsa.RoleID DESC

--SELECT *
--FROM #TmpSuperAffected tsa
--WHERE tsa.IsHidden = 1  AND tsa.IsDisable = 1
--ORDER BY tsa.srecommend , tsa.RoleID DESC

/*
Solution Migrate Data:
	- 7 Line: SA-US$ , SA-IN , SWU , SVUS , SATU , SAS , OPS-US$
		+ Part 1: ProductStatus of SabaCasino have IsHidden = 0 AND IsDisable IN (0,1) 
			-> Copy Data Other RNG Casino From Saba Casino
		+ Part 2: Downline has IsHidden = IsDisable = 1
			-> Copy follow rule create new account, Copy values from Upline : Refer SP: Acc_DynamicCustomerInfo_00
			-> AND Update ProductStatus Of Other RNG Casino IsHidden = 0
	- 3 Line: StarixTestYNG , supertestteYM , TWSuper-7333
		+ Update ProductStatus Of Other RNG Casino IsHidden = 1
*/

---- Part 1: IsHidden = 0 AND IsDisable IN (0,1)
----SELECT * FROM #TmpSuperAffected WHERE IsHidden  = 0 AND IsDisable IN (0,1)

---- Step 1: Initial PT
INSERT INTO CustPTSetting3rd_Agent 
	(
		CustID
	    , SportType
	    , BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
	    , MinPT
	    , MaxPT
	)
SELECT	s.CustID
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS  BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
	    , MinPT
	    , MaxPT
FROM CustPTSetting3rd_Agent s WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tem ON s.CustID = tem.CustID
WHERE IsHidden  = 0 
AND IsDisable IN (0,1)
AND tem.RoleID  IN (2,3,4)
AND s.SportType = @SportType_SabaCasino
AND s.BetType = @BetType_SabaCasino



INSERT INTO CustPTSetting3rd_Member 
	(
		CustID
	    , SportType
	    , BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
	)
SELECT	s.CustID
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS  BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
FROM CustPTSetting3rd_Member s WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tem ON s.CustID = tem.CustID
WHERE IsHidden  = 0 
AND IsDisable IN (0,1)
AND tem.RoleID  = 1
AND s.SportType = @SportType_SabaCasino
AND s.BetType = @BetType_SabaCasino

---- Step 2: Initial WL

INSERT INTO CustWinLossLimit_Agent 
	(
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
	)
SELECT 
		s.CustId
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
FROM CustWinLossLimit_Agent s WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tem ON s.CustID = tem.CustID
WHERE IsHidden  = 0 
AND IsDisable IN (0,1)
AND tem.RoleID  IN (2,3,4)
AND s.SportType = @SportType_SabaCasino
AND s.BetType = @BetType_SabaCasino

INSERT INTO CustWinLossLimit_Member 
	(
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
	)
SELECT 
		s.CustId
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
FROM CustWinLossLimit_Member s WITH (NOLOCK)
INNER JOIN #TmpSuperAffected tem ON s.CustID = tem.CustID
WHERE IsHidden  = 0 
AND IsDisable IN (0,1)
AND tem.RoleID  = 1
AND s.SportType = @SportType_SabaCasino
AND s.BetType = @BetType_SabaCasino




-- Part 2: IsHidden = IsDisable = 1
--SELECT * FROM #TmpSuperAffected WHERE srecommend = 3 AND IsHidden = 1 AND IsDisable = 1 AND RoleID = 3
--SELECT * FROM #TmpSuperAffected WHERE custid IN (4176,4183,58969,118211,156404,214696)

 ----Step 1: Initial PT Follow Upline

----Init for Master
INSERT INTO CustPTSetting3rd_Agent 
	(
		CustID
	    , SportType
	    , BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
	    , MinPT
	    , MaxPT
	)
SELECT 	temMaster.mrecommend AS CustID
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS  BetType
	    , IsLive
	    , 0 AS IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , 0 AS SuperPT
	    , MasterPT
	    , 0 AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
	    , 0 AS MinPT
	    , 100 AS MaxPT
FROM #TmpSuperAffected temMaster 
INNER JOIN #TmpSuperAffected temSuper ON temMaster.srecommend = temSuper.srecommend
INNER JOIN CustPTSetting3rd_Agent s WITH (NOLOCK) ON s.CustID = temSuper.srecommend
WHERE temMaster.IsHidden  = 1
AND temMaster.IsDisable = 1
AND temMaster.RoleID  = 3
AND temSuper.RoleID = 4
AND s.SportType = @SportType_OtherRNGCasino
AND s.BetType = @BetType_OtherRNGCasino

------Init for Agent
INSERT INTO CustPTSetting3rd_Agent 
	(
		CustID
	    , SportType
	    , BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
	    , MinPT
	    , MaxPT
	)
SELECT 	temAgent.recommend AS CustID
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS  BetType
	    , IsLive
	    , IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , 0 AS SuperPT
	    , MasterPT
	    , 0 AS AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
	    , 0 AS MinPT
	    , 100 AS MaxPT
FROM #TmpSuperAffected temAgent 
INNER JOIN #TmpSuperAffected temMaster ON temAgent.mrecommend = temMaster.mrecommend
INNER JOIN CustPTSetting3rd_Agent s WITH (NOLOCK) ON s.CustID = temMaster.mrecommend
WHERE temAgent.IsHidden  = 1
AND temAgent.IsDisable = 1
AND temAgent.RoleID  = 2
AND temMaster.RoleID = 3
AND s.SportType = @SportType_OtherRNGCasino
AND s.BetType = @BetType_OtherRNGCasino


--------Init for Member
INSERT INTO CustPTSetting3rd_Member 
	(
		CustID
	    , SportType
	    , BetType
	    , IsLive
	    , IsAutoMasterPT
	    , IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , AutoSuperPT
	    , AutoMasterPT
	)
SELECT 	temMember.CustID AS CustID
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS  BetType
	    , IsLive
	    , 0 AS IsAutoMasterPT
	    , 0 AS IsAutoSuperPT
	    , SuperPT
	    , MasterPT
	    , AgentPT
	    , 0 AS AutoSuperPT
	    , 0 AS AutoMasterPT
FROM #TmpSuperAffected temMember 
INNER JOIN #TmpSuperAffected temAgent ON temMember.recommend = temAgent.recommend
INNER JOIN CustPTSetting3rd_Agent s WITH (NOLOCK) ON s.CustID = temAgent.recommend
WHERE temMember.IsHidden  = 1
AND temMember.IsDisable = 1
AND temMember.RoleID  = 1
AND temAgent.RoleID = 2
AND s.SportType = @SportType_OtherRNGCasino
AND s.BetType = @BetType_OtherRNGCasino


-------- Step 2: Initial WL Follow Upline

-------- Init for Master
INSERT INTO CustWinLossLimit_Agent 
	(
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
	)
SELECT 	temMaster.mrecommend AS CustID
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS  BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
FROM #TmpSuperAffected temMaster 
INNER JOIN #TmpSuperAffected temSuper ON temMaster.srecommend = temSuper.srecommend
INNER JOIN CustWinLossLimit_Agent s WITH (NOLOCK) ON s.CustID = temSuper.srecommend
WHERE temMaster.IsHidden  = 1
AND temMaster.IsDisable = 1
AND temMaster.RoleID  = 3
AND temSuper.RoleID = 4
AND s.SportType = @SportType_OtherRNGCasino
AND s.BetType = @BetType_OtherRNGCasino


-- ------Init for Agent
INSERT INTO CustWinLossLimit_Agent 
	(
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
	)
SELECT 	temAgent.recommend AS CustID
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS  BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
FROM #TmpSuperAffected temAgent 
INNER JOIN #TmpSuperAffected temMaster ON temAgent.mrecommend = temMaster.mrecommend
INNER JOIN CustWinLossLimit_Agent s WITH (NOLOCK) ON s.CustID = temMaster.mrecommend
WHERE temAgent.IsHidden  = 1
AND temAgent.IsDisable = 1
AND temAgent.RoleID  = 2
AND temMaster.RoleID = 3
AND s.SportType = @SportType_OtherRNGCasino
AND s.BetType = @BetType_OtherRNGCasino

-------- Init for Member
INSERT INTO CustWinLossLimit_Member 
	(
		CustId
	    , SportType
	    , BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
	)
SELECT 	temMember.CustID AS CustID
	    , @SportType_OtherRNGCasino AS SportType
	    , @BetType_OtherRNGCasino AS  BetType
	    , MaxWinLimit
	    , MaxLossLimit
	    , IsAutoReset
FROM #TmpSuperAffected temMember 
INNER JOIN #TmpSuperAffected temAgent ON temMember.recommend = temAgent.recommend
INNER JOIN CustWinLossLimit_Agent s WITH (NOLOCK) ON s.CustID = temAgent.recommend
WHERE temMember.IsHidden  = 1
AND temMember.IsDisable = 1
AND temMember.RoleID  = 1
AND temAgent.RoleID = 2
AND s.SportType = @SportType_OtherRNGCasino
AND s.BetType = @BetType_OtherRNGCasino


---- Step 3: Update ProductStatus.IsHidden = 0

SELECT @bitmapOrder_OtherRNGCasino = (SELECT psp.bitmapOrder FROM ProductStatusProfile psp WITH(NOLOCK)  WHERE psp.Sporttype = @SportType_OtherRNGCasino)

--SELECT 
--	temp.*,
--	cs.*,
--	(SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden,  @bitmapOrder_OtherRNGCasino, 0)) AS bitmapIsHidden_Gen,
--	(SELECT value FROM dbo.f_CustSetting_ProductStatusSel ((SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden,  @bitmapOrder_OtherRNGCasino, 0)),  @bitmapOrder_OtherRNGCasino)) AS bitmapIsHidden_Values
UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden,  @bitmapOrder_OtherRNGCasino, 0))
FROM CustProductStatus cs WITH (NOLOCK)
INNER JOIN #TmpSuperAffected temp ON temp.CustID = cs.CustID
--WHERE temp.IsHidden = 1

---------------------------------------------------------------------------------------------------------------------------------------------------------
TRUNCATE TABLE #SuperID
TRUNCATE TABLE #TmpSuperAffected

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid FROM Customer c WITH (NOLOCK) WHERE c.username IN ('StarixTestYNG','TWSuper-7333','supertestteYM')

INSERT INTO #TmpSuperAffected 
	(
		Site
	    , ExchangeId
	    , UserName
	    , RoleID
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
	)
SELECT	Site
	    , currency
	    , UserName
	    , cu.roleid
	    , CustID
	    , srecommend
	    , mrecommend
	    , recommend
FROM Customer cu WITH (NOLOCK)
INNER JOIN #SuperID c ON cu.srecommend = c.SuperID

-- Updated (IsHidden = 1 Other RNG Game) Of Account List 'StarixTestYNG','TWSuper-7333','supertestteYM'
UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden,  @bitmapOrder_OtherRNGCasino, 1))
FROM CustProductStatus cs WITH (NOLOCK)
INNER JOIN #TmpSuperAffected temp ON temp.CustID = cs.CustID


DROP TABLE #SuperID
DROP TABLE #TmpSuperAffected