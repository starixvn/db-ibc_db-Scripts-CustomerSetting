/*
	Date: 20201209
	Created: Winfred 
	Task: #146800 - Pragmatic - Integrate 14 new games Dec 2020 for Cash [Redmine:146800]
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
									,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
									,ExchangeId int)
									
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--GBP
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4245 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4246 ,'0.25' ,'50'      ,0.25 ,50      ,12   UNION ALL	--GBP	--GBP
SELECT 4247 ,'0.25' ,'10'      ,0.25 ,10      ,12   UNION ALL	--GBP	--GBP
SELECT 4248 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4249 ,'0.1'  ,'5'       ,0.1  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4250 ,'0.25' ,'5'       ,0.25 ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4251 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4252 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4253 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4254 ,'0.1'  ,'10'      ,0.1  ,10      ,12   UNION ALL	--GBP	--GBP
SELECT 4255 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4256 ,'0.2'  ,'8'       ,0.2  ,8       ,12   UNION ALL	--GBP	--GBP
SELECT 4257 ,'0.1'  ,'18'      ,0.1  ,18      ,12   UNION ALL	--GBP	--GBP
--=============================================
--IDR, IN
SELECT 4244 ,'3.6'  ,'30'      ,3.6  ,30      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4245 ,'2.4'  ,'180'     ,2.4  ,180     ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4246 ,'9'    ,'900'     ,9    ,900     ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4247 ,'3'    ,'112.5'   ,3    ,112.5   ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4248 ,'3.6'  ,'54'      ,3.6  ,54      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4249 ,'4.5'  ,'45'      ,4.5  ,45      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4250 ,'4.5'  ,'45'      ,4.5  ,45      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4251 ,'5.4'  ,'44'      ,5.4  ,44      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4252 ,'5.4'  ,'44'      ,5.4  ,44      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4253 ,'5.4'  ,'44'      ,5.4  ,44      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4254 ,'4.5'  ,'135'     ,4.5  ,135     ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4255 ,'5.4'  ,'44'      ,5.4  ,44      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4256 ,'5.4'  ,'80'      ,5.4  ,80      ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4257 ,'4.5'  ,'324'     ,4.5  ,324     ,34   UNION ALL	--IDR	--IDR, IN
SELECT 4244 ,'3.6'  ,'30'      ,3.6  ,30      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4245 ,'2.4'  ,'180'     ,2.4  ,180     ,15   UNION ALL	--IN	--IDR, IN
SELECT 4246 ,'9'    ,'900'     ,9    ,900     ,15   UNION ALL	--IN	--IDR, IN
SELECT 4247 ,'3'    ,'112.5'   ,3    ,112.5   ,15   UNION ALL	--IN	--IDR, IN
SELECT 4248 ,'3.6'  ,'54'      ,3.6  ,54      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4249 ,'4.5'  ,'45'      ,4.5  ,45      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4250 ,'4.5'  ,'45'      ,4.5  ,45      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4251 ,'5.4'  ,'44'      ,5.4  ,44      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4252 ,'5.4'  ,'44'      ,5.4  ,44      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4253 ,'5.4'  ,'44'      ,5.4  ,44      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4254 ,'4.5'  ,'135'     ,4.5  ,135     ,15   UNION ALL	--IN	--IDR, IN
SELECT 4255 ,'5.4'  ,'44'      ,5.4  ,44      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4256 ,'5.4'  ,'80'      ,5.4  ,80      ,15   UNION ALL	--IN	--IDR, IN
SELECT 4257 ,'4.5'  ,'324'     ,4.5  ,324     ,15   UNION ALL	--IN	--IDR, IN
--=============================================
--INH,VND
SELECT 4244 ,'3.6'  ,'54'      ,3.6  ,54      ,51   UNION ALL	--INH	--INH,VND
SELECT 4245 ,'2'    ,'360'     ,2    ,360     ,51   UNION ALL	--INH	--INH,VND
SELECT 4246 ,'4.5'  ,'1800'    ,4.5  ,1800    ,51   UNION ALL	--INH	--INH,VND
SELECT 4247 ,'2.5'  ,'180'     ,2.5  ,180     ,51   UNION ALL	--INH	--INH,VND
SELECT 4248 ,'3.6'  ,'108'     ,3.6  ,108     ,51   UNION ALL	--INH	--INH,VND
SELECT 4249 ,'1.8'  ,'108'     ,1.8  ,108     ,51   UNION ALL	--INH	--INH,VND
SELECT 4250 ,'4.5'  ,'110'     ,4.5  ,110     ,51   UNION ALL	--INH	--INH,VND
SELECT 4251 ,'3.6'  ,'108'     ,3.6  ,108     ,51   UNION ALL	--INH	--INH,VND
SELECT 4252 ,'3.6'  ,'108'     ,3.6  ,108     ,51   UNION ALL	--INH	--INH,VND
SELECT 4253 ,'3.6'  ,'108'     ,3.6  ,108     ,51   UNION ALL	--INH	--INH,VND
SELECT 4254 ,'1.8'  ,'360'     ,1.8  ,360     ,51   UNION ALL	--INH	--INH,VND
SELECT 4255 ,'3.6'  ,'108'     ,3.6  ,108     ,51   UNION ALL	--INH	--INH,VND
SELECT 4256 ,'3.6'  ,'216'     ,3.6  ,216     ,51   UNION ALL	--INH	--INH,VND
SELECT 4257 ,'1.8'  ,'1296'    ,1.8  ,1296    ,51   UNION ALL	--INH	--INH,VND
--=============================================
--INR, RUB
SELECT 4244 ,'10'   ,'100'     ,10   ,100     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4245 ,'10'   ,'1000'    ,10   ,1000    ,61   UNION ALL	--INR	--INR, RUB
SELECT 4246 ,'12.5' ,'2500'    ,12.5 ,2500    ,61   UNION ALL	--INR	--INR, RUB
SELECT 4247 ,'12.5' ,'500'     ,12.5 ,500     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4248 ,'10'   ,'250'     ,10   ,250     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4249 ,'5'    ,'300'     ,5    ,300     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4250 ,'12.5' ,'300'     ,12.5 ,300     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4251 ,'10'   ,'300'     ,10   ,300     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4252 ,'10'   ,'300'     ,10   ,300     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4253 ,'10'   ,'300'     ,10   ,300     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4254 ,'5'    ,'1000'    ,5    ,1000    ,61   UNION ALL	--INR	--INR, RUB
SELECT 4255 ,'10'   ,'300'     ,10   ,300     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4256 ,'10'   ,'600'     ,10   ,600     ,61   UNION ALL	--INR	--INR, RUB
SELECT 4257 ,'5'    ,'3600'    ,5    ,3600    ,61   UNION ALL	--INR	--INR, RUB
SELECT 4244 ,'10'   ,'100'     ,10   ,100     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4245 ,'10'   ,'1000'    ,10   ,1000    ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4246 ,'12.5' ,'2500'    ,12.5 ,2500    ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4247 ,'12.5' ,'500'     ,12.5 ,500     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4248 ,'10'   ,'250'     ,10   ,250     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4249 ,'5'    ,'300'     ,5    ,300     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4250 ,'12.5' ,'300'     ,12.5 ,300     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4251 ,'10'   ,'300'     ,10   ,300     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4252 ,'10'   ,'300'     ,10   ,300     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4253 ,'10'   ,'300'     ,10   ,300     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4254 ,'5'    ,'1000'    ,5    ,1000    ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4255 ,'10'   ,'300'     ,10   ,300     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4256 ,'10'   ,'600'     ,10   ,600     ,55   UNION ALL	--RUB	--INR, RUB
SELECT 4257 ,'5'    ,'3600'    ,5    ,3600    ,55   UNION ALL	--RUB	--INR, RUB
--=============================================
--JPY
SELECT 4244 ,'20'   ,'200'     ,20   ,200     ,32   UNION ALL	--JPY	--JPY
SELECT 4245 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 4246 ,'25'   ,'5000'    ,25   ,5000    ,32   UNION ALL	--JPY	--JPY
SELECT 4247 ,'25'   ,'1000'    ,25   ,1000    ,32   UNION ALL	--JPY	--JPY
SELECT 4248 ,'20'   ,'500'     ,20   ,500     ,32   UNION ALL	--JPY	--JPY
SELECT 4249 ,'10'   ,'600'     ,10   ,600     ,32   UNION ALL	--JPY	--JPY
SELECT 4250 ,'25'   ,'600'     ,25   ,600     ,32   UNION ALL	--JPY	--JPY
SELECT 4251 ,'20'   ,'600'     ,20   ,600     ,32   UNION ALL	--JPY	--JPY
SELECT 4252 ,'20'   ,'600'     ,20   ,600     ,32   UNION ALL	--JPY	--JPY
SELECT 4253 ,'20'   ,'600'     ,20   ,600     ,32   UNION ALL	--JPY	--JPY
SELECT 4254 ,'10'   ,'2000'    ,10   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 4255 ,'20'   ,'600'     ,20   ,600     ,32   UNION ALL	--JPY	--JPY
SELECT 4256 ,'20'   ,'1200'    ,20   ,1200    ,32   UNION ALL	--JPY	--JPY
SELECT 4257 ,'10'   ,'7200'    ,10   ,7200    ,32   UNION ALL	--JPY	--JPY
--=============================================
--KRW, Won
SELECT 4244 ,'200'  ,'2000'    ,200  ,2000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4245 ,'200'  ,'20000'   ,200  ,20000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4246 ,'250'  ,'50000'   ,250  ,50000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4247 ,'250'  ,'10000'   ,250  ,10000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4248 ,'200'  ,'5000'    ,200  ,5000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4249 ,'100'  ,'6000'    ,100  ,6000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4250 ,'250'  ,'6000'    ,250  ,6000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4251 ,'200'  ,'6000'    ,200  ,6000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4252 ,'200'  ,'6000'    ,200  ,6000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4253 ,'200'  ,'6000'    ,200  ,6000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4254 ,'100'  ,'20000'   ,100  ,20000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4255 ,'200'  ,'6000'    ,200  ,6000    ,45   UNION ALL	--Won	--KRW, Won
SELECT 4256 ,'200'  ,'12000'   ,200  ,12000   ,45   UNION ALL	--Won	--KRW, Won
SELECT 4257 ,'100'  ,'72000'   ,100  ,72000   ,45   UNION ALL	--Won	--KRW, Won
--=============================================
--RM, MYR,  PLN, KHR
SELECT 4244 ,'0.6'  ,'8'       ,0.6  ,8       ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4245 ,'0.6'  ,'60'      ,0.6  ,60      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4246 ,'0.75' ,'300'     ,0.75 ,300     ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4247 ,'0.75' ,'30'      ,0.75 ,30      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4248 ,'0.6'  ,'18'      ,0.6  ,18      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4249 ,'0.3'  ,'15'      ,0.3  ,15      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4250 ,'0.75' ,'15'      ,0.75 ,15      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4251 ,'0.6'  ,'14'      ,0.6  ,14      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4252 ,'0.6'  ,'14'      ,0.6  ,14      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4253 ,'0.6'  ,'14'      ,0.6  ,14      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4254 ,'0.3'  ,'45'      ,0.3  ,45      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4255 ,'0.6'  ,'14'      ,0.6  ,14      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4256 ,'0.6'  ,'26'      ,0.6  ,26      ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4257 ,'0.3'  ,'108'     ,0.3  ,108     ,71   UNION ALL	--KHR	--RM, MYR,  PLN, KHR
SELECT 4244 ,'0.6'  ,'8'       ,0.6  ,8       ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4245 ,'0.6'  ,'60'      ,0.6  ,60      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4246 ,'0.75' ,'300'     ,0.75 ,300     ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4247 ,'0.75' ,'30'      ,0.75 ,30      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4248 ,'0.6'  ,'18'      ,0.6  ,18      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4249 ,'0.3'  ,'15'      ,0.3  ,15      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4250 ,'0.75' ,'15'      ,0.75 ,15      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4251 ,'0.6'  ,'14'      ,0.6  ,14      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4252 ,'0.6'  ,'14'      ,0.6  ,14      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4253 ,'0.6'  ,'14'      ,0.6  ,14      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4254 ,'0.3'  ,'45'      ,0.3  ,45      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4255 ,'0.6'  ,'14'      ,0.6  ,14      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4256 ,'0.6'  ,'26'      ,0.6  ,26      ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4257 ,'0.3'  ,'108'     ,0.3  ,108     ,56   UNION ALL	--PLN	--RM, MYR,  PLN, KHR
SELECT 4244 ,'0.6'  ,'8'       ,0.6  ,8       ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4245 ,'0.6'  ,'60'      ,0.6  ,60      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4246 ,'0.75' ,'300'     ,0.75 ,300     ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4247 ,'0.75' ,'30'      ,0.75 ,30      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4248 ,'0.6'  ,'18'      ,0.6  ,18      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4249 ,'0.3'  ,'15'      ,0.3  ,15      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4250 ,'0.75' ,'15'      ,0.75 ,15      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4251 ,'0.6'  ,'14'      ,0.6  ,14      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4252 ,'0.6'  ,'14'      ,0.6  ,14      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4253 ,'0.6'  ,'14'      ,0.6  ,14      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4254 ,'0.3'  ,'45'      ,0.3  ,45      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4255 ,'0.6'  ,'14'      ,0.6  ,14      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4256 ,'0.6'  ,'26'      ,0.6  ,26      ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
SELECT 4257 ,'0.3'  ,'108'     ,0.3  ,108     ,2    UNION ALL	--RM	--RM, MYR,  PLN, KHR
--=============================================
--RMB, CNY, YUN
SELECT 4244 ,'1.2'  ,'12'      ,1.2  ,12      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4245 ,'1.2'  ,'120'     ,1.2  ,120     ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4246 ,'1.5'  ,'600'     ,1.5  ,600     ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4247 ,'0.25' ,'50'      ,0.25 ,50      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4248 ,'1.2'  ,'36'      ,1.2  ,36      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4249 ,'0.6'  ,'30'      ,0.6  ,30      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4250 ,'1.5'  ,'30'      ,1.5  ,30      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4251 ,'1.2'  ,'30'      ,1.2  ,30      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4252 ,'1.2'  ,'30'      ,1.2  ,30      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4253 ,'1.2'  ,'30'      ,1.2  ,30      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4254 ,'0.6'  ,'90'      ,0.6  ,90      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4255 ,'1.2'  ,'30'      ,1.2  ,30      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4256 ,'1.2'  ,'54'      ,1.2  ,54      ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4257 ,'0.6'  ,'216'     ,0.6  ,216     ,13   UNION ALL	--RMB	--RMB, CNY, YUN
SELECT 4244 ,'1.2'  ,'12'      ,1.2  ,12      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4245 ,'1.2'  ,'120'     ,1.2  ,120     ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4246 ,'1.5'  ,'600'     ,1.5  ,600     ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4247 ,'0.25' ,'50'      ,0.25 ,50      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4248 ,'1.2'  ,'36'      ,1.2  ,36      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4249 ,'0.6'  ,'30'      ,0.6  ,30      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4250 ,'1.5'  ,'30'      ,1.5  ,30      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4251 ,'1.2'  ,'30'      ,1.2  ,30      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4252 ,'1.2'  ,'30'      ,1.2  ,30      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4253 ,'1.2'  ,'30'      ,1.2  ,30      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4254 ,'0.6'  ,'90'      ,0.6  ,90      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4255 ,'1.2'  ,'30'      ,1.2  ,30      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4256 ,'1.2'  ,'54'      ,1.2  ,54      ,66   UNION ALL	--YUN	--RMB, CNY, YUN
SELECT 4257 ,'0.6'  ,'216'     ,0.6  ,216     ,66   UNION ALL	--YUN	--RMB, CNY, YUN
--=============================================
--TB
SELECT 4244 ,'6'    ,'70'      ,6    ,70      ,4    UNION ALL	--TB	--TB
SELECT 4245 ,'6'    ,'600'     ,6    ,600     ,4    UNION ALL	--TB	--TB
SELECT 4246 ,'7.5'  ,'3000'    ,7.5  ,3000    ,4    UNION ALL	--TB	--TB
SELECT 4247 ,'7.5'  ,'300'     ,7.5  ,300     ,4    UNION ALL	--TB	--TB
SELECT 4248 ,'6'    ,'150'     ,6    ,150     ,4    UNION ALL	--TB	--TB
SELECT 4249 ,'3'    ,'180'     ,3    ,180     ,4    UNION ALL	--TB	--TB
SELECT 4250 ,'7.5'  ,'180'     ,7.5  ,180     ,4    UNION ALL	--TB	--TB
SELECT 4251 ,'6'    ,'180'     ,6    ,180     ,4    UNION ALL	--TB	--TB
SELECT 4252 ,'6'    ,'180'     ,6    ,180     ,4    UNION ALL	--TB	--TB
SELECT 4253 ,'6'    ,'180'     ,6    ,180     ,4    UNION ALL	--TB	--TB
SELECT 4254 ,'3'    ,'600'     ,3    ,600     ,4    UNION ALL	--TB	--TB
SELECT 4255 ,'6'    ,'180'     ,6    ,180     ,4    UNION ALL	--TB	--TB
SELECT 4256 ,'6'    ,'360'     ,6    ,360     ,4    UNION ALL	--TB	--TB
SELECT 4257 ,'3'    ,'2160'    ,3    ,2160    ,4    UNION ALL	--TB	--TB
--=============================================
--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4245 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4246 ,'0.25' ,'100'     ,0.25 ,100     ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4247 ,'0.25' ,'10'      ,0.25 ,10      ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4248 ,'0.2'  ,'4'       ,0.2  ,4       ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4249 ,'0.1'  ,'6'       ,0.1  ,6       ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4250 ,'0.25' ,'7.4'     ,0.25 ,7.4     ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4251 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4252 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4253 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4254 ,'0.1'  ,'20'      ,0.1  ,20      ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4255 ,'0.2'  ,'6'       ,0.2  ,6       ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4256 ,'0.2'  ,'12'      ,0.2  ,12      ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4257 ,'0.1'  ,'72'      ,0.1  ,72      ,9    UNION ALL	--AUD	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4245 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4246 ,'0.25' ,'100'     ,0.25 ,100     ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4247 ,'0.25' ,'10'      ,0.25 ,10      ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4248 ,'0.2'  ,'4'       ,0.2  ,4       ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4249 ,'0.1'  ,'6'       ,0.1  ,6       ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4250 ,'0.25' ,'7.4'     ,0.25 ,7.4     ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4251 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4252 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4253 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4254 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4255 ,'0.2'  ,'6'       ,0.2  ,6       ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4256 ,'0.2'  ,'12'      ,0.2  ,12      ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4257 ,'0.1'  ,'72'      ,0.1  ,72      ,6    UNION ALL	--EURO	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4245 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4246 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4247 ,'0.25' ,'10'      ,0.25 ,10      ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4248 ,'0.2'  ,'4'       ,0.2  ,4       ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4249 ,'0.1'  ,'6'       ,0.1  ,6       ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4250 ,'0.25' ,'7.4'     ,0.25 ,7.4     ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4251 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4252 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4253 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4254 ,'0.1'  ,'20'      ,0.1  ,20      ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4255 ,'0.2'  ,'6'       ,0.2  ,6       ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4256 ,'0.2'  ,'12'      ,0.2  ,12      ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4257 ,'0.1'  ,'72'      ,0.1  ,72      ,3    UNION ALL	--US$	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4245 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4246 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4247 ,'0.25' ,'10'      ,0.25 ,10      ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4248 ,'0.2'  ,'4'       ,0.2  ,4       ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4249 ,'0.1'  ,'6'       ,0.1  ,6       ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4250 ,'0.25' ,'7.4'     ,0.25 ,7.4     ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4251 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4252 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4253 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4254 ,'0.1'  ,'20'      ,0.1  ,20      ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4255 ,'0.2'  ,'6'       ,0.2  ,6       ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4256 ,'0.2'  ,'12'      ,0.2  ,12      ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4257 ,'0.1'  ,'72'      ,0.1  ,72      ,96   UNION ALL	--USDT	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4245 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4246 ,'0.25' ,'100'     ,0.25 ,100     ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4247 ,'0.25' ,'10'      ,0.25 ,10      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4248 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4249 ,'0.1'  ,'6'       ,0.1  ,6       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4250 ,'0.25' ,'7.4'     ,0.25 ,7.4     ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4251 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4252 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4253 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4254 ,'0.1'  ,'20'      ,0.1  ,20      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4255 ,'0.2'  ,'6'       ,0.2  ,6       ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4256 ,'0.2'  ,'12'      ,0.2  ,12      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4257 ,'0.1'  ,'72'      ,0.1  ,72      ,20   UNION ALL	--UUS	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4244 ,'0.2'  ,'2'       ,0.2  ,2       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4245 ,'0.2'  ,'20'      ,0.2  ,20      ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4246 ,'0.25' ,'100'     ,0.25 ,100     ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4247 ,'0.25' ,'10'      ,0.25 ,10      ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4248 ,'0.2'  ,'4'       ,0.2  ,4       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4249 ,'0.1'  ,'6'       ,0.1  ,6       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4250 ,'0.25' ,'7.4'     ,0.25 ,7.4     ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4251 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4252 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4253 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4254 ,'0.1'  ,'20'      ,0.1  ,20      ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4255 ,'0.2'  ,'6'       ,0.2  ,6       ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4256 ,'0.2'  ,'12'      ,0.2  ,12      ,72   UNION ALL	--YNG	--USD,EUR,SGD,AUD,YNG,UUS
SELECT 4257 ,'0.1'  ,'72'      ,0.1  ,72      ,72				--YNG	--USD,EUR,SGD,AUD,YNG,UUS

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