/*
	Created: Elodie
	Task: Adjust Setting for Saba.club
	DB: DBCUST/CustDB
	Date: 20200321
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
	AND ci.site IN ('789y')

DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'

CREATE TABLE #SMAList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY)
CREATE TABLE #MemberList_PT (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY)	
CREATE TABLE #SMAList_WinLossLimit (custid INT, MaxWinLimit SMALLMONEY, MaxLossLimit MONEY, IsAutoReset BIT)
CREATE TABLE #MemberList_WinLossLimit (custid INT, MaxWinLimit SMALLMONEY, MaxLossLimit MONEY, IsAutoReset BIT)

DECLARE @tmp_PT TABLE (custid INT, SPositionTaking SMALLMONEY, MPositionTaking SMALLMONEY, APositionTaking SMALLMONEY, IsAutoMPositionTaking BIT, AutoMPositionTaking SMALLMONEY, IsAutoPositionTaking BIT, AutoPositionTaking SMALLMONEY, MinPositionTaking SMALLMONEY)
DECLARE @tmp_WinLossLimit TABLE (custid INT, MaxWinLimit SMALLMONEY, MaxLossLimit MONEY, IsAutoReset BIT) 

DECLARE @ProductID TINYINT = 42
DECLARE @fSportType SMALLINT, @fBetType SMALLINT, @tSportType SMALLINT, @tBetType SMALLINT, @IsLive BIT
	
CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	44, 1, SportType, BetType, 0, SettingType, 0
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType = 1

INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	212, 4001, SportType, BetType, 0, SettingType, 0 
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType = 6

--------------------------------------PT Setting-------------------------------------------------	
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
FROM #DestinationSportBetType		
WHERE SettingType = 1

--AGENT LEVEL
INSERT INTO  #SMAList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking, MinPositionTaking)
SELECT ci.custid, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT, cs.MinPT
FROM DBOTI.CustDB_BackupSetting.dbo.CustPTSetting3rd_Agent cs WITH(NOLOCK) 
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
			)

--MEMBER LEVEL
INSERT INTO #MemberList_PT (custid, SPositionTaking, MPositionTaking, APositionTaking, IsAutoMPositionTaking, AutoMPositionTaking, IsAutoPositionTaking, AutoPositionTaking)
SELECT ci.custid, cs.SuperPT, cs.MasterPT, cs.AgentPT, cs.IsAutoMasterPT, cs.AutoMasterPT, cs.IsAutoSuperPT, cs.AutoSuperPT
FROM DBOTI.CustDB_BackupSetting.dbo.CustPTSetting3rd_Member cs WITH(NOLOCK)
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
	OUTPUT Deleted.custid, Deleted.SPositionTaking, Deleted.MPositionTaking, Deleted.APositionTaking, Deleted.IsAutoMPositionTaking, Deleted.AutoMPositionTaking, Deleted.IsAutoPositionTaking, Deleted.AutoPositionTaking, Deleted.MinPositionTaking
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
	FROM dbo.CustPTSetting3rd_Agent csa WITH(ROWLOCK)
		INNER JOIN @tmp_PT cs ON csa.custid = cs.custid AND csa.SportType = @tSportType AND csa.BetType = @tBetType

	DELETE @tmp_PT
END

WHILE (1 = 1)
BEGIN				
	DELETE TOP (4000) t 
	OUTPUT Deleted.custid, Deleted.SPositionTaking, Deleted.MPositionTaking, Deleted.APositionTaking, Deleted.IsAutoMPositionTaking, Deleted.AutoMPositionTaking, Deleted.IsAutoPositionTaking, Deleted.AutoPositionTaking
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
END
	
--------------------------------------WinLoss Limit Setting-------------------------------------------------		
SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType, @tSportType = tSportType, @tBetType = tBetType
FROM #DestinationSportBetType		
WHERE SettingType = 6

--Agent Level
INSERT INTO #SMAList_WinLossLimit (custid, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT cs.custid, cs.MaxWinLimit, cs.MaxLossLimit, cs.IsAutoReset
FROM DBOTI.CustDB_BackupSetting.dbo.CustWinLossLimit_Agent cs WITH(NOLOCK)
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
FROM DBOTI.CustDB_BackupSetting.dbo.CustWinLossLimit_Member cs WITH(NOLOCK)
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
END

DROP TABLE #DestinationSportBetType	