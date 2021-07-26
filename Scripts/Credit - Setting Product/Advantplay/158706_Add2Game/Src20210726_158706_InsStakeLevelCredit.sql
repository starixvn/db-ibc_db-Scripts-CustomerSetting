/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210726
	Task:  AdvantPlay - Incorporate 2 new games King of Glory & Bubble Dragon UUS  RedmineID:#158706
	DB: DBCust/CustDB
	P/s : Add stakelevel group 2 new games UUS
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(27))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--IN,IND,IDD,IDR,DDD
SELECT 7711 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7712 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7711 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7712 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7711 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7712 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7711 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7712 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7711 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7712 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
--INH,DON
SELECT 7711 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7712 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7711 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7712 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
--RM,HKK
SELECT 7711 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7712 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7711 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7712 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
--RMB
SELECT 7711 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7712 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
--THB
SELECT 7711 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7712 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
--US$,Yen,$US,UT,USD
SELECT 7711 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7712 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7711 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7712 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7711 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7712 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7711 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7712 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7711 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7712 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
--Won
SELECT 7711 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7712 ,'250'  ,'100000'  ,250  ,100000  ,45				--Won	--WON

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MinStake > 999

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
WHERE s.GameTypeID = 7701)

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
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 