/*
	Date: 20200731
	Created: Winfred 
	Task: #138659 - Pragmatic - Update setting for 7 New Jackpot Games for Credit [Redmine:138481]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--USD code($US, US$, UT, Yen),MMK, Euro, EUR,UUS, YNG
--$US
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,35   UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,35   UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,35   UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,35   UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,35   UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,35   UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,35   UNION ALL
--EUR
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,78   UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,78   UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,78   UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,78   UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,78   UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,78   UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,78   UNION ALL
--EURO
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,6    UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,6    UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,6    UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,6    UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,6    UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,6    UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,6    UNION ALL
--MMK
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,69   UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,69   UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,69   UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,69   UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,69   UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,69   UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,69   UNION ALL
--US$
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,3    UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,3    UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,3    UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,3    UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,3    UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,3    UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,3    UNION ALL
--UT
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,64   UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,64   UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,64   UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,64   UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,64   UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,64   UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,64   UNION ALL
--UUS
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,20   UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,20   UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,20   UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,20   UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,20   UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,20   UNION ALL
--Yen
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,16   UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,16   UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,16   UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,16   UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,16   UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,16   UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,16   UNION ALL
--YNG
SELECT 4187 ,'0.35' ,'14'      ,0.35 ,14      ,72   UNION ALL
SELECT 4188 ,'0.5'  ,'15'      ,0.5  ,15      ,72   UNION ALL
SELECT 4189 ,'0.6'  ,'15'      ,0.6  ,15      ,72   UNION ALL
SELECT 4228 ,'0.45' ,'54'      ,0.45 ,54      ,72   UNION ALL
SELECT 4229 ,'0.5'  ,'50'      ,0.5  ,50      ,72   UNION ALL
SELECT 4230 ,'0.5'  ,'50'      ,0.5  ,50      ,72   UNION ALL
SELECT 4231 ,'0.5'  ,'30'      ,0.5  ,30      ,72   UNION ALL
--=============================================
-- DDD,IND,IDR,IDD,IN
-- DDD
SELECT 4187 ,'4.2'  ,'168'     ,4.2  ,168     ,47   UNION ALL
SELECT 4188 ,'6'    ,'180'     ,6    ,180     ,47   UNION ALL
SELECT 4189 ,'7.2'  ,'180'     ,7.2  ,180     ,47   UNION ALL
SELECT 4228 ,'5.4'  ,'648'     ,5.4  ,648     ,47   UNION ALL
SELECT 4229 ,'6'    ,'600'     ,6    ,600     ,47   UNION ALL
SELECT 4230 ,'6'    ,'600'     ,6    ,600     ,47   UNION ALL
SELECT 4231 ,'6'    ,'360'     ,6    ,360     ,47   UNION ALL
--IDD
SELECT 4187 ,'4.2'  ,'168'     ,4.2  ,168     ,33   UNION ALL
SELECT 4188 ,'6'    ,'180'     ,6    ,180     ,33   UNION ALL
SELECT 4189 ,'7.2'  ,'180'     ,7.2  ,180     ,33   UNION ALL
SELECT 4228 ,'5.4'  ,'648'     ,5.4  ,648     ,33   UNION ALL
SELECT 4229 ,'6'    ,'600'     ,6    ,600     ,33   UNION ALL
SELECT 4230 ,'6'    ,'600'     ,6    ,600     ,33   UNION ALL
SELECT 4231 ,'6'    ,'360'     ,6    ,360     ,33   UNION ALL
--IDR
SELECT 4187 ,'4.2'  ,'168'     ,4.2  ,168     ,34   UNION ALL
SELECT 4188 ,'6'    ,'180'     ,6    ,180     ,34   UNION ALL
SELECT 4189 ,'7.2'  ,'180'     ,7.2  ,180     ,34   UNION ALL
SELECT 4228 ,'5.4'  ,'648'     ,5.4  ,648     ,34   UNION ALL
SELECT 4229 ,'6'    ,'600'     ,6    ,600     ,34   UNION ALL
SELECT 4230 ,'6'    ,'600'     ,6    ,600     ,34   UNION ALL
SELECT 4231 ,'6'    ,'360'     ,6    ,360     ,34   UNION ALL
--IN
SELECT 4187 ,'4.2'  ,'168'     ,4.2  ,168     ,15   UNION ALL
SELECT 4188 ,'6'    ,'180'     ,6    ,180     ,15   UNION ALL
SELECT 4189 ,'7.2'  ,'180'     ,7.2  ,180     ,15   UNION ALL
SELECT 4228 ,'5.4'  ,'648'     ,5.4  ,648     ,15   UNION ALL
SELECT 4229 ,'6'    ,'600'     ,6    ,600     ,15   UNION ALL
SELECT 4230 ,'6'    ,'600'     ,6    ,600     ,15   UNION ALL
SELECT 4231 ,'6'    ,'360'     ,6    ,360     ,15   UNION ALL
--IND
SELECT 4187 ,'4.2'  ,'168'     ,4.2  ,168     ,22   UNION ALL
SELECT 4188 ,'6'    ,'180'     ,6    ,180     ,22   UNION ALL
SELECT 4189 ,'7.2'  ,'180'     ,7.2  ,180     ,22   UNION ALL
SELECT 4228 ,'5.4'  ,'648'     ,5.4  ,648     ,22   UNION ALL
SELECT 4229 ,'6'    ,'600'     ,6    ,600     ,22   UNION ALL
SELECT 4230 ,'6'    ,'600'     ,6    ,600     ,22   UNION ALL
SELECT 4231 ,'6'    ,'360'     ,6    ,360     ,22   UNION ALL
--=============================================
-- INH
SELECT 4187 ,'7'    ,'280'     ,7    ,280     ,51   UNION ALL
SELECT 4188 ,'10'   ,'300'     ,10   ,300     ,51   UNION ALL
SELECT 4189 ,'12'   ,'300'     ,12   ,300     ,51   UNION ALL
SELECT 4228 ,'9'    ,'1080'    ,9    ,1080    ,51   UNION ALL
SELECT 4229 ,'10'   ,'1000'    ,10   ,1000    ,51   UNION ALL
SELECT 4230 ,'10'   ,'1000'    ,10   ,1000    ,51   UNION ALL
SELECT 4231 ,'10'   ,'600'     ,10   ,600     ,51   UNION ALL
--=============================================
--INR, RUB
--INR
SELECT 4187 ,'24.5' ,'980'     ,24.5 ,980     ,61   UNION ALL
SELECT 4188 ,'35'   ,'1050'    ,35   ,1050    ,61   UNION ALL
SELECT 4189 ,'42'   ,'1050'    ,42   ,1050    ,61   UNION ALL
SELECT 4228 ,'31.5' ,'3780'    ,31.5 ,3780    ,61   UNION ALL
SELECT 4229 ,'35'   ,'3500'    ,35   ,3500    ,61   UNION ALL
SELECT 4230 ,'35'   ,'3500'    ,35   ,3500    ,61   UNION ALL
SELECT 4231 ,'35'   ,'2100'    ,35   ,2100    ,61   UNION ALL
--RUB
SELECT 4187 ,'24.5' ,'980'     ,24.5 ,980     ,55   UNION ALL
SELECT 4188 ,'35'   ,'1050'    ,35   ,1050    ,55   UNION ALL
SELECT 4189 ,'42'   ,'1050'    ,42   ,1050    ,55   UNION ALL
SELECT 4228 ,'31.5' ,'3780'    ,31.5 ,3780    ,55   UNION ALL
SELECT 4229 ,'35'   ,'3500'    ,35   ,3500    ,55   UNION ALL
SELECT 4230 ,'35'   ,'3500'    ,35   ,3500    ,55   UNION ALL
SELECT 4231 ,'35'   ,'2100'    ,35   ,2100    ,55   UNION ALL
--=============================================
-- RM, HKK
-- HKK
SELECT 4187 ,'1.4'  ,'56'      ,1.4  ,56      ,67   UNION ALL
SELECT 4188 ,'2'    ,'60'      ,2    ,60      ,67   UNION ALL
SELECT 4189 ,'2.4'  ,'60'      ,2.4  ,60      ,67   UNION ALL
SELECT 4228 ,'1.8'  ,'216'     ,1.8  ,216     ,67   UNION ALL
SELECT 4229 ,'2'    ,'200'     ,2    ,200     ,67   UNION ALL
SELECT 4230 ,'2'    ,'200'     ,2    ,200     ,67   UNION ALL
SELECT 4231 ,'2'    ,'120'     ,2    ,120     ,67   UNION ALL
-- RM
SELECT 4187 ,'1.4'  ,'56'      ,1.4  ,56      ,2    UNION ALL
SELECT 4188 ,'2'    ,'60'      ,2    ,60      ,2    UNION ALL
SELECT 4189 ,'2.4'  ,'60'      ,2.4  ,60      ,2    UNION ALL
SELECT 4228 ,'1.8'  ,'216'     ,1.8  ,216     ,2    UNION ALL
SELECT 4229 ,'2'    ,'200'     ,2    ,200     ,2    UNION ALL
SELECT 4230 ,'2'    ,'200'     ,2    ,200     ,2    UNION ALL
SELECT 4231 ,'2'    ,'120'     ,2    ,120     ,2    UNION ALL
--=============================================
-- RMB, HK$
-- HK$
SELECT 4187 ,'2.8'  ,'112'     ,2.8  ,112     ,5    UNION ALL
SELECT 4188 ,'4'    ,'120'     ,4    ,120     ,5    UNION ALL
SELECT 4189 ,'4.8'  ,'120'     ,4.8  ,120     ,5    UNION ALL
SELECT 4228 ,'3.6'  ,'432'     ,3.6  ,432     ,5    UNION ALL
SELECT 4229 ,'4'    ,'400'     ,4    ,400     ,5    UNION ALL
SELECT 4230 ,'4'    ,'400'     ,4    ,400     ,5    UNION ALL
SELECT 4231 ,'4'    ,'240'     ,4    ,240     ,5    UNION ALL
--RMB
SELECT 4187 ,'2.8'  ,'112'     ,2.8  ,112     ,13   UNION ALL
SELECT 4188 ,'4'    ,'120'     ,4    ,120     ,13   UNION ALL
SELECT 4189 ,'4.8'  ,'120'     ,4.8  ,120     ,13   UNION ALL
SELECT 4228 ,'3.6'  ,'432'     ,3.6  ,432     ,13   UNION ALL
SELECT 4229 ,'4'    ,'400'     ,4    ,400     ,13   UNION ALL
SELECT 4230 ,'4'    ,'400'     ,4    ,400     ,13   UNION ALL
SELECT 4231 ,'4'    ,'240'     ,4    ,240     ,13   UNION ALL
--=============================================
-- THB, TB
-- TB
SELECT 4187 ,'10.5' ,'420'     ,10.5 ,420     ,4    UNION ALL
SELECT 4188 ,'15'   ,'450'     ,15   ,450     ,4    UNION ALL
SELECT 4189 ,'18'   ,'450'     ,18   ,450     ,4    UNION ALL
SELECT 4228 ,'13.5' ,'1620'    ,13.5 ,1620    ,4    UNION ALL
SELECT 4229 ,'15'   ,'1500'    ,15   ,1500    ,4    UNION ALL
SELECT 4230 ,'15'   ,'1500'    ,15   ,1500    ,4    UNION ALL
SELECT 4231 ,'15'   ,'900'     ,15   ,900     ,4    UNION ALL
-- THB
SELECT 4187 ,'10.5' ,'420'     ,10.5 ,420     ,43   UNION ALL
SELECT 4188 ,'15'   ,'450'     ,15   ,450     ,43   UNION ALL
SELECT 4189 ,'18'   ,'450'     ,18   ,450     ,43   UNION ALL
SELECT 4228 ,'13.5' ,'1620'    ,13.5 ,1620    ,43   UNION ALL
SELECT 4229 ,'15'   ,'1500'    ,15   ,1500    ,43   UNION ALL
SELECT 4230 ,'15'   ,'1500'    ,15   ,1500    ,43   UNION ALL
SELECT 4231 ,'15'   ,'900'     ,15   ,900     ,43   UNION ALL
--=============================================
-- Won
SELECT 4187 ,'350'  ,'14000'   ,350  ,14000   ,45   UNION ALL
SELECT 4188 ,'500'  ,'15000'   ,500  ,15000   ,45   UNION ALL
SELECT 4189 ,'600'  ,'15000'   ,600  ,15000   ,45   UNION ALL
SELECT 4228 ,'450'  ,'54000'   ,450  ,54000   ,45   UNION ALL
SELECT 4229 ,'500'  ,'50000'   ,500  ,50000   ,45   UNION ALL
SELECT 4230 ,'500'  ,'50000'   ,500  ,50000   ,45   UNION ALL
SELECT 4231 ,'500'  ,'30000'   ,500  ,30000   ,45  	

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4101)

MERGE StakeLevelGroupDetail as g 
USING STAKE_TEMP s on g.StakeLevelID = s.StakeLevelID AND g.GameTypeID = s.GameTypeID
WHEN MATCHED THEN UPDATE SET 
					g.MinLabel = s.MinLabel,
					g.MaxLabel = s.MaxLabel,
					g.MinStake =  s.MinStake,
					g.MaxStake =  s.MaxStake
WHEN NOT MATCHED THEN 
					INSERT (StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
					VALUES (s.StakeLevelID,s.GameTypeID,s.MinLabel,s.MaxLabel,s.MinStake,s.MaxStake)					
					 ;
DROP TABLE #StakeLevel_Temp