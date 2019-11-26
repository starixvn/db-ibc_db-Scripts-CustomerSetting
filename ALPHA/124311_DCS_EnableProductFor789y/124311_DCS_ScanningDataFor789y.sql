USE [CustDB]
GO
/*
	Created: Tiara
	Task: Scanning data for 789y headlines RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20191126
*/ 

--Get SMA of group headline 789y
CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.site IN ('789y')

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
	currency INT
)

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT
)

INSERT INTO #SMATemp (CustID, roleid, currency)
SELECT custid, roleid, currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 

INSERT INTO #MemberTemp (CustID, currency)
SELECT custid, currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 

CREATE TABLE #ProductID
(
	Productid INT
)

INSERT INTO #ProductID(Productid) 
	SELECT 5 UNION ALL
	SELECT 16 UNION ALL
    SELECT 21 UNION ALL
	SELECT 22 UNION ALL
	SELECT 24 UNION ALL
	SELECT 28 UNION ALL
	SELECT 23
	
CREATE TABLE #SportBettypeFilterStatus
(
	Productid INT,
	SportType INT,
	Bettype INT
)

INSERT INTO #SportBettypeFilterStatus (Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,13) AS F

INSERT INTO #SportBettypeFilterStatus (Productid,SportType,Bettype)
SELECT 23,SportType,Bettype
FROM dbo.f_CustSetting_SportBetTypeSettingSelect(23,11) AS F

SELECT * FROM #SportBettypeFilterStatus WITH (NOLOCK)

CREATE TABLE #SportBettypeFilterOtherSetting
(
	Productid INT,
	SportType INT,
	Bettype INT
)

INSERT INTO #SportBettypeFilterOtherSetting (Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,2) AS F

INSERT INTO #SportBettypeFilterOtherSetting(Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,7) AS F

INSERT INTO #SportBettypeFilterOtherSetting(Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,8) AS F
--DROP TABLE  #SportBettypeFilterStatus


-----3-SB2 (Esport, Muay Thai)- Enabled-0,0,0/0.1,0.1,0.1
--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 16
		AND isDisabled.value = 0
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 16
		AND isDisabled.value = 0
		
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 16
		AND isDisabled.value = 0
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 16
		AND isDisabled.value = 0
		
-----4-SB2 (Esport, Muay Thai)- Disabled- Already has bet setting
--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 16
		AND isDisabled.value = 1
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 16
		AND isDisabled.value = 1
		
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 16
		AND isDisabled.value = 1
		
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 16
		AND isDisabled.value = 1

-----5-	Virtual Sports - Enabled- 0,0,0/0.1,0.1,0.1
--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 5
		AND isDisabled.value = 0
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 5
		AND isDisabled.value = 0
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 5
		AND isDisabled.value = 0
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 5
		AND isDisabled.value = 0
		
		
-----5-	Lottery- Enabled- 0,0,0/0.1,0.1,0.1
--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 28
		AND isDisabled.value = 0
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 28
		AND isDisabled.value = 0
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 28
		AND isDisabled.value = 0
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 28
		AND isDisabled.value = 0
		
-----5-	NG2- Enabled- 0,0,0/0.1,0.1,0.1
--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 23
		AND isDisabled.value = 0
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 23
		AND isDisabled.value = 0
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 23
		AND isDisabled.value = 0
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 23
		AND isDisabled.value = 0

-----6-	Virtual Sports- Disabled- 0,0,0/0.1,0.1,0.1
--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 5
		AND isDisabled.value = 1
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 5
		AND isDisabled.value = 1
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 5
		AND isDisabled.value = 1
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 5
		AND isDisabled.value = 1
		
-----6-	Lottery- Disabled- 0,0,0/0.1,0.1,0.1
--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 28
		AND isDisabled.value = 1
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 28
		AND isDisabled.value = 1
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 28
		AND isDisabled.value = 1
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 28
		AND isDisabled.value = 1
		
-----6-	NG2- Disabled- 0,0,0/0.1,0.1,0.1
--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 23
		AND isDisabled.value = 1
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 23
		AND isDisabled.value = 1
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 23
		AND isDisabled.value = 1
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
		AND F.Productid = 23
		AND isDisabled.value = 1
		
-----7-	Virtual Sports- Disabled- Already has bet setting

--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 5
		AND isDisabled.value = 1
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 5
		AND isDisabled.value = 1
		
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 5
		AND isDisabled.value = 1
		
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 5
		AND isDisabled.value = 1


-----7-	Lottery- Disabled- Already has bet setting

--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 28
		AND isDisabled.value = 1
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 28
		AND isDisabled.value = 1
		
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 28
		AND isDisabled.value = 1
		
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 28
		AND isDisabled.value = 1
		
-----7-	NG2- Disabled- Already has bet setting

--SMA
SELECT COUNT(DISTINCT S.CustID)
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 23
		AND isDisabled.value = 1
		
--Members
SELECT COUNT(DISTINCT S.CustID)
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 23
		AND isDisabled.value = 1
		
		
--Select top SMA
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #SMATemp S INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 23
		AND isDisabled.value = 1
		
		
--Select top MEMBER		
SELECT  DISTINCT TOP 1000 S.CustID, C.MinBet, C.MaxBet, C.MaxPerMatch, C.SportType, C.BetType
FROM #MemberTemp S INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON S.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE (C.MinBet != 0.1 OR C.MaxBet != 0.1 OR C.MaxPerMatch != 0.1) 
		AND (C.MinBet != 0 OR C.MaxBet != 0 OR C.MaxPerMatch != 0)
		AND F.Productid = 23
		AND isDisabled.value = 1
				
-----8-	Allbet- Disabled- No stake level
--SMA
SELECT COUNT (DISTINCT C.CustID) AS SMA
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 1
	
--Members
SELECT COUNT (DISTINCT C.CustID) AS MEMBERS
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = '' 
	AND isDisabled.value = 1
--Select top SMA

SELECT DISTINCT TOP 1000 SMA.CustID, C.StakeLevelList
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 1
		
--Select top MEMBER		

SELECT DISTINCT TOP 1000 M.CustID, C.StakeLevelList
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	Cross JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 1
	
	
-----9-	Allbet- Enabled- No stake level

--SMA
SELECT COUNT (DISTINCT C.CustID) AS SMA
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 0
	
--Members
SELECT COUNT (DISTINCT C.CustID) AS MEMBERS
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 0
--Select top SMA

SELECT DISTINCT TOP 1000 SMA.CustID, C.StakeLevelList
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 0
	
		
--Select top MEMBER		

SELECT DISTINCT TOP 1000 M.CustID, C.StakeLevelList
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 0
	
----10-	Allbet- Disabled- Already has stake level

--SMA
SELECT COUNT (DISTINCT C.CustID) AS SMA
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND isDisabled.value = 1
	AND C.StakeLevelList IS NOT NULL AND C.StakeLevelList <> ''
	
	
--Members
SELECT COUNT (DISTINCT C.CustID) AS MEMBERS
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND isDisabled.value = 1
	AND C.StakeLevelList IS NOT NULL AND C.StakeLevelList <> ''
--Select top SMA

SELECT DISTINCT TOP 1000 SMA.CustID, C.StakeLevelList
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND isDisabled.value = 1
	AND C.StakeLevelList IS NOT NULL AND C.StakeLevelList <> ''
	
		
--Select top MEMBER		

SELECT DISTINCT TOP 1000 M.CustID, C.StakeLevelList
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 21 
	AND isDisabled.value = 1
	AND C.StakeLevelList IS NOT NULL AND C.StakeLevelList <> ''
	
-----11-Macau Game (MG, Card Club, Pragmatic)-Disable - No stake Level group

--SMA
SELECT COUNT (DISTINCT C.CustID) AS SMA
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 1
	
--Members
SELECT COUNT (DISTINCT C.CustID) AS MEMBERS
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 1
--Select top SMA

SELECT DISTINCT TOP 1000 SMA.CustID, C.StakeLevelList
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 1
	
		
--Select top MEMBER		

SELECT DISTINCT TOP 1000 M.CustID, C.StakeLevelList
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 1
	
-----12-Macau Game (MG, Card Club, Pragmatic)-Enabled - No stake Level group

--SMA
SELECT COUNT (DISTINCT C.CustID) AS SMA
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 0
	
--Members
SELECT COUNT (DISTINCT C.CustID) AS MEMBERS
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 0
--Select top SMA

SELECT DISTINCT TOP 1000 SMA.CustID, C.StakeLevelList
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 0
	
		
--Select top MEMBER		

SELECT DISTINCT TOP 1000 M.CustID, C.StakeLevelList
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND C.StakeLevelList IS NULL OR C.StakeLevelList = ''
	AND isDisabled.value = 0
	
-----13-Macau Game (MG, Card Club, Pragmatic)-Disable - Already has stake Level group

--SMA
SELECT COUNT (DISTINCT C.CustID) AS SMA
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND isDisabled.value = 1
	AND C.StakeLevelList IS NOT NULL AND C.StakeLevelList <> ''
	
--Members
SELECT COUNT (DISTINCT C.CustID) AS MEMBERS
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND isDisabled.value = 1
	AND C.StakeLevelList IS NOT NULL AND C.StakeLevelList <> ''
--Select top SMA

SELECT DISTINCT TOP 1000 SMA.CustID, C.StakeLevelList
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustStakeLevel_Agent C WITH (NOLOCK) ON SMA.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND isDisabled.value = 1
	AND C.StakeLevelList IS NOT NULL AND C.StakeLevelList <> ''
	
		
--Select top MEMBER		

SELECT DISTINCT TOP 1000 M.CustID, C.StakeLevelList
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustStakeLevel_Member C WITH (NOLOCK) ON M.CustID = C.CustID 
	INNER JOIN CustProductStatus CS WITH (NOLOCK) ON CS.CustID = C.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	INNER JOIN #SportBettypeFilterOtherSetting O WITH (NOLOCK) ON C.SportType = O.SportType AND C.BetType = O.Bettype AND F.Productid = O.Productid
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 22 
	AND isDisabled.value = 1
	AND C.StakeLevelList IS NOT NULL AND C.StakeLevelList <> ''
	
-----14-Fishing World- Disabled

--SMA
SELECT COUNT (DISTINCT SMA.CustID) AS SMA
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustProductStatus CS WITH (NOLOCK) ON SMA.CustID = CS.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 24 
	AND isDisabled.value = 1
	
--Members
SELECT COUNT (DISTINCT M.CustID) AS MEMBERS
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustProductStatus CS WITH (NOLOCK) ON M.CustID = CS.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 24
	AND isDisabled.value = 1
--Select top SMA

SELECT DISTINCT TOP 1000 SMA.CustID
FROM #SMATemp SMA WITH (NOLOCK) INNER JOIN CustProductStatus CS WITH (NOLOCK) ON SMA.CustID = CS.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 24 
	AND isDisabled.value = 1
	
		
--Select top MEMBER		

SELECT DISTINCT TOP 1000 M.CustID
FROM #MemberTemp M WITH (NOLOCK) INNER JOIN CustProductStatus CS WITH (NOLOCK) ON M.CustID = CS.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterStatus F WITH (NOLOCK) ON P.Sporttype = F.SportType AND P.Bettype = F.Bettype
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, P.bitmapOrder) as isDisabled
WHERE F.Productid = 24
	AND isDisabled.value = 1	
	

----Drop all temp tables	
DROP TABLE #supers
DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #ProductID
DROP TABLE #SportBettypeFilterStatus
DROP TABLE #SportBettypeFilterOtherSetting