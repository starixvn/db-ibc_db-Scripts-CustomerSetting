/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211110
	Task: PG Soft - Add 9 new games - Credit RedmineID:#163595
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(15))
								

INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
-- USD
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--USD
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--USD
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--USD
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--USD
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,35   UNION ALL	--$US	--USD
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--USD
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,35   UNION ALL	--$US	--USD
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,35   UNION ALL	--$US	--USD
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--USD
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--USD
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--USD
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--USD
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--USD
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--USD
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--USD
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--USD
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--USD
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,95   UNION ALL	--USD	--USD
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--USD
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,95   UNION ALL	--USD	--USD
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,95   UNION ALL	--USD	--USD
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--USD
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--USD
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--USD
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--USD
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--USD
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,64   UNION ALL	--UT	--USD
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--USD
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,64   UNION ALL	--UT	--USD
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,64   UNION ALL	--UT	--USD
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--USD
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--USD
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--USD
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--USD
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--USD
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,16   UNION ALL	--Yen	--USD
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--USD
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,16   UNION ALL	--Yen	--USD
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,16   UNION ALL	--Yen	--USD
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--USD
--IDR
SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL	--DDD	--IDR
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,47   UNION ALL	--DDD	--IDR
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL	--DDD	--IDR
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL	--DDD	--IDR
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--IDR
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL	--DDD	--IDR
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,47   UNION ALL	--DDD	--IDR
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,47   UNION ALL	--DDD	--IDR
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,47   UNION ALL	--DDD	--IDR
SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL	--IDD	--IDR
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,33   UNION ALL	--IDD	--IDR
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL	--IDD	--IDR
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL	--IDD	--IDR
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--IDR
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL	--IDD	--IDR
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,33   UNION ALL	--IDD	--IDR
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,33   UNION ALL	--IDD	--IDR
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,33   UNION ALL	--IDD	--IDR
SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL	--IDR	--IDR
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,34   UNION ALL	--IDR	--IDR
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL	--IDR	--IDR
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL	--IDR	--IDR
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--IDR
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL	--IDR	--IDR
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,34   UNION ALL	--IDR	--IDR
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,34   UNION ALL	--IDR	--IDR
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,34   UNION ALL	--IDR	--IDR
SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,15   UNION ALL	--IN	--IDR
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--IDR
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,15   UNION ALL	--IN	--IDR
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--IDR
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL	--IND	--IDR
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,22   UNION ALL	--IND	--IDR
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL	--IND	--IDR
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL	--IND	--IDR
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--IDR
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL	--IND	--IDR
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,22   UNION ALL	--IND	--IDR
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,22   UNION ALL	--IND	--IDR
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,22   UNION ALL	--IND	--IDR
--THB
SELECT 6078 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL	--THB	--THB
SELECT 6079 ,'5'    ,'2000'    ,5    ,2000    ,43   UNION ALL	--THB	--THB
SELECT 6080 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL	--THB	--THB
SELECT 6081 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL	--THB	--THB
SELECT 6082 ,'4'    ,'4000'    ,4    ,4000    ,43   UNION ALL	--THB	--THB
SELECT 6083 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL	--THB	--THB
SELECT 6084 ,'4'    ,'2000'    ,4    ,2000    ,43   UNION ALL	--THB	--THB
SELECT 6085 ,'4'    ,'4000'    ,4    ,4000    ,43   UNION ALL	--THB	--THB
SELECT 6086 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL	--THB	--THB
--MMK
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL	--MMK	--MMK
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,69   UNION ALL	--MMK	--MMK
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL	--MMK	--MMK
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL	--MMK	--MMK
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,69   UNION ALL	--MMK	--MMK
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL	--MMK	--MMK
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,69   UNION ALL	--MMK	--MMK
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,69   UNION ALL	--MMK	--MMK
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,69   			--MMK	--MMK

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

--The purpose is to have all games from PG Soft will start at min bet 0.50 on Indonesia Credit

CREATE TABLE #StakeLevel_Upd (GameTypeID INT,MinStake float)
INSERT INTO #StakeLevel_Upd(GameTypeID,MinStake )
SELECT  6001 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6002 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6003 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6004 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6005 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6006 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6007 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6008 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6009 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6010 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6011 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6012 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6013 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6014 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6015 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6016 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6017 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6018 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6019 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6020 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6021 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6024 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6025 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6026 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6027 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6028 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6031 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6032 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6034 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6036 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6037 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6038 AS GameTypeID   ,0.1 AS MinStake UNION ALL
SELECT  6039 AS GameTypeID   ,0.45 AS MinStake UNION ALL
SELECT  6040 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6041 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6042 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6043 AS GameTypeID   ,0.45 AS MinStake UNION ALL
SELECT  6044 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6045 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6046 AS GameTypeID   ,0.45 AS MinStake UNION ALL
SELECT  6047 AS GameTypeID   ,0.45 AS MinStake UNION ALL
SELECT  6048 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6050 AS GameTypeID   ,0.3 AS MinStake UNION ALL
SELECT  6051 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6052 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6053 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6055 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6056 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6057 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6058 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6059 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6060 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6061 AS GameTypeID   ,0.2 AS MinStake UNION ALL
SELECT  6062 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6063 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6064 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6065 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6066 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6067 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6068 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6069 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6070 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6071 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6072 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6073 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6074 AS GameTypeID   ,0.5 AS MinStake UNION ALL
SELECT  6075 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6076 AS GameTypeID   ,0.4 AS MinStake UNION ALL
SELECT  6077 AS GameTypeID   ,0.4 AS MinStake 

INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
SELECT g.GameTypeID,CAST (u.MinStake AS VARCHAR(10)) AS  MinLabel, 
g.MaxLabel,u.MinStake AS MinStake, g.MaxStake,s.ExchangeId 
FROM StakeLevel s WITH(NOLOCK)
INNER JOIN StakeLevelGroupDetail g WITH(NOLOCK) ON s.StakeLevelID = g.StakeLevelID
INNER JOIN #StakeLevel_Upd u ON g.GameTypeID = u.GameTypeID
WHERE s.GameTypeID = 6001 
AND GameGroupID = 15 AND s.ExchangeId IN (15,22,33,34,47) --IN,IND,IDD,IDR,DDD

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
DROP TABLE #StakeLevel_Upd


