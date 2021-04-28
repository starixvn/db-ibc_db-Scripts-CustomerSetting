/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task:  Adjust Setting for VGaming [#RM:153938]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.site IN ('BEST-ODDS', 'INDO', 'XYZBET', '611111', '722222', '733333', '222223', '755555', 'KORIBC', '7aa666', 'IBCIndo')
	AND ci.currency IN (
							13, --CNY(RMB)
							6, --EUR(EURO)
							12, --GBP(GBP)
							5, --HKD(HK$)
							67, --HKD(HKK)
							47, --IDR(DDD)
							33, --IDR(IDD)
							34, --IDR(IDR)
							15, --IDR(IN)
							22, --IDR(IND)
							45, --KRW(Won)
							69, --MMK(MMK)
							2, --MYR(RM)
							43, --THB(THB)
							35, --USD($US)
							3, --USD(US$)
							95, --USD(USD)
							64, --USD(UT)
							16 --USD(Yen)
			)

CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY)
CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
CREATE TABLE #SMAList_WinLossLimit (custid INT, MaxWinLimit SMALLMONEY, MaxLossLimit MONEY, IsAutoReset BIT)
CREATE TABLE #MemberList_WinLossLimit (custid INT, MaxWinLimit SMALLMONEY, MaxLossLimit MONEY, IsAutoReset BIT)

DECLARE @tmp_PT TABLE (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY, MaxPositionTaking SMALLMONEY)
DECLARE @tmp_WinLossLimit TABLE (custid INT, MaxWinLimit SMALLMONEY, MaxLossLimit MONEY, IsAutoReset BIT) 

DECLARE @ProductID TINYINT = 66
DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
DECLARE @bitmapOrderDest tinyint = 34 --VGaming
DECLARE @bitmapOrderSource tinyint = 21 --Saba.club

CREATE TABLE #CustStatus
	(
		CustID INT PRIMARY KEY CLUSTERED,
		isDisabled BIT,
		isHidden BIT
	)

CREATE TABLE #CustStatus_batch
	(
		CustID INT PRIMARY KEY CLUSTERED,
		isDisabled BIT,
		isHidden BIT
	)

;WITH tmpSaba AS
(
	SELECT
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, @bitmapOrderSource)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, @bitmapOrderSource)) as isHidden,
		c.CustID
	FROM CustProductStatus c WITH (NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	WHERE ci.Enabled = 1
)
,tmpVGaming AS
(
	SELECT
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled,@bitmapOrderDest)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, @bitmapOrderDest)) as isHidden,
		c.CustID
	FROM CustProductStatus c WITH (NOLOCK)
		INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = c.custid
		INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	WHERE ci.Enabled = 1
)
INSERT INTO #CustStatus(isDisabled,isHidden,CustID)
SELECT a.isDisabled,a.isHidden,a.CustID
FROM tmpSaba a 
	INNER JOIN tmpVGaming b ON a.CustID = b.CustID
WHERE a.isDisabled <> b.isDisabled OR a.isHidden <> b. isHidden

--Adjust Status			
WHILE 1 = 1
BEGIN
		DELETE TOP (3000) #CustStatus OUTPUT DELETED.CustID,deleted.isDisabled,deleted.isHidden INTO #CustStatus_batch(CustID,isDisabled,isHidden)

		IF @@ROWCOUNT=0
			BREAK

		UPDATE cs
		SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@bitmapOrderDest,ci.isHidden)),
			bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@bitmapOrderDest,ci.isDisabled))
		FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
			INNER JOIN #CustStatus_batch ci WITH(NOLOCK) ON cs.CustID = ci.CustID

		TRUNCATE TABLE #CustStatus_batch

		WAITFOR DELAY '00:00:00.050'
END
------------------------------------------------------------------------------------
	
CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	200, 1611, SportType, BetType, 0, SettingType, 0
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType IN (1,6)

--------------------------------------PT Setting-------------------------------------------------	
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
FROM #DestinationSportBetType		
WHERE SettingType = 1

--AGENT LEVEL
INSERT INTO  #SMAList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking, MaxPositionTaking)
SELECT ci.custid, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT, cs.MinPT, cs.MaxPT
FROM dbo.CustPTSetting3rd_Agent cs WITH(NOLOCK) 
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	INNER JOIN dbo.CustPTSetting3rd_Agent csa WITH(NOLOCK) ON csa.custid = cs.custid 
WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
		AND ci.roleid IN (2,3,4) AND Enabled = 1
		AND (
			cs.SuperPT <> csa.SuperPT
			OR cs.MasterPT <> csa.MasterPT
			OR cs.AgentPT <> csa.AgentPT
			OR cs.IsAutoMasterPT <> csa.IsAutoMasterPT
			OR cs.AutoMasterPT <> csa.AutoMasterPT
			OR cs.IsAutoSuperPT <> csa.IsAutoSuperPT
			OR cs.AutoSuperPT <> csa.AutoSuperPT
			OR cs.MinPT <> csa.MinPT 
			OR cs.MaxPT <> csa.MaxPT
			)

--MEMBER LEVEL
INSERT INTO #MemberList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking)
SELECT ci.custid, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT
FROM dbo.CustPTSetting3rd_Member cs WITH(NOLOCK)
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	INNER JOIN dbo.CustPTSetting3rd_Member csm WITH(NOLOCK) ON csm.custid = cs.custid 
WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
		AND ci.roleid = 1 AND Enabled = 1
		AND (
			cs.SuperPT <> csm.SuperPT
			OR cs.MasterPT <> csm.MasterPT
			OR cs.AgentPT <> csm.AgentPT
			OR cs.IsAutoMasterPT <> csm.IsAutoMasterPT
			OR cs.AutoMasterPT <> csm.AutoMasterPT
			OR cs.IsAutoSuperPT <> csm.IsAutoSuperPT
			OR cs.AutoSuperPT <> csm.AutoSuperPT
			)
--Adjust data
WHILE (1 = 1)
BEGIN				
	DELETE TOP (4000) t 
	OUTPUT Deleted.custid, Deleted.SPositionTaking, Deleted.MPositionTaking, Deleted.APositionTaking, Deleted.IsAutoMPositionTaking, Deleted.AutoMPositionTaking, Deleted.IsAutoPositionTaking, Deleted.AutoPositionTaking, Deleted.MinPositionTaking,deleted.MaxPositionTaking
	INTO @tmp_PT
	FROM #SMAList_PT t
		
	IF @@ROWCOUNT = 0 BREAK	

	UPDATE csa
	SET	csa.SuperPT = cs.spositiontaking
		,csa.MasterPT =  cs.mpositiontaking
		,csa.AgentPT = cs.apositiontaking 
		,csa.IsAutoMasterPT = cs.isautompositiontaking
		,csa.AutoMasterPT = cs.autompositiontaking
		,csa.IsAutoSuperPT = cs.isautopositiontaking 
		,csa.AutoSuperPT = cs.autopositiontaking
		,csa.MinPT = cs.minpositiontaking
		,csa.MaxPT = cs.MaxPositionTaking
	FROM dbo.CustPTSetting3rd_Agent csa WITH(ROWLOCK)
		INNER JOIN @tmp_PT cs ON csa.custid = cs.custid AND csa.SportType = @tSportType AND csa.BetType = @tBetType

	DELETE @tmp_PT

	WAITFOR DELAY '00:00:00.050'
END

WHILE (1 = 1)
BEGIN				
	DELETE TOP (4000) t 
	OUTPUT Deleted.custid, Deleted.SPositionTaking, Deleted.MPositionTaking, Deleted.APositionTaking, Deleted.IsAutoMPositionTaking, Deleted.AutoMPositionTaking, Deleted.IsAutoPositionTaking, Deleted.AutoPositionTaking, NULL,NULL
	INTO @tmp_PT
	FROM #MemberList_PT t
		
	IF @@ROWCOUNT = 0 BREAK	

	UPDATE csm
	SET	csm.SuperPT = cs.spositiontaking
		,csm.MasterPT =  cs.mpositiontaking
		,csm.AgentPT = cs.apositiontaking
		,csm.IsAutoMasterPT = cs.isautompositiontaking
		,csm.AutoMasterPT = cs.autompositiontaking
		,csm.IsAutoSuperPT = cs.isautopositiontaking 
		,csm.AutoSuperPT = cs.autopositiontaking
	FROM dbo.CustPTSetting3rd_Member csm WITH(ROWLOCK)
		INNER JOIN @tmp_PT cs ON cs.custid = csm.custid AND csm.bettype = @tBetType AND csm.sporttype = @tSportType

	DELETE @tmp_PT

	WAITFOR DELAY '00:00:00.050'
END
	
--------------------------------------WinLoss Limit Setting-------------------------------------------------		
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
FROM #DestinationSportBetType		
WHERE SettingType = 6

--Agent Level
INSERT INTO #SMAList_WinLossLimit (custid, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT cs.custid, cs.MaxWinLimit, cs.MaxLossLimit, cs.IsAutoReset
FROM dbo.CustWinLossLimit_Agent cs WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON cs.CustID = c.custid
	INNER JOIN #supers s WITH (NOLOCK) ON c.srecommend = s.custid
	INNER JOIN dbo.CustWinLossLimit_Agent csa WITH(NOLOCK) ON csa.custid = cs.custid
WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csa.SportType = @tSportType AND csa.BetType = @tBetType
		AND c.roleid IN (2,3,4) AND Enabled = 1
		AND (
			cs.MaxWinLimit <> csa.MaxWinLimit
			OR cs.MaxLossLimit <> csa.MaxLossLimit
			OR cs.IsAutoReset <> csa.IsAutoReset			
			)

--Member Level
INSERT INTO #MemberList_WinLossLimit (custid, MaxWinLimit, MaxLossLimit, IsAutoReset)	   
SELECT cs.custid, cs.MaxWinLimit, cs.MaxLossLimit, cs.IsAutoReset
FROM dbo.CustWinLossLimit_Member cs WITH(NOLOCK)
	INNER JOIN custInfo c WITH(NOLOCK) ON cs.CustID = c.custid
	INNER JOIN #supers s WITH (NOLOCK) ON c.srecommend = s.custid
	INNER JOIN dbo.CustWinLossLimit_Member csm WITH(NOLOCK) ON csm.custid = cs.custid
WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType AND csm.SportType = @tSportType AND csm.BetType = @tBetType
		AND c.roleid = 1 AND Enabled = 1
		AND (
			cs.MaxWinLimit <> csm.MaxWinLimit
			OR cs.MaxLossLimit <> csm.MaxLossLimit
			OR cs.IsAutoReset <> csm.IsAutoReset			
			)

WHILE (1 = 1)
BEGIN	
	DELETE TOP (4000) t 
	OUTPUT Deleted.custid, Deleted.MaxWinLimit, Deleted.MaxLossLimit, Deleted.IsAutoReset
	INTO @tmp_WinLossLimit
	FROM #SMAList_WinLossLimit t

	IF @@ROWCOUNT = 0 BREAK

	UPDATE csa
	SET csa.MaxWinLimit = cs.MaxWinLimit,       
		csa.MaxLossLimit = cs.MaxLossLimit,   
		csa.IsAutoReset = cs.IsAutoReset
	FROM dbo.CustWinLossLimit_Agent csa WITH(ROWLOCK)
		INNER JOIN @tmp_WinLossLimit cs ON cs.custid = csa.CustID AND csa.SportType = @tSportType AND csa.BetType = @tBetType

	DELETE @tmp_WinLossLimit

	WAITFOR DELAY '00:00:00.050'
END

WHILE (1 = 1)
BEGIN	
	DELETE TOP (4000) t 	
	OUTPUT Deleted.custid, Deleted.MaxWinLimit, Deleted.MaxLossLimit, Deleted.IsAutoReset
	INTO @tmp_WinLossLimit
	FROM #MemberList_WinLossLimit t

	IF @@ROWCOUNT = 0 BREAK

	UPDATE csm
	SET csm.MaxWinLimit = cs.MaxWinLimit,       
		csm.MaxLossLimit = cs.MaxLossLimit,   
		csm.IsAutoReset = cs.IsAutoReset
	FROM dbo.CustWinLossLimit_Member csm WITH(ROWLOCK)
		INNER JOIN @tmp_WinLossLimit cs ON cs.custid = csm.CustID AND csm.SportType = @tSportType AND csm.BetType = @tBetType
	
	DELETE @tmp_WinLossLimit

	WAITFOR DELAY '00:00:00.050'
END

DROP TABLE #DestinationSportBetType	
DROP TABLE #CustStatus_batch
DROP TABLE #MemberList_PT
DROP TABLE #MemberList_WinLossLimit
DROP TABLE #SMAList_PT
DROP TABLE #SMAList_WinLossLimit
DROP TABLE #supers
DROP TABLE #CustStatus