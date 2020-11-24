/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201124
	Task:  Update Fifty Dragons and Fifty Lions [Joker] - deposit RedmineID:#145829
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--EURO
SELECT 6406 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 6407 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--EURO
--DDD
SELECT 6406 ,'0.25' ,'150'     ,0.25 ,150     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.25' ,'150'     ,0.25 ,150     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
--IDD
SELECT 6406 ,'0.25' ,'150'     ,0.25 ,150     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.25' ,'150'     ,0.25 ,150     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
--IDR
SELECT 6406 ,'0.25' ,'150'     ,0.25 ,150     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.25' ,'150'     ,0.25 ,150     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
--IN
SELECT 6406 ,'0.25' ,'150'     ,0.25 ,150     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.25' ,'150'     ,0.25 ,150     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
--IND
SELECT 6406 ,'0.25' ,'150'     ,0.25 ,150     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.25' ,'150'     ,0.25 ,150     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
--UUS
SELECT 6406 ,'0.25' ,'150'     ,0.25 ,150     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6407 ,'0.25' ,'150'     ,0.25 ,150     ,20   UNION ALL	--UUS	--IN,IND,IDD,IDR,DDD,UUS
--INR
SELECT 6406 ,'2500' ,'50000'   ,2500 ,50000   ,61   UNION ALL	--INR	--INR
SELECT 6407 ,'2500' ,'50000'   ,2500 ,50000   ,61   UNION ALL	--INR	--INR
--MMK
SELECT 6406 ,'250'  ,'15000'   ,250  ,15000   ,69   UNION ALL	--MMK	--MMK
SELECT 6407 ,'250'  ,'15000'   ,250  ,15000   ,69   UNION ALL	--MMK	--MMK
--HK$
SELECT 6406 ,'0.25' ,'25'      ,0.25 ,25      ,5    UNION ALL	--HK$	--RM,HK$,HKK
SELECT 6407 ,'0.25' ,'25'      ,0.25 ,25      ,5    UNION ALL	--HK$	--RM,HK$,HKK
--HKK
SELECT 6406 ,'0.25' ,'25'      ,0.25 ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6407 ,'0.25' ,'25'      ,0.25 ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
--RM
SELECT 6406 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6407 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
--RMB
SELECT 6406 ,'25'   ,'12500'   ,25   ,12500   ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6407 ,'25'   ,'12500'   ,25   ,12500   ,13   UNION ALL	--RMB	--RMB,YUN
--YUN
SELECT 6406 ,'25'   ,'12500'   ,25   ,12500   ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6407 ,'25'   ,'12500'   ,25   ,12500   ,66   UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 6406 ,'5'    ,'150'     ,5    ,150     ,4    UNION ALL	--TB	--TB,THB
SELECT 6407 ,'5'    ,'150'     ,5    ,150     ,4    UNION ALL	--TB	--TB,THB
--THB
SELECT 6406 ,'5'    ,'150'     ,5    ,150     ,43   UNION ALL	--THB	--TB,THB
SELECT 6407 ,'5'    ,'150'     ,5    ,150     ,43   UNION ALL	--THB	--TB,THB
--$US
SELECT 6406 ,'0.25' ,'25'      ,0.25 ,25      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.25' ,'25'      ,0.25 ,25      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
--US$
SELECT 6406 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
--USD
SELECT 6406 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
--UT
SELECT 6406 ,'0.25' ,'25'      ,0.25 ,25      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.25' ,'25'      ,0.25 ,25      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
--Yen
SELECT 6406 ,'0.25' ,'25'      ,0.25 ,25      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6407 ,'0.25' ,'25'      ,0.25 ,25      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
--Won
SELECT 6406 ,'250'  ,'15000'   ,250  ,15000   ,45   UNION ALL	--Won	--Won
SELECT 6407 ,'250'  ,'15000'   ,250  ,15000   ,45				--Won	--Won

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MinStake > 999

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
WHERE s.GameTypeID = 6401)

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
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 