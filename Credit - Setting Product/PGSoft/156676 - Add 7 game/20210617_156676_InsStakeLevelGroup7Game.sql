/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210617
	Task:  Add 7 new game [PG Game]  - Credit real currency RedmineID:#156676
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(15))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--IN,IND,IDD,IDR,DDD
SELECT 6071 ,'1'    ,'1000'    ,1    ,1000    ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 6072 ,'1'    ,'100'     ,1    ,100     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 6073 ,'1'    ,'1000'    ,1    ,1000    ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 6074 ,'1'    ,'1000'    ,1    ,1000    ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 6075 ,'1'    ,'100'     ,1    ,100     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 6076 ,'1'    ,'100'     ,1    ,100     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 6077 ,'1'    ,'100'     ,1    ,100     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 6071 ,'1'    ,'1000'    ,1    ,1000    ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 6072 ,'1'    ,'100'     ,1    ,100     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 6073 ,'1'    ,'1000'    ,1    ,1000    ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 6074 ,'1'    ,'1000'    ,1    ,1000    ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 6075 ,'1'    ,'100'     ,1    ,100     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 6076 ,'1'    ,'100'     ,1    ,100     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 6077 ,'1'    ,'100'     ,1    ,100     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 6071 ,'1'    ,'1000'    ,1    ,1000    ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 6072 ,'1'    ,'100'     ,1    ,100     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 6073 ,'1'    ,'1000'    ,1    ,1000    ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 6074 ,'1'    ,'1000'    ,1    ,1000    ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 6075 ,'1'    ,'100'     ,1    ,100     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 6076 ,'1'    ,'100'     ,1    ,100     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 6077 ,'1'    ,'100'     ,1    ,100     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 6071 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 6072 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 6073 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 6074 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 6075 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 6076 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 6077 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 6071 ,'1'    ,'1000'    ,1    ,1000    ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 6072 ,'1'    ,'100'     ,1    ,100     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 6073 ,'1'    ,'1000'    ,1    ,1000    ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 6074 ,'1'    ,'1000'    ,1    ,1000    ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 6075 ,'1'    ,'100'     ,1    ,100     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 6076 ,'1'    ,'100'     ,1    ,100     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 6077 ,'1'    ,'100'     ,1    ,100     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
--MMK
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,69   UNION ALL	--MMK	--MMK
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL	--MMK	--MMK
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,69   UNION ALL	--MMK	--MMK
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,69   UNION ALL	--MMK	--MMK
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL	--MMK	--MMK
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL	--MMK	--MMK
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL	--MMK	--MMK
--THB
SELECT 6071 ,'4'    ,'4000'    ,4    ,4000    ,43   UNION ALL	--THB	--THB
SELECT 6072 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL	--THB	--THB
SELECT 6073 ,'4'    ,'4000'    ,4    ,4000    ,43   UNION ALL	--THB	--THB
SELECT 6074 ,'4'    ,'4000'    ,4    ,4000    ,43   UNION ALL	--THB	--THB
SELECT 6075 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL	--THB	--THB
SELECT 6076 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL	--THB	--THB
SELECT 6077 ,'4'    ,'400'     ,4    ,400     ,43   UNION ALL	--THB	--THB
--US$, Yen, $US, UT, USD
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--US$, Yen, $US, UT, USD
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$, Yen, $US, UT, USD
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--US$, Yen, $US, UT, USD
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--US$, Yen, $US, UT, USD
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--US$, Yen, $US, UT, USD
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,16				--Yen	--US$, Yen, $US, UT, USD

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