/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220324
	Task: PG Soft - Add 9 new games - Deposit RedmineID:#169831
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId INT, GameGroupID INT DEFAULT(16))

--#region insert data to temp table	
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--ARS
SELECT 6087 ,'4'        ,'400'         ,4        ,400         ,86   UNION ALL	--ARS	--ARS
SELECT 6088 ,'5'        ,'2000'        ,5        ,2000        ,86   UNION ALL	--ARS	--ARS
SELECT 6089 ,'4'        ,'4000'        ,4        ,4000        ,86   UNION ALL	--ARS	--ARS
SELECT 6090 ,'4'        ,'400'         ,4        ,400         ,86   UNION ALL	--ARS	--ARS
SELECT 6091 ,'4'        ,'400'         ,4        ,400         ,86   UNION ALL	--ARS	--ARS
SELECT 6092 ,'4'        ,'400'         ,4        ,400         ,86   UNION ALL	--ARS	--ARS
SELECT 6093 ,'5'        ,'5000'        ,5        ,5000        ,86   UNION ALL	--ARS	--ARS
SELECT 6094 ,'4'        ,'2000'        ,4        ,2000        ,86   UNION ALL	--ARS	--ARS
SELECT 6095 ,'4'        ,'2000'        ,4        ,2000        ,86   UNION ALL	--ARS	--ARS
--AUD
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,9    UNION ALL	--AUD	--AUD
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,9    UNION ALL	--AUD	--AUD
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,9    UNION ALL	--AUD	--AUD
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,9    UNION ALL	--AUD	--AUD
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,9    UNION ALL	--AUD	--AUD
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,9    UNION ALL	--AUD	--AUD
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,9    UNION ALL	--AUD	--AUD
--BDT
SELECT 6087 ,'10'       ,'1000'        ,10       ,1000        ,97   UNION ALL	--BDT	--BDT
SELECT 6088 ,'10'       ,'4000'        ,10       ,4000        ,97   UNION ALL	--BDT	--BDT
SELECT 6089 ,'10'       ,'10000'       ,10       ,10000       ,97   UNION ALL	--BDT	--BDT
SELECT 6090 ,'10'       ,'1000'        ,10       ,1000        ,97   UNION ALL	--BDT	--BDT
SELECT 6091 ,'10'       ,'1000'        ,10       ,1000        ,97   UNION ALL	--BDT	--BDT
SELECT 6092 ,'10'       ,'1000'        ,10       ,1000        ,97   UNION ALL	--BDT	--BDT
SELECT 6093 ,'10'       ,'10000'       ,10       ,10000       ,97   UNION ALL	--BDT	--BDT
SELECT 6094 ,'10'       ,'5000'        ,10       ,5000        ,97   UNION ALL	--BDT	--BDT
SELECT 6095 ,'10'       ,'5000'        ,10       ,5000        ,97   UNION ALL	--BDT	--BDT
--BND
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,46   UNION ALL	--BND	--BND
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,46   UNION ALL	--BND	--BND
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,46   UNION ALL	--BND	--BND
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,46   UNION ALL	--BND	--BND
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,46   UNION ALL	--BND	--BND
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,46   UNION ALL	--BND	--BND
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,46   UNION ALL	--BND	--BND
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,46   UNION ALL	--BND	--BND
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,46   UNION ALL	--BND	--BND
--BRL
SELECT 6087 ,'0.4'      ,'40'          ,0.4      ,40          ,82   UNION ALL	--BRL	--BRL
SELECT 6088 ,'0.5'      ,'200'         ,0.5      ,200         ,82   UNION ALL	--BRL	--BRL
SELECT 6089 ,'0.4'      ,'400'         ,0.4      ,400         ,82   UNION ALL	--BRL	--BRL
SELECT 6090 ,'0.4'      ,'40'          ,0.4      ,40          ,82   UNION ALL	--BRL	--BRL
SELECT 6091 ,'0.4'      ,'40'          ,0.4      ,40          ,82   UNION ALL	--BRL	--BRL
SELECT 6092 ,'0.4'      ,'40'          ,0.4      ,40          ,82   UNION ALL	--BRL	--BRL
SELECT 6093 ,'0.5'      ,'500'         ,0.5      ,500         ,82   UNION ALL	--BRL	--BRL
SELECT 6094 ,'0.4'      ,'200'         ,0.4      ,200         ,82   UNION ALL	--BRL	--BRL
SELECT 6095 ,'0.4'      ,'200'         ,0.4      ,200         ,82   UNION ALL	--BRL	--BRL
--CAN
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,50   UNION ALL	--CAN	--CAN
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,50   UNION ALL	--CAN	--CAN
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,50   UNION ALL	--CAN	--CAN
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,50   UNION ALL	--CAN	--CAN
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,50   UNION ALL	--CAN	--CAN
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,50   UNION ALL	--CAN	--CAN
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,50   UNION ALL	--CAN	--CAN
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,50   UNION ALL	--CAN	--CAN
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,50   UNION ALL	--CAN	--CAN
--CHF
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,41   UNION ALL	--CHF	--CHF
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,41   UNION ALL	--CHF	--CHF
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,41   UNION ALL	--CHF	--CHF
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,41   UNION ALL	--CHF	--CHF
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,41   UNION ALL	--CHF	--CHF
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,41   UNION ALL	--CHF	--CHF
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,41   UNION ALL	--CHF	--CHF
--CLP
SELECT 6087 ,'100'      ,'10000'       ,100      ,10000       ,83   UNION ALL	--CLP	--CLP
SELECT 6088 ,'150'      ,'60000'       ,150      ,60000       ,83   UNION ALL	--CLP	--CLP
SELECT 6089 ,'100'      ,'100000'      ,100      ,100000      ,83   UNION ALL	--CLP	--CLP
SELECT 6090 ,'100'      ,'10000'       ,100      ,10000       ,83   UNION ALL	--CLP	--CLP
SELECT 6091 ,'100'      ,'10000'       ,100      ,10000       ,83   UNION ALL	--CLP	--CLP
SELECT 6092 ,'100'      ,'10000'       ,100      ,10000       ,83   UNION ALL	--CLP	--CLP
SELECT 6093 ,'100'      ,'100000'      ,100      ,100000      ,83   UNION ALL	--CLP	--CLP
SELECT 6094 ,'100'      ,'50000'       ,100      ,50000       ,83   UNION ALL	--CLP	--CLP
SELECT 6095 ,'100'      ,'50000'       ,100      ,50000       ,83   UNION ALL	--CLP	--CLP
--CZK
SELECT 6087 ,'2'        ,'200'         ,2        ,200         ,57   UNION ALL	--CZK	--CZK
SELECT 6088 ,'2.5'      ,'1000'        ,2.5      ,1000        ,57   UNION ALL	--CZK	--CZK
SELECT 6089 ,'2'        ,'2000'        ,2        ,2000        ,57   UNION ALL	--CZK	--CZK
SELECT 6090 ,'2'        ,'200'         ,2        ,200         ,57   UNION ALL	--CZK	--CZK
SELECT 6091 ,'2'        ,'200'         ,2        ,200         ,57   UNION ALL	--CZK	--CZK
SELECT 6092 ,'2'        ,'200'         ,2        ,200         ,57   UNION ALL	--CZK	--CZK
SELECT 6093 ,'5'        ,'5000'        ,5        ,5000        ,57   UNION ALL	--CZK	--CZK
SELECT 6094 ,'2'        ,'1000'        ,2        ,1000        ,57   UNION ALL	--CZK	--CZK
SELECT 6095 ,'2'        ,'1000'        ,2        ,1000        ,57   UNION ALL	--CZK	--CZK
--DKK
SELECT 6087 ,'1'        ,'100'         ,1        ,100         ,52   UNION ALL	--DKK	--DKK
SELECT 6088 ,'1'        ,'400'         ,1        ,400         ,52   UNION ALL	--DKK	--DKK
SELECT 6089 ,'1'        ,'1000'        ,1        ,1000        ,52   UNION ALL	--DKK	--DKK
SELECT 6090 ,'1'        ,'100'         ,1        ,100         ,52   UNION ALL	--DKK	--DKK
SELECT 6091 ,'1'        ,'100'         ,1        ,100         ,52   UNION ALL	--DKK	--DKK
SELECT 6092 ,'1'        ,'100'         ,1        ,100         ,52   UNION ALL	--DKK	--DKK
SELECT 6093 ,'2'        ,'2000'        ,2        ,2000        ,52   UNION ALL	--DKK	--DKK
SELECT 6094 ,'1'        ,'500'         ,1        ,500         ,52   UNION ALL	--DKK	--DKK
SELECT 6095 ,'1'        ,'500'         ,1        ,500         ,52   UNION ALL	--DKK	--DKK
--EURO
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,6    UNION ALL	--EURO	--EURO
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,6    UNION ALL	--EURO	--EURO
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,6    UNION ALL	--EURO	--EURO
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,6    UNION ALL	--EURO	--EURO
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,6    UNION ALL	--EURO	--EURO
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,6    UNION ALL	--EURO	--EURO
--GBP
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,12   UNION ALL	--GBP	--GBP
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,12   UNION ALL	--GBP	--GBP
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,12   UNION ALL	--GBP	--GBP
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,12   UNION ALL	--GBP	--GBP
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,12   UNION ALL	--GBP	--GBP
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,12   UNION ALL	--GBP	--GBP
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,12   UNION ALL	--GBP	--GBP
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,12   UNION ALL	--GBP	--GBP
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,12   UNION ALL	--GBP	--GBP
--GHS
SELECT 6087 ,'0.4'      ,'40'          ,0.4      ,40          ,80   UNION ALL	--GHS	--GHS
SELECT 6088 ,'0.5'      ,'200'         ,0.5      ,200         ,80   UNION ALL	--GHS	--GHS
SELECT 6089 ,'0.4'      ,'400'         ,0.4      ,400         ,80   UNION ALL	--GHS	--GHS
SELECT 6090 ,'0.4'      ,'40'          ,0.4      ,40          ,80   UNION ALL	--GHS	--GHS
SELECT 6091 ,'0.4'      ,'40'          ,0.4      ,40          ,80   UNION ALL	--GHS	--GHS
SELECT 6092 ,'0.4'      ,'40'          ,0.4      ,40          ,80   UNION ALL	--GHS	--GHS
SELECT 6093 ,'0.5'      ,'500'         ,0.5      ,500         ,80   UNION ALL	--GHS	--GHS
SELECT 6094 ,'0.4'      ,'200'         ,0.4      ,200         ,80   UNION ALL	--GHS	--GHS
SELECT 6095 ,'0.4'      ,'200'         ,0.4      ,200         ,80   UNION ALL	--GHS	--GHS
--IN
SELECT 6087 ,'0.5'      ,'100'         ,0.5      ,100         ,15   UNION ALL	--IN	--IN
SELECT 6088 ,'0.5'      ,'400'         ,0.5      ,400         ,15   UNION ALL	--IN	--IN
SELECT 6089 ,'0.5'      ,'1000'        ,0.5      ,1000        ,15   UNION ALL	--IN	--IN
SELECT 6090 ,'0.5'      ,'100'         ,0.5      ,100         ,15   UNION ALL	--IN	--IN
SELECT 6091 ,'0.5'      ,'100'         ,0.5      ,100         ,15   UNION ALL	--IN	--IN
SELECT 6092 ,'0.5'      ,'100'         ,0.5      ,100         ,15   UNION ALL	--IN	--IN
SELECT 6093 ,'0.2'      ,'2000'        ,0.2      ,2000        ,15   UNION ALL	--IN	--IN
SELECT 6094 ,'0.2'      ,'1000'        ,0.2      ,1000        ,15   UNION ALL	--IN	--IN
SELECT 6095 ,'0.2'      ,'1000'        ,0.2      ,1000        ,15   UNION ALL	--IN	--IN
--INH,DON,UUS,YNG
SELECT 6087 ,'2'        ,'200'         ,2        ,200         ,7    UNION ALL	--DON	--INH,DON,UUS,YNG
SELECT 6088 ,'2.5'      ,'1000'        ,2.5      ,1000        ,7    UNION ALL	--DON	--INH,DON,UUS,YNG 
SELECT 6089 ,'2'        ,'2000'        ,2        ,2000        ,7    UNION ALL	--DON	--INH,DON,UUS,YNG
SELECT 6090 ,'2'        ,'200'         ,2        ,200         ,7    UNION ALL	--DON	--INH,DON,UUS,YNG 
SELECT 6091 ,'2'        ,'200'         ,2        ,200         ,7    UNION ALL	--DON	--INH,DON,UUS,YNG
SELECT 6092 ,'2'        ,'200'         ,2        ,200         ,7    UNION ALL	--DON	--INH,DON,UUS,YNG 
SELECT 6093 ,'5'        ,'5000'        ,5        ,5000        ,7    UNION ALL	--DON	--INH,DON,UUS,YNG
SELECT 6094 ,'2'        ,'1000'        ,2        ,1000        ,7    UNION ALL	--DON	--INH,DON,UUS,YNG 
SELECT 6095 ,'2'        ,'1000'        ,2        ,1000        ,7    UNION ALL	--DON	--INH,DON,UUS,YNG
SELECT 6087 ,'2'        ,'200'         ,2        ,200         ,51   UNION ALL	--INH	--INH,DON,UUS,YNG
SELECT 6088 ,'2.5'      ,'1000'        ,2.5      ,1000        ,51   UNION ALL	--INH	--INH,DON,UUS,YNG 
SELECT 6089 ,'2'        ,'2000'        ,2        ,2000        ,51   UNION ALL	--INH	--INH,DON,UUS,YNG
SELECT 6090 ,'2'        ,'200'         ,2        ,200         ,51   UNION ALL	--INH	--INH,DON,UUS,YNG 
SELECT 6091 ,'2'        ,'200'         ,2        ,200         ,51   UNION ALL	--INH	--INH,DON,UUS,YNG
SELECT 6092 ,'2'        ,'200'         ,2        ,200         ,51   UNION ALL	--INH	--INH,DON,UUS,YNG 
SELECT 6093 ,'5'        ,'5000'        ,5        ,5000        ,51   UNION ALL	--INH	--INH,DON,UUS,YNG
SELECT 6094 ,'2'        ,'1000'        ,2        ,1000        ,51   UNION ALL	--INH	--INH,DON,UUS,YNG 
SELECT 6095 ,'2'        ,'1000'        ,2        ,1000        ,51   UNION ALL	--INH	--INH,DON,UUS,YNG
--INR
SELECT 6087 ,'6'        ,'600'         ,6        ,600         ,61   UNION ALL	--INR	--INR
SELECT 6088 ,'10'       ,'4000'        ,10       ,4000        ,61   UNION ALL	--INR	--INR
SELECT 6089 ,'5'        ,'5000'        ,5        ,5000        ,61   UNION ALL	--INR	--INR
SELECT 6090 ,'6'        ,'600'         ,6        ,600         ,61   UNION ALL	--INR	--INR
SELECT 6091 ,'6'        ,'600'         ,6        ,600         ,61   UNION ALL	--INR	--INR
SELECT 6092 ,'6'        ,'600'         ,6        ,600         ,61   UNION ALL	--INR	--INR
SELECT 6093 ,'10'       ,'10000'       ,10       ,10000       ,61   UNION ALL	--INR	--INR
SELECT 6094 ,'6'        ,'3000'        ,6        ,3000        ,61   UNION ALL	--INR	--INR
SELECT 6095 ,'6'        ,'3000'        ,6        ,3000        ,61   UNION ALL	--INR	--INR
--JPY
SELECT 6087 ,'20'       ,'2000'        ,20       ,2000        ,32   UNION ALL	--JPY	--JPY
SELECT 6088 ,'25'       ,'10000'       ,25       ,10000       ,32   UNION ALL	--JPY	--JPY
SELECT 6089 ,'20'       ,'20000'       ,20       ,20000       ,32   UNION ALL	--JPY	--JPY
SELECT 6090 ,'20'       ,'2000'        ,20       ,2000        ,32   UNION ALL	--JPY	--JPY
SELECT 6091 ,'20'       ,'2000'        ,20       ,2000        ,32   UNION ALL	--JPY	--JPY
SELECT 6092 ,'20'       ,'2000'        ,20       ,2000        ,32   UNION ALL	--JPY	--JPY
SELECT 6093 ,'30'       ,'30000'       ,30       ,30000       ,32   UNION ALL	--JPY	--JPY
SELECT 6094 ,'20'       ,'10000'       ,20       ,10000       ,32   UNION ALL	--JPY	--JPY
SELECT 6095 ,'20'       ,'10000'       ,20       ,10000       ,32   UNION ALL	--JPY	--JPY
--KES
SELECT 6087 ,'10'       ,'1000'        ,10       ,1000        ,79   UNION ALL	--KES	--KES
SELECT 6088 ,'12.5'     ,'5000'        ,12.5     ,5000        ,79   UNION ALL	--KES	--KES
SELECT 6089 ,'10'       ,'10000'       ,10       ,10000       ,79   UNION ALL	--KES	--KES
SELECT 6090 ,'10'       ,'1000'        ,10       ,1000        ,79   UNION ALL	--KES	--KES
SELECT 6091 ,'10'       ,'1000'        ,10       ,1000        ,79   UNION ALL	--KES	--KES
SELECT 6092 ,'10'       ,'1000'        ,10       ,1000        ,79   UNION ALL	--KES	--KES
SELECT 6093 ,'20'       ,'20000'       ,20       ,20000       ,79   UNION ALL	--KES	--KES
SELECT 6094 ,'10'       ,'5000'        ,10       ,5000        ,79   UNION ALL	--KES	--KES
SELECT 6095 ,'10'       ,'5000'        ,10       ,5000        ,79   UNION ALL	--KES	--KES
--KHR
SELECT 6087 ,'0.4'      ,'40'          ,0.4      ,40          ,71   UNION ALL	--KHR	--KHR
SELECT 6088 ,'0.5'      ,'200'         ,0.5      ,200         ,71   UNION ALL	--KHR	--KHR
SELECT 6089 ,'0.4'      ,'400'         ,0.4      ,400         ,71   UNION ALL	--KHR	--KHR
SELECT 6090 ,'0.4'      ,'40'          ,0.4      ,40          ,71   UNION ALL	--KHR	--KHR
SELECT 6091 ,'0.4'      ,'40'          ,0.4      ,40          ,71   UNION ALL	--KHR	--KHR
SELECT 6092 ,'0.4'      ,'40'          ,0.4      ,40          ,71   UNION ALL	--KHR	--KHR
SELECT 6093 ,'0.5'      ,'500'         ,0.5      ,500         ,71   UNION ALL	--KHR	--KHR
SELECT 6094 ,'0.4'      ,'200'         ,0.4      ,200         ,71   UNION ALL	--KHR	--KHR
SELECT 6095 ,'0.4'      ,'200'         ,0.4      ,200         ,71   UNION ALL	--KHR	--KHR
--KZT
SELECT 6087 ,'40'       ,'4000'        ,40       ,4000        ,122  UNION ALL	--KZT	--KZT
SELECT 6088 ,'50'       ,'20000'       ,50       ,20000       ,122  UNION ALL	--KZT	--KZT
SELECT 6089 ,'40'       ,'40000'       ,40       ,40000       ,122  UNION ALL	--KZT	--KZT
SELECT 6090 ,'40'       ,'4000'        ,40       ,4000        ,122  UNION ALL	--KZT	--KZT
SELECT 6091 ,'40'       ,'4000'        ,40       ,4000        ,122  UNION ALL	--KZT	--KZT
SELECT 6092 ,'40'       ,'4000'        ,40       ,4000        ,122  UNION ALL	--KZT	--KZT
SELECT 6093 ,'50'       ,'50000'       ,50       ,50000       ,122  UNION ALL	--KZT	--KZT
SELECT 6094 ,'40'       ,'20000'       ,40       ,20000       ,122  UNION ALL	--KZT	--KZT
SELECT 6095 ,'40'       ,'20000'       ,40       ,20000       ,122  UNION ALL	--KZT	--KZT
--LAK
SELECT 6087 ,'1'        ,'100'         ,1        ,100         ,93   UNION ALL	--LAK	--LAK
SELECT 6088 ,'1'        ,'400'         ,1        ,400         ,93   UNION ALL	--LAK	--LAK
SELECT 6089 ,'1'        ,'1000'        ,1        ,1000        ,93   UNION ALL	--LAK	--LAK
SELECT 6090 ,'1'        ,'100'         ,1        ,100         ,93   UNION ALL	--LAK	--LAK
SELECT 6091 ,'1'        ,'100'         ,1        ,100         ,93   UNION ALL	--LAK	--LAK
SELECT 6092 ,'1'        ,'100'         ,1        ,100         ,93   UNION ALL	--LAK	--LAK
SELECT 6093 ,'1'        ,'1000'        ,1        ,1000        ,93   UNION ALL	--LAK	--LAK
SELECT 6094 ,'1'        ,'500'         ,1        ,500         ,93   UNION ALL	--LAK	--LAK
SELECT 6095 ,'1'        ,'500'         ,1        ,500         ,93   UNION ALL	--LAK	--LAK
--LIR
SELECT 6087 ,'0.4'      ,'40'          ,0.4      ,40          ,73   UNION ALL	--LIR	--LIR
SELECT 6088 ,'0.5'      ,'200'         ,0.5      ,200         ,73   UNION ALL	--LIR	--LIR 
SELECT 6089 ,'0.4'      ,'400'         ,0.4      ,400         ,73   UNION ALL	--LIR	--LIR
SELECT 6090 ,'0.4'      ,'40'          ,0.4      ,40          ,73   UNION ALL	--LIR	--LIR 
SELECT 6091 ,'0.4'      ,'40'          ,0.4      ,40          ,73   UNION ALL	--LIR	--LIR
SELECT 6092 ,'0.4'      ,'40'          ,0.4      ,40          ,73   UNION ALL	--LIR	--LIR 
SELECT 6093 ,'0.5'      ,'500'         ,0.5      ,500         ,73   UNION ALL	--LIR	--LIR
SELECT 6094 ,'0.4'      ,'200'         ,0.4      ,200         ,73   UNION ALL	--LIR	--LIR 
SELECT 6095 ,'0.4'      ,'200'         ,0.4      ,200         ,73   UNION ALL	--LIR	--LIR
--MKK,MK
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,94   UNION ALL	--MK	--MKK,MK
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,94   UNION ALL	--MK	--MKK,MK
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,94   UNION ALL	--MK	--MKK,MK
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,94   UNION ALL	--MK	--MKK,MK
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,94   UNION ALL	--MK	--MKK,MK
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,94   UNION ALL	--MK	--MKK,MK
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,94   UNION ALL	--MK	--MKK,MK
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,94   UNION ALL	--MK	--MKK,MK
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,94   UNION ALL	--MK	--MKK,MK
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,70   UNION ALL	--MKK	--MKK,MK
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,70   UNION ALL	--MKK	--MKK,MK
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,70   UNION ALL	--MKK	--MKK,MK
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,70   UNION ALL	--MKK	--MKK,MK
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,70   UNION ALL	--MKK	--MKK,MK
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,70   UNION ALL	--MKK	--MKK,MK
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,70   UNION ALL	--MKK	--MKK,MK
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,70   UNION ALL	--MKK	--MKK,MK
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,70   UNION ALL	--MKK	--MKK,MK
--MXN
SELECT 6087 ,'2'        ,'200'         ,2        ,200         ,49   UNION ALL	--MXN	--MXN
SELECT 6088 ,'2.5'      ,'1000'        ,2.5      ,1000        ,49   UNION ALL	--MXN	--MXN
SELECT 6089 ,'2'        ,'2000'        ,2        ,2000        ,49   UNION ALL	--MXN	--MXN
SELECT 6090 ,'2'        ,'200'         ,2        ,200         ,49   UNION ALL	--MXN	--MXN
SELECT 6091 ,'2'        ,'200'         ,2        ,200         ,49   UNION ALL	--MXN	--MXN
SELECT 6092 ,'2'        ,'200'         ,2        ,200         ,49   UNION ALL	--MXN	--MXN
SELECT 6093 ,'5'        ,'5000'        ,5        ,5000        ,49   UNION ALL	--MXN	--MXN
SELECT 6094 ,'2'        ,'1000'        ,2        ,1000        ,49   UNION ALL	--MXN	--MXN
SELECT 6095 ,'2'        ,'1000'        ,2        ,1000        ,49   UNION ALL	--MXN	--MXN
--NOK
SELECT 6087 ,'2'        ,'200'         ,2        ,200         ,54   UNION ALL	--NOK	--NOK
SELECT 6088 ,'2.5'      ,'1000'        ,2.5      ,1000        ,54   UNION ALL	--NOK	--NOK
SELECT 6089 ,'2'        ,'2000'        ,2        ,2000        ,54   UNION ALL	--NOK	--NOK
SELECT 6090 ,'2'        ,'200'         ,2        ,200         ,54   UNION ALL	--NOK	--NOK
SELECT 6091 ,'2'        ,'200'         ,2        ,200         ,54   UNION ALL	--NOK	--NOK
SELECT 6092 ,'2'        ,'200'         ,2        ,200         ,54   UNION ALL	--NOK	--NOK
SELECT 6093 ,'2.5'      ,'2500'        ,2.5      ,2500        ,54   UNION ALL	--NOK	--NOK
SELECT 6094 ,'2'        ,'1000'        ,2        ,1000        ,54   UNION ALL	--NOK	--NOK
SELECT 6095 ,'2'        ,'1000'        ,2        ,1000        ,54   UNION ALL	--NOK	--NOK
--PEN
SELECT 6087 ,'0.4'      ,'40'          ,0.4      ,40          ,85   UNION ALL	--PEN	--PEN
SELECT 6088 ,'0.5'      ,'200'         ,0.5      ,200         ,85   UNION ALL	--PEN	--PEN
SELECT 6089 ,'0.4'      ,'400'         ,0.4      ,400         ,85   UNION ALL	--PEN	--PEN
SELECT 6090 ,'0.4'      ,'40'          ,0.4      ,40          ,85   UNION ALL	--PEN	--PEN
SELECT 6091 ,'0.4'      ,'40'          ,0.4      ,40          ,85   UNION ALL	--PEN	--PEN
SELECT 6092 ,'0.4'      ,'40'          ,0.4      ,40          ,85   UNION ALL	--PEN	--PEN
SELECT 6093 ,'0.5'      ,'500'         ,0.5      ,500         ,85   UNION ALL	--PEN	--PEN
SELECT 6094 ,'0.4'      ,'200'         ,0.4      ,200         ,85   UNION ALL	--PEN	--PEN
SELECT 6095 ,'0.4'      ,'200'         ,0.4      ,200         ,85   UNION ALL	--PEN	--PEN
--PLN
SELECT 6087 ,'0.4'      ,'40'          ,0.4      ,40          ,56   UNION ALL	--PLN	--PLN
SELECT 6088 ,'0.5'      ,'200'         ,0.5      ,200         ,56   UNION ALL	--PLN	--PLN
SELECT 6089 ,'0.4'      ,'400'         ,0.4      ,400         ,56   UNION ALL	--PLN	--PLN
SELECT 6090 ,'0.4'      ,'40'          ,0.4      ,40          ,56   UNION ALL	--PLN	--PLN
SELECT 6091 ,'0.4'      ,'40'          ,0.4      ,40          ,56   UNION ALL	--PLN	--PLN
SELECT 6092 ,'0.4'      ,'40'          ,0.4      ,40          ,56   UNION ALL	--PLN	--PLN
SELECT 6093 ,'0.5'      ,'500'         ,0.5      ,500         ,56   UNION ALL	--PLN	--PLN
SELECT 6094 ,'0.4'      ,'200'         ,0.4      ,200         ,56   UNION ALL	--PLN	--PLN
SELECT 6095 ,'0.4'      ,'200'         ,0.4      ,200         ,56   UNION ALL	--PLN	--PLN
--RMB,YUN
SELECT 6087 ,'0.4'      ,'500'         ,0.4      ,500         ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6088 ,'0.5'      ,'500'         ,0.5      ,500         ,13   UNION ALL	--RMB	--RMB,YUN 
SELECT 6089 ,'0.5'      ,'500'         ,0.5      ,500         ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6090 ,'0.4'      ,'500'         ,0.4      ,500         ,13   UNION ALL	--RMB	--RMB,YUN 
SELECT 6091 ,'0.4'      ,'500'         ,0.4      ,500         ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6092 ,'0.4'      ,'500'         ,0.4      ,500         ,13   UNION ALL	--RMB	--RMB,YUN 
SELECT 6093 ,'0.5'      ,'1000'        ,0.5      ,1000        ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6094 ,'0.4'      ,'500'         ,0.4      ,500         ,13   UNION ALL	--RMB	--RMB,YUN 
SELECT 6095 ,'0.4'      ,'500'         ,0.4      ,500         ,13   UNION ALL	--RMB	--RMB,YUN
SELECT 6087 ,'0.4'      ,'500'         ,0.4      ,500         ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6088 ,'0.5'      ,'500'         ,0.5      ,500         ,66   UNION ALL	--YUN	--RMB,YUN 
SELECT 6089 ,'0.5'      ,'500'         ,0.5      ,500         ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6090 ,'0.4'      ,'500'         ,0.4      ,500         ,66   UNION ALL	--YUN	--RMB,YUN 
SELECT 6091 ,'0.4'      ,'500'         ,0.4      ,500         ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6092 ,'0.4'      ,'500'         ,0.4      ,500         ,66   UNION ALL	--YUN	--RMB,YUN 
SELECT 6093 ,'0.5'      ,'1000'        ,0.5      ,1000        ,66   UNION ALL	--YUN	--RMB,YUN
SELECT 6094 ,'0.4'      ,'500'         ,0.4      ,500         ,66   UNION ALL	--YUN	--RMB,YUN 
SELECT 6095 ,'0.4'      ,'500'         ,0.4      ,500         ,66   UNION ALL	--YUN	--RMB,YUN
--RON
SELECT 6087 ,'0.4'      ,'40'          ,0.4      ,40          ,58   UNION ALL	--RON	--RON
SELECT 6088 ,'0.5'      ,'200'         ,0.5      ,200         ,58   UNION ALL	--RON	--RON
SELECT 6089 ,'0.4'      ,'400'         ,0.4      ,400         ,58   UNION ALL	--RON	--RON
SELECT 6090 ,'0.4'      ,'40'          ,0.4      ,40          ,58   UNION ALL	--RON	--RON
SELECT 6091 ,'0.4'      ,'40'          ,0.4      ,40          ,58   UNION ALL	--RON	--RON
SELECT 6092 ,'0.4'      ,'40'          ,0.4      ,40          ,58   UNION ALL	--RON	--RON
SELECT 6093 ,'0.5'      ,'500'         ,0.5      ,500         ,58   UNION ALL	--RON	--RON
SELECT 6094 ,'0.4'      ,'200'         ,0.4      ,200         ,58   UNION ALL	--RON	--RON
SELECT 6095 ,'0.4'      ,'200'         ,0.4      ,200         ,58   UNION ALL	--RON	--RON
--RUB
SELECT 6087 ,'6'        ,'600'         ,6        ,600         ,55   UNION ALL	--RUB	--RUB
SELECT 6088 ,'10'       ,'4000'        ,10       ,4000        ,55   UNION ALL	--RUB	--RUB
SELECT 6089 ,'5'        ,'5000'        ,5        ,5000        ,55   UNION ALL	--RUB	--RUB
SELECT 6090 ,'6'        ,'600'         ,6        ,600         ,55   UNION ALL	--RUB	--RUB
SELECT 6091 ,'6'        ,'600'         ,6        ,600         ,55   UNION ALL	--RUB	--RUB
SELECT 6092 ,'6'        ,'600'         ,6        ,600         ,55   UNION ALL	--RUB	--RUB
SELECT 6093 ,'10'       ,'10000'       ,10       ,10000       ,55   UNION ALL	--RUB	--RUB
SELECT 6094 ,'6'        ,'3000'        ,6        ,3000        ,55   UNION ALL	--RUB	--RUB
SELECT 6095 ,'6'        ,'3000'        ,6        ,3000        ,55   UNION ALL	--RUB	--RUB
--SEK
SELECT 6087 ,'2'        ,'200'         ,2        ,200         ,53   UNION ALL	--SEK	--SEK
SELECT 6088 ,'2.5'      ,'1000'        ,2.5      ,1000        ,53   UNION ALL	--SEK	--SEK
SELECT 6089 ,'2'        ,'2000'        ,2        ,2000        ,53   UNION ALL	--SEK	--SEK
SELECT 6090 ,'2'        ,'200'         ,2        ,200         ,53   UNION ALL	--SEK	--SEK
SELECT 6091 ,'2'        ,'200'         ,2        ,200         ,53   UNION ALL	--SEK	--SEK
SELECT 6092 ,'2'        ,'200'         ,2        ,200         ,53   UNION ALL	--SEK	--SEK
SELECT 6093 ,'2.5'      ,'2500'        ,2.5      ,2500        ,53   UNION ALL	--SEK	--SEK
SELECT 6094 ,'2'        ,'1000'        ,2        ,1000        ,53   UNION ALL	--SEK	--SEK
SELECT 6095 ,'2'        ,'1000'        ,2        ,1000        ,53   UNION ALL	--SEK	--SEK
--TB
SELECT 6087 ,'4'        ,'400'         ,4        ,400         ,4    UNION ALL	--TB	--TB
SELECT 6088 ,'5'        ,'2000'        ,5        ,2000        ,4    UNION ALL	--TB	--TB
SELECT 6089 ,'4'        ,'4000'        ,4        ,4000        ,4    UNION ALL	--TB	--TB
SELECT 6090 ,'4'        ,'400'         ,4        ,400         ,4    UNION ALL	--TB	--TB
SELECT 6091 ,'4'        ,'400'         ,4        ,400         ,4    UNION ALL	--TB	--TB
SELECT 6092 ,'4'        ,'400'         ,4        ,400         ,4    UNION ALL	--TB	--TB
SELECT 6093 ,'1'        ,'5000'        ,1        ,5000        ,4    UNION ALL	--TB	--TB
SELECT 6094 ,'1'        ,'2000'        ,1        ,2000        ,4    UNION ALL	--TB	--TB
SELECT 6095 ,'1'        ,'2000'        ,1        ,2000        ,4    UNION ALL	--TB	--TB
--USDT,US$
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,3    UNION ALL	--US$	--USDT,US$ 
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,3    UNION ALL	--US$	--USDT,US$
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,3    UNION ALL	--US$	--USDT,US$ 
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,3    UNION ALL	--US$	--USDT,US$
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,3    UNION ALL	--US$	--USDT,US$ 
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,3    UNION ALL	--US$	--USDT,US$
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,3    UNION ALL	--US$	--USDT,US$ 
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,3    UNION ALL	--US$	--USDT,US$
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,96   UNION ALL	--USDT	--USDT,US$
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,96   UNION ALL	--USDT	--USDT,US$ 
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,96   UNION ALL	--USDT	--USDT,US$
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,96   UNION ALL	--USDT	--USDT,US$ 
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,96   UNION ALL	--USDT	--USDT,US$
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,96   UNION ALL	--USDT	--USDT,US$ 
SELECT 6093 ,'0.25'     ,'250'         ,0.25     ,250         ,96   UNION ALL	--USDT	--USDT,US$
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,96   UNION ALL	--USDT	--USDT,US$ 
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,96   UNION ALL	--USDT	--USDT,US$
--Won
SELECT 6087 ,'0.2'      ,'20'          ,0.2      ,20          ,45   UNION ALL	--Won	--Won
SELECT 6088 ,'0.25'     ,'100'         ,0.25     ,100         ,45   UNION ALL	--Won	--Won
SELECT 6089 ,'0.2'      ,'200'         ,0.2      ,200         ,45   UNION ALL	--Won	--Won
SELECT 6090 ,'0.2'      ,'20'          ,0.2      ,20          ,45   UNION ALL	--Won	--Won
SELECT 6091 ,'0.2'      ,'20'          ,0.2      ,20          ,45   UNION ALL	--Won	--Won
SELECT 6092 ,'0.2'      ,'20'          ,0.2      ,20          ,45   UNION ALL	--Won	--Won
SELECT 6093 ,'0.3'      ,'300'         ,0.3      ,300         ,45   UNION ALL	--Won	--Won
SELECT 6094 ,'0.2'      ,'100'         ,0.2      ,100         ,45   UNION ALL	--Won	--Won
SELECT 6095 ,'0.2'      ,'100'         ,0.2      ,100         ,45				--Won	--Won

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #Dep_StakeLevel_Temp t
WHERE MaxStake > 999

;WITH STAKE_TEMP AS 
(
	SELECT s.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake,s.ExchangeId,s.GameGroupID
	FROM Dep_StakeLevel s WITH(NOLOCK)
	CROSS APPLY ( SELECT t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake 
				  FROM #Dep_StakeLevel_Temp t 
				  where t.ExchangeId = s.ExchangeId and t.GameGroupID = s.GameGroupID) t
	WHERE s.GameTypeID = 6001
)

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
