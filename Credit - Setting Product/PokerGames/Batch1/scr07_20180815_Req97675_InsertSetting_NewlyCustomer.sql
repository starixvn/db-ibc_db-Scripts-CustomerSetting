/*
	Created: Elodie
	Task: Copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20180815
*/ 
PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DECLARE @MaxCustID INT
	
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
	AND ci.site IN ('789y')
	AND ci.currency <> 20

DECLARE @ProductID INT = 33, @currency INT

SELECT t.* 
INTO #SportBettypeFilter3
FROM ProductSettingDetail t WITH (NOLOCK)
WHERE t.SettingType = 3 AND t.ProductID = @ProductID

SELECT t.* 
INTO #SportBettypeFilter6
FROM ProductSettingDetail t WITH (NOLOCK)
WHERE t.SettingType = 6 AND t.ProductID = @ProductID

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT,
	Credit MONEY
)

CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
	currency INT,
	Credit MONEY
)
	
INSERT INTO #MemberTemp (CustID, currency, Credit)
SELECT custid, currency, Credit
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1 AND custid > @maxcustid	
	
INSERT INTO #SMATemp (CustID, roleid, currency, Credit)
SELECT custid, roleid, currency, Credit
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1 AND custid > @maxcustid 

----------------------------------------Comm Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustDiscount3rd_Agent (CustID, SportType, BetType, Discount)	        
SELECT ci.custid, sb.SportType, sb.BetType, 
	CASE	WHEN ci.roleid = 4 THEN 0.85
			ELSE 0 END 
FROM #SMATemp ci WITH(NOLOCK)
	CROSS APPLY #SportBettypeFilter3 sb 

--Member Level
INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
SELECT ci.custid, sb.SportType, sb.BetType, 0, 0, 0, 0.85
FROM #MemberTemp ci WITH(NOLOCK)
	CROSS APPLY #SportBettypeFilter3 sb
----------------------------------------WinLoss Limit Setting-------------------------------------------------		
--Agent Level
INSERT INTO dbo.CustWinLossLimit_Agent (CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, sb.SportType, sb.BetType, 0, 
	CASE	WHEN FLOOR(ci.Credit * 0.1) < cs.MinLossLimit THEN cs.MinLossLimit
			WHEN FLOOR(ci.Credit * 0.1) > cs.DefaultLossLimit THEN cs.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END, 1
FROM #SMATemp ci WITH(NOLOCK)
	INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON ci.currency = cs.ExchangeId
	CROSS APPLY #SportBettypeFilter6 sb
WHERE cs.ProductId = @ProductID	
		 
--Member Level
INSERT INTO dbo.CustWinLossLimit_Member(CustID, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
SELECT ci.custid, sb.SportType, sb.BetType, 0,
	CASE	WHEN FLOOR(ci.Credit * 0.1) < cs.MinLossLimit THEN cs.MinLossLimit
			WHEN FLOOR(ci.Credit * 0.1) > cs.DefaultLossLimit THEN cs.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END, 1
FROM #MemberTemp ci WITH(NOLOCK)
	INNER JOIN dbo.LossLimit_GlobalSetting cs WITH(NOLOCK) ON ci.currency = cs.ExchangeId
	CROSS APPLY #SportBettypeFilter6 sb
WHERE cs.ProductId = @ProductID	

/*******************************CUST PRODUCTSTATUS TABLE*******************************/	
DECLARE @xmlStrValue_0 XML, @xmlStrValue_1 XML, @Sporttype SMALLINT = 163

SET @xmlStrValue_0 =(
		SELECT (
				SELECT psp.bitmapOrder	AS '@b'
					, 0	AS '@s'
				FROM ProductStatusProfile psp WITH (NOLOCK)
				WHERE psp.Sporttype = @Sporttype AND Bettype BETWEEN 1401 AND 1404
				FOR XML PATH('r')
					, TYPE
				)
		FOR XML PATH('root')
			, TYPE
		)

SET @xmlStrValue_1 =(
		SELECT (
				SELECT psp.bitmapOrder	AS '@b'
					, 1	AS '@s'
				FROM ProductStatusProfile psp WITH (NOLOCK)
				WHERE psp.Sporttype = @Sporttype AND Bettype BETWEEN 1401 AND 1404
				FOR XML PATH('r')
					, TYPE
				)
		FOR XML PATH('root')
			, TYPE
		)

SELECT custid, roleid
INTO #DisableLine
FROM custInfo WITH (NOLOCK) 
WHERE username IN (	'')

SELECT custid, ci.roleid, ci.srecommend
INTO #CustList
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.srecommend IN (SELECT custid FROM #supers) AND custid > @MaxCustID

UPDATE cs
SET cs.bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),@xmlStrValue_0)))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID

--Should update disabled = 1 for newly member
UPDATE cs
SET bitmapIsDisabled = CASE WHEN ci.roleid BETWEEN 2 AND 4 THEN (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrValue_0)))
							ELSE (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrValue_1))) END
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
WHERE NOT EXISTS (SELECT 1 FROM #DisableLine WHERE custid = ci.srecommend)	

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #SportBettypeFilter3
DROP TABLE #SportBettypeFilter6	

PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 