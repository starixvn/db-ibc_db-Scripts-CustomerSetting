/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 202209152
	Task:	 Macau Game - Rename the setting page into RNG Slot and hide all bet limit setting [Redmine: 174513]
	DB:		 DBCUST/CustDB
*/ 

DELETE P
FROM ProductSettingDetail P WITH (ROWLOCK) WHERE P.ProductID = 53

ALTER TABLE ProductSettingDetail DROP CONSTRAINT PK_ProductSettingDetail

ALTER TABLE ProductSettingDetail ADD CONSTRAINT PK_ProductSettingDetail 
    PRIMARY KEY (SettingType, SportType, BetType, IsLive,ProductID);

--ALTER TABLE ProductSettingDetail DROP CONSTRAINT PK_ProductSettingDetail

--ALTER TABLE ProductSettingDetail ADD CONSTRAINT PK_ProductSettingDetail 
--    PRIMARY KEY (SettingType, SportType, BetType, IsLive);

DECLARE @MaxProductSettingID INT
SELECT @MaxProductSettingID = MAX(ProductSettingID) FROM ProductSettingDetail WITH(NOLOCK)

INSERT INTO [ProductSettingDetail]
 ([SettingType], [SportType], [BetType], [IsLive], [ProductID], [MaxPT], [MaxDiscount], [IsSync], [IsHidden]
   ,[IsDisabled], [SettingLevel], [DisplayOrder] ,[SettingStatus], [IntervalValue], [RealProductId], [MaxChoice],[ProductSettingID],[Parent_ProductSettingID])
SELECT SettingType, SportType, BetType, IsLive,53 AS ProductID, MaxPT, MaxDiscount, IsSync, IsHidden
   ,IsDisabled, SettingLevel, DisplayOrder ,SettingStatus, IntervalValue, 
   CASE 
	WHEN SettingType = 8 AND SportType = 155 THEN 73 --Microgaming
	WHEN SettingType = 8 AND SportType = 156 THEN 72 --SEAL Entertainment
	WHEN SettingType = 8 AND SportType = 165 THEN 34 --Arcadia Gaming
	WHEN SettingType = 8 AND SportType = 167 THEN 62 --CG
	WHEN SettingType = 8 AND SportType = 172 THEN 67 --AdvantPlay
	WHEN SettingType = 8 AND SportType = 174 THEN 68 --AdvantPlay Mini
	WHEN SettingType = 8 AND SportType = 212 THEN 18 --Macau Games 
	WHEN SettingType = 8 AND SportType = 232 THEN 55 --PG Soft
	WHEN SettingType = 8 AND SportType = 234 THEN 56 --Joker 
	WHEN SettingType = 8 AND SportType = 237 THEN 60 --MaxGame  
	WHEN SettingType = 8 AND SportType = 238 THEN 61 --Habanero   
	WHEN SettingType = 8 AND SportType = 247 THEN 36 --SG 
	WHEN SettingType = 8 AND SportType = 248 THEN 32 --PP 
   ELSE RealProductId END AS RealProductId, MaxChoice,
   @MaxProductSettingID + ROW_NUMBER() OVER(ORDER BY SettingType)  AS ProductSettingID,Parent_ProductSettingID
FROM ProductSettingDetail WITH(NOLOCK)
WHERE ProductID = 22 AND SettingType <> 3 AND SportType <> 9904 -- Macau

SELECT @MaxProductSettingID = MAX(ProductSettingID) FROM ProductSettingDetail WITH(NOLOCK)

INSERT INTO [ProductSettingDetail]
 ([SettingType], [SportType], [BetType], [IsLive], [ProductID], [MaxPT], [MaxDiscount], [IsSync], [IsHidden]
   ,[IsDisabled], [SettingLevel], [DisplayOrder] ,[SettingStatus], [IntervalValue], [RealProductId], [MaxChoice],[ProductSettingID],[Parent_ProductSettingID])
SELECT  a.SettingType, 9906 AS SportType, a.BetType, a.IsLive,53 AS ProductID, a.MaxPT, a.MaxDiscount, a.IsSync, a.IsHidden
   ,a.IsDisabled, a.SettingLevel, a.DisplayOrder ,a.SettingStatus, a.IntervalValue, a.RealProductId, a.MaxChoice
   ,@MaxProductSettingID + 1 AS ProductSettingID,b.ProductSettingID AS Parent_ProductSettingID
FROM ProductSettingDetail a WITH(NOLOCK)
INNER JOIN ProductSettingDetail b WITH(NOLOCK) ON a.ProductID = b.ProductID AND a.SettingType = b.SettingType AND b.SportType = 212
WHERE a.ProductID = 22  AND a.SportType = 9904 AND a.SettingType = 21 -- Macau

DELETE P FROM ProductSettingSystemDisplay P WITH (ROWLOCK) WHERE P.ProductID = 53

INSERT INTO ProductSettingSystemDisplay(SystemID,ProductID,SettingType,DisplayMode)
SELECT SystemID,53 AS ProductID,SettingType,DisplayMode
FROM  ProductSettingSystemDisplay d (NOLOCK) WHERE ProductID in ( 22) 
UNION 
SELECT 2 AS SystemID,53 AS ProductID,8 AS SettingType, 3 AS DisplayMode --Alpha
UNION 
SELECT 3 AS SystemID,53 AS ProductID,8 AS SettingType, 3 AS DisplayMode --Internal Alpha
UNION 
SELECT 4 AS SystemID,53 AS ProductID,8 AS SettingType, 3 AS DisplayMode --External NAP
UNION 
SELECT 5 AS SystemID,53 AS ProductID,8 AS SettingType, 3 AS DisplayMode --External NAP
UNION 
SELECT 6 AS SystemID,53 AS ProductID,8 AS SettingType, 3 AS DisplayMode --789y Alpha
UNION 
SELECT 7 AS SystemID,53 AS ProductID,8 AS SettingType, 3 AS DisplayMode --789y Internal Alpha
UNION 
SELECT 8 AS SystemID,53 AS ProductID,8 AS SettingType, 3 AS DisplayMode --789y External NAP
UNION 
SELECT 9 AS SystemID,53 AS ProductID,8 AS SettingType, 3 AS DisplayMode --789y External NAP (Bet Setting only)
order by SettingType, SystemID

DELETE P
FROM ProductStatusProfile P WITH (ROWLOCK) WHERE P.Sporttype = 9906

INSERT INTO	dbo.ProductStatusProfile(Sporttype, Bettype, bitmapOrder)
VALUES	(9906, 4001, 12)

select * from ProductStatusProfile	order by bitmapOrder
