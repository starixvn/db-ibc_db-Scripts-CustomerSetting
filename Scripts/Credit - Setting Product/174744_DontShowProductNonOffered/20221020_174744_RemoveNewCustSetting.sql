/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Non Offer - Delete setting for new created users [#RM:174744]
	DB: DBCUST/CustDB 
*/

CREATE TABLE #supers (custid INT PRIMARY KEY CLUSTERED, site VARCHAR(10), currency TINYINT)
CREATE TABLE #TempSite(site nvarchar(50),	currency nvarchar(50),	bitmapOrder	varchar(100),	ProductID VARCHAR(100), isRNGKeno	INT)

CREATE TABLE #ProductSettingDetail (SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, ProductID TINYINT, RealProductId TINYINT)
CREATE TABLE #Member (CustID INT PRIMARY KEY CLUSTERED , isRNGKeno INT, ProductID VARCHAR(100),isfinished BIT DEFAULT(0) , bitmapOrder	VARCHAR(100))
CREATE TABLE #MemberTemp (CustID INT PRIMARY KEY)
CREATE TABLE #SMATemp (	CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT , isRNGKeno INT, ProductID VARCHAR(100),isfinished BIT DEFAULT(0),	bitmapOrder	VARCHAR(100))
CREATE TABLE #SMATempNew (CustID INT PRIMARY KEY)

INSERT INTO #TempSite(site , currency ,	bitmapOrder , ProductID , isRNGKeno )
		  SELECT '222223' AS site, 2 AS currency ,'25,4,8'  AS bitmapOrder                                 ,'23,24,46'  AS ProductID                                                , 0   AS isRNGKeno
UNION ALL SELECT '222223'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '222223'    , 67 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '611111'    , 2  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '611111'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '611111'    , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT '611111'    , 42 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '722222'    , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '722222'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '722222'    , 13 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '722222'    , 67 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '733333'    , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '733333'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT '733333'    , 13 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '733333'    , 67 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '755555'    , 43 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT '76666B'    , 69 ,'21,24,25,29,34,4,8'                                                    ,'23,24,42,46,47,51,66'                                                  , 0  
UNION ALL SELECT '789y'      , 2  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '789y'      , 3  ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '789y'      , 6  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '789y'      , 16 ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '789y'      , 35 ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '789y'      , 64 ,'25,34,8'                                                               ,'24,46,66'                                                              , 0  
UNION ALL SELECT '7aa666'    , 2  ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT '7aa666'    , 69 ,'24,25,29,4,8'                                                          ,'23,24,46,47,51'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'BEST-ODDS' , 3  ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 6  ,'25,29,31,4,8'                                                          ,'23,24,46,51,59'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 9  ,'21,22,24,25,27,29,30,31,33,34,37,38,4,8'                               ,'23,24,42,45,46,47,51,52,57,59,6,65,66,70'                              , 0  
UNION ALL SELECT 'BEST-ODDS' , 10 ,'21,25,4,8'                                                             ,'23,24,42,46'                                                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 12 ,'25,29,31,37,38,4,8'                                                    ,'23,24,46,51,59,6,70'                                                   , 0  
UNION ALL SELECT 'BEST-ODDS' , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 15 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 16 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 22 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 33 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 34 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 35 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 41 ,'20,21,22,24,25,27,29,30,31,33,34,37,38,4,8'                            ,'23,24,39,42,45,46,47,51,52,57,59,6,65,66,70'                           , 0  
UNION ALL SELECT 'BEST-ODDS' , 42 ,'10,11,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,37,38,39,4,5,6,8','21,22,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70' , 1  
UNION ALL SELECT 'BEST-ODDS' , 43 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  
UNION ALL SELECT 'BEST-ODDS' , 45 ,'20,25,30,31,4,8'                                                       ,'23,24,39,46,57,59'                                                     , 0  
UNION ALL SELECT 'IBCIndo'   , 22 ,'4,8'                                                                   ,'23,24'                                                                 , 0  
UNION ALL SELECT 'IBCIndo'   , 33 ,'4,8'                                                                   ,'23,24'                                                                 , 0  
UNION ALL SELECT 'IBCIndo'   , 34 ,'4,8'                                                                   ,'23,24'                                                                 , 0  
UNION ALL SELECT 'IMBC'      , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT 'indo'      , 15 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 22 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 33 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 34 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'INDO'      , 47 ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'KORIBC'    , 45 ,'20,25,30,31,4,8'                                                       ,'23,24,39,46,57,59'                                                     , 0  
UNION ALL SELECT 'XYZBET'    , 2  ,'25,4,8'                                                                ,'23,24,46'                                                              , 0  
UNION ALL SELECT 'XYZBET'    , 5  ,'25,30,4,8'                                                             ,'23,24,46,57'                                                           , 0  
UNION ALL SELECT 'XYZBET'    , 6  ,'25,29,31,4,8'                                                          ,'23,24,46,51,59'                                                        , 0  
UNION ALL SELECT 'XYZBET'    , 12 ,'25,29,31,37,38,4,8'                                                    ,'23,24,46,51,59,6,70'                                                   , 0  
UNION ALL SELECT 'XYZBET'    , 13 ,'20,25,4,8'                                                             ,'23,24,39,46'                                                           , 0  
UNION ALL SELECT 'XYZBET'    , 15 ,'21,25,34,4,8'                                                          ,'23,24,42,46,66'                                                        , 0  

DECLARE @max_custid INT, @ProductID varchar(200)
SELECT @max_custid = xxx
SET @ProductID = '21,23,24,28,38,39,40,42,45,46,47,5,50,51,52,57,59,6,63,65,66,69,70'

INSERT INTO #ProductSettingDetail(SettingType, SportType, BetType, IsLive, ProductID, RealProductId)
SELECT SettingType, SportType, BetType, IsLive, ProductID, RealProductId
FROM ProductSettingDetail WITH(NOLOCK)
WHERE SettingType NOT IN (4,11,13,21) 
AND RealProductId  IN (SELECT VALUE AS ProductID FROM STRING_SPLIT(@ProductID,',') WHERE VALUE <> '')

INSERT INTO #supers(custid, site,currency)
SELECT ci.custid, ci.site,ci.currency
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND (  ( ci.Site IN ('222223') AND ci.currency IN (2,5,67))
			OR ( ci.Site IN ('611111') AND ci.currency IN (13,2,42,5))
			OR ( ci.Site IN ('722222') AND ci.currency IN (13,2,5,67))
			OR ( ci.Site IN ('733333') AND ci.currency IN (13,2,5,67))
			OR ( ci.Site IN ('755555') AND ci.currency IN (43))
			OR ( ci.Site IN ('76666B') AND ci.currency IN (69))
			OR ( ci.Site IN ('789y') AND ci.currency IN (16,2,3,35,6,64))
			OR ( ci.Site IN ('7aa666') AND ci.currency IN (2,69))
			OR ( ci.Site IN ('BEST-ODDS') AND ci.currency IN (10,12,13,15,16,2,22,3,33,34,35,41,42,43,45,5,6,9))
			OR ( ci.Site IN ('IBCIndo') AND ci.currency IN (22,33,34))
			OR ( ci.Site IN ('IMBC') AND ci.currency IN (13))
			OR ( ci.Site IN ('INDO') AND ci.currency IN (15,22,33,34,47))
			OR ( ci.Site IN ('KORIBC') AND ci.currency IN (45))
			OR ( ci.Site IN ('XYZBET') AND ci.currency IN (12,13,15,2,5,6)))

INSERT INTO #Member (CustID , isRNGKeno , ProductID , bitmapOrder)
SELECT c.custid , t.isRNGKeno, t.ProductID, t.bitmapOrder
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
	INNER JOIN #TempSite t ON t.site = s.site AND t.currency = s.currency
WHERE roleid = 1  AND Enabled = 1 AND c.custid > @max_custid
	
INSERT INTO #SMATemp (CustID, roleid , isRNGKeno , ProductID, bitmapOrder)
SELECT c.custid, roleid , t.isRNGKeno, t.ProductID, t.bitmapOrder
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
	INNER JOIN #TempSite t ON t.site = s.site AND t.currency = s.currency
WHERE c.roleid IN (2,3,4) AND Enabled = 1 AND c.custid > @max_custid 

DECLARE @batch int = 3000

--PositionTaking
IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (1,18))
BEGIN
	CREATE TABLE #CustPTSetting3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTSetting3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTGroupSetting3rd_Member(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(AgentID ,Sporttype ,Bettype ,IsLive))

	CREATE TABLE #CustPTSetting3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTSetting3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype ,IsLive))
	CREATE TABLE #CustPTGroupSetting3rd_MemberTemp(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(AgentID ,Sporttype ,Bettype ,IsLive))
		
	INSERT INTO #CustPTSetting3rd_Agent(CustID, SportType, BetType, IsLive)
	SELECT a.CustID, a.SportType, a.BetType, a.IsLive
	FROM CustPTSetting3rd_Agent a WITH(NOLOCK)
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (1,18)
		
	INSERT INTO #CustPTSetting3rd_Member(CustID, SportType, BetType, IsLive)
	SELECT a.CustID, a.SportType, a.BetType, a.IsLive
	FROM CustPTSetting3rd_Member a WITH(NOLOCK)
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (1,18)

	INSERT INTO #CustPTGroupSetting3rd_Member(AgentID, SportType, BetType, IsLive)
	SELECT a.AgentID, a.SportType, a.BetType, a.IsLive
	FROM CustPTGroupSetting3rd_Member a WITH(NOLOCK)
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.AgentID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (1,18) AND ci.roleid = 2
		
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTSetting3rd_Agent)
	BEGIN
		DELETE TOP (@batch) #CustPTSetting3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
		INTO #CustPTSetting3rd_AgentTemp(CustID, SportType, BetType, IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustPTSetting3rd_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustPTSetting3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

		TRUNCATE TABLE #CustPTSetting3rd_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTSetting3rd_Member)
	BEGIN
		DELETE TOP (@batch) #CustPTSetting3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
		INTO #CustPTSetting3rd_MemberTemp(CustID, SportType, BetType, IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustPTSetting3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustPTSetting3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

		TRUNCATE TABLE #CustPTSetting3rd_MemberTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustPTGroupSetting3rd_Member)
	BEGIN
		DELETE TOP (@batch) #CustPTGroupSetting3rd_Member OUTPUT DELETED.AgentID, DELETED.SportType,DELETED.BetType,DELETED.IsLive 
		INTO #CustPTGroupSetting3rd_MemberTemp(AgentID, SportType, BetType, IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustPTGroupSetting3rd_MemberTemp ci ON ci.AgentID = cg.AgentID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

		TRUNCATE TABLE #CustPTGroupSetting3rd_MemberTemp
	END

	DROP TABLE #CustPTSetting3rd_Agent
	DROP TABLE #CustPTSetting3rd_Member
	DROP TABLE #CustPTGroupSetting3rd_Member
	DROP TABLE #CustPTSetting3rd_AgentTemp
	DROP TABLE #CustPTSetting3rd_MemberTemp
	DROP TABLE #CustPTGroupSetting3rd_MemberTemp
END

--BetLimit	
IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (2,9,16,20))
BEGIN
	CREATE TABLE #CustBetSetting3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #CustBetSetting3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype))

	CREATE TABLE #CustBetSetting3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #CustBetSetting3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
											PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
	INSERT INTO #CustBetSetting3rd_Agent(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustBetSetting3rd_Agent a WITH(NOLOCK)
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (2,9,16,20)
		
	INSERT INTO #CustBetSetting3rd_Member(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustBetSetting3rd_Member a WITH(NOLOCK)
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (2,9,16,20)

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustBetSetting3rd_Agent)
	BEGIN
		DELETE TOP (@batch) #CustBetSetting3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #CustBetSetting3rd_AgentTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustBetSetting3rd_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustBetSetting3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #CustBetSetting3rd_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustBetSetting3rd_Member)
	BEGIN
		DELETE TOP (@batch) #CustBetSetting3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #CustBetSetting3rd_MemberTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustBetSetting3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustBetSetting3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #CustBetSetting3rd_MemberTemp
	END

	DROP TABLE #CustBetSetting3rd_Agent
	DROP TABLE #CustBetSetting3rd_Member
	DROP TABLE #CustBetSetting3rd_AgentTemp
	DROP TABLE #CustBetSetting3rd_MemberTemp
END

--Commission		
IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (3,19,5,14))
BEGIN
	CREATE TABLE #CustDiscount3rd_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #CustDiscount3rd_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype))

	CREATE TABLE #CustDiscount3rd_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #CustDiscount3rd_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
											PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
	INSERT INTO #CustDiscount3rd_Agent(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustDiscount3rd_Agent a WITH(NOLOCK)
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (3,19,5,14)
		
	INSERT INTO #CustDiscount3rd_Member(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustDiscount3rd_Member a WITH(NOLOCK)
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (3,19,5,14)

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscount3rd_Agent)
	BEGIN
		DELETE TOP (@batch) #CustDiscount3rd_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #CustDiscount3rd_AgentTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustDiscount3rd_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustDiscount3rd_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #CustDiscount3rd_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustDiscount3rd_Member)
	BEGIN
		DELETE TOP (@batch) #CustDiscount3rd_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #CustDiscount3rd_MemberTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustDiscount3rd_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustDiscount3rd_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #CustDiscount3rd_MemberTemp
	END

	DROP TABLE #CustDiscount3rd_Agent
	DROP TABLE #CustDiscount3rd_Member
	DROP TABLE #CustDiscount3rd_AgentTemp
	DROP TABLE #CustDiscount3rd_MemberTemp
END
	
--Win Loss Limit		
IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (6,12))
BEGIN
	CREATE TABLE #CustWinLossLimit_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #CustWinLossLimit_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype))

	CREATE TABLE #CustWinLossLimit_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #CustWinLossLimit_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
											PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
	INSERT INTO #CustWinLossLimit_Agent(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustWinLossLimit_Agent a WITH(NOLOCK)
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (6,12)
		
	INSERT INTO #CustWinLossLimit_Member(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustWinLossLimit_Member a WITH(NOLOCK)
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (6,12)

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLossLimit_Agent)
	BEGIN
		DELETE TOP (@batch) #CustWinLossLimit_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #CustWinLossLimit_AgentTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustWinLossLimit_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustWinLossLimit_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #CustWinLossLimit_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustWinLossLimit_Member)
	BEGIN
		DELETE TOP (@batch) #CustWinLossLimit_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #CustWinLossLimit_MemberTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustWinLossLimit_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustWinLossLimit_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #CustWinLossLimit_MemberTemp
	END

	DROP TABLE #CustWinLossLimit_Agent
	DROP TABLE #CustWinLossLimit_Member
	DROP TABLE #CustWinLossLimit_AgentTemp
	DROP TABLE #CustWinLossLimit_MemberTemp
END
	
--Stake Level		
IF EXISTS(SELECT TOP 1 1 FROM #ProductSettingDetail WHERE SettingType IN (7,8,17))
BEGIN
	CREATE TABLE #CustStakeLevel_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype ))
	CREATE TABLE #CustStakeLevel_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype))

	CREATE TABLE #CustStakeLevel_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID ,Sporttype ,Bettype))
	CREATE TABLE #CustStakeLevel_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT,  
											PRIMARY KEY(CustID ,Sporttype ,Bettype))
		
	INSERT INTO #CustStakeLevel_Agent(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustStakeLevel_Agent a WITH(NOLOCK)
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (7,8,17)
		
	INSERT INTO #CustStakeLevel_Member(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM CustStakeLevel_Member a WITH(NOLOCK)
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
		CROSS APPLY (SELECT CAST(VALUE AS INT) AS ProductID FROM STRING_SPLIT(ci.ProductID,',') WHERE VALUE <> '') b
		INNER JOIN #ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType AND b.ProductID = t.RealProductId
	WHERE t.SettingType IN (7,8,17)

	WHILE EXISTS(SELECT TOP 1 1 FROM #CustStakeLevel_Agent)
	BEGIN
		DELETE TOP (@batch) #CustStakeLevel_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #CustStakeLevel_AgentTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #CustStakeLevel_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #CustStakeLevel_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #CustStakeLevel_Member)
	BEGIN
		DELETE TOP (@batch) #CustStakeLevel_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #CustStakeLevel_MemberTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #CustStakeLevel_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #CustStakeLevel_MemberTemp
	END

	DROP TABLE #CustStakeLevel_Agent
	DROP TABLE #CustStakeLevel_Member
	DROP TABLE #CustStakeLevel_AgentTemp
	DROP TABLE #CustStakeLevel_MemberTemp
END

-- Disable keno 
WHILE EXISTS(SELECT TOP 1 1 FROM #SMATemp WHERE isfinished = 0 AND isRNGKeno = 1)
BEGIN
	UPDATE TOP (@batch) #SMATemp 
	SET isfinished = 1
	OUTPUT DELETED.CustID INTO #SMATempNew(CustID)
	WHERE isfinished = 0 AND isRNGKeno = 1

	IF @@ROWCOUNT=0
		BREAK		

	--Update keno status 
	UPDATE g 
	SET HideKeno = 1
	FROM dbo.CustInfo g WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #SMATempNew b ON g.CustID = b.CustID 
		
	TRUNCATE TABLE #SMATempNew
END

WHILE EXISTS(SELECT TOP 1 1 FROM #Member WHERE isfinished = 0 AND isRNGKeno = 1)
BEGIN
	UPDATE TOP (@batch) #Member 
	SET isfinished = 1
	OUTPUT DELETED.CustID INTO #MemberTemp(CustID)
	WHERE isfinished = 0 AND isRNGKeno = 1

	IF @@ROWCOUNT=0
		BREAK		
	
	--Update keno status 
	UPDATE g 
	SET HideKeno = 1
	FROM dbo.CustInfo g WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #MemberTemp b ON g.CustID = b.CustID 

	TRUNCATE TABLE #MemberTemp
END

-- Update Status 
CREATE TABLE #AllUsers (CustID INT PRIMARY KEY, XmlDisable VARCHAR(MAX))
CREATE TABLE #CustProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32),isfinished BIT DEFAULT(0))
CREATE TABLE #TempProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32))

INSERT INTO #AllUsers (CustID,XmlDisable)
SELECT DISTINCT SMA.CustID , c.zxml FROM #SMATemp SMA WITH (NOLOCK)
CROSS APPLY ( SELECT DISTINCT
					bitmap AS '@b', 
					1 AS '@s'
				FROM (SELECT value AS bitmap
					FROM STRING_SPLIT(SMA.bitmapOrder,',')
					WHERE value <> '') vh 
				FOR XML PATH ('r'), ROOT ('root')) c (zxml)
UNION 
SELECT DISTINCT M.CustID , c.zxml FROM #Member M WITH (NOLOCK)
CROSS APPLY ( SELECT DISTINCT
					bitmap AS '@b', 
					1 AS '@s'
				FROM (SELECT value AS bitmap
					FROM STRING_SPLIT(M.bitmapOrder,',')
					WHERE value <> '') vh 
				FOR XML PATH ('r'), ROOT ('root')) c (zxml)

INSERT INTO #CustProductStatus(CustID,bitmapIsHidden)
SELECT cs.CustID
	,bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),a.XmlDisable)))
FROM CustProductStatus cs WITH(NOLOCK)
	INNER JOIN  #AllUsers a ON a.CustID = cs.custid

WHILE 1 = 1 
BEGIN
	TRUNCATE TABLE #TempProductStatus

	UPDATE TOP (@batch) a WITH (ROWLOCK)
	SET a.isfinished = 1
	OUTPUT DELETED.CustID,DELETED.bitmapIsHidden INTO #TempProductStatus(CustID,bitmapIsHidden)
	FROM #CustProductStatus a 
	WHERE a.isfinished = 0
		 
	IF @@ROWCOUNT = 0 
		BREAK;

	UPDATE c 
	SET  c.bitmapIsHidden = tmp.bitmapIsHidden
	FROM CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

	WAITFOR DELAY '00:00:00.100'
END

DROP TABLE #ProductSettingDetail	
DROP TABLE #Member
DROP TABLE #SMATemp
DROP TABLE #supers
DROP TABLE #TempSite
DROP TABLE #MemberTemp
DROP TABLE #SMATempNew
DROP TABLE #TempProductStatus
DROP TABLE #CustProductStatus
DROP TABLE #AllUsers