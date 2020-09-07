/*
	Date: 20200610
	Created: Winfred 
	Task:  Pragmatic - Integrate 11 new games for Cash - Real Currency RedmineID:#140578
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--GBP
SELECT 4232 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4233 ,'0.25' ,'25'      ,0.25 ,25      ,12   UNION ALL	--GBP	--GBP
SELECT 4234 ,'0.2'  ,'8'       ,0.2  ,8       ,12   UNION ALL	--GBP	--GBP
SELECT 4235 ,'0.25' ,'10'      ,0.25 ,10      ,12   UNION ALL	--GBP	--GBP
SELECT 4236 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4237 ,'0.09' ,'5'       ,0.09 ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4238 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4239 ,'0.1'  ,'2'       ,0.1  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4240 ,'0.05' ,'10'      ,0.05 ,10      ,12   UNION ALL	--GBP	--GBP
SELECT 4241 ,'0.1'  ,'0'       ,0.1  ,0       ,12   UNION ALL	--GBP	--GBP
SELECT 4242 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
--IDR
SELECT 4232 ,'1.8'  ,'180'     ,1.8  ,180     ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4233 ,'2.25' ,'225'     ,2.25 ,225     ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4234 ,'1.8'  ,'90'      ,1.8  ,90      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4235 ,'2.25' ,'113'     ,2.25 ,113     ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4236 ,'1.8'  ,'72'      ,1.8  ,72      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4237 ,'0.81' ,'32'      ,0.81 ,32      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4238 ,'1.8'  ,'180'     ,1.8  ,180     ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4239 ,'0.9'  ,'18'      ,0.9  ,18      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4240 ,'0.45' ,'90'      ,0.45 ,90      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4241 ,'0.9'  ,'360'     ,0.9  ,360     ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4242 ,'1'    ,'18'      ,1    ,18      ,34   UNION ALL	--IDR	--IDR, IN
--IN
SELECT 4232 ,'1.8'  ,'180'     ,1.8  ,180     ,15   UNION ALL	--IN	--IDR, IN
SELECT 4233 ,'2.25' ,'225'     ,2.25 ,225     ,15   UNION ALL	--IN	--IDR, IN
SELECT 4234 ,'1.8'  ,'90'      ,1.8  ,90      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4235 ,'2.25' ,'113'     ,2.25 ,113     ,15   UNION ALL	--IN	--IDR, IN
SELECT 4236 ,'1.8'  ,'72'      ,1.8  ,72      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4237 ,'0.81' ,'32'      ,0.81 ,32      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4238 ,'1.8'  ,'180'     ,1.8  ,180     ,15   UNION ALL	--IN	--IDR, IN
SELECT 4239 ,'0.9'  ,'18'      ,0.9  ,18      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4240 ,'0.45' ,'90'      ,0.45 ,90      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4241 ,'0.9'  ,'360'     ,0.9  ,360     ,15   UNION ALL	--IN	--IDR, IN
SELECT 4242 ,'1'    ,'18'      ,1    ,18      ,15   UNION ALL	--IN	--IDR, IN
--INH
SELECT 4232 ,'2'    ,'360'     ,2    ,360     ,51   UNION ALL	--INH	--INH,VND
SELECT 4233 ,'2.5'  ,'450'     ,2.5  ,450     ,51   UNION ALL	--INH	--INH,VND
SELECT 4234 ,'2'    ,'120'     ,2    ,120     ,51   UNION ALL	--INH	--INH,VND
SELECT 4235 ,'2.5'  ,'180'     ,2.5  ,180     ,51   UNION ALL	--INH	--INH,VND
SELECT 4236 ,'3.6'  ,'72'      ,3.6  ,72      ,51   UNION ALL	--INH	--INH,VND
SELECT 4237 ,'1.8'  ,'45'      ,1.8  ,45      ,51   UNION ALL	--INH	--INH,VND
SELECT 4238 ,'2'    ,'360'     ,2    ,360     ,51   UNION ALL	--INH	--INH,VND
SELECT 4239 ,'1'    ,'20'      ,1    ,20      ,51   UNION ALL	--INH	--INH,VND
SELECT 4240 ,'0.5'  ,'150'     ,0.5  ,150     ,51   UNION ALL	--INH	--INH,VND
SELECT 4241 ,'1.8'  ,'720'     ,1.8  ,720     ,51   UNION ALL	--INH	--INH,VND
SELECT 4242 ,'2'    ,'20'      ,2    ,20      ,51   UNION ALL	--INH	--INH,VND
--INR
SELECT 4232 ,'10'   ,'1000'    ,10   ,1000    ,61   UNION ALL	--INR	--INR, RUB
SELECT 4233 ,'12.5' ,'1250'    ,12.5 ,1250    ,61   UNION ALL	--INR	--INR, RUB
SELECT 4234 ,'10'   ,'400'     ,10   ,400     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4235 ,'12.5' ,'500'     ,12.5 ,500     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4236 ,'10'   ,'200'     ,10   ,200     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4237 ,'4.5'  ,'225'     ,4.5  ,225     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4238 ,'10'   ,'1000'    ,10   ,1000    ,61   UNION ALL	--INR	--INR, RUB
SELECT 4239 ,'5'    ,'100'     ,5    ,100     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4240 ,'2.5'  ,'500'     ,2.5  ,500     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4241 ,'5'    ,'2000'    ,5    ,2000    ,61   UNION ALL	--INR	--INR, RUB
SELECT 4242 ,'10'   ,'100'     ,10   ,100     ,61   UNION ALL	--INR	--INR, RUB
--RUB
SELECT 4232 ,'10'   ,'1000'    ,10   ,1000    ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4233 ,'12.5' ,'1250'    ,12.5 ,1250    ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4234 ,'10'   ,'400'     ,10   ,400     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4235 ,'12.5' ,'500'     ,12.5 ,500     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4236 ,'10'   ,'200'     ,10   ,200     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4237 ,'4.5'  ,'225'     ,4.5  ,225     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4238 ,'10'   ,'1000'    ,10   ,1000    ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4239 ,'5'    ,'100'     ,5    ,100     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4240 ,'2.5'  ,'500'     ,2.5  ,500     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4241 ,'5'    ,'2000'    ,5    ,2000    ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4242 ,'10'   ,'100'     ,10   ,100     ,55   UNION ALL	--RUB	--INR, RUB
--JPY
SELECT 4232 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 4233 ,'25'   ,'2500'    ,25   ,2500    ,32   UNION ALL	--JPY	--JPY
SELECT 4234 ,'20'   ,'800'     ,20   ,800     ,32   UNION ALL	--JPY	--JPY
SELECT 4235 ,'25'   ,'1000'    ,25   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4236 ,'20'   ,'400'     ,20   ,400     ,32   UNION ALL	--JPY	--JPY
SELECT 4237 ,'9'    ,'450'     ,9    ,450     ,32   UNION ALL	--JPY	--JPY
SELECT 4238 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 4239 ,'10'   ,'200'     ,10   ,200     ,32   UNION ALL	--JPY	--JPY
SELECT 4240 ,'5'    ,'1000'    ,5    ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4241 ,'10'   ,'4000'    ,10   ,4000    ,32   UNION ALL	--JPY	--JPY
SELECT 4242 ,'20'   ,'200'     ,20   ,200     ,32   UNION ALL	--JPY	--JPY
--Won
SELECT 4232 ,'200'  ,'20000'   ,200  ,20000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4233 ,'250'  ,'25000'   ,250  ,25000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4234 ,'200'  ,'8000'    ,200  ,8000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4235 ,'250'  ,'10000'   ,250  ,10000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4236 ,'200'  ,'4000'    ,200  ,4000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4237 ,'90'   ,'4500'    ,90   ,4500    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4238 ,'200'  ,'20000'   ,200  ,20000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4239 ,'100'  ,'2000'    ,100  ,2000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4240 ,'50'   ,'10000'   ,50   ,10000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4241 ,'100'  ,'40000'   ,100  ,40000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4242 ,'200'  ,'2000'    ,200  ,2000    ,45   UNION ALL	--Won	--KRW, Won
--KHR
SELECT 4232 ,'0.6'  ,'60'      ,0.6  ,60      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4233 ,'0.75' ,'75'      ,0.75 ,75      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4234 ,'0.6'  ,'24'      ,0.6  ,24      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4235 ,'0.75' ,'30'      ,0.75 ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4236 ,'0.6'  ,'12'      ,0.6  ,12      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4237 ,'0.09' ,'5'       ,0.09 ,5       ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4238 ,'0.6'  ,'60'      ,0.6  ,60      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4240 ,'0.15' ,'30'      ,0.15 ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4241 ,'0.3'  ,'120'     ,0.3  ,120     ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4242 ,'0.2'  ,'6'       ,0.2  ,6       ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
--PLN
SELECT 4232 ,'0.6'  ,'60'      ,0.6  ,60      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4233 ,'0.75' ,'75'      ,0.75 ,75      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4234 ,'0.6'  ,'24'      ,0.6  ,24      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4235 ,'0.75' ,'30'      ,0.75 ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4236 ,'0.6'  ,'12'      ,0.6  ,12      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4237 ,'0.09' ,'5'       ,0.09 ,5       ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4238 ,'0.6'  ,'60'      ,0.6  ,60      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4240 ,'0.15' ,'30'      ,0.15 ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4241 ,'0.3'  ,'120'     ,0.3  ,120     ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4242 ,'0.2'  ,'6'       ,0.2  ,6       ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
--RM
SELECT 4232 ,'0.6'  ,'60'      ,0.6  ,60      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4233 ,'0.75' ,'75'      ,0.75 ,75      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4234 ,'0.6'  ,'24'      ,0.6  ,24      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4235 ,'0.75' ,'30'      ,0.75 ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4236 ,'0.6'  ,'12'      ,0.6  ,12      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4237 ,'0.09' ,'5'       ,0.09 ,5       ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4238 ,'0.6'  ,'60'      ,0.6  ,60      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4240 ,'0.15' ,'30'      ,0.15 ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4241 ,'0.3'  ,'120'     ,0.3  ,120     ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4242 ,'0.2'  ,'6'       ,0.2  ,6       ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
--RMB
SELECT 4232 ,'1.2'  ,'120'     ,1.2  ,120     ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4234 ,'0.2'  ,'40'      ,0.2  ,40      ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4235 ,'0.25' ,'50'      ,0.25 ,50      ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4236 ,'0.2'  ,'24'      ,0.2  ,24      ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4238 ,'1.2'  ,'120'     ,1.2  ,120     ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4239 ,'0.1'  ,'10'      ,0.1  ,10      ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4240 ,'0.5'  ,'60'      ,0.5  ,60      ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4241 ,'0.6'  ,'240'     ,0.6  ,240     ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
SELECT 4242 ,'0.4'  ,'6'       ,0.4  ,6       ,13   UNION ALL	--RMB	--RMB, CNY, YUN, 
--YUN
SELECT 4232 ,'1.2'  ,'120'     ,1.2  ,120     ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4234 ,'0.2'  ,'40'      ,0.2  ,40      ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4235 ,'0.25' ,'50'      ,0.25 ,50      ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4236 ,'0.2'  ,'24'      ,0.2  ,24      ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4238 ,'1.2'  ,'120'     ,1.2  ,120     ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4239 ,'0.1'  ,'10'      ,0.1  ,10      ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4240 ,'0.5'  ,'60'      ,0.5  ,60      ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4241 ,'0.6'  ,'240'     ,0.6  ,240     ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
SELECT 4242 ,'0.4'  ,'6'       ,0.4  ,6       ,66   UNION ALL	--YUN	--RMB, CNY, YUN, 
--TB
SELECT 4232 ,'6'    ,'600'     ,6    ,600     ,4    UNION ALL	--TB	--TB
SELECT 4233 ,'7.5'  ,'750'     ,7.5  ,750     ,4    UNION ALL	--TB	--TB
SELECT 4234 ,'6'    ,'240'     ,6    ,240     ,4    UNION ALL	--TB	--TB
SELECT 4235 ,'7.5'  ,'300'     ,7.5  ,300     ,4    UNION ALL	--TB	--TB
SELECT 4236 ,'6'    ,'120'     ,6    ,120     ,4    UNION ALL	--TB	--TB
SELECT 4237 ,'9'    ,'81'      ,9    ,81      ,4    UNION ALL	--TB	--TB
SELECT 4238 ,'6'    ,'600'     ,6    ,600     ,4    UNION ALL	--TB	--TB
SELECT 4239 ,'2'    ,'40'      ,2    ,40      ,4    UNION ALL	--TB	--TB
SELECT 4240 ,'1.5'  ,'300'     ,1.5  ,300     ,4    UNION ALL	--TB	--TB
SELECT 4241 ,'3'    ,'1200'    ,3    ,1200    ,4    UNION ALL	--TB	--TB
SELECT 4242 ,'2'    ,'40'      ,2    ,40      ,4    UNION ALL	--TB	--TB
--EUR
SELECT 4232 ,'0.2'  ,'20'      ,0.2  ,20      ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4233 ,'0.25' ,'25'      ,0.25 ,25      ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4234 ,'0.2'  ,'8'       ,0.2  ,8       ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4235 ,'0.25' ,'10'      ,0.25 ,10      ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4236 ,'0.2'  ,'4'       ,0.2  ,4       ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4237 ,'0.09' ,'5'       ,0.09 ,5       ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4238 ,'0.2'  ,'20'      ,0.2  ,20      ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4239 ,'0.1'  ,'2'       ,0.1  ,2       ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4240 ,'0.05' ,'10'      ,0.05 ,10      ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4241 ,'0.1'  ,'40'      ,0.1  ,40      ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
SELECT 4242 ,'0.2'  ,'2'       ,0.2  ,2       ,78   UNION ALL	--EUR	--USD,EUR, YNG,UUS
--USD
SELECT 4232 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4233 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4234 ,'0.2'  ,'8'       ,0.2  ,8       ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4235 ,'0.25' ,'10'      ,0.25 ,10      ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4236 ,'0.2'  ,'4'       ,0.2  ,4       ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4237 ,'0.09' ,'5'       ,0.09 ,5       ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4238 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4239 ,'0.1'  ,'2'       ,0.1  ,2       ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4240 ,'0.05' ,'10'      ,0.05 ,10      ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4241 ,'0.1'  ,'40'      ,0.1  ,40      ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
SELECT 4242 ,'0.2'  ,'2'       ,0.2  ,2       ,95   UNION ALL	--USD	--USD,EUR, YNG,UUS
--UUS
SELECT 4232 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4233 ,'0.25' ,'25'      ,0.25 ,25      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4234 ,'0.2'  ,'8'       ,0.2  ,8       ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4235 ,'0.25' ,'10'      ,0.25 ,10      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4236 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4237 ,'0.09' ,'5'       ,0.09 ,5       ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4238 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4239 ,'0.1'  ,'2'       ,0.1  ,2       ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4240 ,'0.05' ,'10'      ,0.05 ,10      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4241 ,'0.1'  ,'40'      ,0.1  ,40      ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
SELECT 4242 ,'0.2'  ,'2'       ,0.2  ,2       ,20   UNION ALL	--UUS	--USD,EUR, YNG,UUS
--YNG
SELECT 4232 ,'0.2'  ,'20'      ,0.2  ,20      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4233 ,'0.25' ,'25'      ,0.25 ,25      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4234 ,'0.2'  ,'8'       ,0.2  ,8       ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4235 ,'0.25' ,'10'      ,0.25 ,10      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4236 ,'0.2'  ,'4'       ,0.2  ,4       ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4237 ,'0.09' ,'5'       ,0.09 ,5       ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4238 ,'0.2'  ,'20'      ,0.2  ,20      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4239 ,'0.1'  ,'2'       ,0.1  ,2       ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4240 ,'0.05' ,'10'      ,0.05 ,10      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4241 ,'0.1'  ,'40'      ,0.1  ,40      ,72   UNION ALL	--YNG	--USD,EUR, YNG,UUS
SELECT 4242 ,'0.2'  ,'2'       ,0.2  ,2       ,72				--YNG	--USD,EUR, YNG,UUS

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  WHERE t.ExchangeId = s.ExchangeId) t
WHERE s.GameTypeID = 4101)

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

DROP TABLE #StakeLevel_Temp