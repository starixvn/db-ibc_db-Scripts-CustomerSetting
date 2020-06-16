/*
	Date: 20200615
	Created: Winfred 
	Task: #135758 - Spadegaming - Release of old + new games June 2020
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(12))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--MYR (RM) 
SELECT 4340 ,'0.2' ,'500',0.2,500,2			UNION ALL
-- HKD (HKK, HK$)
SELECT 4340 ,'0.2' ,'500',0.2,500,67		UNION ALL
SELECT 4340 ,'0.2' ,'500',0.2,500,5			UNION ALL
-- PLN  (PLN)
SELECT 4340 ,'0.2' ,'500',0.2,500,56		UNION ALL
-- KHR (KHR)
SELECT 4340 ,'0.2' ,'500',0.2,500,71		UNION ALL
--UUS
SELECT 4340 ,'0.2' ,'100',0.2,100,20		UNION ALL	
--USD (Yen, UT, $US, US$, TH)
SELECT 4340 ,'0.2' ,'100',0.2,100,16		UNION ALL	
SELECT 4340 ,'0.2' ,'100',0.2,100,64		UNION ALL	
SELECT 4340 ,'0.2' ,'100',0.2,100,35		UNION ALL	
SELECT 4340 ,'0.2' ,'100',0.2,100,3			UNION ALL	
SELECT 4340 ,'0.2' ,'100',0.2,100,74		UNION ALL	
--SGD (SD$) 
SELECT 4340 ,'0.2' ,'100',0.2,100,1			UNION ALL	
--AUD (AUD) 
SELECT 4340 ,'0.2' ,'100',0.2,100,9			UNION ALL	
--MMK (MMK, MKK)
SELECT 4340 ,'0.2' ,'100',0.2,100,69		UNION ALL	
SELECT 4340 ,'0.2' ,'100',0.2,100,70		UNION ALL	
--EUR (Euro, EUR)
SELECT 4340 ,'0.2' ,'100',0.2,100,78		UNION ALL
SELECT 4340 ,'0.2' ,'100',0.2,100,6			UNION ALL
--GBP (GBP)	
SELECT 4340 ,'0.2' ,'100',0.2,100,12		UNION ALL
--CNY (RMB, CY, YUN) 
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,13		UNION ALL
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,81		UNION ALL
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,66		UNION ALL
--NOK (NOK)
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,54		UNION ALL 
--SEK (SEK)
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,53		UNION ALL
--IDR (DDD, IND, IDR, IDD, IN)
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,47		UNION ALL
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,22		UNION ALL
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,34		UNION ALL
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,33		UNION ALL
SELECT 4340 ,'0.2' ,'1,000',0.2,1000,15		UNION ALL 
--VND (INH)
SELECT 4340 ,'1' ,'2,000',1,2000,51			UNION ALL 	
--THB(THB, TB) 
SELECT 4340 ,'2' ,'5,000',2,5000,43			UNION ALL 
SELECT 4340 ,'2' ,'5,000',2,5000,4			UNION ALL 
--KRW (Won)
SELECT 4340 ,'40' ,'100,000',40,100000,45	UNION ALL 
--RUB (RUB)
SELECT 4340 ,'20' ,'5,000',20,5000,55		UNION ALL 
--INR(INR)
SELECT 4340 ,'20' ,'5,000',20,5000,61		UNION ALL 
--JPY (JPY)
SELECT 4340 ,'20' ,'5,000',20,5000,32		UNION ALL 
-- YNG
SELECT 4340 ,'1' ,'2,000',1,2000,72			

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4301)

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
