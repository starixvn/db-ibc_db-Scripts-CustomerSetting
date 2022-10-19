/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 202209152
	Task:	 Macau Game - Rename the setting page into RNG Slot and hide all bet limit setting [Redmine: 174513]
	DB:		 DBCUST/CustDB
*/ 

DELETE P FROM ProductSettingDetail P WITH (ROWLOCK) WHERE P.ProductID = 22 AND SettingType = 3

UPDATE a
SET a.ProductID = 53,
	a.RealProductId = CASE 
						WHEN SettingType = 8 AND SportType = 155 THEN 73 --Microgaming
						WHEN SettingType = 8 AND SportType = 156 THEN 72 --SEAL Entertainment
						WHEN SettingType = 8 AND SportType = 165 THEN 34 --Arcadia Gaming
						WHEN SettingType = 8 AND SportType = 167 THEN 62 --CG
						WHEN SettingType = 8 AND SportType = 172 THEN 67 --AdvantPlay
						WHEN SettingType = 8 AND SportType = 174 THEN 68 --AdvantPlay Mini
						WHEN SettingType = 8 AND SportType = 212 THEN 22 --Macau Games 
						WHEN SettingType = 8 AND SportType = 232 THEN 55 --PG Soft
						WHEN SettingType = 8 AND SportType = 234 THEN 56 --Joker 
						WHEN SettingType = 8 AND SportType = 237 THEN 60 --MaxGame  
						WHEN SettingType = 8 AND SportType = 238 THEN 61 --Habanero   
						WHEN SettingType = 8 AND SportType = 247 THEN 36 --SG 
						WHEN SettingType = 8 AND SportType = 248 THEN 32 --PP 
					   ELSE RealProductId END,
	a.SportType = CASE WHEN SettingType = 21 AND SportType = 212 THEN 9906 ELSE SportType END
FROM dbo.ProductSettingDetail a WITH(ROWLOCK,UPDLOCK)
WHERE ProductID  = 22

UPDATE a
SET a.ProductID = 53
FROM dbo.ProductSettingSystemDisplay a WITH(ROWLOCK,UPDLOCK)
WHERE a.ProductID = 22

INSERT INTO ProductSettingSystemDisplay(SystemID,ProductID,SettingType,DisplayMode)
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
ORDER BY SettingType, SystemID

UPDATE a
SET a.Sporttype = 9906
FROM dbo.ProductStatusProfile a WITH(ROWLOCK,UPDLOCK)
WHERE a.Sporttype = 212 AND Bettype = 4001 

UPDATE a
SET  a.ProductID = 53
FROM dbo.LossLimit_GlobalSetting a WITH(ROWLOCK,UPDLOCK)
WHERE a.ProductID = 22 

--SELECT * FROM ProductStatusProfile WITH (ROWLOCK) ORDER BY bitmapOrder
--SELECT * FROM ProductSettingDetail WITH (ROWLOCK) where ProductID  IN (22,53) ORDER BY ProductID
--SELECT * FROM ProductSettingSystemDisplay WITH (ROWLOCK) where ProductID  IN (22,53) ORDER BY ProductID
