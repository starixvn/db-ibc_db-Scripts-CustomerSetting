/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tina
	Date: 20210219
	Task: PG Soft - Add 9 new games - Real currencies - Credit RedmineID:#150276
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(15))
								

INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
-- USD
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,3   UNION ALL --USD(US$)
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,3   UNION ALL --USD(US$)
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,3   UNION ALL --USD(US$)
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,3   UNION ALL --USD(US$)
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,3   UNION ALL --USD(US$)
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,3   UNION ALL --USD(US$)
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,3   UNION ALL --USD(US$)
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,3   UNION ALL --USD(US$)
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,3   UNION ALL --USD(US$)

SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL --USD(Yen)
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL --USD(Yen)
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL --USD(Yen)
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL --USD(Yen)
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,16   UNION ALL --USD(Yen)
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL --USD(Yen)
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,16   UNION ALL --USD(Yen)
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,16   UNION ALL --USD(Yen)
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL --USD(Yen)

SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL --USD($US)
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL --USD($US)
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL --USD($US)
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL --USD($US)
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,35   UNION ALL --USD($US)
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL --USD($US)
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,35   UNION ALL --USD($US)
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,35   UNION ALL --USD($US)
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL --USD($US)

SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL --USD(UT)
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL --USD(UT)
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL --USD(UT)
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL --USD(UT)
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,64   UNION ALL --USD(UT)
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL --USD(UT)
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,64   UNION ALL --USD(UT)
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,64   UNION ALL --USD(UT)
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL --USD(UT)

SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL --USD(USD)
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL --USD(USD)
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL --USD(USD)
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL --USD(USD)
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,95   UNION ALL --USD(USD)
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL --USD(USD)
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,95   UNION ALL --USD(USD)
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,95   UNION ALL --USD(USD)
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL --USD(USD)
--IDR
SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL --IDR(IN)
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,15   UNION ALL --IDR(IN)
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL --IDR(IN)
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL --IDR(IN)
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL --IDR(IN)
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL --IDR(IN)
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,15   UNION ALL --IDR(IN)
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL --IDR(IN)
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL --IDR(IN)

SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL --IDR(IND)
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,22   UNION ALL --IDR(IND)
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL --IDR(IND)
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL --IDR(IND)
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL --IDR(IND)
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL --IDR(IND)
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,22   UNION ALL --IDR(IND)
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL --IDR(IND)
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL --IDR(IND)

SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL --IDR(IDD)
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,33   UNION ALL --IDR(IDD)
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL --IDR(IDD)
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL --IDR(IDD)
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL --IDR(IDD)
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL --IDR(IDD)
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,33   UNION ALL --IDR(IDD)
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL --IDR(IDD)
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL --IDR(IDD)

SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL --IDR(IDR)
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,34   UNION ALL --IDR(IDR)
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL --IDR(IDR)
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL --IDR(IDR)
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL --IDR(IDR)
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL --IDR(IDR)
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,34   UNION ALL --IDR(IDR)
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL --IDR(IDR)
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL --IDR(IDR)

SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL --IDR(DDD)
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,47   UNION ALL --IDR(DDD)
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL --IDR(DDD)
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL --IDR(DDD)
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL --IDR(DDD)
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL --IDR(DDD)
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,47   UNION ALL --IDR(DDD)
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL --IDR(DDD)
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL --IDR(DDD)
--THB
SELECT 6078 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL --THB(THB)
SELECT 6079 ,'5'    ,'2000'    ,5    ,2000    ,43   UNION ALL --THB(THB)
SELECT 6080 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL --THB(THB)
SELECT 6081 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL --THB(THB)
SELECT 6082 ,'4'    ,'4000'    ,4    ,4000    ,43   UNION ALL --THB(THB)
SELECT 6083 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL --THB(THB)
SELECT 6084 ,'4'    ,'2000'    ,4    ,2000    ,43   UNION ALL --THB(THB)
SELECT 6085 ,'4'    ,'4000'    ,4    ,4000    ,43   UNION ALL --THB(THB)
SELECT 6086 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL --THB(THB)
--MMK
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL --MMK(MMK)
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,69   UNION ALL --MMK(MMK)
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL --MMK(MMK)
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL --MMK(MMK)
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,69   UNION ALL --MMK(MMK)
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL --MMK(MMK)
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,69   UNION ALL --MMK(MMK)
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,69   UNION ALL --MMK(MMK)
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,69			  --MMK(MMK)

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS 
(
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM StakeLevel s WITH(NOLOCK)
	CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
				  FROM #StakeLevel_Temp t 
				  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 6001
)

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


