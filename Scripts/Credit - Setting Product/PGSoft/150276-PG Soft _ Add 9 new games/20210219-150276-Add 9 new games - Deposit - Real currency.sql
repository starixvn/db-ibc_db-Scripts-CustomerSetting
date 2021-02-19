/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tina
	Date: 20210219
	Task: PG Soft - Add 9 new games - Real currencies - Deposit RedmineID:#150276
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(16))

--#region insert data to temp table	
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
-----------------------------Test Currencies-----------------------------
SELECT 6062 ,'0.2'  ,'100'	,0.2	,100    ,3   UNION ALL --USD(US$)
SELECT 6063 ,'0.2'  ,'100'  ,0.2	,100    ,3   UNION ALL --USD(US$)
SELECT 6064 ,'0.2'  ,'20'   ,0.2	,20     ,3   UNION ALL --USD(US$)
SELECT 6065 ,'0.2'  ,'20'   ,0.2	,20     ,3   UNION ALL --USD(US$)
SELECT 6066 ,'0.2'  ,'200'  ,0.2	,200    ,3   UNION ALL --USD(US$)
SELECT 6067 ,'0.25' ,'100'  ,0.25	,100    ,3   UNION ALL --USD(US$)
SELECT 6068 ,'0.2'  ,'20'   ,0.2	,20     ,3   UNION ALL --USD(US$)
SELECT 6069 ,'0.2'  ,'20'   ,0.2	,20     ,3   UNION ALL --USD(US$)
SELECT 6070 ,'0.2'  ,'200'  ,0.2	,200    ,3   UNION ALL --USD(US$)

SELECT 6062 ,'0.2'  ,'100'  ,0.2	,100    ,96   UNION ALL --USD(USDT)
SELECT 6063 ,'0.2'  ,'100'  ,0.2	,100    ,96   UNION ALL --USD(USDT)
SELECT 6064 ,'0.2'  ,'20'   ,0.2	,20     ,96   UNION ALL --USD(USDT)
SELECT 6065 ,'0.2'  ,'20'   ,0.2	,20     ,96   UNION ALL --USD(USDT)
SELECT 6066 ,'0.2'  ,'200'  ,0.2	,200    ,96   UNION ALL --USD(USDT)
SELECT 6067 ,'0.25' ,'100'  ,0.25	,100    ,96   UNION ALL --USD(USDT)
SELECT 6068 ,'0.2'  ,'20'   ,0.2	,20     ,96   UNION ALL --USD(USDT)
SELECT 6069 ,'0.2'  ,'20'   ,0.2	,20     ,96   UNION ALL --USD(USDT)
SELECT 6070 ,'0.2'  ,'200'  ,0.2	,200    ,96   UNION ALL --USD(USDT)

SELECT 6062 ,'1'	,'500'  ,1		,500    ,15   UNION ALL --IDR(IN)
SELECT 6063 ,'1'	,'500'  ,1		,500    ,15   UNION ALL --IDR(IN)
SELECT 6064 ,'1'	,'100'  ,1		,100    ,15   UNION ALL --IDR(IN)
SELECT 6065 ,'1'	,'100'  ,1		,100    ,15   UNION ALL --IDR(IN)
SELECT 6066 ,'1'	,'1000' ,1		,1000   ,15   UNION ALL --IDR(IN)
SELECT 6067 ,'1'	,'400'  ,1		,400    ,15   UNION ALL --IDR(IN)
SELECT 6068 ,'1'	,'100'  ,1		,100    ,15   UNION ALL --IDR(IN)
SELECT 6069 ,'1'	,'100'  ,1		,100    ,15   UNION ALL --IDR(IN)
SELECT 6070 ,'1'	,'1000' ,1		,1000   ,15   UNION ALL --IDR(IN)

SELECT 6062 ,'4'	,'2000' ,4		,2000    ,4   UNION ALL --THB(TB)
SELECT 6063 ,'4'	,'2000' ,4		,2000    ,4   UNION ALL --THB(TB)
SELECT 6064 ,'4'	,'400'  ,4		,400     ,4   UNION ALL --THB(TB)
SELECT 6065 ,'4'	,'400'  ,4		,400     ,4   UNION ALL --THB(TB)
SELECT 6066 ,'4'	,'4000' ,4		,4000    ,4   UNION ALL --THB(TB)
SELECT 6067 ,'5'	,'2000' ,5		,2000    ,4   UNION ALL --THB(TB)
SELECT 6068 ,'4'	,'400'  ,4		,400     ,4   UNION ALL --THB(TB)
SELECT 6069 ,'4'	,'400'  ,4		,400     ,4   UNION ALL --THB(TB)
SELECT 6070 ,'4'	,'4000' ,4		,4000    ,4   UNION ALL --THB(TB)

SELECT 6062 ,'0.2'  ,'100'  ,0.2	,100     ,70   UNION ALL --MMK(MKK)
SELECT 6063 ,'0.2'  ,'100'  ,0.2	,100     ,70   UNION ALL --MMK(MKK)
SELECT 6064 ,'0.2'  ,'20'   ,0.2	,20      ,70   UNION ALL --MMK(MKK)
SELECT 6065 ,'0.2'  ,'20'   ,0.2	,20      ,70   UNION ALL --MMK(MKK)
SELECT 6066 ,'0.2'  ,'200'  ,0.2	,200     ,70   UNION ALL --MMK(MKK)
SELECT 6067 ,'0.25' ,'100'  ,0.25	,100     ,70   UNION ALL --MMK(MKK)
SELECT 6068 ,'0.2'  ,'20'   ,0.2	,20      ,70   UNION ALL --MMK(MKK)
SELECT 6069 ,'0.2'  ,'20'   ,0.2	,20      ,70   UNION ALL --MMK(MKK)
SELECT 6070 ,'0.2'  ,'200'  ,0.2	,200     ,70   UNION ALL --MMK(MKK)

SELECT 6062 ,'0.2'  ,'100'  ,0.2	,100     ,94   UNION ALL --MMK(MK)
SELECT 6063 ,'0.2'  ,'100'  ,0.2	,100     ,94   UNION ALL --MMK(MK)
SELECT 6064 ,'0.2'  ,'20'   ,0.2	,20      ,94   UNION ALL --MMK(MK)
SELECT 6065 ,'0.2'  ,'20'   ,0.2	,20      ,94   UNION ALL --MMK(MK)
SELECT 6066 ,'0.2'  ,'200'  ,0.2	,200     ,94   UNION ALL --MMK(MK)
SELECT 6067 ,'0.25' ,'100'  ,0.25	,100     ,94   UNION ALL --MMK(MK)
SELECT 6068 ,'0.2'  ,'20'   ,0.2	,20      ,94   UNION ALL --MMK(MK)
SELECT 6069 ,'0.2'  ,'20'   ,0.2	,20      ,94   UNION ALL --MMK(MK)
SELECT 6070 ,'0.2'  ,'200'  ,0.2	,200     ,94		     --MMK(MK)
--#endregion insert data to temp table

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS 
(
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM Dep_StakeLevel s WITH(NOLOCK)
	CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
				  FROM #Dep_StakeLevel_Temp t 
				  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 6001
)

MERGE Dep_StakeLevelGroupDetail as g 
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
DROP TABLE #Dep_StakeLevel_Temp
