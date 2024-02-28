/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231018@Johnson
	Task: Offer Missing 3rd products for new site 777777
	DB: DBCUST/CustDB
*/
--20240206@Johnson: Add GameLaunchPerSite/GameLaunchPerCurrency
INSERT INTO GameLaunchPerSite(SportType,BetType,SiteID,IsLaunched,IsTest)
SELECT 247,	4599,	1216,	1,	0

INSERT INTO GameLaunchPerCurrency(SportType,BetType,Currency,IsLaunched,IsTest)
SELECT 247,	4599,	14,	1,	0

/*
--20240205@Johnson: offer Cashout
UPDATE ProductStatusSiteCurrency WITH(ROWLOCK)
SET IsHidden = 0,
	IsDisabled = 0
WHERE SiteID = 1216
	AND SportType = 9903

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
SET IsLaunched = 1
WHERE SiteID = 1216
	AND SportType IN (9903,9905)
*/
	
/*
--20231018@Johnson: Offer missing 3rd products
DECLARE @siteID INT

SELECT @siteID = SiteID 
FROM Site WITH(NOLOCK)
WHERE site = '777777'

--Dont offer these sports
INSERT INTO [dbo].[SportNonOfferedSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID])
SELECT 212, 4001, 0, @siteID--Macau Games


;WITH T AS (
SELECT 	242	sporttype,	46 realProductID
UNION SELECT 	232	,	55
UNION SELECT 	238	,	61
UNION SELECT 	225	,	52
UNION SELECT 	212	,	22
UNION SELECT 	241	,	47
UNION SELECT 	239	,	57
UNION SELECT 	170	,	65
UNION SELECT 	248	,	32
)
UPDATE s 
SET s.RealProductID = t.RealProductID
FROM SportNonOfferedSiteCurrency s WITH(ROWLOCK)
	INNER JOIN T on s.SportType = t.SportType 
WHERE SiteID = @SiteID
	


--20240202@Johnson: update bet limit for Funky Games
DECLARE @StakeLevelID INT,
	 @currency INT

SELECT @Currency = ExchangeId--PC
FROM exchange WITH(NOLOCK)
WHERE currency = 'PC'

SELECT @StakeLevelID = StakeLevelID
FROM StakeLevel (NOLOCK)
WHERE GameTypeID = 5500 AND ExchangeId = @currency

;WITH T AS (
	SELECT  5500 GameTypeID, 25 MinStake,36000 MaxStake,'25' MinLabel, '36,000' MaxLabel	
	UNION ALL SELECT  5501 , 50 ,30000 ,'50' , '30,000' 	
	UNION ALL SELECT  5502 , 50 ,30000 ,'50' , '30,000' 	
	UNION ALL SELECT  5503 , 50 ,30000 ,'50' , '30,000' 	
	UNION ALL SELECT  5504 , 20 ,120000 ,'20' , '120,000' 	
	UNION ALL SELECT  5505 , 50 ,30000 ,'50' , '30,000' 	
	UNION ALL SELECT  5506 , 20 ,2000 ,'20' , '2,000' 	
	UNION ALL SELECT  5507 , 20 ,78000 ,'20' , '78,000' 	
	UNION ALL SELECT  5508 , 20 ,80000 ,'20' , '80,000' 	
	UNION ALL SELECT  5509 , 20 ,640000 ,'20' , '640,000' 	
	UNION ALL SELECT  5510 , 12 ,240 ,'12' , '240' 	
	UNION ALL SELECT  5511 , 9 ,180 ,'9' , '180' 	
	UNION ALL SELECT  5512 , 12 ,240 ,'12' , '240' 	
	UNION ALL SELECT  5513 , 12 ,38400 ,'12' , '38,400' 	
	UNION ALL SELECT  5514 , 9 ,180 ,'9' , '180' 	
	UNION ALL SELECT  5515 , 4 ,440 ,'4' , '440' 	
	UNION ALL SELECT  5516 , 4 ,440 ,'4' , '440' 	
	UNION ALL SELECT  5517 , 16 ,320 ,'16' , '320' 	
	UNION ALL SELECT  5518 , 12 ,240 ,'12' , '240' 	
	UNION ALL SELECT  5519 , 9 ,180 ,'9' , '180' 	
	UNION ALL SELECT  5520 , 9 ,180 ,'9' , '180' 	
	UNION ALL SELECT  5521 , 10 ,200 ,'10' , '200' 	
	UNION ALL SELECT  5522 , 11.4 ,228 ,'11.4' , '228' 	
	UNION ALL SELECT  5523 , 11.4 ,228 ,'11.4' , '228' 	
	UNION ALL SELECT  5524 , 50 ,40000 ,'50' , '40,000' 	
	UNION ALL SELECT  5525 , 50 ,20000 ,'50' , '20,000' 	
	UNION ALL SELECT  5526 , 5 ,100 ,'5' , '100' 	
	UNION ALL SELECT  5527 , 20 ,8000 ,'20' , '8,000' 		
)
UPDATE s
SET s.MinLabel = t.MinLabel
   ,s.MaxLabel = t.MaxLabel
   ,s.MinStake = t.MinStake
   ,s.MaxStake = t.MaxStake
FROM StakeLevelGroupDetail s WITH(UPDLOCK)
	INNER JOIN T ON s.GameTypeID = t.GameTypeID
WHERE StakeLevelID = @StakeLevelID

*/
