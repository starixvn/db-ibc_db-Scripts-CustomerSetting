/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Pragmatic - Integrate 11 new games for Credit - Real Currency RedmineID:#140578
	DB: DBCust/CustDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--$US
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,35   UNION ALL	--$US	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--EUR
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,78   UNION ALL	--EUR	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--EURO
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,6    UNION ALL	--EURO	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--MMK
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,69   UNION ALL	--MMK	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--US$
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,3    UNION ALL	--US$	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--USD
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,95   UNION ALL	--USD	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--UT
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,64   UNION ALL	--UT	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--UUS
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--Yen
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,16   UNION ALL	--Yen	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--YNG
SELECT 4232 ,'0.2'  ,'40'      ,0.2  ,40      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4233 ,'0.25' ,'50'      ,0.25 ,50      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4234 ,'0.2'  ,'20'      ,0.2  ,20      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4235 ,'0.25' ,'25'      ,0.25 ,25      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4236 ,'0.2'  ,'12'      ,0.2  ,12      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4237 ,'0.09' ,'9'       ,0.09 ,9       ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4238 ,'0.2'  ,'40'      ,0.2  ,40      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4239 ,'0.1'  ,'5'       ,0.1  ,5       ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4240 ,'0.05' ,'50'      ,0.05 ,50      ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4241 ,'0.1'  ,'100'     ,0.1  ,100     ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
SELECT 4242 ,'0.2'  ,'4'       ,0.2  ,4       ,72   UNION ALL	--YNG	--$US, US$, UT, Yen,USD,MMK, Euro, EUR,UUS, YNG
--DDD
SELECT 4232 ,'1.8'  ,'360'     ,1.8  ,360     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4233 ,'2.25' ,'450'     ,2.25 ,450     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4234 ,'1.8'  ,'180'     ,1.8  ,180     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4235 ,'2.25' ,'225'     ,2.25 ,225     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4236 ,'1.8'  ,'108'     ,1.8  ,108     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4237 ,'0.81' ,'81'      ,0.81 ,81      ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4238 ,'1.8'  ,'360'     ,1.8  ,360     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4239 ,'0.9'  ,'45'      ,0.9  ,45      ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4240 ,'0.45' ,'450'     ,0.45 ,450     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4241 ,'0.9'  ,'900'     ,0.9  ,900     ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
SELECT 4242 ,'1.8'  ,'36'      ,1.8  ,36      ,47   UNION ALL	--DDD	--DDD,IND,IDR,IDD,IN
--IDD
SELECT 4232 ,'1.8'  ,'360'     ,1.8  ,360     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4233 ,'2.25' ,'450'     ,2.25 ,450     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4234 ,'1.8'  ,'180'     ,1.8  ,180     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4235 ,'2.25' ,'225'     ,2.25 ,225     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4236 ,'1.8'  ,'108'     ,1.8  ,108     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4237 ,'0.81' ,'81'      ,0.81 ,81      ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4238 ,'1.8'  ,'360'     ,1.8  ,360     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4239 ,'0.9'  ,'45'      ,0.9  ,45      ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4240 ,'0.45' ,'450'     ,0.45 ,450     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4241 ,'0.9'  ,'900'     ,0.9  ,900     ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
SELECT 4242 ,'1.8'  ,'36'      ,1.8  ,36      ,33   UNION ALL	--IDD	--DDD,IND,IDR,IDD,IN
--IDR
SELECT 4232 ,'1.8'  ,'360'     ,1.8  ,360     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4233 ,'2.25' ,'450'     ,2.25 ,450     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4234 ,'1.8'  ,'180'     ,1.8  ,180     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4235 ,'2.25' ,'225'     ,2.25 ,225     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4236 ,'1.8'  ,'108'     ,1.8  ,108     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4237 ,'0.81' ,'81'      ,0.81 ,81      ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4238 ,'1.8'  ,'360'     ,1.8  ,360     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4239 ,'0.9'  ,'45'      ,0.9  ,45      ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4240 ,'0.45' ,'450'     ,0.45 ,450     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4241 ,'0.9'  ,'900'     ,0.9  ,900     ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
SELECT 4242 ,'1.8'  ,'36'      ,1.8  ,36      ,34   UNION ALL	--IDR	--DDD,IND,IDR,IDD,IN
--IN
SELECT 4232 ,'1.8'  ,'360'     ,1.8  ,360     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4233 ,'2.25' ,'450'     ,2.25 ,450     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4234 ,'1.8'  ,'180'     ,1.8  ,180     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4235 ,'2.25' ,'225'     ,2.25 ,225     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4236 ,'1.8'  ,'108'     ,1.8  ,108     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4237 ,'0.81' ,'81'      ,0.81 ,81      ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4238 ,'1.8'  ,'360'     ,1.8  ,360     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4239 ,'0.9'  ,'45'      ,0.9  ,45      ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4240 ,'0.45' ,'450'     ,0.45 ,450     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4241 ,'0.9'  ,'900'     ,0.9  ,900     ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
SELECT 4242 ,'1.8'  ,'36'      ,1.8  ,36      ,15   UNION ALL	--IN	--DDD,IND,IDR,IDD,IN
--IND
SELECT 4232 ,'1.8'  ,'360'     ,1.8  ,360     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4233 ,'2.25' ,'450'     ,2.25 ,450     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4234 ,'1.8'  ,'180'     ,1.8  ,180     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4235 ,'2.25' ,'225'     ,2.25 ,225     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4236 ,'1.8'  ,'108'     ,1.8  ,108     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4237 ,'0.81' ,'81'      ,0.81 ,81      ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4238 ,'1.8'  ,'360'     ,1.8  ,360     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4239 ,'0.9'  ,'45'      ,0.9  ,45      ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4240 ,'0.45' ,'450'     ,0.45 ,450     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4241 ,'0.9'  ,'900'     ,0.9  ,900     ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
SELECT 4242 ,'1.8'  ,'36'      ,1.8  ,36      ,22   UNION ALL	--IND	--DDD,IND,IDR,IDD,IN
--GBP
SELECT 4232 ,'0.2'  ,'12'      ,0.2  ,12      ,12   UNION ALL	--GBP	--GBP
SELECT 4233 ,'0.25' ,'25'      ,0.25 ,25      ,12   UNION ALL	--GBP	--GBP
SELECT 4234 ,'0.2'  ,'10'      ,0.2  ,10      ,12   UNION ALL	--GBP	--GBP
SELECT 4235 ,'0.25' ,'10'      ,0.25 ,10      ,12   UNION ALL	--GBP	--GBP
SELECT 4236 ,'0.2'  ,'4'       ,0.2  ,4       ,12   UNION ALL	--GBP	--GBP
SELECT 4237 ,'0.09' ,'4.5'     ,0.09 ,4.5     ,12   UNION ALL	--GBP	--GBP
SELECT 4238 ,'0.2'  ,'12'      ,0.2  ,12      ,12   UNION ALL	--GBP	--GBP
SELECT 4239 ,'0.1'  ,'2'       ,0.1  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4240 ,'0.05' ,'10'      ,0.05 ,10      ,12   UNION ALL	--GBP	--GBP
SELECT 4241 ,'0.05' ,'30'      ,0.05 ,30      ,12   UNION ALL	--GBP	--GBP
SELECT 4242 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
--HKK
SELECT 4232 ,'0.6'  ,'120'     ,0.6  ,120     ,67   UNION ALL	--HKK	--HKK
SELECT 4233 ,'0.75' ,'150'     ,0.75 ,150     ,67   UNION ALL	--HKK	--HKK
SELECT 4234 ,'0.6'  ,'60'      ,0.6  ,60      ,67   UNION ALL	--HKK	--HKK
SELECT 4235 ,'0.75' ,'75'      ,0.75 ,75      ,67   UNION ALL	--HKK	--HKK
SELECT 4236 ,'0.6'  ,'36'      ,0.6  ,36      ,67   UNION ALL	--HKK	--HKK
SELECT 4237 ,'0.27' ,'27'      ,0.27 ,27      ,67   UNION ALL	--HKK	--HKK
SELECT 4238 ,'0.6'  ,'120'     ,0.6  ,120     ,67   UNION ALL	--HKK	--HKK
SELECT 4239 ,'0.3'  ,'15'      ,0.3  ,15      ,67   UNION ALL	--HKK	--HKK
SELECT 4240 ,'0.15' ,'150'     ,0.15 ,150     ,67   UNION ALL	--HKK	--HKK
SELECT 4241 ,'0.3'  ,'300'     ,0.3  ,300     ,67   UNION ALL	--HKK	--HKK
SELECT 4242 ,'0.6'  ,'12'      ,0.6  ,12      ,67   UNION ALL	--HKK	--HKK
--RM
SELECT 4232 ,'0.6'  ,'120'     ,0.6  ,120     ,2    UNION ALL	--RM	--RM
SELECT 4233 ,'0.75' ,'150'     ,0.75 ,150     ,2    UNION ALL	--RM	--RM
SELECT 4234 ,'0.6'  ,'60'      ,0.6  ,60      ,2    UNION ALL	--RM	--RM
SELECT 4235 ,'0.75' ,'75'      ,0.75 ,75      ,2    UNION ALL	--RM	--RM
SELECT 4236 ,'0.6'  ,'36'      ,0.6  ,36      ,2    UNION ALL	--RM	--RM
SELECT 4237 ,'0.27' ,'27'      ,0.27 ,27      ,2    UNION ALL	--RM	--RM
SELECT 4238 ,'0.6'  ,'120'     ,0.6  ,120     ,2    UNION ALL	--RM	--RM
SELECT 4239 ,'0.3'  ,'15'      ,0.3  ,15      ,2    UNION ALL	--RM	--RM
SELECT 4240 ,'0.15' ,'150'     ,0.15 ,150     ,2    UNION ALL	--RM	--RM
SELECT 4241 ,'0.3'  ,'300'     ,0.3  ,300     ,2    UNION ALL	--RM	--RM
SELECT 4242 ,'0.6'  ,'12'      ,0.6  ,12      ,2    UNION ALL	--RM	--RM
--HK$
SELECT 4232 ,'1.2'  ,'240'     ,1.2  ,240     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4233 ,'1.5'  ,'300'     ,1.5  ,300     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4234 ,'1.2'  ,'120'     ,1.2  ,120     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4235 ,'1.5'  ,'150'     ,1.5  ,150     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4236 ,'1.2'  ,'72'      ,1.2  ,72      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4237 ,'0.54' ,'54'      ,0.54 ,54      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4238 ,'1.2'  ,'240'     ,1.2  ,240     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4239 ,'0.6'  ,'30'      ,0.6  ,30      ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4240 ,'0.3'  ,'300'     ,0.3  ,300     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4241 ,'0.6'  ,'600'     ,0.6  ,600     ,5    UNION ALL	--HK$	--RMB, HK$
SELECT 4242 ,'1.2'  ,'24'      ,1.2  ,24      ,5    UNION ALL	--HK$	--RMB, HK$
--RMB
SELECT 4232 ,'1.2'  ,'240'     ,1.2  ,240     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4233 ,'1.5'  ,'300'     ,1.5  ,300     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4234 ,'1.2'  ,'120'     ,1.2  ,120     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4235 ,'1.5'  ,'150'     ,1.5  ,150     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4236 ,'1.2'  ,'72'      ,1.2  ,72      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4237 ,'0.54' ,'54'      ,0.54 ,54      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4238 ,'1.2'  ,'240'     ,1.2  ,240     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4239 ,'0.6'  ,'30'      ,0.6  ,30      ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4240 ,'0.3'  ,'300'     ,0.3  ,300     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4241 ,'0.6'  ,'600'     ,0.6  ,600     ,13   UNION ALL	--RMB	--RMB, HK$
SELECT 4242 ,'1.2'  ,'24'      ,1.2  ,24      ,13   UNION ALL	--RMB	--RMB, HK$
--THB
SELECT 4232 ,'6'    ,'2250'    ,6    ,2250    ,43   UNION ALL	--THB	--THB
SELECT 4233 ,'7.5'  ,'1500'    ,7.5  ,1500    ,43   UNION ALL	--THB	--THB
SELECT 4234 ,'6'    ,'600'     ,6    ,600     ,43   UNION ALL	--THB	--THB
SELECT 4235 ,'7.5'  ,'750'     ,7.5  ,750     ,43   UNION ALL	--THB	--THB
SELECT 4236 ,'6'    ,'360'     ,6    ,360     ,43   UNION ALL	--THB	--THB
SELECT 4237 ,'2.7'  ,'270'     ,2.7  ,270     ,43   UNION ALL	--THB	--THB
SELECT 4238 ,'6'    ,'2250'    ,6    ,2250    ,43   UNION ALL	--THB	--THB
SELECT 4239 ,'3'    ,'150'     ,3    ,150     ,43   UNION ALL	--THB	--THB
SELECT 4240 ,'1.5'  ,'1500'    ,1.5  ,1500    ,43   UNION ALL	--THB	--THB
SELECT 4241 ,'3'    ,'3000'    ,3    ,3000    ,43   UNION ALL	--THB	--THB
SELECT 4242 ,'6'    ,'120'     ,6    ,120     ,43   UNION ALL	--THB	--THB
--Won
SELECT 4232 ,'200'  ,'75000'   ,200  ,75000   ,45   UNION ALL	--Won	--Won
SELECT 4233 ,'250'  ,'50000'   ,250  ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4234 ,'200'  ,'20000'   ,200  ,20000   ,45   UNION ALL	--Won	--Won
SELECT 4235 ,'250'  ,'25000'   ,250  ,25000   ,45   UNION ALL	--Won	--Won
SELECT 4236 ,'200'  ,'12000'   ,200  ,12000   ,45   UNION ALL	--Won	--Won
SELECT 4237 ,'90'   ,'9000'    ,90   ,9000    ,45   UNION ALL	--Won	--Won
SELECT 4238 ,'200'  ,'75000'   ,200  ,75000   ,45   UNION ALL	--Won	--Won
SELECT 4239 ,'100'  ,'5000'    ,100  ,5000    ,45   UNION ALL	--Won	--Won
SELECT 4240 ,'50'   ,'50000'   ,50   ,50000   ,45   UNION ALL	--Won	--Won
SELECT 4241 ,'100'  ,'100000'  ,100  ,100000  ,45   UNION ALL	--Won	--Won
SELECT 4242 ,'200'  ,'4000'    ,200  ,4000    ,45				--Won	--Won   

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
WHERE s.GameTypeID = 4101)

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