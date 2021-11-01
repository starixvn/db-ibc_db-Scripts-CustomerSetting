/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 202111101
	Created: Winfred 
	Task: #163502 - Pragmatic - Integrate 16 new games for Credit [Redmine:163502]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(6))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--GBP
SELECT 4282 ,'0.4'  ,'8'       ,0.4  ,8       ,12   UNION ALL	--GBP	--GBP
SELECT 4283 ,'0.4'  ,'8'       ,0.4  ,8       ,12   UNION ALL	--GBP	--GBP
SELECT 4284 ,'1.8'  ,'18'      ,1.8  ,18      ,12   UNION ALL	--GBP	--GBP
SELECT 4285 ,'1.2'  ,'24'      ,1.2  ,24      ,12   UNION ALL	--GBP	--GBP
SELECT 4286 ,'0.4'  ,'16'      ,0.4  ,16      ,12   UNION ALL	--GBP	--GBP
SELECT 4287 ,'0.4'  ,'20'      ,0.4  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 4288 ,'0.9'  ,'18'      ,0.9  ,18      ,12   UNION ALL	--GBP	--GBP
SELECT 4289 ,'0.4'  ,'16'      ,0.4  ,16      ,12   UNION ALL	--GBP	--GBP
SELECT 4290 ,'0.4'  ,'16'      ,0.4  ,16      ,12   UNION ALL	--GBP	--GBP
SELECT 4291 ,'0.4'  ,'16'      ,0.4  ,16      ,12   UNION ALL	--GBP	--GBP
--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'  ,'240'     ,0.2  ,240     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.2'  ,'240'     ,0.2  ,240     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4284 ,'0.9'  ,'360'     ,0.9  ,360     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4285 ,'0.6'  ,'480'     ,0.6  ,480     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'  ,'240'     ,0.2  ,240     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4287 ,'0.2'  ,'240'     ,0.2  ,240     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4288 ,'0.45' ,'360'     ,0.45 ,360     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'  ,'240'     ,0.2  ,240     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4290 ,'0.2'  ,'240'     ,0.2  ,240     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4291 ,'0.2'  ,'240'     ,0.2  ,240     ,47   UNION ALL	--DDD	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'  ,'240'     ,0.2  ,240     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.2'  ,'240'     ,0.2  ,240     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4284 ,'0.9'  ,'360'     ,0.9  ,360     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4285 ,'0.6'  ,'480'     ,0.6  ,480     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'  ,'240'     ,0.2  ,240     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4287 ,'0.2'  ,'240'     ,0.2  ,240     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4288 ,'0.45' ,'360'     ,0.45 ,360     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'  ,'240'     ,0.2  ,240     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4290 ,'0.2'  ,'240'     ,0.2  ,240     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4291 ,'0.2'  ,'240'     ,0.2  ,240     ,33   UNION ALL	--IDD	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'  ,'240'     ,0.2  ,240     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.2'  ,'240'     ,0.2  ,240     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4284 ,'0.9'  ,'360'     ,0.9  ,360     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4285 ,'0.6'  ,'480'     ,0.6  ,480     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'  ,'240'     ,0.2  ,240     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4287 ,'0.2'  ,'240'     ,0.2  ,240     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4288 ,'0.45' ,'360'     ,0.45 ,360     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'  ,'240'     ,0.2  ,240     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4290 ,'0.2'  ,'240'     ,0.2  ,240     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4291 ,'0.2'  ,'240'     ,0.2  ,240     ,34   UNION ALL	--IDR	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'  ,'240'     ,0.2  ,240     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.2'  ,'240'     ,0.2  ,240     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4284 ,'0.9'  ,'360'     ,0.9  ,360     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4285 ,'0.6'  ,'480'     ,0.6  ,480     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'  ,'240'     ,0.2  ,240     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4287 ,'0.2'  ,'240'     ,0.2  ,240     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4288 ,'0.45' ,'360'     ,0.45 ,360     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'  ,'240'     ,0.2  ,240     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4290 ,'0.2'  ,'240'     ,0.2  ,240     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4291 ,'0.2'  ,'240'     ,0.2  ,240     ,15   UNION ALL	--IN	--IDR,DDD,IDD,IN,IND
SELECT 4282 ,'0.2'  ,'240'     ,0.2  ,240     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4283 ,'0.2'  ,'240'     ,0.2  ,240     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4284 ,'0.9'  ,'360'     ,0.9  ,360     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4285 ,'0.6'  ,'480'     ,0.6  ,480     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4286 ,'0.2'  ,'240'     ,0.2  ,240     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4287 ,'0.2'  ,'240'     ,0.2  ,240     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4288 ,'0.45' ,'360'     ,0.45 ,360     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4289 ,'0.2'  ,'240'     ,0.2  ,240     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4290 ,'0.2'  ,'240'     ,0.2  ,240     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
SELECT 4291 ,'0.2'  ,'240'     ,0.2  ,240     ,22   UNION ALL	--IND	--IDR,DDD,IDD,IN,IND
--INH
SELECT 4282 ,'10'   ,'400'     ,10   ,400     ,51   UNION ALL	--INH	--INH
SELECT 4283 ,'10'   ,'400'     ,10   ,400     ,51   UNION ALL	--INH	--INH
SELECT 4284 ,'45'   ,'360'     ,45   ,360     ,51   UNION ALL	--INH	--INH
SELECT 4285 ,'30'   ,'900'     ,30   ,900     ,51   UNION ALL	--INH	--INH
SELECT 4286 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4287 ,'10'   ,'600'     ,10   ,600     ,51   UNION ALL	--INH	--INH
SELECT 4288 ,'22.5' ,'675'     ,22.5 ,675     ,51   UNION ALL	--INH	--INH
SELECT 4289 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4290 ,'10'   ,'800'     ,10   ,800     ,51   UNION ALL	--INH	--INH
SELECT 4291 ,'10'   ,'600'     ,10   ,600     ,51   UNION ALL	--INH	--INH
--RM , HKK
SELECT 4282 ,'1'    ,'80'      ,1    ,80      ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4283 ,'1'    ,'80'      ,1    ,80      ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4284 ,'4.5'  ,'135'     ,4.5  ,135     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4285 ,'3'    ,'120'     ,3    ,120     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4286 ,'1'    ,'160'     ,1    ,160     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4287 ,'1'    ,'120'     ,1    ,120     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4288 ,'2.25' ,'180'     ,2.25 ,180     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4289 ,'1'    ,'160'     ,1    ,160     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4290 ,'1'    ,'160'     ,1    ,160     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4291 ,'1'    ,'120'     ,1    ,120     ,67   UNION ALL	--HKK	--RM , HKK
SELECT 4282 ,'1'    ,'80'      ,1    ,80      ,2    UNION ALL	--RM	--RM , HKK
SELECT 4283 ,'1'    ,'80'      ,1    ,80      ,2    UNION ALL	--RM	--RM , HKK
SELECT 4284 ,'4.5'  ,'135'     ,4.5  ,135     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4285 ,'3'    ,'120'     ,3    ,120     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4286 ,'1'    ,'160'     ,1    ,160     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4287 ,'1'    ,'120'     ,1    ,120     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4288 ,'2.25' ,'180'     ,2.25 ,180     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4289 ,'1'    ,'160'     ,1    ,160     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4290 ,'1'    ,'160'     ,1    ,160     ,2    UNION ALL	--RM	--RM , HKK
SELECT 4291 ,'1'    ,'120'     ,1    ,120     ,2    UNION ALL	--RM	--RM , HKK
--RMB , HK$
SELECT 4282 ,'2'    ,'160'     ,2    ,160     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4283 ,'2'    ,'160'     ,2    ,160     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4284 ,'9'    ,'180'     ,9    ,180     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4285 ,'6'    ,'360'     ,6    ,360     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4286 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4287 ,'2'    ,'160'     ,2    ,160     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4288 ,'4.5'  ,'270'     ,4.5  ,270     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4289 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4290 ,'2'    ,'300'     ,2    ,300     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4291 ,'2'    ,'200'     ,2    ,200     ,81   UNION ALL	--CY	--RMB , HK$,CY
SELECT 4282 ,'2'    ,'160'     ,2    ,160     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4283 ,'2'    ,'160'     ,2    ,160     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4284 ,'9'    ,'180'     ,9    ,180     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4285 ,'6'    ,'360'     ,6    ,360     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4286 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4287 ,'2'    ,'160'     ,2    ,160     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4288 ,'4.5'  ,'270'     ,4.5  ,270     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4289 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4290 ,'2'    ,'300'     ,2    ,300     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4291 ,'2'    ,'200'     ,2    ,200     ,5    UNION ALL	--HK$	--RMB , HK$,CY
SELECT 4282 ,'2'    ,'160'     ,2    ,160     ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4283 ,'2'    ,'160'     ,2    ,160     ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4284 ,'9'    ,'180'     ,9    ,180     ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4285 ,'6'    ,'360'     ,6    ,360     ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4286 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4287 ,'2'    ,'160'     ,2    ,160     ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4288 ,'4.5'  ,'270'     ,4.5  ,270     ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4289 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4290 ,'2'    ,'300'     ,2    ,300     ,13   UNION ALL	--RMB	--RMB , HK$,CY
SELECT 4291 ,'2'    ,'200'     ,2    ,200     ,13   UNION ALL	--RMB	--RMB , HK$,CY
--THB , TB
SELECT 4282 ,'10'   ,'600'     ,10   ,600     ,43   UNION ALL	--THB	--THB , TB
SELECT 4283 ,'10'   ,'600'     ,10   ,600     ,43   UNION ALL	--THB	--THB , TB
SELECT 4284 ,'45'   ,'450'     ,45   ,450     ,43   UNION ALL	--THB	--THB , TB
SELECT 4285 ,'30'   ,'1200'    ,30   ,1200    ,43   UNION ALL	--THB	--THB , TB
SELECT 4286 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4287 ,'10'   ,'600'     ,10   ,600     ,43   UNION ALL	--THB	--THB , TB
SELECT 4288 ,'22.5' ,'1125'    ,22.5 ,1125    ,43   UNION ALL	--THB	--THB , TB
SELECT 4289 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4290 ,'10'   ,'1000'    ,10   ,1000    ,43   UNION ALL	--THB	--THB , TB
SELECT 4291 ,'10'   ,'600'     ,10   ,600     ,43   UNION ALL	--THB	--THB , TB
-- US$, USD , YEN , UT , $US , YNG , MMK
SELECT 4282 ,'0.4'  ,'20'      ,0.4  ,20      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.4'  ,'20'      ,0.4  ,20      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4285 ,'1.2'  ,'60'      ,1.2  ,60      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.4'  ,'100'     ,0.4  ,100     ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4287 ,'0.4'  ,'30'      ,0.4  ,30      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4288 ,'0.9'  ,'45'      ,0.9  ,45      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4291 ,'0.4'  ,'30'      ,0.4  ,30      ,35   UNION ALL	--$US	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.4'  ,'20'      ,0.4  ,20      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.4'  ,'20'      ,0.4  ,20      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4285 ,'1.2'  ,'60'      ,1.2  ,60      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.4'  ,'100'     ,0.4  ,100     ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4287 ,'0.4'  ,'30'      ,0.4  ,30      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4288 ,'0.9'  ,'45'      ,0.9  ,45      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4291 ,'0.4'  ,'30'      ,0.4  ,30      ,6    UNION ALL	--EURO	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.4'  ,'20'      ,0.4  ,20      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.4'  ,'20'      ,0.4  ,20      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4285 ,'1.2'  ,'60'      ,1.2  ,60      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.4'  ,'100'     ,0.4  ,100     ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4287 ,'0.4'  ,'30'      ,0.4  ,30      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4288 ,'0.9'  ,'45'      ,0.9  ,45      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4291 ,'0.4'  ,'30'      ,0.4  ,30      ,69   UNION ALL	--MMK	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.4'  ,'20'      ,0.4  ,20      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.4'  ,'20'      ,0.4  ,20      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4285 ,'1.2'  ,'60'      ,1.2  ,60      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.4'  ,'100'     ,0.4  ,100     ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4287 ,'0.4'  ,'30'      ,0.4  ,30      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4288 ,'0.9'  ,'45'      ,0.9  ,45      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4291 ,'0.4'  ,'30'      ,0.4  ,30      ,3    UNION ALL	--US$	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.4'  ,'20'      ,0.4  ,20      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.4'  ,'20'      ,0.4  ,20      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4285 ,'1.2'  ,'60'      ,1.2  ,60      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.4'  ,'100'     ,0.4  ,100     ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4287 ,'0.4'  ,'30'      ,0.4  ,30      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4288 ,'0.9'  ,'45'      ,0.9  ,45      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4291 ,'0.4'  ,'30'      ,0.4  ,30      ,95   UNION ALL	--USD	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.4'  ,'20'      ,0.4  ,20      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.4'  ,'20'      ,0.4  ,20      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4285 ,'1.2'  ,'60'      ,1.2  ,60      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.4'  ,'100'     ,0.4  ,100     ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4287 ,'0.4'  ,'30'      ,0.4  ,30      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4288 ,'0.9'  ,'45'      ,0.9  ,45      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4291 ,'0.4'  ,'30'      ,0.4  ,30      ,64   UNION ALL	--UT	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4282 ,'0.4'  ,'20'      ,0.4  ,20      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4283 ,'0.4'  ,'20'      ,0.4  ,20      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4284 ,'1.8'  ,'27'      ,1.8  ,27      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4285 ,'1.2'  ,'60'      ,1.2  ,60      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4286 ,'0.4'  ,'100'     ,0.4  ,100     ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4287 ,'0.4'  ,'30'      ,0.4  ,30      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4288 ,'0.9'  ,'45'      ,0.9  ,45      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4289 ,'0.4'  ,'50'      ,0.4  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4290 ,'0.4'  ,'50'      ,0.4  ,50      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
SELECT 4291 ,'0.4'  ,'30'      ,0.4  ,30      ,16   UNION ALL	--Yen	--USD , YEN , UT , $US , YNG , MMK , US$,UUS , EURO
--WON , KRW
SELECT 4282 ,'400'  ,'20000'   ,400  ,20000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4283 ,'400'  ,'20000'   ,400  ,20000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4284 ,'1800' ,'18000'   ,1800 ,18000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4285 ,'1200' ,'60000'   ,1200 ,60000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4286 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4287 ,'400'  ,'20000'   ,400  ,20000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4288 ,'900'  ,'45000'   ,900  ,45000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4289 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4290 ,'400'  ,'40000'   ,400  ,40000   ,45   UNION ALL	--Won	--WON , KRW
SELECT 4291 ,'400'  ,'20000'   ,400  ,20000   ,45   			--Won	--WON , KRW
	
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