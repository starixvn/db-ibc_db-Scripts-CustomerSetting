/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Insert Setting StakeLevelGroupDetail [PG Game]  - Credit RedmineID:#137763
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
-- DDD,IND,IDR,IDD,IN
-- DDD
SELECT 6001 ,'1'      ,'100'       ,1      ,100       ,47   UNION ALL
SELECT 6002 ,'1'      ,'100'       ,1      ,100       ,47   UNION ALL
SELECT 6003 ,'1'      ,'100'       ,1      ,100       ,47   UNION ALL
SELECT 6004 ,'1'      ,'100'       ,1      ,100       ,47   UNION ALL
SELECT 6005 ,'2'      ,'2000'      ,2      ,2000      ,47   UNION ALL
SELECT 6006 ,'1'      ,'100'       ,1      ,100       ,47   UNION ALL
SELECT 6007 ,'1'      ,'250'       ,1      ,250       ,47   UNION ALL
SELECT 6008 ,'1'      ,'500'       ,1      ,500       ,47   UNION ALL
SELECT 6009 ,'1'      ,'1000'      ,1      ,1000      ,47   UNION ALL
SELECT 6010 ,'1'      ,'300'       ,1      ,300       ,47   UNION ALL
SELECT 6011 ,'1'      ,'250'       ,1      ,250       ,47   UNION ALL
SELECT 6012 ,'1'      ,'250'       ,1      ,250       ,47   UNION ALL
SELECT 6013 ,'2'      ,'400'       ,2      ,400       ,47   UNION ALL
SELECT 6014 ,'1.5'    ,'150'       ,1.5    ,150       ,47   UNION ALL
SELECT 6015 ,'1'      ,'250'       ,1      ,250       ,47   UNION ALL
SELECT 6016 ,'1'      ,'100'       ,1      ,100       ,47   UNION ALL
SELECT 6017 ,'1.5'    ,'300'       ,1.5    ,300       ,47   UNION ALL
SELECT 6018 ,'1'      ,'500'       ,1      ,500       ,47   UNION ALL
SELECT 6019 ,'2'      ,'4000'      ,2      ,4000      ,47   UNION ALL
SELECT 6020 ,'1'      ,'1000'      ,1      ,1000      ,47   UNION ALL
--IDD
SELECT 6001 ,'1'      ,'100'       ,1      ,100       ,33   UNION ALL
SELECT 6002 ,'1'      ,'100'       ,1      ,100       ,33   UNION ALL
SELECT 6003 ,'1'      ,'100'       ,1      ,100       ,33   UNION ALL
SELECT 6004 ,'1'      ,'100'       ,1      ,100       ,33   UNION ALL
SELECT 6005 ,'2'      ,'2000'      ,2      ,2000      ,33   UNION ALL
SELECT 6006 ,'1'      ,'100'       ,1      ,100       ,33   UNION ALL
SELECT 6007 ,'1'      ,'250'       ,1      ,250       ,33   UNION ALL
SELECT 6008 ,'1'      ,'500'       ,1      ,500       ,33   UNION ALL
SELECT 6009 ,'1'      ,'1000'      ,1      ,1000      ,33   UNION ALL
SELECT 6010 ,'1'      ,'300'       ,1      ,300       ,33   UNION ALL
SELECT 6011 ,'1'      ,'250'       ,1      ,250       ,33   UNION ALL
SELECT 6012 ,'1'      ,'250'       ,1      ,250       ,33   UNION ALL
SELECT 6013 ,'2'      ,'400'       ,2      ,400       ,33   UNION ALL
SELECT 6014 ,'1.5'    ,'150'       ,1.5    ,150       ,33   UNION ALL
SELECT 6015 ,'1'      ,'250'       ,1      ,250       ,33   UNION ALL
SELECT 6016 ,'1'      ,'100'       ,1      ,100       ,33   UNION ALL
SELECT 6017 ,'1.5'    ,'300'       ,1.5    ,300       ,33   UNION ALL
SELECT 6018 ,'1'      ,'500'       ,1      ,500       ,33   UNION ALL
SELECT 6019 ,'2'      ,'4000'      ,2      ,4000      ,33   UNION ALL
SELECT 6020 ,'1'      ,'1000'      ,1      ,1000      ,33   UNION ALL
--IDR
SELECT 6001 ,'1'      ,'100'       ,1      ,100       ,34   UNION ALL
SELECT 6002 ,'1'      ,'100'       ,1      ,100       ,34   UNION ALL
SELECT 6003 ,'1'      ,'100'       ,1      ,100       ,34   UNION ALL
SELECT 6004 ,'1'      ,'100'       ,1      ,100       ,34   UNION ALL
SELECT 6005 ,'2'      ,'2000'      ,2      ,2000      ,34   UNION ALL
SELECT 6006 ,'1'      ,'100'       ,1      ,100       ,34   UNION ALL
SELECT 6007 ,'1'      ,'250'       ,1      ,250       ,34   UNION ALL
SELECT 6008 ,'1'      ,'500'       ,1      ,500       ,34   UNION ALL
SELECT 6009 ,'1'      ,'1000'      ,1      ,1000      ,34   UNION ALL
SELECT 6010 ,'1'      ,'300'       ,1      ,300       ,34   UNION ALL
SELECT 6011 ,'1'      ,'250'       ,1      ,250       ,34   UNION ALL
SELECT 6012 ,'1'      ,'250'       ,1      ,250       ,34   UNION ALL
SELECT 6013 ,'2'      ,'400'       ,2      ,400       ,34   UNION ALL
SELECT 6014 ,'1.5'    ,'150'       ,1.5    ,150       ,34   UNION ALL
SELECT 6015 ,'1'      ,'250'       ,1      ,250       ,34   UNION ALL
SELECT 6016 ,'1'      ,'100'       ,1      ,100       ,34   UNION ALL
SELECT 6017 ,'1.5'    ,'300'       ,1.5    ,300       ,34   UNION ALL
SELECT 6018 ,'1'      ,'500'       ,1      ,500       ,34   UNION ALL
SELECT 6019 ,'2'      ,'4000'      ,2      ,4000      ,34   UNION ALL
SELECT 6020 ,'1'      ,'1000'      ,1      ,1000      ,34   UNION ALL
--IN
SELECT 6001 ,'1'      ,'100'       ,1      ,100       ,15   UNION ALL
SELECT 6002 ,'1'      ,'100'       ,1      ,100       ,15   UNION ALL
SELECT 6003 ,'1'      ,'100'       ,1      ,100       ,15   UNION ALL
SELECT 6004 ,'1'      ,'100'       ,1      ,100       ,15   UNION ALL
SELECT 6005 ,'2'      ,'2000'      ,2      ,2000      ,15   UNION ALL
SELECT 6006 ,'1'      ,'100'       ,1      ,100       ,15   UNION ALL
SELECT 6007 ,'1'      ,'250'       ,1      ,250       ,15   UNION ALL
SELECT 6008 ,'1'      ,'500'       ,1      ,500       ,15   UNION ALL
SELECT 6009 ,'1'      ,'1000'      ,1      ,1000      ,15   UNION ALL
SELECT 6010 ,'1'      ,'300'       ,1      ,300       ,15   UNION ALL
SELECT 6011 ,'1'      ,'250'       ,1      ,250       ,15   UNION ALL
SELECT 6012 ,'1'      ,'250'       ,1      ,250       ,15   UNION ALL
SELECT 6013 ,'2'      ,'400'       ,2      ,400       ,15   UNION ALL
SELECT 6014 ,'1.5'    ,'150'       ,1.5    ,150       ,15   UNION ALL
SELECT 6015 ,'1'      ,'250'       ,1      ,250       ,15   UNION ALL
SELECT 6016 ,'1'      ,'100'       ,1      ,100       ,15   UNION ALL
SELECT 6017 ,'1.5'    ,'300'       ,1.5    ,300       ,15   UNION ALL
SELECT 6018 ,'1'      ,'500'       ,1      ,500       ,15   UNION ALL
SELECT 6019 ,'2'      ,'4000'      ,2      ,4000      ,15   UNION ALL
SELECT 6020 ,'1'      ,'1000'      ,1      ,1000      ,15   UNION ALL
--IND
SELECT 6001 ,'1'      ,'100'       ,1      ,100       ,22   UNION ALL
SELECT 6002 ,'1'      ,'100'       ,1      ,100       ,22   UNION ALL
SELECT 6003 ,'1'      ,'100'       ,1      ,100       ,22   UNION ALL
SELECT 6004 ,'1'      ,'100'       ,1      ,100       ,22   UNION ALL
SELECT 6005 ,'2'      ,'2000'      ,2      ,2000      ,22   UNION ALL
SELECT 6006 ,'1'      ,'100'       ,1      ,100       ,22   UNION ALL
SELECT 6007 ,'1'      ,'250'       ,1      ,250       ,22   UNION ALL
SELECT 6008 ,'1'      ,'500'       ,1      ,500       ,22   UNION ALL
SELECT 6009 ,'1'      ,'1000'      ,1      ,1000      ,22   UNION ALL
SELECT 6010 ,'1'      ,'300'       ,1      ,300       ,22   UNION ALL
SELECT 6011 ,'1'      ,'250'       ,1      ,250       ,22   UNION ALL
SELECT 6012 ,'1'      ,'250'       ,1      ,250       ,22   UNION ALL
SELECT 6013 ,'2'      ,'400'       ,2      ,400       ,22   UNION ALL
SELECT 6014 ,'1.5'    ,'150'       ,1.5    ,150       ,22   UNION ALL
SELECT 6015 ,'1'      ,'250'       ,1      ,250       ,22   UNION ALL
SELECT 6016 ,'1'      ,'100'       ,1      ,100       ,22   UNION ALL
SELECT 6017 ,'1.5'    ,'300'       ,1.5    ,300       ,22   UNION ALL
SELECT 6018 ,'1'      ,'500'       ,1      ,500       ,22   UNION ALL
SELECT 6019 ,'2'      ,'4000'      ,2      ,4000      ,22   UNION ALL
SELECT 6020 ,'1'      ,'1000'      ,1      ,1000      ,22   UNION ALL
--=============================================
-- Won
SELECT 6001 ,'0.2'    ,'20'        ,0.2    ,20        ,45   UNION ALL
SELECT 6002 ,'0.2'    ,'20'        ,0.2    ,20        ,45   UNION ALL
SELECT 6003 ,'0.2'    ,'20'        ,0.2    ,20        ,45   UNION ALL
SELECT 6004 ,'0.2'    ,'20'        ,0.2    ,20        ,45   UNION ALL
SELECT 6005 ,'0.3'    ,'300'       ,0.3    ,300       ,45   UNION ALL
SELECT 6006 ,'0.2'    ,'20'        ,0.2    ,20        ,45   UNION ALL
SELECT 6007 ,'0.2'    ,'50'        ,0.2    ,50        ,45   UNION ALL
SELECT 6008 ,'0.2'    ,'100'       ,0.2    ,100       ,45   UNION ALL
SELECT 6009 ,'0.2'    ,'200'       ,0.2    ,200       ,45   UNION ALL
SELECT 6010 ,'0.25'   ,'75'        ,0.25   ,75        ,45   UNION ALL
SELECT 6011 ,'0.2'    ,'50'        ,0.2    ,50        ,45   UNION ALL
SELECT 6012 ,'0.2'    ,'50'        ,0.2    ,50        ,45   UNION ALL
SELECT 6013 ,'0.3'    ,'60'        ,0.3    ,60        ,45   UNION ALL
SELECT 6014 ,'0.3'    ,'30'        ,0.3    ,30        ,45   UNION ALL
SELECT 6015 ,'0.2'    ,'50'        ,0.2    ,50        ,45   UNION ALL
SELECT 6017 ,'0.3'    ,'60'        ,0.3    ,60        ,45   UNION ALL
SELECT 6018 ,'0.2'    ,'100'       ,0.2    ,100       ,45   UNION ALL
SELECT 6019 ,'0.3'    ,'600'       ,0.3    ,600       ,45   UNION ALL
SELECT 6020 ,'0.2'    ,'200'       ,0.2    ,200       ,45   UNION ALL
--=============================================
-- THB, TB
-- TB
SELECT 6001 ,'4'      ,'400'       ,4      ,400       ,4    UNION ALL
SELECT 6002 ,'4'      ,'400'       ,4      ,400       ,4    UNION ALL
SELECT 6003 ,'4'      ,'400'       ,4      ,400       ,4    UNION ALL
SELECT 6004 ,'4'      ,'400'       ,4      ,400       ,4    UNION ALL
SELECT 6005 ,'5'      ,'5000'      ,5      ,5000      ,4    UNION ALL
SELECT 6006 ,'4'      ,'400'       ,4      ,400       ,4    UNION ALL
SELECT 6007 ,'4'      ,'1000'      ,4      ,1000      ,4    UNION ALL
SELECT 6008 ,'4'      ,'2000'      ,4      ,2000      ,4    UNION ALL
SELECT 6009 ,'4'      ,'4000'      ,4      ,4000      ,4    UNION ALL
SELECT 6010 ,'5'      ,'1500'      ,5      ,1500      ,4    UNION ALL
SELECT 6011 ,'4'      ,'1000'      ,4      ,1000      ,4    UNION ALL
SELECT 6012 ,'4'      ,'1000'      ,4      ,1000      ,4    UNION ALL
SELECT 6013 ,'5'      ,'1000'      ,5      ,1000      ,4    UNION ALL
SELECT 6014 ,'6'      ,'600'       ,6      ,600       ,4    UNION ALL
SELECT 6015 ,'4'      ,'1000'      ,4      ,1000      ,4    UNION ALL
SELECT 6016 ,'4'      ,'400'       ,4      ,400       ,4    UNION ALL
SELECT 6017 ,'6'      ,'1200'      ,6      ,1200      ,4    UNION ALL
SELECT 6018 ,'4'      ,'2000'      ,4      ,2000      ,4    UNION ALL
SELECT 6019 ,'5'      ,'10000'     ,5      ,10000     ,4    UNION ALL
SELECT 6020 ,'4'      ,'4000'      ,4      ,4000      ,4    UNION ALL
-- THB
SELECT 6001 ,'4'      ,'400'       ,4      ,400       ,43   UNION ALL
SELECT 6002 ,'4'      ,'400'       ,4      ,400       ,43   UNION ALL
SELECT 6003 ,'4'      ,'400'       ,4      ,400       ,43   UNION ALL
SELECT 6004 ,'4'      ,'400'       ,4      ,400       ,43   UNION ALL
SELECT 6005 ,'5'      ,'5000'      ,5      ,5000      ,43   UNION ALL
SELECT 6006 ,'4'      ,'400'       ,4      ,400       ,43   UNION ALL
SELECT 6007 ,'4'      ,'1000'      ,4      ,1000      ,43   UNION ALL
SELECT 6008 ,'4'      ,'2000'      ,4      ,2000      ,43   UNION ALL
SELECT 6009 ,'4'      ,'4000'      ,4      ,4000      ,43   UNION ALL
SELECT 6010 ,'5'      ,'1500'      ,5      ,1500      ,43   UNION ALL
SELECT 6011 ,'4'      ,'1000'      ,4      ,1000      ,43   UNION ALL
SELECT 6012 ,'4'      ,'1000'      ,4      ,1000      ,43   UNION ALL
SELECT 6013 ,'5'      ,'1000'      ,5      ,1000      ,43   UNION ALL
SELECT 6014 ,'6'      ,'600'       ,6      ,600       ,43   UNION ALL
SELECT 6015 ,'4'      ,'1000'      ,4      ,1000      ,43   UNION ALL
SELECT 6016 ,'4'      ,'400'       ,4      ,400       ,43   UNION ALL
SELECT 6017 ,'6'      ,'1200'      ,6      ,1200      ,43   UNION ALL
SELECT 6018 ,'4'      ,'2000'      ,4      ,2000      ,43   UNION ALL
SELECT 6019 ,'5'      ,'10000'     ,5      ,10000     ,43   UNION ALL
SELECT 6020 ,'4'      ,'4000'      ,4      ,4000      ,43   UNION ALL
--=============================================
--USD code($US, US$, UT, Yen),MMK, Euro, EUR,UUS, YNG
--US$
SELECT 6001 ,'0.2'    ,'20'        ,0.2    ,20        ,3    UNION ALL
SELECT 6002 ,'0.2'    ,'20'        ,0.2    ,20        ,3    UNION ALL
SELECT 6003 ,'0.2'    ,'20'        ,0.2    ,20        ,3    UNION ALL
SELECT 6004 ,'0.2'    ,'20'        ,0.2    ,20        ,3    UNION ALL
SELECT 6005 ,'0.25'   ,'250'       ,0.25   ,250       ,3    UNION ALL
SELECT 6006 ,'0.2'    ,'20'        ,0.2    ,20        ,3    UNION ALL
SELECT 6007 ,'0.2'    ,'50'        ,0.2    ,50        ,3    UNION ALL
SELECT 6008 ,'0.2'    ,'100'       ,0.2    ,100       ,3    UNION ALL
SELECT 6009 ,'0.2'    ,'200'       ,0.2    ,200       ,3    UNION ALL
SELECT 6010 ,'0.25'   ,'75'        ,0.25   ,75        ,3    UNION ALL
SELECT 6011 ,'0.2'    ,'50'        ,0.2    ,50        ,3    UNION ALL
SELECT 6012 ,'0.2'    ,'50'        ,0.2    ,50        ,3    UNION ALL
SELECT 6013 ,'0.25'   ,'50'        ,0.25   ,50        ,3    UNION ALL
SELECT 6014 ,'0.3'    ,'30'        ,0.3    ,30        ,3    UNION ALL
SELECT 6015 ,'0.2'    ,'50'        ,0.2    ,50        ,3    UNION ALL
SELECT 6016 ,'0.2'    ,'20'        ,0.2    ,20        ,3    UNION ALL
SELECT 6017 ,'0.3'    ,'60'        ,0.3    ,60        ,3    UNION ALL
SELECT 6018 ,'0.2'    ,'100'       ,0.2    ,100       ,3    UNION ALL
SELECT 6019 ,'0.25'   ,'500'       ,0.25   ,500       ,3    UNION ALL
SELECT 6020 ,'0.2'    ,'200'       ,0.2    ,200       ,3    UNION ALL
--USD
SELECT 6001 ,'0.2'    ,'20'        ,0.2    ,20        ,95   UNION ALL
SELECT 6002 ,'0.2'    ,'20'        ,0.2    ,20        ,95   UNION ALL
SELECT 6003 ,'0.2'    ,'20'        ,0.2    ,20        ,95   UNION ALL
SELECT 6004 ,'0.2'    ,'20'        ,0.2    ,20        ,95   UNION ALL
SELECT 6005 ,'0.25'   ,'250'       ,0.25   ,250       ,95   UNION ALL
SELECT 6006 ,'0.2'    ,'20'        ,0.2    ,20        ,95   UNION ALL
SELECT 6007 ,'0.2'    ,'50'        ,0.2    ,50        ,95   UNION ALL
SELECT 6008 ,'0.2'    ,'100'       ,0.2    ,100       ,95   UNION ALL
SELECT 6009 ,'0.2'    ,'200'       ,0.2    ,200       ,95   UNION ALL
SELECT 6010 ,'0.25'   ,'75'        ,0.25   ,75        ,95   UNION ALL
SELECT 6011 ,'0.2'    ,'50'        ,0.2    ,50        ,95   UNION ALL
SELECT 6012 ,'0.2'    ,'50'        ,0.2    ,50        ,95   UNION ALL
SELECT 6013 ,'0.25'   ,'50'        ,0.25   ,50        ,95   UNION ALL
SELECT 6014 ,'0.3'    ,'30'        ,0.3    ,30        ,95   UNION ALL
SELECT 6015 ,'0.2'    ,'50'        ,0.2    ,50        ,95   UNION ALL
SELECT 6016 ,'0.2'    ,'20'        ,0.2    ,20        ,95   UNION ALL
SELECT 6017 ,'0.3'    ,'60'        ,0.3    ,60        ,95   UNION ALL
SELECT 6018 ,'0.2'    ,'100'       ,0.2    ,100       ,95   UNION ALL
SELECT 6019 ,'0.25'   ,'500'       ,0.25   ,500       ,95   UNION ALL
SELECT 6020 ,'0.2'    ,'200'       ,0.2    ,200       ,95   UNION ALL
--UT
SELECT 6001 ,'0.2'    ,'20'        ,0.2    ,20        ,64   UNION ALL
SELECT 6002 ,'0.2'    ,'20'        ,0.2    ,20        ,64   UNION ALL
SELECT 6003 ,'0.2'    ,'20'        ,0.2    ,20        ,64   UNION ALL
SELECT 6004 ,'0.2'    ,'20'        ,0.2    ,20        ,64   UNION ALL
SELECT 6005 ,'0.25'   ,'250'       ,0.25   ,250       ,64   UNION ALL
SELECT 6006 ,'0.2'    ,'20'        ,0.2    ,20        ,64   UNION ALL
SELECT 6007 ,'0.2'    ,'50'        ,0.2    ,50        ,64   UNION ALL
SELECT 6008 ,'0.2'    ,'100'       ,0.2    ,100       ,64   UNION ALL
SELECT 6009 ,'0.2'    ,'200'       ,0.2    ,200       ,64   UNION ALL
SELECT 6010 ,'0.25'   ,'75'        ,0.25   ,75        ,64   UNION ALL
SELECT 6011 ,'0.2'    ,'50'        ,0.2    ,50        ,64   UNION ALL
SELECT 6012 ,'0.2'    ,'50'        ,0.2    ,50        ,64   UNION ALL
SELECT 6013 ,'0.25'   ,'50'        ,0.25   ,50        ,64   UNION ALL
SELECT 6014 ,'0.3'    ,'30'        ,0.3    ,30        ,64   UNION ALL
SELECT 6015 ,'0.2'    ,'50'        ,0.2    ,50        ,64   UNION ALL
SELECT 6016 ,'0.2'    ,'20'        ,0.2    ,20        ,64   UNION ALL
SELECT 6017 ,'0.3'    ,'60'        ,0.3    ,60        ,64   UNION ALL
SELECT 6018 ,'0.2'    ,'100'       ,0.2    ,100       ,64   UNION ALL
SELECT 6019 ,'0.25'   ,'500'       ,0.25   ,500       ,64   UNION ALL
SELECT 6020 ,'0.2'    ,'200'       ,0.2    ,200       ,64   UNION ALL
--Yen
SELECT 6001 ,'0.2'    ,'20'        ,0.2    ,20        ,16   UNION ALL
SELECT 6002 ,'0.2'    ,'20'        ,0.2    ,20        ,16   UNION ALL
SELECT 6003 ,'0.2'    ,'20'        ,0.2    ,20        ,16   UNION ALL
SELECT 6004 ,'0.2'    ,'20'        ,0.2    ,20        ,16   UNION ALL
SELECT 6005 ,'0.25'   ,'250'       ,0.25   ,250       ,16   UNION ALL
SELECT 6006 ,'0.2'    ,'20'        ,0.2    ,20        ,16   UNION ALL
SELECT 6007 ,'0.2'    ,'50'        ,0.2    ,50        ,16   UNION ALL
SELECT 6008 ,'0.2'    ,'100'       ,0.2    ,100       ,16   UNION ALL
SELECT 6009 ,'0.2'    ,'200'       ,0.2    ,200       ,16   UNION ALL
SELECT 6010 ,'0.25'   ,'75'        ,0.25   ,75        ,16   UNION ALL
SELECT 6011 ,'0.2'    ,'50'        ,0.2    ,50        ,16   UNION ALL
SELECT 6012 ,'0.2'    ,'50'        ,0.2    ,50        ,16   UNION ALL
SELECT 6013 ,'0.25'   ,'50'        ,0.25   ,50        ,16   UNION ALL
SELECT 6014 ,'0.3'    ,'30'        ,0.3    ,30        ,16   UNION ALL
SELECT 6015 ,'0.2'    ,'50'        ,0.2    ,50        ,16   UNION ALL
SELECT 6016 ,'0.2'    ,'20'        ,0.2    ,20        ,16   UNION ALL
SELECT 6017 ,'0.3'    ,'60'        ,0.3    ,60        ,16   UNION ALL
SELECT 6018 ,'0.2'    ,'100'       ,0.2    ,100       ,16   UNION ALL
SELECT 6019 ,'0.25'   ,'500'       ,0.25   ,500       ,16   UNION ALL
SELECT 6020 ,'0.2'    ,'200'       ,0.2    ,200       ,16    

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
WHERE s.GameTypeID = 6001)

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