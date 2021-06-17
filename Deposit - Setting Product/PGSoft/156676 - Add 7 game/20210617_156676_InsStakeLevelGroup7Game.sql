/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210617
	Task:  Add 7 new game [PG Game]  - Deposit real currency RedmineID:#156676
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(16))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--IN
SELECT 6071 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--IN
SELECT 6072 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN
SELECT 6073 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--IN
SELECT 6074 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--IN
SELECT 6075 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN
SELECT 6076 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN
SELECT 6077 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN
--MKK, MK
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,94   UNION ALL	--MK	--MKK, MK
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MKK, MK
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,94   UNION ALL	--MK	--MKK, MK
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,94   UNION ALL	--MK	--MKK, MK
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MKK, MK
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MKK, MK
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MKK, MK
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,70   UNION ALL	--MKK	--MKK, MK
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,70   UNION ALL	--MKK	--MKK, MK
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,70   UNION ALL	--MKK	--MKK, MK
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MKK, MK
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MKK, MK
--TB
SELECT 6071 ,'4'    ,'4000'    ,4    ,4000    ,4    UNION ALL	--TB	--TB
SELECT 6072 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--TB
SELECT 6073 ,'4'    ,'4000'    ,4    ,4000    ,4    UNION ALL	--TB	--TB
SELECT 6074 ,'4'    ,'4000'    ,4    ,4000    ,4    UNION ALL	--TB	--TB
SELECT 6075 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--TB
SELECT 6076 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--TB
SELECT 6077 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--TB
--US$, USDT
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--US$, USDT
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$, USDT
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--US$, USDT
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--US$, USDT
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$, USDT
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$, USDT
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$, USDT
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,96   UNION ALL	--USDT	--US$, USDT
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--US$, USDT
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,96   UNION ALL	--USDT	--US$, USDT
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,96   UNION ALL	--USDT	--US$, USDT
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--US$, USDT
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--US$, USDT
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,96				--USDT	--US$, USDT


UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #Dep_StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 6001)

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