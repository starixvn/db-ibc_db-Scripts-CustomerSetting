/*
	Date: 20200819
	Created: Winfred 
	Task: #139920 - Macau Game - 10 game Blue Print - Deposit -Real Currency [redmine : 139850]
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(3))
								
INSERT INTO #StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--CY
SELECT 4057 ,'0.1'  ,'30'      ,0.1  ,30      ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
SELECT 4058 ,'0.1'  ,'8'       ,0.1  ,8       ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
SELECT 4059 ,'0.1'  ,'40'      ,0.1  ,40      ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
SELECT 4061 ,'0.2'  ,'20'      ,0.2  ,20      ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
SELECT 4063 ,'0.1'  ,'40'      ,0.1  ,40      ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
SELECT 4073 ,'0.2'  ,'8'       ,0.2  ,8       ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
SELECT 4077 ,'0.2'  ,'20'      ,0.2  ,20      ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
SELECT 4078 ,'0.1'  ,'8'       ,0.1  ,8       ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
SELECT 4079 ,'0.5'  ,'40'      ,0.5  ,40      ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
SELECT 4080 ,'0.2'  ,'40'      ,0.2  ,40      ,81   UNION ALL	--CY	--CNY,RMB, CY, YUN
--RMB
SELECT 4057 ,'0.1'  ,'30'      ,0.1  ,30      ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
SELECT 4058 ,'0.1'  ,'8'       ,0.1  ,8       ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
SELECT 4059 ,'0.1'  ,'40'      ,0.1  ,40      ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
SELECT 4061 ,'0.2'  ,'20'      ,0.2  ,20      ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
SELECT 4063 ,'0.1'  ,'40'      ,0.1  ,40      ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
SELECT 4073 ,'0.2'  ,'8'       ,0.2  ,8       ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
SELECT 4077 ,'0.2'  ,'20'      ,0.2  ,20      ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
SELECT 4078 ,'0.1'  ,'8'       ,0.1  ,8       ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
SELECT 4079 ,'0.5'  ,'40'      ,0.5  ,40      ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
SELECT 4080 ,'0.2'  ,'40'      ,0.2  ,40      ,13   UNION ALL	--RMB	--CNY,RMB, CY, YUN
--YUN
SELECT 4057 ,'0.1'  ,'30'      ,0.1  ,30      ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
SELECT 4058 ,'0.1'  ,'8'       ,0.1  ,8       ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
SELECT 4059 ,'0.1'  ,'40'      ,0.1  ,40      ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
SELECT 4061 ,'0.2'  ,'20'      ,0.2  ,20      ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
SELECT 4063 ,'0.1'  ,'40'      ,0.1  ,40      ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
SELECT 4073 ,'0.2'  ,'8'       ,0.2  ,8       ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
SELECT 4077 ,'0.2'  ,'20'      ,0.2  ,20      ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
SELECT 4078 ,'0.1'  ,'8'       ,0.1  ,8       ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
SELECT 4079 ,'0.5'  ,'40'      ,0.5  ,40      ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
SELECT 4080 ,'0.2'  ,'40'      ,0.2  ,40      ,66   UNION ALL	--YUN	--CNY,RMB, CY, YUN
--DDD
SELECT 4057 ,'0.3'  ,'90'      ,0.3  ,90      ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4058 ,'0.3'  ,'24'      ,0.3  ,24      ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4059 ,'0.3'  ,'120'     ,0.3  ,120     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4061 ,'0.6'  ,'60'      ,0.6  ,60      ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4063 ,'0.3'  ,'120'     ,0.3  ,120     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4073 ,'0.6'  ,'24'      ,0.6  ,24      ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4077 ,'0.6'  ,'60'      ,0.6  ,60      ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4078 ,'0.3'  ,'24'      ,0.3  ,24      ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4079 ,'1.5'  ,'120'     ,1.5  ,120     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
SELECT 4080 ,'0.6'  ,'120'     ,0.6  ,120     ,47   UNION ALL	--DDD	--DDD, IND, IDR, IDD, IN
--IDD
SELECT 4057 ,'0.3'  ,'90'      ,0.3  ,90      ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4058 ,'0.3'  ,'24'      ,0.3  ,24      ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4059 ,'0.3'  ,'120'     ,0.3  ,120     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4061 ,'0.6'  ,'60'      ,0.6  ,60      ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4063 ,'0.3'  ,'120'     ,0.3  ,120     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4073 ,'0.6'  ,'24'      ,0.6  ,24      ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4077 ,'0.6'  ,'60'      ,0.6  ,60      ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4078 ,'0.3'  ,'24'      ,0.3  ,24      ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4079 ,'1.5'  ,'120'     ,1.5  ,120     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
SELECT 4080 ,'0.6'  ,'120'     ,0.6  ,120     ,33   UNION ALL	--IDD	--DDD, IND, IDR, IDD, IN
--IDR
SELECT 4057 ,'0.3'  ,'90'      ,0.3  ,90      ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4058 ,'0.3'  ,'24'      ,0.3  ,24      ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4059 ,'0.3'  ,'120'     ,0.3  ,120     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4061 ,'0.6'  ,'60'      ,0.6  ,60      ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4063 ,'0.3'  ,'120'     ,0.3  ,120     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4073 ,'0.6'  ,'24'      ,0.6  ,24      ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4077 ,'0.6'  ,'60'      ,0.6  ,60      ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4078 ,'0.3'  ,'24'      ,0.3  ,24      ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4079 ,'1.5'  ,'120'     ,1.5  ,120     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
SELECT 4080 ,'0.6'  ,'120'     ,0.6  ,120     ,34   UNION ALL	--IDR	--DDD, IND, IDR, IDD, IN
--IN
SELECT 4057 ,'0.3'  ,'90'      ,0.3  ,90      ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4058 ,'0.3'  ,'24'      ,0.3  ,24      ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4059 ,'0.3'  ,'120'     ,0.3  ,120     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4061 ,'0.6'  ,'60'      ,0.6  ,60      ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4063 ,'0.3'  ,'120'     ,0.3  ,120     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4073 ,'0.6'  ,'24'      ,0.6  ,24      ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4077 ,'0.6'  ,'60'      ,0.6  ,60      ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4078 ,'0.3'  ,'24'      ,0.3  ,24      ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4079 ,'1.5'  ,'120'     ,1.5  ,120     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
SELECT 4080 ,'0.6'  ,'120'     ,0.6  ,120     ,15   UNION ALL	--IN	--DDD, IND, IDR, IDD, IN
--IND
SELECT 4057 ,'0.3'  ,'90'      ,0.3  ,90      ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4058 ,'0.3'  ,'24'      ,0.3  ,24      ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4059 ,'0.3'  ,'120'     ,0.3  ,120     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4061 ,'0.6'  ,'60'      ,0.6  ,60      ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4063 ,'0.3'  ,'120'     ,0.3  ,120     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4073 ,'0.6'  ,'24'      ,0.6  ,24      ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4077 ,'0.6'  ,'60'      ,0.6  ,60      ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4078 ,'0.3'  ,'24'      ,0.3  ,24      ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4079 ,'1.5'  ,'120'     ,1.5  ,120     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
SELECT 4080 ,'0.6'  ,'120'     ,0.6  ,120     ,22   UNION ALL	--IND	--DDD, IND, IDR, IDD, IN
--EUR
SELECT 4057 ,'0.1'  ,'8'       ,0.1  ,8       ,78   UNION ALL	--EUR	--Euro, EUR
SELECT 4058 ,'0.1'  ,'2'       ,0.1  ,2       ,78   UNION ALL	--EUR	--Euro, EUR
SELECT 4059 ,'0.1'  ,'5'       ,0.1  ,5       ,78   UNION ALL	--EUR	--Euro, EUR
SELECT 4061 ,'0.2'  ,'5'       ,0.2  ,5       ,78   UNION ALL	--EUR	--Euro, EUR
SELECT 4063 ,'0.1'  ,'5'       ,0.1  ,5       ,78   UNION ALL	--EUR	--Euro, EUR
SELECT 4073 ,'0.2'  ,'2'       ,0.2  ,2       ,78   UNION ALL	--EUR	--Euro, EUR
SELECT 4077 ,'0.2'  ,'5'       ,0.2  ,5       ,78   UNION ALL	--EUR	--Euro, EUR
SELECT 4078 ,'0.1'  ,'2'       ,0.1  ,2       ,78   UNION ALL	--EUR	--Euro, EUR
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,78   UNION ALL	--EUR	--Euro, EUR
SELECT 4080 ,'0.2'  ,'5'       ,0.2  ,5       ,78   UNION ALL	--EUR	--Euro, EUR
--EURO
SELECT 4057 ,'0.1'  ,'8'       ,0.1  ,8       ,6    UNION ALL	--EURO	--Euro, EUR
SELECT 4058 ,'0.1'  ,'2'       ,0.1  ,2       ,6    UNION ALL	--EURO	--Euro, EUR
SELECT 4059 ,'0.1'  ,'5'       ,0.1  ,5       ,6    UNION ALL	--EURO	--Euro, EUR
SELECT 4061 ,'0.2'  ,'5'       ,0.2  ,5       ,6    UNION ALL	--EURO	--Euro, EUR
SELECT 4063 ,'0.1'  ,'5'       ,0.1  ,5       ,6    UNION ALL	--EURO	--Euro, EUR
SELECT 4073 ,'0.2'  ,'2'       ,0.2  ,2       ,6    UNION ALL	--EURO	--Euro, EUR
SELECT 4077 ,'0.2'  ,'5'       ,0.2  ,5       ,6    UNION ALL	--EURO	--Euro, EUR
SELECT 4078 ,'0.1'  ,'2'       ,0.1  ,2       ,6    UNION ALL	--EURO	--Euro, EUR
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,6    UNION ALL	--EURO	--Euro, EUR
SELECT 4080 ,'0.2'  ,'5'       ,0.2  ,5       ,6    UNION ALL	--EURO	--Euro, EUR
--GBP
SELECT 4057 ,'0.1'  ,'8'       ,0.1  ,8       ,12   UNION ALL	--GBP	--GBP
SELECT 4058 ,'0.1'  ,'2'       ,0.1  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4059 ,'0.1'  ,'5'       ,0.1  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4061 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4063 ,'0.1'  ,'5'       ,0.1  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4073 ,'0.2'  ,'2'       ,0.2  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4077 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
SELECT 4078 ,'0.1'  ,'2'       ,0.1  ,2       ,12   UNION ALL	--GBP	--GBP
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,12   UNION ALL	--GBP	--GBP
SELECT 4080 ,'0.2'  ,'5'       ,0.2  ,5       ,12   UNION ALL	--GBP	--GBP
--HID
SELECT 4057 ,'0.1'  ,'30'      ,0.1  ,30      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4058 ,'0.1'  ,'8'       ,0.1  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4059 ,'0.1'  ,'40'      ,0.1  ,40      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4061 ,'0.2'  ,'20'      ,0.2  ,20      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4063 ,'0.1'  ,'40'      ,0.1  ,40      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4073 ,'0.2'  ,'8'       ,0.2  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4077 ,'0.2'  ,'20'      ,0.2  ,20      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4078 ,'0.1'  ,'8'       ,0.1  ,8       ,92   UNION ALL	--HID	--HK$, HID
SELECT 4079 ,'0.5'  ,'40'      ,0.5  ,40      ,92   UNION ALL	--HID	--HK$, HID
SELECT 4080 ,'0.2'  ,'40'      ,0.2  ,40      ,92   UNION ALL	--HID	--HK$, HID
--HK$
SELECT 4057 ,'0.1'  ,'30'      ,0.1  ,30      ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4058 ,'0.1'  ,'8'       ,0.1  ,8       ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4059 ,'0.1'  ,'40'      ,0.1  ,40      ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4061 ,'0.2'  ,'20'      ,0.2  ,20      ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4063 ,'0.1'  ,'40'      ,0.1  ,40      ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4073 ,'0.2'  ,'8'       ,0.2  ,8       ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4077 ,'0.2'  ,'20'      ,0.2  ,20      ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4078 ,'0.1'  ,'8'       ,0.1  ,8       ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4079 ,'0.5'  ,'40'      ,0.5  ,40      ,5    UNION ALL	--HK$	--HK$, HID
SELECT 4080 ,'0.2'  ,'40'      ,0.2  ,40      ,5    UNION ALL	--HK$	--HK$, HID
--INH
SELECT 4057 ,'0.6'  ,'180'     ,0.6  ,180     ,51   UNION ALL	--INH	--INH
SELECT 4058 ,'0.6'  ,'48'      ,0.6  ,48      ,51   UNION ALL	--INH	--INH
SELECT 4059 ,'0.6'  ,'240'     ,0.6  ,240     ,51   UNION ALL	--INH	--INH
SELECT 4061 ,'1.2'  ,'120'     ,1.2  ,120     ,51   UNION ALL	--INH	--INH
SELECT 4063 ,'0.6'  ,'240'     ,0.6  ,240     ,51   UNION ALL	--INH	--INH
SELECT 4073 ,'1.2'  ,'48'      ,1.2  ,48      ,51   UNION ALL	--INH	--INH
SELECT 4077 ,'1.2'  ,'120'     ,1.2  ,120     ,51   UNION ALL	--INH	--INH
SELECT 4078 ,'0.6'  ,'48'      ,0.6  ,48      ,51   UNION ALL	--INH	--INH
SELECT 4079 ,'3'    ,'240'     ,3    ,240     ,51   UNION ALL	--INH	--INH
SELECT 4080 ,'1.2'  ,'240'     ,1.2  ,240     ,51   UNION ALL	--INH	--INH
--INR
SELECT 4057 ,'5'    ,'750'     ,5    ,750     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
SELECT 4058 ,'5'    ,'200'     ,5    ,200     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
SELECT 4059 ,'5'    ,'500'     ,5    ,500     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
SELECT 4061 ,'10'   ,'500'     ,10   ,500     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
SELECT 4063 ,'5'    ,'500'     ,5    ,500     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
SELECT 4073 ,'10'   ,'200'     ,10   ,200     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
SELECT 4077 ,'10'   ,'500'     ,10   ,500     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
SELECT 4078 ,'5'    ,'200'     ,5    ,200     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
SELECT 4079 ,'25'   ,'500'     ,25   ,500     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
SELECT 4080 ,'10'   ,'500'     ,10   ,500     ,61   UNION ALL	--INR	--INR, PTU, PS, PTH
--PS
SELECT 4057 ,'5'    ,'750'     ,5    ,750     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
SELECT 4058 ,'5'    ,'200'     ,5    ,200     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
SELECT 4059 ,'5'    ,'500'     ,5    ,500     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
SELECT 4061 ,'10'   ,'500'     ,10   ,500     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
SELECT 4063 ,'5'    ,'500'     ,5    ,500     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
SELECT 4073 ,'10'   ,'200'     ,10   ,200     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
SELECT 4077 ,'10'   ,'500'     ,10   ,500     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
SELECT 4078 ,'5'    ,'200'     ,5    ,200     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
SELECT 4079 ,'25'   ,'500'     ,25   ,500     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
SELECT 4080 ,'10'   ,'500'     ,10   ,500     ,76   UNION ALL	--PS	--INR, PTU, PS, PTH
--PTH
SELECT 4057 ,'5'    ,'750'     ,5    ,750     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
SELECT 4058 ,'5'    ,'200'     ,5    ,200     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
SELECT 4059 ,'5'    ,'500'     ,5    ,500     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
SELECT 4061 ,'10'   ,'500'     ,10   ,500     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
SELECT 4063 ,'5'    ,'500'     ,5    ,500     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
SELECT 4073 ,'10'   ,'200'     ,10   ,200     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
SELECT 4077 ,'10'   ,'500'     ,10   ,500     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
SELECT 4078 ,'5'    ,'200'     ,5    ,200     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
SELECT 4079 ,'25'   ,'500'     ,25   ,500     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
SELECT 4080 ,'10'   ,'500'     ,10   ,500     ,77   UNION ALL	--PTH	--INR, PTU, PS, PTH
--PTU
SELECT 4057 ,'5'    ,'750'     ,5    ,750     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
SELECT 4058 ,'5'    ,'200'     ,5    ,200     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
SELECT 4059 ,'5'    ,'500'     ,5    ,500     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
SELECT 4061 ,'10'   ,'500'     ,10   ,500     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
SELECT 4063 ,'5'    ,'500'     ,5    ,500     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
SELECT 4073 ,'10'   ,'200'     ,10   ,200     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
SELECT 4077 ,'10'   ,'500'     ,10   ,500     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
SELECT 4078 ,'5'    ,'200'     ,5    ,200     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
SELECT 4079 ,'25'   ,'500'     ,25   ,500     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
SELECT 4080 ,'10'   ,'500'     ,10   ,500     ,75   UNION ALL	--PTU	--INR, PTU, PS, PTH
--JPY
SELECT 4057 ,'10'   ,'1500'    ,10   ,1500    ,32   UNION ALL	--JPY	--JPY, P, PTS
SELECT 4058 ,'10'   ,'400'     ,10   ,400     ,32   UNION ALL	--JPY	--JPY, P, PTS
SELECT 4059 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY, P, PTS
SELECT 4061 ,'20'   ,'1000'    ,20   ,1000    ,32   UNION ALL	--JPY	--JPY, P, PTS
SELECT 4063 ,'10'   ,'1000'    ,10   ,1000    ,32   UNION ALL	--JPY	--JPY, P, PTS
SELECT 4073 ,'20'   ,'400'     ,20   ,400     ,32   UNION ALL	--JPY	--JPY, P, PTS
SELECT 4077 ,'20'   ,'1000'    ,20   ,1000    ,32   UNION ALL	--JPY	--JPY, P, PTS
SELECT 4078 ,'10'   ,'400'     ,10   ,400     ,32   UNION ALL	--JPY	--JPY, P, PTS
SELECT 4079 ,'50'   ,'1000'    ,50   ,1000    ,32   UNION ALL	--JPY	--JPY, P, PTS
SELECT 4080 ,'20'   ,'1000'    ,20   ,1000    ,32   UNION ALL	--JPY	--JPY, P, PTS
--P
SELECT 4057 ,'10'   ,'1500'    ,10   ,1500    ,37   UNION ALL	--P	--JPY, P, PTS
SELECT 4058 ,'10'   ,'400'     ,10   ,400     ,37   UNION ALL	--P	--JPY, P, PTS
SELECT 4059 ,'10'   ,'1000'    ,10   ,1000    ,37   UNION ALL	--P	--JPY, P, PTS
SELECT 4061 ,'20'   ,'1000'    ,20   ,1000    ,37   UNION ALL	--P	--JPY, P, PTS
SELECT 4063 ,'10'   ,'1000'    ,10   ,1000    ,37   UNION ALL	--P	--JPY, P, PTS
SELECT 4073 ,'20'   ,'400'     ,20   ,400     ,37   UNION ALL	--P	--JPY, P, PTS
SELECT 4077 ,'20'   ,'1000'    ,20   ,1000    ,37   UNION ALL	--P	--JPY, P, PTS
SELECT 4078 ,'10'   ,'400'     ,10   ,400     ,37   UNION ALL	--P	--JPY, P, PTS
SELECT 4079 ,'50'   ,'1000'    ,50   ,1000    ,37   UNION ALL	--P	--JPY, P, PTS
SELECT 4080 ,'20'   ,'1000'    ,20   ,1000    ,37   UNION ALL	--P	--JPY, P, PTS
--Pts
SELECT 4057 ,'10'   ,'1500'    ,10   ,1500    ,31   UNION ALL	--Pts	--JPY, P, PTS
SELECT 4058 ,'10'   ,'400'     ,10   ,400     ,31   UNION ALL	--Pts	--JPY, P, PTS
SELECT 4059 ,'10'   ,'1000'    ,10   ,1000    ,31   UNION ALL	--Pts	--JPY, P, PTS
SELECT 4061 ,'20'   ,'1000'    ,20   ,1000    ,31   UNION ALL	--Pts	--JPY, P, PTS
SELECT 4063 ,'10'   ,'1000'    ,10   ,1000    ,31   UNION ALL	--Pts	--JPY, P, PTS
SELECT 4073 ,'20'   ,'400'     ,20   ,400     ,31   UNION ALL	--Pts	--JPY, P, PTS
SELECT 4077 ,'20'   ,'1000'    ,20   ,1000    ,31   UNION ALL	--Pts	--JPY, P, PTS
SELECT 4078 ,'10'   ,'400'     ,10   ,400     ,31   UNION ALL	--Pts	--JPY, P, PTS
SELECT 4079 ,'50'   ,'1000'    ,50   ,1000    ,31   UNION ALL	--Pts	--JPY, P, PTS
SELECT 4080 ,'20'   ,'1000'    ,20   ,1000    ,31   UNION ALL	--Pts	--JPY, P, PTS
--KHR
SELECT 4057 ,'0.1'  ,'30'      ,0.1  ,30      ,71   UNION ALL	--KHR	--KHR
SELECT 4058 ,'0.1'  ,'8'       ,0.1  ,8       ,71   UNION ALL	--KHR	--KHR
SELECT 4059 ,'0.1'  ,'40'      ,0.1  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 4061 ,'0.2'  ,'20'      ,0.2  ,20      ,71   UNION ALL	--KHR	--KHR
SELECT 4063 ,'0.1'  ,'40'      ,0.1  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 4073 ,'0.2'  ,'8'       ,0.2  ,8       ,71   UNION ALL	--KHR	--KHR
SELECT 4077 ,'0.2'  ,'20'      ,0.2  ,20      ,71   UNION ALL	--KHR	--KHR
SELECT 4078 ,'0.1'  ,'10'      ,0.1  ,10      ,71   UNION ALL	--KHR	--KHR
SELECT 4079 ,'0.5'  ,'40'      ,0.5  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 4080 ,'0.2'  ,'40'      ,0.2  ,40      ,71   UNION ALL	--KHR	--KHR
--MKK
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,70   UNION ALL	--MKK	--MMK, MKK
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,70   UNION ALL	--MKK	--MMK, MKK
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,70   UNION ALL	--MKK	--MMK, MKK
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,70   UNION ALL	--MKK	--MMK, MKK
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,70   UNION ALL	--MKK	--MMK, MKK
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,70   UNION ALL	--MKK	--MMK, MKK
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,70   UNION ALL	--MKK	--MMK, MKK
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,70   UNION ALL	--MKK	--MMK, MKK
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,70   UNION ALL	--MKK	--MMK, MKK
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,70   UNION ALL	--MKK	--MMK, MKK
--MMK
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,69   UNION ALL	--MMK	--MMK, MKK
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,69   UNION ALL	--MMK	--MMK, MKK
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,69   UNION ALL	--MMK	--MMK, MKK
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,69   UNION ALL	--MMK	--MMK, MKK
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,69   UNION ALL	--MMK	--MMK, MKK
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,69   UNION ALL	--MMK	--MMK, MKK
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,69   UNION ALL	--MMK	--MMK, MKK
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,69   UNION ALL	--MMK	--MMK, MKK
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,69   UNION ALL	--MMK	--MMK, MKK
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,69   UNION ALL	--MMK	--MMK, MKK
--HKK
SELECT 4057 ,'0.1'  ,'30'      ,0.1  ,30      ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
SELECT 4058 ,'0.1'  ,'8'       ,0.1  ,8       ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
SELECT 4059 ,'0.1'  ,'40'      ,0.1  ,40      ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
SELECT 4061 ,'0.2'  ,'20'      ,0.2  ,20      ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
SELECT 4063 ,'0.1'  ,'40'      ,0.1  ,40      ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
SELECT 4073 ,'0.2'  ,'8'       ,0.2  ,8       ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
SELECT 4077 ,'0.2'  ,'20'      ,0.2  ,20      ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
SELECT 4078 ,'0.1'  ,'8'       ,0.1  ,8       ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
SELECT 4079 ,'0.5'  ,'40'      ,0.5  ,40      ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
SELECT 4080 ,'0.2'  ,'40'      ,0.2  ,40      ,67   UNION ALL	--HKK	--MYR, HKD,RM, HKK
--RM
SELECT 4057 ,'0.1'  ,'30'      ,0.1  ,30      ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
SELECT 4058 ,'0.1'  ,'8'       ,0.1  ,8       ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
SELECT 4059 ,'0.1'  ,'40'      ,0.1  ,40      ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
SELECT 4061 ,'0.2'  ,'20'      ,0.2  ,20      ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
SELECT 4063 ,'0.1'  ,'40'      ,0.1  ,40      ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
SELECT 4073 ,'0.2'  ,'8'       ,0.2  ,8       ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
SELECT 4077 ,'0.2'  ,'20'      ,0.2  ,20      ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
SELECT 4078 ,'0.1'  ,'8'       ,0.1  ,8       ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
SELECT 4079 ,'0.5'  ,'40'      ,0.5  ,40      ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
SELECT 4080 ,'0.2'  ,'40'      ,0.2  ,40      ,2    UNION ALL	--RM	--MYR, HKD,RM, HKK
--KW
SELECT 4057 ,'100'  ,'15000'   ,100  ,15000   ,62   UNION ALL	--KW	--PT, Won, KW
SELECT 4058 ,'100'  ,'4000'    ,100  ,4000    ,62   UNION ALL	--KW	--PT, Won, KW
SELECT 4059 ,'100'  ,'10000'   ,100  ,10000   ,62   UNION ALL	--KW	--PT, Won, KW
SELECT 4061 ,'200'  ,'10000'   ,200  ,10000   ,62   UNION ALL	--KW	--PT, Won, KW
SELECT 4063 ,'100'  ,'10000'   ,100  ,10000   ,62   UNION ALL	--KW	--PT, Won, KW
SELECT 4073 ,'200'  ,'4000'    ,200  ,4000    ,62   UNION ALL	--KW	--PT, Won, KW
SELECT 4077 ,'200'  ,'10000'   ,200  ,10000   ,62   UNION ALL	--KW	--PT, Won, KW
SELECT 4078 ,'100'  ,'4000'    ,100  ,4000    ,62   UNION ALL	--KW	--PT, Won, KW
SELECT 4079 ,'500'  ,'10000'   ,500  ,10000   ,62   UNION ALL	--KW	--PT, Won, KW
SELECT 4080 ,'200'  ,'10000'   ,200  ,10000   ,62   UNION ALL	--KW	--PT, Won, KW
--PT
SELECT 4057 ,'100'  ,'15000'   ,100  ,15000   ,44   UNION ALL	--PT	--PT, Won, KW
SELECT 4058 ,'100'  ,'4000'    ,100  ,4000    ,44   UNION ALL	--PT	--PT, Won, KW
SELECT 4059 ,'100'  ,'10000'   ,100  ,10000   ,44   UNION ALL	--PT	--PT, Won, KW
SELECT 4061 ,'200'  ,'10000'   ,200  ,10000   ,44   UNION ALL	--PT	--PT, Won, KW
SELECT 4063 ,'100'  ,'10000'   ,100  ,10000   ,44   UNION ALL	--PT	--PT, Won, KW
SELECT 4073 ,'200'  ,'4000'    ,200  ,4000    ,44   UNION ALL	--PT	--PT, Won, KW
SELECT 4077 ,'200'  ,'10000'   ,200  ,10000   ,44   UNION ALL	--PT	--PT, Won, KW
SELECT 4078 ,'100'  ,'4000'    ,100  ,4000    ,44   UNION ALL	--PT	--PT, Won, KW
SELECT 4079 ,'500'  ,'10000'   ,500  ,10000   ,44   UNION ALL	--PT	--PT, Won, KW
SELECT 4080 ,'200'  ,'10000'   ,200  ,10000   ,44   UNION ALL	--PT	--PT, Won, KW
--Won
SELECT 4057 ,'100'  ,'15000'   ,100  ,15000   ,45   UNION ALL	--Won	--PT, Won, KW
SELECT 4058 ,'100'  ,'4000'    ,100  ,4000    ,45   UNION ALL	--Won	--PT, Won, KW
SELECT 4059 ,'100'  ,'10000'   ,100  ,10000   ,45   UNION ALL	--Won	--PT, Won, KW
SELECT 4061 ,'200'  ,'10000'   ,200  ,10000   ,45   UNION ALL	--Won	--PT, Won, KW
SELECT 4063 ,'100'  ,'10000'   ,100  ,10000   ,45   UNION ALL	--Won	--PT, Won, KW
SELECT 4073 ,'200'  ,'4000'    ,200  ,4000    ,45   UNION ALL	--Won	--PT, Won, KW
SELECT 4077 ,'200'  ,'10000'   ,200  ,10000   ,45   UNION ALL	--Won	--PT, Won, KW
SELECT 4078 ,'100'  ,'4000'    ,100  ,4000    ,45   UNION ALL	--Won	--PT, Won, KW
SELECT 4079 ,'500'  ,'10000'   ,500  ,10000   ,45   UNION ALL	--Won	--PT, Won, KW
SELECT 4080 ,'200'  ,'10000'   ,200  ,10000   ,45   UNION ALL	--Won	--PT, Won, KW
--RUB
SELECT 4057 ,'5'    ,'1000'    ,5    ,1000    ,55   UNION ALL	--RUB	--RUB
SELECT 4058 ,'5'    ,'1000'    ,5    ,1000    ,55   UNION ALL	--RUB	--RUB
SELECT 4059 ,'5'    ,'1000'    ,5    ,1000    ,55   UNION ALL	--RUB	--RUB
SELECT 4061 ,'10'   ,'1000'    ,10   ,1000    ,55   UNION ALL	--RUB	--RUB
SELECT 4063 ,'5'    ,'1000'    ,5    ,1000    ,55   UNION ALL	--RUB	--RUB
SELECT 4073 ,'10'   ,'1000'    ,10   ,1000    ,55   UNION ALL	--RUB	--RUB
SELECT 4077 ,'10'   ,'1000'    ,10   ,1000    ,55   UNION ALL	--RUB	--RUB
SELECT 4078 ,'5'    ,'200'     ,5    ,200     ,55   UNION ALL	--RUB	--RUB
SELECT 4079 ,'25'   ,'500'     ,25   ,500     ,55   UNION ALL	--RUB	--RUB
SELECT 4080 ,'10'   ,'1000'    ,10   ,1000    ,55   UNION ALL	--RUB	--RUB
--TB
SELECT 4057 ,'1'    ,'300'     ,1    ,300     ,4    UNION ALL	--TB	--THB, TB
SELECT 4058 ,'1'    ,'80'      ,1    ,80      ,4    UNION ALL	--TB	--THB, TB
SELECT 4059 ,'1'    ,'400'     ,1    ,400     ,4    UNION ALL	--TB	--THB, TB
SELECT 4061 ,'2'    ,'200'     ,2    ,200     ,4    UNION ALL	--TB	--THB, TB
SELECT 4063 ,'1'    ,'400'     ,1    ,400     ,4    UNION ALL	--TB	--THB, TB
SELECT 4073 ,'2'    ,'80'      ,2    ,80      ,4    UNION ALL	--TB	--THB, TB
SELECT 4077 ,'2'    ,'200'     ,2    ,200     ,4    UNION ALL	--TB	--THB, TB
SELECT 4078 ,'1'    ,'80'      ,1    ,80      ,4    UNION ALL	--TB	--THB, TB
SELECT 4079 ,'5'    ,'400'     ,5    ,400     ,4    UNION ALL	--TB	--THB, TB
SELECT 4080 ,'2'    ,'400'     ,2    ,400     ,4    UNION ALL	--TB	--THB, TB
--THB
SELECT 4057 ,'1'    ,'300'     ,1    ,300     ,43   UNION ALL	--THB	--THB, TB
SELECT 4058 ,'1'    ,'80'      ,1    ,80      ,43   UNION ALL	--THB	--THB, TB
SELECT 4059 ,'1'    ,'400'     ,1    ,400     ,43   UNION ALL	--THB	--THB, TB
SELECT 4061 ,'2'    ,'200'     ,2    ,200     ,43   UNION ALL	--THB	--THB, TB
SELECT 4063 ,'1'    ,'400'     ,1    ,400     ,43   UNION ALL	--THB	--THB, TB
SELECT 4073 ,'2'    ,'80'      ,2    ,80      ,43   UNION ALL	--THB	--THB, TB
SELECT 4077 ,'2'    ,'200'     ,2    ,200     ,43   UNION ALL	--THB	--THB, TB
SELECT 4078 ,'1'    ,'80'      ,1    ,80      ,43   UNION ALL	--THB	--THB, TB
SELECT 4079 ,'5'    ,'400'     ,5    ,400     ,43   UNION ALL	--THB	--THB, TB
SELECT 4080 ,'2'    ,'400'     ,2    ,400     ,43   UNION ALL	--THB	--THB, TB
--$US
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,35   UNION ALL	--$US	--Yen, UT, $US, US$, USD, UUS, YNG
--US$
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,3    UNION ALL	--US$	--Yen, UT, $US, US$, USD, UUS, YNG
--USD
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,95   UNION ALL	--USD	--Yen, UT, $US, US$, USD, UUS, YNG
--UT
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,64   UNION ALL	--UT	--Yen, UT, $US, US$, USD, UUS, YNG
--UUS
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD, UUS, YNG
--Yen
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,16   UNION ALL	--Yen	--Yen, UT, $US, US$, USD, UUS, YNG
--YNG
SELECT 4057 ,'0.1'  ,'15'      ,0.1  ,15      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4058 ,'0.1'  ,'4'       ,0.1  ,4       ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4059 ,'0.1'  ,'10'      ,0.1  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4061 ,'0.2'  ,'10'      ,0.2  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4063 ,'0.1'  ,'10'      ,0.1  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4073 ,'0.2'  ,'4'       ,0.2  ,4       ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4077 ,'0.2'  ,'10'      ,0.2  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4078 ,'0.1'  ,'4'       ,0.1  ,4       ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4079 ,'0.5'  ,'10'      ,0.5  ,10      ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD, UUS, YNG
SELECT 4080 ,'0.2'  ,'10'      ,0.2  ,10      ,72				--YNG	--Yen, UT, $US, US$, USD, UUS, YNG		

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS (
SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
FROM Dep_StakeLevel s WITH(NOLOCK)
CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
			  FROM #StakeLevel_Temp t 
			  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
WHERE s.GameTypeID = 4001)

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