/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220324
	Task: PG Soft - Add 9 new games - Credit RedmineID:#169831
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(15))
								
--#region Insert to temp table
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--IN,IND,DDD,IDR,IDD
SELECT 6087 ,'0.5'     ,'100'         ,0.5     ,100         ,47   UNION ALL	--DDD	--IN,IND,DDD,IDR,IDD
SELECT 6088 ,'0.5'     ,'400'         ,0.5     ,400         ,47   UNION ALL	--DDD	--IN,IND,DDD,IDR,IDD
SELECT 6089 ,'0.5'     ,'1000'        ,0.5     ,1000        ,47   UNION ALL	--DDD	--IN,IND,DDD,IDR,IDD
SELECT 6090 ,'0.5'     ,'100'         ,0.5     ,100         ,47   UNION ALL	--DDD	--IN,IND,DDD,IDR,IDD
SELECT 6091 ,'0.5'     ,'100'         ,0.5     ,100         ,47   UNION ALL	--DDD	--IN,IND,DDD,IDR,IDD
SELECT 6092 ,'0.5'     ,'100'         ,0.5     ,100         ,47   UNION ALL	--DDD	--IN,IND,DDD,IDR,IDD
SELECT 6093 ,'0.2'     ,'2000'        ,0.2     ,2000        ,47   UNION ALL	--DDD	--IN,IND,DDD,IDR,IDD
SELECT 6094 ,'0.2'     ,'1000'        ,0.2     ,1000        ,47   UNION ALL	--DDD	--IN,IND,DDD,IDR,IDD
SELECT 6095 ,'0.2'     ,'1000'        ,0.2     ,1000        ,47   UNION ALL	--DDD	--IN,IND,DDD,IDR,IDD
SELECT 6087 ,'0.5'     ,'100'         ,0.5     ,100         ,33   UNION ALL	--IDD	--IN,IND,DDD,IDR,IDD
SELECT 6088 ,'0.5'     ,'400'         ,0.5     ,400         ,33   UNION ALL	--IDD	--IN,IND,DDD,IDR,IDD
SELECT 6089 ,'0.5'     ,'1000'        ,0.5     ,1000        ,33   UNION ALL	--IDD	--IN,IND,DDD,IDR,IDD
SELECT 6090 ,'0.5'     ,'100'         ,0.5     ,100         ,33   UNION ALL	--IDD	--IN,IND,DDD,IDR,IDD
SELECT 6091 ,'0.5'     ,'100'         ,0.5     ,100         ,33   UNION ALL	--IDD	--IN,IND,DDD,IDR,IDD
SELECT 6092 ,'0.5'     ,'100'         ,0.5     ,100         ,33   UNION ALL	--IDD	--IN,IND,DDD,IDR,IDD
SELECT 6093 ,'0.2'     ,'2000'        ,0.2     ,2000        ,33   UNION ALL	--IDD	--IN,IND,DDD,IDR,IDD
SELECT 6094 ,'0.2'     ,'1000'        ,0.2     ,1000        ,33   UNION ALL	--IDD	--IN,IND,DDD,IDR,IDD
SELECT 6095 ,'0.2'     ,'1000'        ,0.2     ,1000        ,33   UNION ALL	--IDD	--IN,IND,DDD,IDR,IDD
SELECT 6087 ,'0.5'     ,'100'         ,0.5     ,100         ,34   UNION ALL	--IDR	--IN,IND,DDD,IDR,IDD
SELECT 6088 ,'0.5'     ,'400'         ,0.5     ,400         ,34   UNION ALL	--IDR	--IN,IND,DDD,IDR,IDD
SELECT 6089 ,'0.5'     ,'1000'        ,0.5     ,1000        ,34   UNION ALL	--IDR	--IN,IND,DDD,IDR,IDD
SELECT 6090 ,'0.5'     ,'100'         ,0.5     ,100         ,34   UNION ALL	--IDR	--IN,IND,DDD,IDR,IDD
SELECT 6091 ,'0.5'     ,'100'         ,0.5     ,100         ,34   UNION ALL	--IDR	--IN,IND,DDD,IDR,IDD
SELECT 6092 ,'0.5'     ,'100'         ,0.5     ,100         ,34   UNION ALL	--IDR	--IN,IND,DDD,IDR,IDD
SELECT 6093 ,'0.2'     ,'2000'        ,0.2     ,2000        ,34   UNION ALL	--IDR	--IN,IND,DDD,IDR,IDD
SELECT 6094 ,'0.2'     ,'1000'        ,0.2     ,1000        ,34   UNION ALL	--IDR	--IN,IND,DDD,IDR,IDD
SELECT 6095 ,'0.2'     ,'1000'        ,0.2     ,1000        ,34   UNION ALL	--IDR	--IN,IND,DDD,IDR,IDD
SELECT 6087 ,'0.5'     ,'100'         ,0.5     ,100         ,15   UNION ALL	--IN	--IN,IND,DDD,IDR,IDD
SELECT 6088 ,'0.5'     ,'400'         ,0.5     ,400         ,15   UNION ALL	--IN	--IN,IND,DDD,IDR,IDD
SELECT 6089 ,'0.5'     ,'1000'        ,0.5     ,1000        ,15   UNION ALL	--IN	--IN,IND,DDD,IDR,IDD
SELECT 6090 ,'0.5'     ,'100'         ,0.5     ,100         ,15   UNION ALL	--IN	--IN,IND,DDD,IDR,IDD
SELECT 6091 ,'0.5'     ,'100'         ,0.5     ,100         ,15   UNION ALL	--IN	--IN,IND,DDD,IDR,IDD
SELECT 6092 ,'0.5'     ,'100'         ,0.5     ,100         ,15   UNION ALL	--IN	--IN,IND,DDD,IDR,IDD
SELECT 6093 ,'0.2'     ,'2000'        ,0.2     ,2000        ,15   UNION ALL	--IN	--IN,IND,DDD,IDR,IDD
SELECT 6094 ,'0.2'     ,'1000'        ,0.2     ,1000        ,15   UNION ALL	--IN	--IN,IND,DDD,IDR,IDD
SELECT 6095 ,'0.2'     ,'1000'        ,0.2     ,1000        ,15   UNION ALL	--IN	--IN,IND,DDD,IDR,IDD
SELECT 6087 ,'0.5'     ,'100'         ,0.5     ,100         ,22   UNION ALL	--IND	--IN,IND,DDD,IDR,IDD
SELECT 6088 ,'0.5'     ,'400'         ,0.5     ,400         ,22   UNION ALL	--IND	--IN,IND,DDD,IDR,IDD
SELECT 6089 ,'0.5'     ,'1000'        ,0.5     ,1000        ,22   UNION ALL	--IND	--IN,IND,DDD,IDR,IDD
SELECT 6090 ,'0.5'     ,'100'         ,0.5     ,100         ,22   UNION ALL	--IND	--IN,IND,DDD,IDR,IDD
SELECT 6091 ,'0.5'     ,'100'         ,0.5     ,100         ,22   UNION ALL	--IND	--IN,IND,DDD,IDR,IDD
SELECT 6092 ,'0.5'     ,'100'         ,0.5     ,100         ,22   UNION ALL	--IND	--IN,IND,DDD,IDR,IDD
SELECT 6093 ,'0.2'     ,'2000'        ,0.2     ,2000        ,22   UNION ALL	--IND	--IN,IND,DDD,IDR,IDD
SELECT 6094 ,'0.2'     ,'1000'        ,0.2     ,1000        ,22   UNION ALL	--IND	--IN,IND,DDD,IDR,IDD
SELECT 6095 ,'0.2'     ,'1000'        ,0.2     ,1000        ,22   UNION ALL	--IND	--IN,IND,DDD,IDR,IDD
--MMK
SELECT 6087 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--MMK
SELECT 6088 ,'0.25'    ,'100'         ,0.25    ,100         ,69   UNION ALL	--MMK	--MMK  
SELECT 6089 ,'0.2'     ,'200'         ,0.2     ,200         ,69   UNION ALL	--MMK	--MMK
SELECT 6090 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--MMK  
SELECT 6091 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--MMK
SELECT 6092 ,'0.2'     ,'20'          ,0.2     ,20          ,69   UNION ALL	--MMK	--MMK  
SELECT 6093 ,'0.25'    ,'250'         ,0.25    ,250         ,69   UNION ALL	--MMK	--MMK
SELECT 6094 ,'0.2'     ,'100'         ,0.2     ,100         ,69   UNION ALL	--MMK	--MMK  
SELECT 6095 ,'0.2'     ,'100'         ,0.2     ,100         ,69   UNION ALL	--MMK	--MMK
--THB
SELECT 6087 ,'4'       ,'400'         ,4       ,400         ,43   UNION ALL	--THB	--THB
SELECT 6088 ,'5'       ,'2000'        ,5       ,2000        ,43   UNION ALL	--THB	--THB
SELECT 6089 ,'4'       ,'4000'        ,4       ,4000        ,43   UNION ALL	--THB	--THB
SELECT 6090 ,'4'       ,'400'         ,4       ,400         ,43   UNION ALL	--THB	--THB
SELECT 6091 ,'4'       ,'400'         ,4       ,400         ,43   UNION ALL	--THB	--THB
SELECT 6092 ,'4'       ,'400'         ,4       ,400         ,43   UNION ALL	--THB	--THB
SELECT 6093 ,'1'       ,'5000'        ,1       ,5000        ,43   UNION ALL	--THB	--THB
SELECT 6094 ,'1'       ,'2000'        ,1       ,2000        ,43   UNION ALL	--THB	--THB
SELECT 6095 ,'1'       ,'2000'        ,1       ,2000        ,43   UNION ALL	--THB	--THB
--USD , YEN , UT , $US , US$
SELECT 6087 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , US$
SELECT 6088 ,'0.25'    ,'100'         ,0.25    ,100         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , US$ 
SELECT 6089 ,'0.2'     ,'200'         ,0.2     ,200         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , US$
SELECT 6090 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , US$ 
SELECT 6091 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , US$
SELECT 6092 ,'0.2'     ,'20'          ,0.2     ,20          ,35   UNION ALL	--$US	--USD , YEN , UT , $US , US$ 
SELECT 6093 ,'0.25'    ,'250'         ,0.25    ,250         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , US$
SELECT 6094 ,'0.2'     ,'100'         ,0.2     ,100         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , US$ 
SELECT 6095 ,'0.2'     ,'100'         ,0.2     ,100         ,35   UNION ALL	--$US	--USD , YEN , UT , $US , US$
SELECT 6087 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , US$
SELECT 6088 ,'0.25'    ,'100'         ,0.25    ,100         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , US$ 
SELECT 6089 ,'0.2'     ,'200'         ,0.2     ,200         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , US$
SELECT 6090 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , US$ 
SELECT 6091 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , US$
SELECT 6092 ,'0.2'     ,'20'          ,0.2     ,20          ,3    UNION ALL	--US$	--USD , YEN , UT , $US , US$ 
SELECT 6093 ,'0.25'    ,'250'         ,0.25    ,250         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , US$
SELECT 6094 ,'0.2'     ,'100'         ,0.2     ,100         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , US$ 
SELECT 6095 ,'0.2'     ,'100'         ,0.2     ,100         ,3    UNION ALL	--US$	--USD , YEN , UT , $US , US$
SELECT 6087 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , US$
SELECT 6088 ,'0.25'    ,'100'         ,0.25    ,100         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , US$ 
SELECT 6089 ,'0.2'     ,'200'         ,0.2     ,200         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , US$
SELECT 6090 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , US$ 
SELECT 6091 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , US$
SELECT 6092 ,'0.2'     ,'20'          ,0.2     ,20          ,95   UNION ALL	--USD	--USD , YEN , UT , $US , US$ 
SELECT 6093 ,'0.25'    ,'250'         ,0.25    ,250         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , US$
SELECT 6094 ,'0.2'     ,'100'         ,0.2     ,100         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , US$ 
SELECT 6095 ,'0.2'     ,'100'         ,0.2     ,100         ,95   UNION ALL	--USD	--USD , YEN , UT , $US , US$
SELECT 6087 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , US$
SELECT 6088 ,'0.25'    ,'100'         ,0.25    ,100         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , US$ 
SELECT 6089 ,'0.2'     ,'200'         ,0.2     ,200         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , US$
SELECT 6090 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , US$ 
SELECT 6091 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , US$
SELECT 6092 ,'0.2'     ,'20'          ,0.2     ,20          ,64   UNION ALL	--UT	--USD , YEN , UT , $US , US$ 
SELECT 6093 ,'0.25'    ,'250'         ,0.25    ,250         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , US$
SELECT 6094 ,'0.2'     ,'100'         ,0.2     ,100         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , US$ 
SELECT 6095 ,'0.2'     ,'100'         ,0.2     ,100         ,64   UNION ALL	--UT	--USD , YEN , UT , $US , US$
SELECT 6087 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , US$
SELECT 6088 ,'0.25'    ,'100'         ,0.25    ,100         ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , US$ 
SELECT 6089 ,'0.2'     ,'200'         ,0.2     ,200         ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , US$
SELECT 6090 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , US$ 
SELECT 6091 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , US$
SELECT 6092 ,'0.2'     ,'20'          ,0.2     ,20          ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , US$ 
SELECT 6093 ,'0.25'    ,'250'         ,0.25    ,250         ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , US$
SELECT 6094 ,'0.2'     ,'100'         ,0.2     ,100         ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , US$ 
SELECT 6095 ,'0.2'     ,'100'         ,0.2     ,100         ,16				--Yen	--USD , YEN , UT , $US , US$

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


