/*
	Created: 20200504@Eden
	Task: Copy Setting for new created users of ION - HKK [Redmine: 132323]
	DB: DBCUST/CustDB
*/

PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
DECLARE @ProductID TINYINT = 41, @Sporttype INT = 225, @Bettype INT = 5601
DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT
DECLARE @MaxPT TINYINT

SELECT @MaxCustID = xxx

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
			AND ci.Site <> 'CN88'
			AND CI.currency = 67 --HKK

SELECT TOP 1 @MaxPT = MaxPT FROM ProductSettingDetail WITH (NOLOCK) WHERE ProductID = @ProductID AND SettingType = 1

CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	243, 3101, SportType, BetType, 0, SettingType, 0
FROM ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SportType = @Sporttype AND SettingType IN (1)

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
	currency INT
)

INSERT INTO #MemberTemp (CustID, currency)
SELECT custid, currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid	
	
INSERT INTO #SMATemp (CustID, roleid, currency)
SELECT custid, roleid, currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 

--------------------------------------PT Setting-------------------------------------------------

SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
FROM #DestinationSportBetType		
WHERE SettingType = 1

--Agent Level
INSERT INTO dbo.CustPTSetting3rd_Agent
		(	[CustID]
			,[SportType]
			,[BetType]
			,[IsLive]
			,[SuperPT]
			,[MasterPT]
			,[AgentPT]
			,[IsAutoMasterPT]
			,[AutoMasterPT]
			,[IsAutoSuperPT]
			,[AutoSuperPT]
			,[MinPT]
			,[MaxPT])
SELECT 
		C.custid, dest.tSportType, dest.tBetType
		,C.IsLive
		,C.SuperPT
		,C.MasterPT
		,C.AgentPT
		,C.IsAutoMasterPT
		,C.AutoMasterPT
		,C.IsAutoSuperPT
		,C.AutoSuperPT
		,C.MinPT
		,C.MaxPT
FROM dbo.CustPTSetting3rd_Agent C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.custid
		CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.SportType = @fSportType
		AND dest.SettingType = 1

--Member Level
INSERT INTO dbo.CustPTSetting3rd_Member
		(	[custid]
			,	[sporttype]
			,	[bettype]
			,	[islive]
			,	[superPT]
			,	[masterPT]
			,	[agentPT]
			,	[IsAutoMasterPT]
			,	[AutoMasterPT]
			,	[IsAutoSuperPT]
			,	[AutoSuperPT])
SELECT 
		C.custid, dest.tSportType, dest.tBetType
		,C.IsLive
		,C.SuperPT
		,C.MasterPT
		,C.AgentPT
		,C.IsAutoMasterPT
		,C.AutoMasterPT
		,C.IsAutoSuperPT
		,C.AutoSuperPT
FROM CustPTSetting3rd_Member C WITH(NOLOCK) 
		INNER JOIN #MemberTemp ci ON C.CustID = ci.custid
		CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.sporttype = @fSportType
		AND dest.SettingType = 1

--Group PT 
INSERT INTO dbo.CustPTGroupSetting3rd_Member
	(	[AgentID]
		,[SportType]
		,[BetType]
		,[IsLive]
		,[SuperPT]
		,[MasterPT]
		,[AgentPT]
		,[IsAutoMasterPT]
		,[AutoMasterPT]
		,[IsAutoSuperPT]
		,[AutoSuperPT]
		)
SELECT 
		C.AgentID, dest.tSportType, dest.tBetType
		,C.IsLive
		,C.SuperPT
		,C.MasterPT
		,C.AgentPT
		,C.IsAutoMasterPT
		,C.AutoMasterPT
		,C.IsAutoSuperPT
		,C.AutoSuperPT
FROM dbo.CustPTGroupSetting3rd_Member C WITH(NOLOCK) 
		INNER JOIN #SMATemp ci ON ci.custid = C.AgentID
		CROSS APPLY #DestinationSportBetType dest
WHERE C.bettype = @fBetType AND C.SportType = @fSportType
		AND dest.SettingType = 1	

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType	
DROP TABLE #supers
PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
