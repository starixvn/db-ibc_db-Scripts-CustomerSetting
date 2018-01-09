/*
	Created: Elodie
	Task: Copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20171214
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
	AND ci.site IN ('733333', '222223', '222225', '222227', '033333', 'JPNIBC', '611111', '722222', '766666', '7aa666', 'BEST-ODDS', 'XYZbet', '755555', '789y')
	AND ci.currency <> 20
	AND ci.custid NOT IN (1,2,3,4,5,6,9,12,13,15,16,17,22,30,32,33,34,35,36,41,42,21278849,21278858) -- dummy account		

DECLARE @ProductID TINYINT = 26
CREATE TABLE #DestinationSportBetType(tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT)
INSERT INTO #DestinationSportBetType (tSportType, tBetType, IsLive, SettingType)
SELECT	SportType, BetType, 0, SettingType
FROM dbo.ProductSettingDetail WITH (NOLOCK)
WHERE ProductID = @ProductID AND SettingType IN (14)

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

DECLARE @TicketComm DECIMAL(9,8) = 0.1
--------------------------------------Ticket Commission Setting-------------------------------------------------			
--Agent Level
INSERT INTO dbo.CustDiscount3rd_Agent(CustID, SportType, BetType, Discount)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 
		CASE	WHEN roleid = 4 THEN @TicketComm
				WHEN roleid = 3 THEN 0
				WHEN roleid = 2 THEN 0 END
FROM #SMATemp ci 
	CROSS APPLY #DestinationSportBetType dest
WHERE dest.SettingType = 14
		 
--Member Level
INSERT INTO dbo.CustDiscount3rd_Member(CustID, SportType, BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount)
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, 0, 0, 0
FROM #MemberTemp ci WITH(NOLOCK) 
	CROSS APPLY #DestinationSportBetType dest
WHERE dest.SettingType = 14

/*******************************CUST PRODUCT STATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 9
--Member of cross site batch 1
SELECT ci.custid
INTO #MemberBatch1
FROM dbo.custInfo ci WITH (NOLOCK)	
WHERE ((mrecommend IN (40958, 45638, 60349, 63971, 167860, 244268, 272369, 620479, 771534, 832960, 852273, 861558, 891798, 913666, 916007, 929428, 971014, 979669, 981513, 997587, 2006349, 2087760)
			AND roleid = 1)
		OR (recommend IN (8346,104769) AND roleid = 1))	
	AND ci.custid > @MaxCustID
	AND ci.srecommend IN (324561, 395075, 506057, 674248, 796555, 993226, 1016771, 1036451, 1127269, 1156957, 1164457, 2042873, 2453866, 5005322, 17721601) --super of cross site batch 1
	
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #MemberBatch1 ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1))
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #MemberTemp ci WITH(NOLOCK) ON cs.CustID = ci.CustID

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType	

PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 