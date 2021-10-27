/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211019
	Task:  Add new 4 games for AdvantPlay Deposit RedmineID:#163229
	DB: DBCust/CustDB
	P/s : Add new 4 games for AdvantPlay  Deposit
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(28))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--INR
SELECT 7713 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7714 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7715 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7716 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
--IN
SELECT 7713 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7714 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7715 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7716 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
--INH,DON
SELECT 7713 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7714 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7715 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7716 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7713 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7714 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7715 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7716 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
--RM
SELECT 7713 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7714 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7715 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7716 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
--RMB
SELECT 7713 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7714 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7715 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7716 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7713 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7714 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7715 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7716 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 7713 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7714 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7715 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7716 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
--US$,USDTT
SELECT 7713 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7714 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7715 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7716 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7713 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7714 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7715 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7716 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
--WON				  
SELECT 7713 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7714 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7715 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7716 ,'50'   ,'70000'   ,50   ,70000   ,45   			--Won	--WON

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
WHERE s.GameTypeID = 7701)

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