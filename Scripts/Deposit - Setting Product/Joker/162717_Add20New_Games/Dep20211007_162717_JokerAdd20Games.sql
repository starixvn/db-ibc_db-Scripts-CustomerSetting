/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211007
	Task:  Add 20 New Games for [Joker] - Deposit RedmineID:#162717
	DB: DBCust/CustDB
*/
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(18))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
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
--IN
SELECT 6416 ,'0.15' ,'60'      ,0.15 ,60      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6418 ,'0.25' ,'75'      ,0.25 ,75      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6419 ,'0.2'  ,'60'      ,0.2  ,60      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6420 ,'0.25' ,'75'      ,0.25 ,75      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6422 ,'0.25' ,'75'      ,0.25 ,75      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6424 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6425 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6426 ,'0.2'  ,'60'      ,0.2  ,60      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6428 ,'0.25' ,'75'      ,0.25 ,75      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6429 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6431 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6432 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6433 ,'0.09' ,'54'      ,0.09 ,54      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6434 ,'0.1'  ,'60'      ,0.1  ,60      ,15   UNION ALL	--IN	--IN,UUS
SELECT 6435 ,'0.15' ,'60'      ,0.15 ,60      ,15   UNION ALL	--IN	--IN,UUS
--RM
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,2    UNION ALL	--RM	--RM
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM
SELECT 6418 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM
SELECT 6419 ,'0.2'  ,'20'      ,0.2  ,20      ,2    UNION ALL	--RM	--RM
SELECT 6420 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,2    UNION ALL	--RM	--RM
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM
SELECT 6423 ,'0.5'  ,'25'      ,0.5  ,25      ,2    UNION ALL	--RM	--RM
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,2    UNION ALL	--RM	--RM
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,2    UNION ALL	--RM	--RM
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,2    UNION ALL	--RM	--RM
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,2    UNION ALL	--RM	--RM
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,2    UNION ALL	--RM	--RM
SELECT 6434 ,'0.1'  ,'20'      ,0.1  ,20      ,2    UNION ALL	--RM	--RM
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,2    UNION ALL	--RM	--RM
--HK$
SELECT 6416 ,'0.15' ,'60'      ,0.15 ,60      ,5    UNION ALL	--HK$	--HK$
SELECT 6417 ,'0.25' ,'50'      ,0.25 ,50      ,5    UNION ALL	--HK$	--HK$
SELECT 6418 ,'0.25' ,'75'      ,0.25 ,75      ,5    UNION ALL	--HK$	--HK$
SELECT 6419 ,'0.2'  ,'60'      ,0.2  ,60      ,5    UNION ALL	--HK$	--HK$
SELECT 6420 ,'0.25' ,'75'      ,0.25 ,75      ,5    UNION ALL	--HK$	--HK$
SELECT 6421 ,'0.4'  ,'40'      ,0.4  ,40      ,5    UNION ALL	--HK$	--HK$
SELECT 6422 ,'0.25' ,'75'      ,0.25 ,75      ,5    UNION ALL	--HK$	--HK$
SELECT 6423 ,'0.5'  ,'50'      ,0.5  ,50      ,5    UNION ALL	--HK$	--HK$
SELECT 6424 ,'0.09' ,'54'      ,0.09 ,54      ,5    UNION ALL	--HK$	--HK$
SELECT 6425 ,'0.09' ,'54'      ,0.09 ,54      ,5    UNION ALL	--HK$	--HK$
SELECT 6426 ,'0.2'  ,'60'      ,0.2  ,60      ,5    UNION ALL	--HK$	--HK$
SELECT 6427 ,'0.5'  ,'50'      ,0.5  ,50      ,5    UNION ALL	--HK$	--HK$
SELECT 6428 ,'0.25' ,'75'      ,0.25 ,75      ,5    UNION ALL	--HK$	--HK$
SELECT 6429 ,'0.09' ,'54'      ,0.09 ,54      ,5    UNION ALL	--HK$	--HK$
SELECT 6430 ,'0.3'  ,'60'      ,0.3  ,60      ,5    UNION ALL	--HK$	--HK$
SELECT 6431 ,'0.09' ,'54'      ,0.09 ,54      ,5    UNION ALL	--HK$	--HK$
SELECT 6432 ,'0.09' ,'54'      ,0.09 ,54      ,5    UNION ALL	--HK$	--HK$
SELECT 6433 ,'0.09' ,'54'      ,0.09 ,54      ,5    UNION ALL	--HK$	--HK$
SELECT 6434 ,'0.1'  ,'60'      ,0.1  ,60      ,5    UNION ALL	--HK$	--HK$
SELECT 6435 ,'0.15' ,'60'      ,0.15 ,60      ,5    UNION ALL	--HK$	--HK$
--RMB,YUN
SELECT 6416 ,'15'   ,'4500'    ,15   ,4500    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6417 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6418 ,'25'   ,'12500'   ,25   ,12500   ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6419 ,'20'   ,'4000'    ,20   ,4000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6420 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6421 ,'40'   ,'4000'    ,40   ,4000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6422 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6423 ,'50'   ,'10000'   ,50   ,10000   ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6424 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6425 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6426 ,'20'   ,'4000'    ,20   ,4000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6427 ,'50'   ,'5000'    ,50   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6428 ,'25'   ,'5000'    ,25   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6429 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6430 ,'30'   ,'6000'    ,30   ,6000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6431 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6432 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6433 ,'9'    ,'4500'    ,9    ,4500    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6434 ,'10'   ,'5000'    ,10   ,5000    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6435 ,'15'   ,'4500'    ,15   ,4500    ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6416 ,'15'   ,'4500'    ,15   ,4500    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6417 ,'25'   ,'5000'    ,25   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6418 ,'25'   ,'12500'   ,25   ,12500   ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6419 ,'20'   ,'4000'    ,20   ,4000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6420 ,'25'   ,'5000'    ,25   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6421 ,'40'   ,'4000'    ,40   ,4000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6422 ,'25'   ,'5000'    ,25   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6423 ,'50'   ,'10000'   ,50   ,10000   ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6424 ,'9'    ,'4500'    ,9    ,4500    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6425 ,'9'    ,'4500'    ,9    ,4500    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6426 ,'20'   ,'4000'    ,20   ,4000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6427 ,'50'   ,'5000'    ,50   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6428 ,'25'   ,'5000'    ,25   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6429 ,'9'    ,'4500'    ,9    ,4500    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6430 ,'30'   ,'6000'    ,30   ,6000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6431 ,'9'    ,'4500'    ,9    ,4500    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6432 ,'9'    ,'4500'    ,9    ,4500    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6433 ,'9'    ,'4500'    ,9    ,4500    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6434 ,'10'   ,'5000'    ,10   ,5000    ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6435 ,'15'   ,'4500'    ,15   ,4500    ,66   UNION ALL	--YUN	--RMB,YUN
--TB
SELECT 6416 ,'150'  ,'15000'   ,150  ,15000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6417 ,'250'  ,'25000'   ,250  ,25000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6418 ,'250'  ,'50000'   ,250  ,50000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6419 ,'200'  ,'20000'   ,200  ,20000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6420 ,'250'  ,'25000'   ,250  ,25000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6421 ,'400'  ,'24000'   ,400  ,24000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6422 ,'250'  ,'25000'   ,250  ,25000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6423 ,'500'  ,'50000'   ,500  ,50000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6424 ,'90'   ,'18000'   ,90   ,18000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6425 ,'90'   ,'18000'   ,90   ,18000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6426 ,'200'  ,'20000'   ,200  ,20000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6427 ,'500'  ,'30000'   ,500  ,30000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6428 ,'250'  ,'25000'   ,250  ,25000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6429 ,'90'   ,'18000'   ,90   ,18000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6430 ,'300'  ,'9000'    ,300  ,9000    ,4    UNION ALL	--TB	--TB,THB
SELECT 6431 ,'90'   ,'18000'   ,90   ,18000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6432 ,'90'   ,'18000'   ,90   ,18000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6433 ,'90'   ,'18000'   ,90   ,18000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6434 ,'100'  ,'20000'   ,100  ,20000   ,4    UNION ALL	--TB	--TB,THB
SELECT 6435 ,'150'  ,'15000'   ,150  ,15000   ,4    UNION ALL	--TB	--TB,THB
--US$
SELECT 6416 ,'0.15' ,'15'      ,0.15 ,15      ,3    UNION ALL	--US$	--US$
SELECT 6417 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$
SELECT 6418 ,'6.25' ,'625'     ,6.25 ,625     ,3    UNION ALL	--US$	--US$
SELECT 6419 ,'4'    ,'400'     ,4    ,400     ,3    UNION ALL	--US$	--US$
SELECT 6420 ,'6.25' ,'625'     ,6.25 ,625     ,3    UNION ALL	--US$	--US$
SELECT 6421 ,'0.4'  ,'8'       ,0.4  ,8       ,3    UNION ALL	--US$	--US$
SELECT 6422 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$
SELECT 6423 ,'25'   ,'1250'    ,25   ,1250    ,3    UNION ALL	--US$	--US$
SELECT 6424 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$
SELECT 6425 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$
SELECT 6426 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--US$
SELECT 6427 ,'0.5'  ,'10'      ,0.5  ,10      ,3    UNION ALL	--US$	--US$
SELECT 6428 ,'0.25' ,'25'      ,0.25 ,25      ,3    UNION ALL	--US$	--US$
SELECT 6429 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$
SELECT 6430 ,'0.3'  ,'30'      ,0.3  ,30      ,3    UNION ALL	--US$	--US$
SELECT 6431 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$
SELECT 6432 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$
SELECT 6433 ,'0.09' ,'18'      ,0.09 ,18      ,3    UNION ALL	--US$	--US$
SELECT 6434 ,'1'    ,'200'     ,1    ,200     ,3    UNION ALL	--US$	--US$
SELECT 6435 ,'0.15' ,'15'      ,0.15 ,15      ,3    UNION ALL	--US$	--US$
--INR
SELECT 6416 ,'1500' ,'30000'   ,1500 ,30000   ,61   UNION ALL	--INR	--INR
SELECT 6417 ,'2500' ,'50000'   ,2500 ,50000   ,61   UNION ALL	--INR	--INR
SELECT 6418 ,'2500' ,'50000'   ,2500 ,50000   ,61   UNION ALL	--INR	--INR
SELECT 6419 ,'2000' ,'40000'   ,2000 ,40000   ,61   UNION ALL	--INR	--INR
SELECT 6420 ,'2500' ,'50000'   ,2500 ,50000   ,61   UNION ALL	--INR	--INR
SELECT 6421 ,'5000' ,'100000'  ,5000 ,100000  ,61   UNION ALL	--INR	--INR
SELECT 6422 ,'2500' ,'50000'   ,2500 ,50000   ,61   UNION ALL	--INR	--INR
SELECT 6423 ,'5000' ,'50000'   ,5000 ,50000   ,61   UNION ALL	--INR	--INR
SELECT 6424 ,'900'  ,'18000'   ,900  ,18000   ,61   UNION ALL	--INR	--INR
SELECT 6425 ,'900'  ,'18000'   ,900  ,18000   ,61   UNION ALL	--INR	--INR
SELECT 6426 ,'2000' ,'40000'   ,2000 ,40000   ,61   UNION ALL	--INR	--INR
SELECT 6427 ,'5000' ,'100000'  ,5000 ,100000  ,61   UNION ALL	--INR	--INR
SELECT 6428 ,'2500' ,'50000'   ,2500 ,50000   ,61   UNION ALL	--INR	--INR
SELECT 6429 ,'900'  ,'18000'   ,900  ,18000   ,61   UNION ALL	--INR	--INR
SELECT 6430 ,'3000' ,'60000'   ,3000 ,60000   ,61   UNION ALL	--INR	--INR
SELECT 6431 ,'900'  ,'18000'   ,900  ,18000   ,61   UNION ALL	--INR	--INR
SELECT 6432 ,'900'  ,'18000'   ,900  ,18000   ,61   UNION ALL	--INR	--INR
SELECT 6433 ,'900'  ,'18000'   ,900  ,18000   ,61   UNION ALL	--INR	--INR
SELECT 6434 ,'1000' ,'20000'   ,1000 ,20000   ,61   UNION ALL	--INR	--INR
SELECT 6435 ,'1500' ,'30000'   ,1500 ,30000   ,61   UNION ALL	--INR	--INR
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
FROM #Dep_StakeLevel_Temp t
WHERE MinStake > 999

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
WHERE s.GameTypeID = 6401)

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
