/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211007
	Task:  Add 20 New Games for [Joker] - Credit RedmineID:#162717
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(17))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--EURO
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,6    UNION ALL	--EURO	--EURO
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 6418 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 6419 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6420 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,6    UNION ALL	--EURO	--EURO
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 6423 ,'0.5'  ,'25'      ,0.5  ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,6    UNION ALL	--EURO	--EURO
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,6    UNION ALL	--EURO	--EURO
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,6    UNION ALL	--EURO	--EURO
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,6    UNION ALL	--EURO	--EURO
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,6    UNION ALL	--EURO	--EURO
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,6    UNION ALL	--EURO	--EURO
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,6    UNION ALL	--EURO	--EURO
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,6    UNION ALL	--EURO	--EURO
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,6    UNION ALL	--EURO	--EURO
SELECT 6434 ,'0.1'  ,'20'      ,0.1  ,20      ,6    UNION ALL	--EURO	--EURO
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,6    UNION ALL	--EURO	--EURO
--IN,IND,IDD,IDR,DDD,UUS
SELECT 6416 ,'0.15' ,'60'      ,0.15 ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6418 ,'0.25' ,'75'      ,0.25 ,75      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6419 ,'0.2'  ,'60'      ,0.2  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6420 ,'0.25' ,'75'      ,0.25 ,75      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6422 ,'0.25' ,'75'      ,0.25 ,75      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6424 ,'0.09' ,'54'      ,0.09 ,54      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6425 ,'0.09' ,'54'      ,0.09 ,54      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6426 ,'0.2'  ,'60'      ,0.2  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6428 ,'0.25' ,'75'      ,0.25 ,75      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6429 ,'0.09' ,'54'      ,0.09 ,54      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6431 ,'0.09' ,'54'      ,0.09 ,54      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6432 ,'0.09' ,'54'      ,0.09 ,54      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6433 ,'0.09' ,'54'      ,0.09 ,54      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6434 ,'0.1'  ,'60'      ,0.1  ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6435 ,'0.15' ,'60'      ,0.15 ,60      ,47   UNION ALL	--DDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6416 ,'0.15' ,'60'      ,0.15 ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6418 ,'0.25' ,'75'      ,0.25 ,75      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6419 ,'0.2'  ,'60'      ,0.2  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6420 ,'0.25' ,'75'      ,0.25 ,75      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6422 ,'0.25' ,'75'      ,0.25 ,75      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6424 ,'0.09' ,'54'      ,0.09 ,54      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6425 ,'0.09' ,'54'      ,0.09 ,54      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6426 ,'0.2'  ,'60'      ,0.2  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6428 ,'0.25' ,'75'      ,0.25 ,75      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6429 ,'0.09' ,'54'      ,0.09 ,54      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6431 ,'0.09' ,'54'      ,0.09 ,54      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6432 ,'0.09' ,'54'      ,0.09 ,54      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6433 ,'0.09' ,'54'      ,0.09 ,54      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6434 ,'0.1'  ,'60'      ,0.1  ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6435 ,'0.15' ,'60'      ,0.15 ,60      ,33   UNION ALL	--IDD	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6416 ,'0.15' ,'60'      ,0.15 ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6418 ,'0.25' ,'75'      ,0.25 ,75      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6419 ,'0.2'  ,'60'      ,0.2  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6420 ,'0.25' ,'75'      ,0.25 ,75      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6422 ,'0.25' ,'75'      ,0.25 ,75      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6424 ,'0.09' ,'54'      ,0.09 ,54      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6425 ,'0.09' ,'54'      ,0.09 ,54      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6426 ,'0.2'  ,'60'      ,0.2  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6428 ,'0.25' ,'75'      ,0.25 ,75      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6429 ,'0.09' ,'54'      ,0.09 ,54      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6431 ,'0.09' ,'54'      ,0.09 ,54      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6432 ,'0.09' ,'54'      ,0.09 ,54      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6433 ,'0.09' ,'54'      ,0.09 ,54      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6434 ,'0.1'  ,'60'      ,0.1  ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6435 ,'0.15' ,'60'      ,0.15 ,60      ,34   UNION ALL	--IDR	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6416 ,'0.15' ,'60'      ,0.15 ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6418 ,'0.25' ,'75'      ,0.25 ,75      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6419 ,'0.2'  ,'60'      ,0.2  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6420 ,'0.25' ,'75'      ,0.25 ,75      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6422 ,'0.25' ,'75'      ,0.25 ,75      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6424 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6425 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6426 ,'0.2'  ,'60'      ,0.2  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6428 ,'0.25' ,'75'      ,0.25 ,75      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6429 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6431 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6432 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6433 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6434 ,'0.1'  ,'60'      ,0.1  ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6435 ,'0.15' ,'60'      ,0.15 ,60      ,15   UNION ALL	--IN	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6416 ,'0.15' ,'60'      ,0.15 ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6418 ,'0.25' ,'75'      ,0.25 ,75      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6419 ,'0.2'  ,'60'      ,0.2  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6420 ,'0.25' ,'75'      ,0.25 ,75      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6422 ,'0.25' ,'75'      ,0.25 ,75      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6424 ,'0.09' ,'54'      ,0.09 ,54      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6425 ,'0.09' ,'54'      ,0.09 ,54      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6426 ,'0.2'  ,'60'      ,0.2  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6428 ,'0.25' ,'75'      ,0.25 ,75      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6429 ,'0.09' ,'54'      ,0.09 ,54      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6431 ,'0.09' ,'54'      ,0.09 ,54      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6432 ,'0.09' ,'54'      ,0.09 ,54      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6433 ,'0.09' ,'54'      ,0.09 ,54      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6434 ,'0.1'  ,'60'      ,0.1  ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
SELECT 6435 ,'0.15' ,'60'      ,0.15 ,60      ,22   UNION ALL	--IND	--IN,IND,IDD,IDR,DDD,UUS
--MMK
SELECT 6416 ,'150'  ,'4500'    ,150  ,4500    ,69   UNION ALL	--MMK	--MMK
SELECT 6417 ,'250'  ,'7500'    ,250  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6418 ,'6250' ,'187500'  ,6250 ,187500  ,69   UNION ALL	--MMK	--MMK
SELECT 6419 ,'4000' ,'120000'  ,4000 ,120000  ,69   UNION ALL	--MMK	--MMK
SELECT 6420 ,'6250' ,'187500'  ,6250 ,187500  ,69   UNION ALL	--MMK	--MMK
SELECT 6421 ,'400'  ,'2000'    ,400  ,2000    ,69   UNION ALL	--MMK	--MMK
SELECT 6422 ,'250'  ,'7500'    ,250  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6423 ,'25000','375000'  ,25000,375000  ,69   UNION ALL	--MMK	--MMK
SELECT 6424 ,'90'   ,'5400'    ,90   ,5400    ,69   UNION ALL	--MMK	--MMK
SELECT 6425 ,'90'   ,'5400'    ,90   ,5400    ,69   UNION ALL	--MMK	--MMK
SELECT 6426 ,'200'  ,'6000'    ,200  ,6000    ,69   UNION ALL	--MMK	--MMK
SELECT 6427 ,'500'  ,'2500'    ,500  ,2500    ,69   UNION ALL	--MMK	--MMK
SELECT 6428 ,'250'  ,'7500'    ,250  ,7500    ,69   UNION ALL	--MMK	--MMK
SELECT 6429 ,'90'   ,'5400'    ,90   ,5400    ,69   UNION ALL	--MMK	--MMK
SELECT 6430 ,'300'  ,'4500'    ,300  ,4500    ,69   UNION ALL	--MMK	--MMK
SELECT 6431 ,'90'   ,'5400'    ,90   ,5400    ,69   UNION ALL	--MMK	--MMK
SELECT 6432 ,'90'   ,'5400'    ,90   ,5400    ,69   UNION ALL	--MMK	--MMK
SELECT 6433 ,'90'   ,'5400'    ,90   ,5400    ,69   UNION ALL	--MMK	--MMK
SELECT 6434 ,'1000' ,'60000'   ,1000 ,60000   ,69   UNION ALL	--MMK	--MMK
SELECT 6435 ,'150'  ,'4500'    ,150  ,4500    ,69   UNION ALL	--MMK	--MMK
--RM,HK$,HKK
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6418 ,'0.25' ,'25'      ,0.25 ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6419 ,'0.2'  ,'20'      ,0.2  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6420 ,'0.25' ,'25'      ,0.25 ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6423 ,'0.5'  ,'25'      ,0.5  ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6434 ,'0.1'  ,'20'      ,0.1  ,20      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,67   UNION ALL	--HKK	--RM,HK$,HKK
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6418 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6419 ,'0.2'  ,'20'      ,0.2  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6420 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6423 ,'0.5'  ,'25'      ,0.5  ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6434 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM,HK$,HKK
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,2    UNION ALL	--RM	--RM,HK$,HKK
--RMB,CY
SELECT 6416 ,'15'   ,'4500'    ,15   ,4500    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6417 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6418 ,'25'   ,'12500'   ,25   ,12500   ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6419 ,'20'   ,'4000'    ,20   ,4000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6420 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6421 ,'40'   ,'4000'    ,40   ,4000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6422 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6423 ,'50'   ,'10000'   ,50   ,10000   ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6424 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6425 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6426 ,'20'   ,'4000'    ,20   ,4000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6427 ,'50'   ,'5000'    ,50   ,5000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6428 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6429 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6430 ,'30'   ,'6000'    ,30   ,6000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6431 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6432 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6433 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6434 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,CY
SELECT 6435 ,'15'   ,'4500'    ,15   ,4500    ,13   UNION ALL	--RMB	--RMB,CY
--TB,THB
SELECT 6416 ,'150'  ,'15000'   ,150  ,15000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6417 ,'250'  ,'25000'   ,250  ,25000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6418 ,'250'  ,'50000'   ,250  ,50000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6419 ,'200'  ,'20000'   ,200  ,20000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6420 ,'250'  ,'25000'   ,250  ,25000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6421 ,'400'  ,'24000'   ,400  ,24000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6422 ,'250'  ,'25000'   ,250  ,25000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6423 ,'500'  ,'50000'   ,500  ,50000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6424 ,'90'   ,'18000'   ,90   ,18000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6425 ,'90'   ,'18000'   ,90   ,18000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6426 ,'200'  ,'20000'   ,200  ,20000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6427 ,'500'  ,'30000'   ,500  ,30000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6428 ,'250'  ,'25000'   ,250  ,25000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6429 ,'90'   ,'18000'   ,90   ,18000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6430 ,'300'  ,'9000'    ,300  ,9000    ,43   UNION ALL	--THB	--TB,THB
SELECT 6431 ,'90'   ,'18000'   ,90   ,18000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6432 ,'90'   ,'18000'   ,90   ,18000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6433 ,'90'   ,'18000'   ,90   ,18000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6434 ,'100'  ,'20000'   ,100  ,20000   ,43   UNION ALL	--THB	--TB,THB
SELECT 6435 ,'150'  ,'15000'   ,150  ,15000   ,43   UNION ALL	--THB	--TB,THB
--US$,YEN,$US,UT,USD
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6418 ,'6.25' ,'625'     ,6.25 ,625     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6419 ,'4'    ,'400'     ,4    ,400     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6420 ,'6.25' ,'625'     ,6.25 ,625     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6423 ,'25'   ,'1250'    ,25   ,1250    ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6434 ,'1'    ,'200'     ,1    ,200     ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,35   UNION ALL	--$US	--US$,YEN,$US,UT,USD
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6418 ,'6.25' ,'625'     ,6.25 ,625     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6419 ,'4'    ,'400'     ,4    ,400     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6420 ,'6.25' ,'625'     ,6.25 ,625     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6423 ,'25'   ,'1250'    ,25   ,1250    ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6434 ,'1'    ,'200'     ,1    ,200     ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,3    UNION ALL	--US$	--US$,YEN,$US,UT,USD
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6418 ,'6.25' ,'625'     ,6.25 ,625     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6419 ,'4'    ,'400'     ,4    ,400     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6420 ,'6.25' ,'625'     ,6.25 ,625     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6423 ,'25'   ,'1250'    ,25   ,1250    ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6434 ,'1'    ,'200'     ,1    ,200     ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,95   UNION ALL	--USD	--US$,YEN,$US,UT,USD
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6418 ,'6.25' ,'625'     ,6.25 ,625     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6419 ,'4'    ,'400'     ,4    ,400     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6420 ,'6.25' ,'625'     ,6.25 ,625     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6423 ,'25'   ,'1250'    ,25   ,1250    ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6434 ,'1'    ,'200'     ,1    ,200     ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,64   UNION ALL	--UT	--US$,YEN,$US,UT,USD
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6418 ,'6.25' ,'625'     ,6.25 ,625     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6419 ,'4'    ,'400'     ,4    ,400     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6420 ,'6.25' ,'625'     ,6.25 ,625     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6423 ,'25'   ,'1250'    ,25   ,1250    ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6434 ,'1'    ,'200'     ,1    ,200     ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,16   UNION ALL	--Yen	--US$,YEN,$US,UT,USD
--Won
SELECT 6416 ,'150'  ,'4500'    ,150  ,4500    ,45   UNION ALL	--Won	--Won
SELECT 6417 ,'250'  ,'7500'    ,250  ,7500    ,45   UNION ALL	--Won	--Won
SELECT 6418 ,'6250' ,'187500'  ,6250 ,187500  ,45   UNION ALL	--Won	--Won
SELECT 6419 ,'4000' ,'120000'  ,4000 ,120000  ,45   UNION ALL	--Won	--Won
SELECT 6420 ,'6250' ,'187500'  ,6250 ,187500  ,45   UNION ALL	--Won	--Won
SELECT 6421 ,'400'  ,'2000'    ,400  ,2000    ,45   UNION ALL	--Won	--Won
SELECT 6422 ,'250'  ,'7500'    ,250  ,7500    ,45   UNION ALL	--Won	--Won
SELECT 6423 ,'25000','375000'  ,25000,375000  ,45   UNION ALL	--Won	--Won
SELECT 6424 ,'90'   ,'5400'    ,90   ,5400    ,45   UNION ALL	--Won	--Won
SELECT 6425 ,'90'   ,'5400'    ,90   ,5400    ,45   UNION ALL	--Won	--Won
SELECT 6426 ,'200'  ,'6000'    ,200  ,6000    ,45   UNION ALL	--Won	--Won
SELECT 6427 ,'500'  ,'2500'    ,500  ,2500    ,45   UNION ALL	--Won	--Won
SELECT 6428 ,'250'  ,'7500'    ,250  ,7500    ,45   UNION ALL	--Won	--Won
SELECT 6429 ,'90'   ,'5400'    ,90   ,5400    ,45   UNION ALL	--Won	--Won
SELECT 6430 ,'300'  ,'4500'    ,300  ,4500    ,45   UNION ALL	--Won	--Won
SELECT 6431 ,'90'   ,'5400'    ,90   ,5400    ,45   UNION ALL	--Won	--Won
SELECT 6432 ,'90'   ,'5400'    ,90   ,5400    ,45   UNION ALL	--Won	--Won
SELECT 6433 ,'90'   ,'5400'    ,90   ,5400    ,45   UNION ALL	--Won	--Won
SELECT 6434 ,'1000' ,'60000'   ,1000 ,60000   ,45   UNION ALL	--Won	--Won
SELECT 6435 ,'150'  ,'4500'    ,150  ,4500    ,45				--Won	--Won

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
WHERE s.GameTypeID = 6401)

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
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 