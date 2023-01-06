/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date:	 20230106
	Created: Winfred 
	Task:	 #182526 - Macau Games & Saba Casino - Adjust betlimit for 12Bet/BDT currency [redmine : 182526]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT ,DefaultBetType INT, SiteID INT)

								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId,GameGroupID,DefaultBetType,SiteID)
--BDT -- Macau 
SELECT 4043 ,'50'  ,'500'     ,50   ,500       ,97	, 3  ,  4001   , 0   UNION ALL	--BDT
--BDT -- Saba Casino 
SELECT 2101 ,'50'  ,'10000'   ,50   ,10000     ,97	, 35 ,  2101   , 0   UNION ALL	--BDT
SELECT 2103 ,'50'  ,'25000'   ,50   ,10000     ,97	, 35 ,  2101   , 0   UNION ALL	--BDT
SELECT 2104 ,'50'  ,'18750'   ,50   ,7500      ,97	, 35 ,  2101   , 0   UNION ALL	--BDT
SELECT 2105 ,'20'  ,'7500'	  ,20   ,7500      ,97	, 35 ,  2101   , 0   UNION ALL	--BDT
SELECT 2112 ,'50'  ,'10000'   ,50   ,10000     ,97	, 35 ,  2101   , 0   UNION ALL	--BDT
SELECT 2113 ,'50'  ,'18750'   ,50   ,7500      ,97	, 35 ,  2101   , 0   UNION ALL	--BDT
SELECT 2115 ,'20'  ,'12500'   ,20   ,5000      ,97	, 35 ,  2101   , 0   UNION ALL	--BDT
SELECT 2120 ,'50'  ,'10000'   ,50   ,10000     ,97	, 35 ,  2101   , 0   UNION ALL	--BDT
SELECT 2121 ,'50'  ,'10000'   ,50   ,10000     ,97	, 35 ,  2101   , 0				--BDT

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  WHERE t.ExchangeId = s.ExchangeId AND t.GameGroupID = s.GameGroupID 
				AND s.GameTypeID = t.DefaultBetType AND s.SiteID = t.SiteID
			) t
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

DROP TABLE #StakeLevel_Temp