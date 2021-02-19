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
								
--#region Insert to temp table
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--------------------------Test Currencies--------------------------------
SELECT 6062 ,'0.2'	,'100'	,0.2  ,100	,3   UNION ALL --USD(US$)
SELECT 6063 ,'0.2'	,'100'  ,0.2  ,100	,3   UNION ALL --USD(US$)
SELECT 6064 ,'0.2'	,'20'   ,0.2  ,20	,3   UNION ALL --USD(US$)
SELECT 6065 ,'0.2'	,'20'   ,0.2  ,20	,3   UNION ALL --USD(US$)
SELECT 6066 ,'0.2'	,'200'  ,0.2  ,200	,3   UNION ALL --USD(US$)
SELECT 6067 ,'0.25' ,'100'  ,0.25 ,100	,3   UNION ALL --USD(US$)
SELECT 6068 ,'0.2'	,'20'   ,0.2  ,20	,3   UNION ALL --USD(US$)
SELECT 6069 ,'0.2'	,'20'   ,0.2  ,20	,3   UNION ALL --USD(US$)
SELECT 6070 ,'0.2'	,'200'  ,0.2  ,200	,3   UNION ALL --USD(US$)

SELECT 6062 ,'0.2'  ,'100'  ,0.2  ,100  ,16   UNION ALL --USD(Yen)
SELECT 6063 ,'0.2'  ,'100'  ,0.2  ,100  ,16   UNION ALL --USD(Yen)
SELECT 6064 ,'0.2'  ,'20'   ,0.2  ,20   ,16   UNION ALL --USD(Yen)
SELECT 6065 ,'0.2'  ,'20'   ,0.2  ,20   ,16   UNION ALL --USD(Yen)
SELECT 6066 ,'0.2'  ,'200'  ,0.2  ,200  ,16   UNION ALL --USD(Yen)
SELECT 6067 ,'0.25' ,'100'  ,0.25 ,100  ,16   UNION ALL --USD(Yen)
SELECT 6068 ,'0.2'  ,'20'   ,0.2  ,20   ,16   UNION ALL --USD(Yen)
SELECT 6069 ,'0.2'  ,'20'   ,0.2  ,20   ,16   UNION ALL --USD(Yen)
SELECT 6070 ,'0.2'  ,'200'  ,0.2  ,200  ,16   UNION ALL --USD(Yen)

SELECT 6062 ,'0.2'	,'100'  ,0.2  ,100	,35   UNION ALL --USD($US)
SELECT 6063 ,'0.2'	,'100'  ,0.2  ,100	,35   UNION ALL --USD($US)
SELECT 6064 ,'0.2'	,'20'   ,0.2  ,20	,35   UNION ALL --USD($US)
SELECT 6065 ,'0.2'	,'20'   ,0.2  ,20	,35   UNION ALL --USD($US)
SELECT 6066 ,'0.2'	,'200'  ,0.2  ,200	,35   UNION ALL --USD($US)
SELECT 6067 ,'0.25' ,'100'  ,0.25 ,100	,35   UNION ALL --USD($US)
SELECT 6068 ,'0.2'	,'20'   ,0.2  ,20	,35   UNION ALL --USD($US)
SELECT 6069 ,'0.2'	,'20'   ,0.2  ,20	,35   UNION ALL --USD($US)
SELECT 6070 ,'0.2'	,'200'  ,0.2  ,200	,35   UNION ALL --USD($US)

SELECT 6062 ,'0.2'	,'100'  ,0.2  ,100	,64   UNION ALL --USD(UT)
SELECT 6063 ,'0.2'	,'100'  ,0.2  ,100	,64   UNION ALL --USD(UT)
SELECT 6064 ,'0.2'	,'20'   ,0.2  ,20	,64   UNION ALL --USD(UT)
SELECT 6065 ,'0.2'	,'20'   ,0.2  ,20	,64   UNION ALL --USD(UT)
SELECT 6066 ,'0.2'	,'200'  ,0.2  ,200	,64   UNION ALL --USD(UT)
SELECT 6067 ,'0.25' ,'100'  ,0.25 ,100	,64   UNION ALL --USD(UT)
SELECT 6068 ,'0.2'	,'20'   ,0.2  ,20	,64   UNION ALL --USD(UT)
SELECT 6069 ,'0.2'	,'20'   ,0.2  ,20	,64   UNION ALL --USD(UT)
SELECT 6070 ,'0.2'	,'200'  ,0.2  ,200	,64   UNION ALL --USD(UT)

SELECT 6062 ,'0.2'	,'100'  ,0.2  ,100	,95   UNION ALL --USD(USD)
SELECT 6063 ,'0.2'	,'100'  ,0.2  ,100	,95   UNION ALL --USD(USD)
SELECT 6064 ,'0.2'	,'20'   ,0.2  ,20	,95   UNION ALL --USD(USD)
SELECT 6065 ,'0.2'	,'20'   ,0.2  ,20	,95   UNION ALL --USD(USD)
SELECT 6066 ,'0.2'	,'200'  ,0.2  ,200	,95   UNION ALL --USD(USD)
SELECT 6067 ,'0.25' ,'100'  ,0.25 ,100	,95   UNION ALL --USD(USD)
SELECT 6068 ,'0.2'	,'20'   ,0.2  ,20	,95   UNION ALL --USD(USD)
SELECT 6069 ,'0.2'	,'20'   ,0.2  ,20	,95   UNION ALL --USD(USD)
SELECT 6070 ,'0.2'	,'200'  ,0.2  ,200	,95   UNION ALL --USD(USD)

SELECT 6062 ,'1'	,'500'  ,1	  ,500	,15   UNION ALL --IDR(IN)
SELECT 6063 ,'1'	,'500'  ,1    ,500	,15   UNION ALL --IDR(IN)
SELECT 6064 ,'1'	,'100'  ,1    ,100	,15   UNION ALL --IDR(IN)
SELECT 6065 ,'1'	,'100'  ,1    ,100	,15   UNION ALL --IDR(IN)
SELECT 6066 ,'1'	,'1000' ,1    ,1000 ,15   UNION ALL --IDR(IN)
SELECT 6067 ,'1'	,'400'  ,1    ,400	,15   UNION ALL --IDR(IN)
SELECT 6068 ,'1'	,'100'  ,1    ,100	,15   UNION ALL --IDR(IN)
SELECT 6069 ,'1'	,'100'  ,1    ,100	,15   UNION ALL --IDR(IN)
SELECT 6070 ,'1'	,'1000' ,1    ,1000 ,15   UNION ALL --IDR(IN)

SELECT 6062 ,'1'	,'500'  ,1    ,500	,22   UNION ALL --IDR(IND)
SELECT 6063 ,'1'	,'500'  ,1    ,500	,22   UNION ALL --IDR(IND)
SELECT 6064 ,'1'	,'100'  ,1    ,100	,22   UNION ALL --IDR(IND)
SELECT 6065 ,'1'	,'100'  ,1    ,100	,22   UNION ALL --IDR(IND)
SELECT 6066 ,'1'	,'1000' ,1    ,1000 ,22   UNION ALL --IDR(IND)
SELECT 6067 ,'1'	,'400'  ,1    ,400	,22   UNION ALL --IDR(IND)
SELECT 6068 ,'1'	,'100'  ,1    ,100	,22   UNION ALL --IDR(IND)
SELECT 6069 ,'1'	,'100'  ,1    ,100	,22   UNION ALL --IDR(IND)
SELECT 6070 ,'1'	,'1000' ,1    ,1000 ,22   UNION ALL --IDR(IND)

SELECT 6062 ,'1'	,'500'  ,1    ,500	,33   UNION ALL --IDR(IDD)
SELECT 6063 ,'1'	,'500'  ,1    ,500	,33   UNION ALL --IDR(IDD)
SELECT 6064 ,'1'	,'100'  ,1    ,100	,33   UNION ALL --IDR(IDD)
SELECT 6065 ,'1'	,'100'  ,1    ,100	,33   UNION ALL --IDR(IDD)
SELECT 6066 ,'1'	,'1000' ,1    ,1000 ,33   UNION ALL --IDR(IDD)
SELECT 6067 ,'1'	,'400'  ,1    ,400	,33   UNION ALL --IDR(IDD)
SELECT 6068 ,'1'	,'100'  ,1    ,100	,33   UNION ALL --IDR(IDD)
SELECT 6069 ,'1'	,'100'  ,1    ,100	,33   UNION ALL --IDR(IDD)
SELECT 6070 ,'1'	,'1000' ,1    ,1000 ,33   UNION ALL --IDR(IDD)

SELECT 6062 ,'1'	,'500'  ,1    ,500	,34   UNION ALL --IDR(IDR)
SELECT 6063 ,'1'	,'500'  ,1    ,500	,34   UNION ALL --IDR(IDR)
SELECT 6064 ,'1'	,'100'  ,1    ,100	,34   UNION ALL --IDR(IDR)
SELECT 6065 ,'1'	,'100'  ,1    ,100	,34   UNION ALL --IDR(IDR)
SELECT 6066 ,'1'	,'1000' ,1    ,1000 ,34   UNION ALL --IDR(IDR)
SELECT 6067 ,'1'	,'400'  ,1    ,400	,34   UNION ALL --IDR(IDR)
SELECT 6068 ,'1'	,'100'  ,1    ,100	,34   UNION ALL --IDR(IDR)
SELECT 6069 ,'1'	,'100'  ,1    ,100	,34   UNION ALL --IDR(IDR)
SELECT 6070 ,'1'	,'1000' ,1    ,1000	,34   UNION ALL --IDR(IDR)

SELECT 6062 ,'1'	,'500'  ,1    ,500	,47   UNION ALL --IDR(DDD)
SELECT 6063 ,'1'	,'500'  ,1    ,500	,47   UNION ALL --IDR(DDD)
SELECT 6064 ,'1'	,'100'  ,1    ,100	,47   UNION ALL --IDR(DDD)
SELECT 6065 ,'1'	,'100'  ,1    ,100	,47   UNION ALL --IDR(DDD)
SELECT 6066 ,'1'	,'1000' ,1    ,1000 ,47   UNION ALL --IDR(DDD)
SELECT 6067 ,'1'	,'400'  ,1    ,400	,47   UNION ALL --IDR(DDD)
SELECT 6068 ,'1'	,'100'  ,1    ,100	,47   UNION ALL --IDR(DDD)
SELECT 6069 ,'1'	,'100'  ,1    ,100	,47   UNION ALL --IDR(DDD)
SELECT 6070 ,'1'	,'1000' ,1    ,1000 ,47   UNION ALL --IDR(DDD)

SELECT 6062 ,'4'	,'2000' ,4    ,2000 ,43   UNION ALL --THB(THB)
SELECT 6063 ,'4'	,'2000' ,4    ,2000 ,43   UNION ALL --THB(THB)
SELECT 6064 ,'4'	,'400'  ,4    ,400	,43   UNION ALL --THB(THB)
SELECT 6065 ,'4'	,'400'  ,4    ,400	,43   UNION ALL --THB(THB)
SELECT 6066 ,'4'	,'4000' ,4    ,4000 ,43   UNION ALL --THB(THB)
SELECT 6067 ,'5'	,'2000' ,5    ,2000 ,43   UNION ALL --THB(THB)
SELECT 6068 ,'4'	,'400'  ,4    ,400	,43   UNION ALL --THB(THB)
SELECT 6069 ,'4'	,'400'  ,4    ,400	,43   UNION ALL --THB(THB)
SELECT 6070 ,'4'	,'4000' ,4    ,4000 ,43   UNION ALL --THB(THB)

SELECT 6062 ,'0.2'	,'100'  ,0.2  ,100	,69   UNION ALL --MMK(MMK)
SELECT 6063 ,'0.2'	,'100'  ,0.2  ,100	,69   UNION ALL --MMK(MMK)
SELECT 6064 ,'0.2'	,'20'   ,0.2  ,20	,69   UNION ALL --MMK(MMK)
SELECT 6065 ,'0.2'	,'20'   ,0.2  ,20	,69   UNION ALL --MMK(MMK)
SELECT 6066 ,'0.2'	,'200'  ,0.2  ,200	,69   UNION ALL --MMK(MMK)
SELECT 6067 ,'0.25' ,'100'  ,0.25 ,100	,69   UNION ALL --MMK(MMK)
SELECT 6068 ,'0.2'	,'20'   ,0.2  ,20	,69   UNION ALL --MMK(MMK)
SELECT 6069 ,'0.2'	,'20'   ,0.2  ,20	,69   UNION ALL --MMK(MMK)
SELECT 6070 ,'0.2'	,'200'  ,0.2  ,200	,69				--MMK(MMK)
--#endregion Insert to temp table

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


