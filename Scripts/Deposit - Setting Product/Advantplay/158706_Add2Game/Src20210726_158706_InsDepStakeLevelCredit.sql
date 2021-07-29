/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210726
	Task:  AdvantPlay - Incorporate 2 new games King of Glory & Bubble Dragon - real currency Deposit RedmineID:#158706
	DB: DBCust/CustDB
	P/s : Add stakelevel group 2 new games real currency - Deposit
*/
PRINT N'Step 1: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(28))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--INR
SELECT 7711 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7712 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
--IN
SELECT 7711 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7712 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
--INH,DON
SELECT 7711 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7712 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7711 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7712 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
--RM
SELECT 7711 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7712 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
--RMB,YUN
SELECT 7711 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7712 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7711 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7712 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 7711 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7712 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
--USDT	--US$,USDT
SELECT 7711 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7712 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7711 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7712 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
--Won
SELECT 7711 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7712 ,'250'  ,'100000'  ,250  ,100000  ,45				--Won	--WON


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
PRINT N'Step 1: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 