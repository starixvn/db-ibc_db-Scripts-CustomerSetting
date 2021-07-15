/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20210531
	Task:	 Insert Setting StakeLevelGroupDetail [AdvantPlay] - deposit RedmineID:#154258
	DB:		 DBCust/CustDB
	P/s : Step 3 Insert Setting StakeLevelGroupDetail
*/
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(28))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--INR
SELECT 7701 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7702 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7703 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7704 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7705 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7706 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7707 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7708 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7709 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
SELECT 7710 ,'20'   ,'15000'   ,20   ,15000   ,61   UNION ALL	--INR	--INR
--IN
SELECT 7701 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7702 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7703 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7704 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7705 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7706 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7707 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7708 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7709 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
SELECT 7710 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN
--INH,DON
SELECT 7701 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7702 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7703 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7704 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7705 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7706 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7707 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7708 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7709 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7710 ,'5'    ,'1500'    ,5    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7701 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7702 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7703 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7704 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7705 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7706 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7707 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7708 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7709 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7710 ,'5'    ,'1500'    ,5    ,1500    ,51   UNION ALL	--INH	--INH,DON
--RM
SELECT 7701 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7702 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7703 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7704 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7705 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7706 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7707 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7708 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7709 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
SELECT 7710 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM
--RMB,YUN
SELECT 7701 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7702 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7703 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7704 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7705 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7706 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7707 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7708 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7709 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7710 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 7701 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7702 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7703 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7704 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7705 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7706 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7707 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7708 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7709 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 7710 ,'2'    ,'1000'    ,2    ,1000    ,66   UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 7701 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7702 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7703 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7704 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7705 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7706 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7707 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7708 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7709 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
SELECT 7710 ,'5'    ,'1500'    ,5    ,1500    ,4    UNION ALL	--TB	--TB
--US$,USDT
SELECT 7701 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7702 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7703 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7704 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7705 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7706 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7707 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7708 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7709 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7710 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,USDT
SELECT 7701 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7702 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7703 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7704 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7705 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7706 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7707 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7708 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7709 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
SELECT 7710 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--US$,USDT
--WON
SELECT 7701 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7702 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7703 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7704 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7705 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7706 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7707 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7708 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7709 ,'250'  ,'100000'  ,250  ,100000  ,45   UNION ALL	--Won	--WON
SELECT 7710 ,'250'  ,'100000'  ,250  ,100000  ,45				--Won	--WON


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
PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 