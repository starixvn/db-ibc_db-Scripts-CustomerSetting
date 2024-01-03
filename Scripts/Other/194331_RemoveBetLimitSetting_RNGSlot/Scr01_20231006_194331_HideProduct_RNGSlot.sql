/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231006
	Task: Hide RNG slot products (Credit tables: run on feature #196141)
		https://nexdev.net/issues/194331
	DB: DBCust/CustDB
*/ 
-------------------------------------------------
USE CustDB
GO

CREATE TABLE #SportRNG (SportType SMALLINT)

INSERT INTO #SportRNG (SportType)
	  SELECT 155 --MG-RNG
UNION SELECT 156 --SEAL Entertainment
UNION SELECT 158 --Jili
UNION SELECT 165 --Arcadia Gaming
UNION SELECT 167 --CG
UNION SELECT 172 --AdvantPlay
UNION SELECT 174 --AdvantPlay Mini
UNION SELECT 212 --Macau Games
UNION SELECT 232 --PG Soft
UNION SELECT 234 --Joker
UNION SELECT 237 --MaxGame
UNION SELECT 238 --Habanero
UNION SELECT 247 --SG
UNION SELECT 248 --PP

--Dep_ProductSettingDetail
UPDATE psd
SET SettingStatus=2
FROM  Dep_ProductSettingDetail psd WITH (ROWLOCK, UPDLOCK)
INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
INNER JOIN #SportRNG s ON s.sporttype=psd.SportType
WHERE SettingType=8 AND SettingStatus <> 2