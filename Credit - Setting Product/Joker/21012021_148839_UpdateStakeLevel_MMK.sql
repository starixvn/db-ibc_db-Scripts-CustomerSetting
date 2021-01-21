/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210121
	Task:  Update StakeLevelGroupDetail [Joker]  currency MMK - Credit RedmineID:#148839
	DB: DBCust/CustDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--MMK
SELECT 6401 ,'0.09'		,'5.4'		,0.09   ,5.4    ,69   UNION ALL	--MMK	--MMK
SELECT 6402 ,'0.1'		,'6'		,0.1	,6		,69   UNION ALL	--MMK	--MMK
SELECT 6403 ,'0.1'		,'6'		,0.1	,6		,69   UNION ALL	--MMK	--MMK
SELECT 6404 ,'0.2'		,'12'		,0.2	,12		,69   UNION ALL	--MMK	--MMK
SELECT 6405 ,'0.1'		,'6'		,0.1	,6		,69   UNION ALL	--MMK	--MMK
SELECT 6406 ,'0.25'		,'15'		,0.25	,15		,69   UNION ALL	--MMK	--MMK
SELECT 6407 ,'0.25'		,'15'		,0.25	,15		,69   UNION ALL	--MMK	--MMK
SELECT 6408 ,'0.2'		,'6'		,0.2	,6		,69   UNION ALL	--MMK	--MMK
SELECT 6409 ,'0.1'		,'6'		,0.1	,6		,69   UNION ALL	--MMK	--MMK
SELECT 6410 ,'0.1'		,'6'		,0.1	,6		,69   UNION ALL	--MMK	--MMK
SELECT 6411 ,'0.1'		,'6'		,0.1	,6		,69   UNION ALL	--MMK	--MMK
SELECT 6412 ,'0.05'		,'3'		,0.05   ,3		,69				--MMK	--MMK


;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 6401)

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
