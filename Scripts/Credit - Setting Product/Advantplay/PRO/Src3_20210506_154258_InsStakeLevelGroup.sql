/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210506
	Task:  Insert Setting StakeLevelGroupDetail for AdvantPlay RedmineID:#154258
	DB: DBCust/CustDB
	P/s : Step 3 Insert Setting StakeLevelGroupDetail AdvantPlay
*/
PRINT N'Step 3: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(27))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--IN,IND,IDD,IDR,DDD
SELECT 7701 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7702 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7703 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7704 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7705 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7706 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7707 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7708 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7709 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7710 ,'3'    ,'600'     ,3    ,600     ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD
SELECT 7701 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7702 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7703 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7704 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7705 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7706 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7707 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7708 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7709 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7710 ,'3'    ,'600'     ,3    ,600     ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD
SELECT 7701 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7702 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7703 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7704 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7705 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7706 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7707 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7708 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7709 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7710 ,'3'    ,'600'     ,3    ,600     ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD
SELECT 7701 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7702 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7703 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7704 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7705 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7706 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7707 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7708 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7709 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7710 ,'3'    ,'600'     ,3    ,600     ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD
SELECT 7701 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7702 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7703 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7704 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7705 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7706 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7707 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7708 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7709 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
SELECT 7710 ,'3'    ,'600'     ,3    ,600     ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD
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
--RM,HKK
SELECT 7701 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7702 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7703 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7704 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7705 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7706 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7707 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7708 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7709 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7710 ,'1'    ,'200'     ,1    ,200     ,67   UNION ALL	--HKK	--RM,HKK
SELECT 7701 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7702 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7703 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7704 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7705 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7706 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7707 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7708 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7709 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
SELECT 7710 ,'1'    ,'200'     ,1    ,200     ,2    UNION ALL	--RM	--RM,HKK
--RMB
SELECT 7701 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7702 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7703 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7704 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7705 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7706 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7707 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7708 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7709 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
SELECT 7710 ,'2'    ,'1000'    ,2    ,1000    ,13   UNION ALL	--RMB	--RMB
--THB
SELECT 7701 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7702 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7703 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7704 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7705 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7706 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7707 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7708 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7709 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
SELECT 7710 ,'5'    ,'1500'    ,5    ,1500    ,43   UNION ALL	--THB	--THB
--US$,Yen,$US,UT,USD
SELECT 7701 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7702 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7703 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7704 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7705 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7706 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7707 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7708 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7709 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7710 ,'0.25' ,'100'     ,0.25 ,100     ,35   UNION ALL	--$US	--US$,Yen,$US,UT,USD
SELECT 7701 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7702 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7703 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7704 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7705 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7706 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7707 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7708 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7709 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7710 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--US$,Yen,$US,UT,USD
SELECT 7701 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7702 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7703 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7704 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7705 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7706 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7707 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7708 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7709 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7710 ,'0.25' ,'100'     ,0.25 ,100     ,95   UNION ALL	--USD	--US$,Yen,$US,UT,USD
SELECT 7701 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7702 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7703 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7704 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7705 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7706 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7707 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7708 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7709 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7710 ,'0.25' ,'100'     ,0.25 ,100     ,64   UNION ALL	--UT	--US$,Yen,$US,UT,USD
SELECT 7701 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7702 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7703 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7704 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7705 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7706 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7707 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7708 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7709 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
SELECT 7710 ,'0.25' ,'100'     ,0.25 ,100     ,16   UNION ALL	--Yen	--US$,Yen,$US,UT,USD
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
SELECT 7710 ,'250'  ,'100000'  ,250  ,100000  ,45	UNION ALL	--Won	--WON
-- Mini Games
SELECT 7711 ,'2'    ,'100'     ,2    ,100     ,35   UNION ALL	--$US	--$US	
SELECT 7711 ,'10'   ,'500'     ,10   ,500     ,81   UNION ALL	--CY	--CY	
SELECT 7711 ,'30'   ,'1700'    ,30   ,1700    ,47   UNION ALL	--DDD	--DDD	
SELECT 7711 ,'2'    ,'100'     ,2    ,100     ,6    UNION ALL	--EURO	--EURO	
SELECT 7711 ,'2'    ,'100'     ,2    ,100     ,12   UNION ALL	--GBP	--GBP	
SELECT 7711 ,'10'   ,'500'     ,10   ,500     ,5    UNION ALL	--HK$	--HK$	
SELECT 7711 ,'10'   ,'500'     ,10   ,500     ,67   UNION ALL	--HKK	--HKK	
SELECT 7711 ,'30'   ,'1700'    ,30   ,1700    ,33   UNION ALL	--IDD	--IDD	
SELECT 7711 ,'30'   ,'1700'    ,30   ,1700    ,34   UNION ALL	--IDR	--IDR	
SELECT 7711 ,'30'   ,'1700'    ,30   ,1700    ,15   UNION ALL	--IN	--IN	
SELECT 7711 ,'30'   ,'1700'    ,30   ,1700    ,22   UNION ALL	--IND	--IND	
SELECT 7711 ,'50'   ,'2800'    ,50   ,2800    ,51   UNION ALL	--INH	--INH	
SELECT 7711 ,'10'   ,'500'     ,10   ,500     ,71   UNION ALL	--KHR	--KHR	
SELECT 7711 ,'5'    ,'150'     ,5    ,150     ,69   UNION ALL	--MMK	--MMK	
SELECT 7711 ,'10'   ,'500'     ,10   ,500     ,2    UNION ALL	--RM	--RM	
SELECT 7711 ,'10'   ,'500'     ,10   ,500     ,13   UNION ALL	--RMB	--RMB	
SELECT 7711 ,'100'  ,'5000'    ,100  ,5000    ,43   UNION ALL	--THB	--THB	
SELECT 7711 ,'2'    ,'100'     ,2    ,100     ,3    UNION ALL	--US$	--US$	
SELECT 7711 ,'2'    ,'100'     ,2    ,100     ,95   UNION ALL	--USD	--USD	
SELECT 7711 ,'2'    ,'100'     ,2    ,100     ,64   UNION ALL	--UT	--UT	
SELECT 7711 ,'3000' ,'150000'  ,3000 ,150000  ,45   UNION ALL	--Won	--Won	
SELECT 7711 ,'2'    ,'100'     ,2    ,100     ,16				--Yen	--Yen	


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
PRINT N'Step 3: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 