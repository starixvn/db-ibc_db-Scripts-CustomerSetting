/*
	Created: Elodie
	Task: Copy Setting for newly created customer
	DB: DBCUST/CustDB
	Date: 20171212
*/ 
PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT
	
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
			AND ci.site IN ('Indo', 'KORIBC')
			AND ci.currency <> 20

DECLARE @ProductID TINYINT = 26
CREATE TABLE #DestinationSportBetType(tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
INSERT INTO #DestinationSportBetType (tSportType, tBetType, IsLive, SettingType, IsFinished)
SELECT	SportType, BetType, 0, SettingType, 0
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
SELECT ci.custid, dest.tsporttype, dest.tbettype, 0, 0, 0, @TicketComm
FROM #MemberTemp ci WITH(NOLOCK) 
	CROSS APPLY #DestinationSportBetType dest
WHERE dest.SettingType = 14


/*******************************CUST PRODUCTSTATUS TABLE*******************************/	
DECLARE @BitmapOrder TINYINT = 9

SELECT custid, roleid
INTO #DisableLine
FROM custInfo WITH (NOLOCK) 
WHERE username IN (	'ACK','ACK2','AHD','AHI','DADR','S922O','BBR','IA','IE','IF','IG','IH','II','IK','IM','IN','IO','IU','IY','KID','KJA','KJI',
					'KND','KNE','KO','KOB','KOR','LHI','SGI','SGKB','MKI','SADA','S5I','S62D','S822D','S88ID','S88IE','SBTD','SHI','DB','LR',
					'SD','AD','AH','AI','AK','AQ','AT','BB','CL','CP','CX','CY','D8G','HO','HU','HW','IB','IJ','IZ','JA','JB','JC','JK','JN',
					'JT','KK','LK','LN','MH','SB','SI','SL','TA','UA','UB','UC','UD','UE','UF','UG','UH','UK','UL','UM','UN','UT','UU','UV',
					'UW','UY','UZ','VB','WA','WB','WG','WH','WU','YM','YN','YY','ZZ','TI','SW','YI','RR','QQ','MM','MW','LI','LW','IP','IR',
					'IC','ID','FF','GI','HI','HP','DW','DI','CI','CS','CU','CO','BI','BJ','AL','VV','WI','UI','SLD','SWO','KDS','TD1','TD2',
					'TD3','TD4','TD5','TD6','TDA','TDB','TDC','TDD','VKD','WE')

----Don't need this list due to no data in this batch
--SELECT custid
--INTO #IgnoredCust
--FROM dbo.custInfo WITH (NOLOCK)
--WHERE ((mrecommend IN (40958, 45638, 60349, 63971, 167860, 244268, 272369, 620479, 771534, 832960, 852273, 861558, 891798, 913666, 916007, 929428, 971014, 979669, 981513, 997587, 2006349, 2087760) AND roleid BETWEEN 1 AND 3)
--		OR (recommend IN (8346,104769) AND roleid BETWEEN 1 AND 2))
--	AND srecommend IN (324561, 395075, 506057, 674248, 796555, 993226, 1016771, 1036451, 1127269, 1156957, 1164457, 2042873, 2453866, 5005322, 17721601)
--	AND custid > @MaxCustID

SELECT custid, ci.roleid, ci.srecommend
INTO #CustList
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.srecommend IN (SELECT custid FROM #supers) AND custid > @MaxCustID
	--AND NOT EXISTS (SELECT 1 FROM #IgnoredCust WHERE custid = ci.custid)	

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0))	
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID

UPDATE cs
SET bitmapIsDisabled = CASE WHEN ci.roleid BETWEEN 2 AND 4 THEN (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,0)) 
							ELSE (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1)) END
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
WHERE NOT EXISTS (SELECT 1 FROM #DisableLine WHERE custid = ci.srecommend)	

DROP TABLE #SMATemp
DROP TABLE #MemberTemp
DROP TABLE #DestinationSportBetType		

PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 