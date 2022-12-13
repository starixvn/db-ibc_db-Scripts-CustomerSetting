/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 202209152
	Task:	 Macau Game - Rename the setting page into RNG Slot and hide all bet limit setting [Redmine: 174513]
	DB:		 DBCUST/CustDB
*/ 

DELETE P FROM ProductSettingDetail P WITH (ROWLOCK) WHERE P.ProductID = 22 AND SettingType = 3

UPDATE a
SET a.ProductID = 18,
	a.RealProductId = 18,
	a.SportType = CASE	
					WHEN SettingType IN (21 ) AND SportType = 212 THEN 9906 
					ELSE SportType END
FROM dbo.ProductSettingDetail a WITH(ROWLOCK,UPDLOCK)
WHERE ProductID  = 22 AND SettingType NOT IN (1,6)

UPDATE a
SET a.Child_DisplayOrder = CASE WHEN a.ProductID  = 18 AND a.SettingType = 21 AND a.SportType = 9906 THEN 1 
								WHEN a.ProductID  = 18 AND a.SettingType = 21 AND a.SportType = 9904 THEN 2 
								WHEN a.ProductID  <> 18 THEN b.STT ELSE Child_DisplayOrder END
FROM dbo.ProductSettingDetail a WITH(ROWLOCK,UPDLOCK)
LEFT JOIN (
	SELECT SettingType, ProductID, SportType, BetType , ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY SportType)  AS STT 
	FROM ProductSettingDetail c WITH(NOLOCK) 
	WHERE c.SettingType in (13,21) 
) b ON a.ProductID = b.ProductID and a.SettingType = b.SettingType AND a.SportType = b.SportType and a.BetType = b.BetType
WHERE a.SettingType in (13,21)  

-- Insert PT
INSERT INTO ProductSettingDetail (SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID)
SELECT SettingType, 9906 AS SportType,BetType,IsLive,18 AS ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
	,SettingStatus = 1,IntervalValue,18 AS RealProductId,MaxChoice ,ProductSettingID = 230,Parent_ProductSettingID 
FROM ProductSettingDetail WITH(NOLOCK) 
WHERE ProductID = 22 AND SettingType = 1 AND sporttype = 212 AND bettype = 4001

INSERT INTO ProductSettingDetail (SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID)
SELECT SettingType, 9906 AS SportType,BetType,IsLive,18 AS ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
	,SettingStatus = 1,IntervalValue,18 AS RealProductId,MaxChoice ,ProductSettingID = 231,Parent_ProductSettingID 
FROM ProductSettingDetail WITH(NOLOCK) 
WHERE ProductID = 22 AND SettingType = 6 AND sporttype = 212 AND bettype = 4001

UPDATE a
SET a.ProductID = 18
FROM dbo.ProductSettingSystemDisplay a WITH(ROWLOCK,UPDLOCK)
WHERE a.ProductID = 22

INSERT INTO ProductSettingSystemDisplay(SystemID,ProductID,SettingType,DisplayMode)
SELECT SystemID,ProductID,SettingType,DisplayMode
FROM (
SELECT 2 AS SystemID,18 AS ProductID,8 AS SettingType, 3 AS DisplayMode --Alpha
UNION 
SELECT 3 AS SystemID,18 AS ProductID,8 AS SettingType, 3 AS DisplayMode --Internal Alpha
UNION 
SELECT 4 AS SystemID,18 AS ProductID,8 AS SettingType, 3 AS DisplayMode --External NAP
UNION 
SELECT 5 AS SystemID,18 AS ProductID,8 AS SettingType, 3 AS DisplayMode --External NAP
UNION 
SELECT 6 AS SystemID,18 AS ProductID,8 AS SettingType, 3 AS DisplayMode --789y Alpha
UNION 
SELECT 7 AS SystemID,18 AS ProductID,8 AS SettingType, 3 AS DisplayMode --789y Internal Alpha
UNION 
SELECT 8 AS SystemID,18 AS ProductID,8 AS SettingType, 3 AS DisplayMode --789y External NAP
UNION 
SELECT 9 AS SystemID,18 AS ProductID,8 AS SettingType, 3 AS DisplayMode --789y External NAP (Bet Setting only)
) KQ 
WHERE NOT EXISTS(SELECT TOP 1 1 FROM ProductSettingSystemDisplay WITH(NOLOCK) 
						WHERE SystemID=KQ.SystemID AND ProductID=KQ.ProductID 
						AND SettingType=KQ.SettingType)
ORDER BY SettingType, SystemID

UPDATE a
SET a.Sporttype = 9906
FROM dbo.ProductStatusProfile a WITH(ROWLOCK,UPDLOCK)
WHERE a.Sporttype = 212 AND Bettype = 4001 

UPDATE a
SET  a.ProductID = 18
FROM dbo.LossLimit_GlobalSetting a WITH(ROWLOCK,UPDLOCK)
WHERE a.ProductID = 22 

--SELECT * FROM ProductStatusProfile WITH (NOLOCK) ORDER BY bitmapOrder
--SELECT * FROM ProductSettingDetail WITH (NOLOCK) where ProductID  IN (22,53) ORDER BY ProductID
--SELECT * FROM ProductSettingSystemDisplay WITH (NOLOCK) where ProductID  IN (22,53) ORDER BY ProductID
