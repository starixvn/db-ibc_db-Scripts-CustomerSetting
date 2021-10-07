/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210924
	Task:  Update Setting StakeLevelGroupDetail for AdvantPlay Deposit RedmineID:#161270
	DB: DBCust/CustDB
	P/s : Update Setting StakeLevelGroupDetail AdvantPlay
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(28))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--INR
SELECT 7701 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7702 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7703 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7704 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7705 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7706 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7707 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7708 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7709 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7710 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7711 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
SELECT 7712 ,'3'    ,'4500'     ,3   ,4500     ,61   UNION ALL	--INR	--INR
--IN
SELECT 7701 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7702 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7703 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7704 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7705 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7706 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7707 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7708 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7709 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7710 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7711 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7712 ,'0.5'  ,'850'     ,0.5  ,850     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
--INH,DON
SELECT 7701 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7702 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7703 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7704 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7705 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7706 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7707 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7708 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7709 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7710 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7711 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7712 ,'1'    ,'1500'    ,1    ,1500    ,7    UNION ALL	--DON	--INH,DON
SELECT 7701 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7702 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7703 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7704 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7705 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7706 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7707 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7708 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7709 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7710 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7711 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
SELECT 7712 ,'1'    ,'1500'    ,1    ,1500    ,51   UNION ALL	--INH	--INH,DON
--RM
SELECT 7701 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7702 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7703 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7704 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7705 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7706 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7707 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7708 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7709 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7710 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7711 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7712 ,'0.25' ,'250'     ,0.25 ,250     ,2    UNION ALL	--RM	--RM,HKK
--RMB
SELECT 7701 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7702 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7703 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7704 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7705 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7706 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7707 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7708 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7709 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7710 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7711 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7712 ,'0.5'  ,'400'     ,0.5  ,400    ,13    UNION ALL	--RMB	--RMB,YUN
SELECT 7701 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7702 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7703 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7704 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7705 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7706 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7707 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7708 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7709 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7710 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7711 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
SELECT 7712 ,'0.5'  ,'400'     ,0.5  ,400    ,66    UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 7701 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7702 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7703 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7704 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7705 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7706 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7707 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7708 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7709 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7710 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7711 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 7712 ,'1'    ,'2000'    ,1    ,2000    ,4    UNION ALL	--TB	--THB
--US$,USDTT
SELECT 7701 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7702 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7703 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7704 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7705 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7706 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7707 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7708 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7709 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7710 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7711 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7712 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USDT
SELECT 7701 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7702 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7703 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7704 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7705 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7706 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7707 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7708 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7709 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7710 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7711 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
SELECT 7712 ,'0.25' ,'50'      ,0.25 ,50      ,96   UNION ALL	--USDT	--US$,Yen,$US,UT,USDT
--WON				  
SELECT 7701 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7702 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7703 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7704 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7705 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7706 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7707 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7708 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7709 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7710 ,'50'   ,'70000'   ,50   ,70000   ,45	UNION ALL	--Won	--WON
SELECT 7711 ,'50'   ,'70000'   ,50   ,70000   ,45   UNION ALL	--Won	--WON
SELECT 7712 ,'50'   ,'70000'   ,50   ,70000   ,45				--Won	--WON




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