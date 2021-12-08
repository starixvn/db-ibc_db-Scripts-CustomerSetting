/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20211110
	Task: PG Soft - Add 9 new games - Deposit RedmineID:#163595
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(16))

INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--ARS
SELECT 6078 ,'4'    ,'400'     ,4    ,400     ,86   UNION ALL	--ARS	--ARS
SELECT 6079 ,'5'    ,'2000'    ,5    ,2000    ,86   UNION ALL	--ARS	--ARS
SELECT 6080 ,'4'    ,'400'     ,4    ,400     ,86   UNION ALL	--ARS	--ARS
SELECT 6081 ,'4'    ,'400'     ,4    ,400     ,86   UNION ALL	--ARS	--ARS
SELECT 6082 ,'4'    ,'4000'    ,4    ,4000    ,86   UNION ALL	--ARS	--ARS
SELECT 6083 ,'4'    ,'400'     ,4    ,400     ,86   UNION ALL	--ARS	--ARS
SELECT 6084 ,'4'    ,'2000'    ,4    ,2000    ,86   UNION ALL	--ARS	--ARS
SELECT 6085 ,'4'    ,'4000'    ,4    ,4000    ,86   UNION ALL	--ARS	--ARS
SELECT 6086 ,'4'    ,'400'     ,4    ,400     ,86   UNION ALL	--ARS	--ARS
--AUD
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--AUD
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,9    UNION ALL	--AUD	--AUD
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--AUD
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--AUD
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,9    UNION ALL	--AUD	--AUD
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--AUD
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,9    UNION ALL	--AUD	--AUD
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,9    UNION ALL	--AUD	--AUD
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--AUD
--BDT
SELECT 6078 ,'10'   ,'1000'    ,10   ,1000    ,97   UNION ALL	--BDT	--BDT
SELECT 6079 ,'10'   ,'4000'    ,10   ,4000    ,97   UNION ALL	--BDT	--BDT
SELECT 6080 ,'10'   ,'1000'    ,10   ,1000    ,97   UNION ALL	--BDT	--BDT
SELECT 6081 ,'10'   ,'1000'    ,10   ,1000    ,97   UNION ALL	--BDT	--BDT
SELECT 6082 ,'10'   ,'10000'   ,10   ,10000   ,97   UNION ALL	--BDT	--BDT
SELECT 6083 ,'10'   ,'1000'    ,10   ,1000    ,97   UNION ALL	--BDT	--BDT
SELECT 6084 ,'10'   ,'5000'    ,10   ,5000    ,97   UNION ALL	--BDT	--BDT
SELECT 6085 ,'10'   ,'10000'   ,10   ,10000   ,97   UNION ALL	--BDT	--BDT
SELECT 6086 ,'10'   ,'1000'    ,10   ,1000    ,97   UNION ALL	--BDT	--BDT
--BND
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,46   UNION ALL	--BND	--BND
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,46   UNION ALL	--BND	--BND
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,46   UNION ALL	--BND	--BND
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,46   UNION ALL	--BND	--BND
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,46   UNION ALL	--BND	--BND
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,46   UNION ALL	--BND	--BND
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,46   UNION ALL	--BND	--BND
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,46   UNION ALL	--BND	--BND
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,46   UNION ALL	--BND	--BND
--BRL
SELECT 6078 ,'0.4'  ,'40'      ,0.4  ,40      ,82   UNION ALL	--BRL	--BRL
SELECT 6079 ,'0.5'  ,'200'     ,0.5  ,200     ,82   UNION ALL	--BRL	--BRL
SELECT 6080 ,'0.4'  ,'40'      ,0.4  ,40      ,82   UNION ALL	--BRL	--BRL
SELECT 6081 ,'0.4'  ,'40'      ,0.4  ,40      ,82   UNION ALL	--BRL	--BRL
SELECT 6082 ,'0.4'  ,'400'     ,0.4  ,400     ,82   UNION ALL	--BRL	--BRL
SELECT 6083 ,'0.4'  ,'40'      ,0.4  ,40      ,82   UNION ALL	--BRL	--BRL
SELECT 6084 ,'0.4'  ,'200'     ,0.4  ,200     ,82   UNION ALL	--BRL	--BRL
SELECT 6085 ,'0.4'  ,'400'     ,0.4  ,400     ,82   UNION ALL	--BRL	--BRL
SELECT 6086 ,'0.4'  ,'40'      ,0.4  ,40      ,82   UNION ALL	--BRL	--BRL
--CAD
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,50   UNION ALL	--CAN	--CAD
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,50   UNION ALL	--CAN	--CAD
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,50   UNION ALL	--CAN	--CAD
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,50   UNION ALL	--CAN	--CAD
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,50   UNION ALL	--CAN	--CAD
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,50   UNION ALL	--CAN	--CAD
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,50   UNION ALL	--CAN	--CAD
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,50   UNION ALL	--CAN	--CAD
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,50   UNION ALL	--CAN	--CAD
--CHF
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,41   UNION ALL	--CHF	--CHF
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,41   UNION ALL	--CHF	--CHF
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,41   UNION ALL	--CHF	--CHF
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,41   UNION ALL	--CHF	--CHF
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,41   UNION ALL	--CHF	--CHF
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,41   UNION ALL	--CHF	--CHF
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,41   UNION ALL	--CHF	--CHF
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,41   UNION ALL	--CHF	--CHF
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,41   UNION ALL	--CHF	--CHF
--CLP
SELECT 6078 ,'100'  ,'10000'   ,100  ,10000   ,83   UNION ALL	--CLP	--CLP
SELECT 6079 ,'150'  ,'60000'   ,150  ,60000   ,83   UNION ALL	--CLP	--CLP
SELECT 6080 ,'100'  ,'10000'   ,100  ,10000   ,83   UNION ALL	--CLP	--CLP
SELECT 6081 ,'100'  ,'10000'   ,100  ,10000   ,83   UNION ALL	--CLP	--CLP
SELECT 6082 ,'100'  ,'100000'  ,100  ,100000  ,83   UNION ALL	--CLP	--CLP
SELECT 6083 ,'100'  ,'10000'   ,100  ,10000   ,83   UNION ALL	--CLP	--CLP
SELECT 6084 ,'100'  ,'50000'   ,100  ,50000   ,83   UNION ALL	--CLP	--CLP
SELECT 6085 ,'100'  ,'100000'  ,100  ,100000  ,83   UNION ALL	--CLP	--CLP
SELECT 6086 ,'100'  ,'10000'   ,100  ,10000   ,83   UNION ALL	--CLP	--CLP
--RMB
SELECT 6078 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6079 ,'0.5'  ,'500'     ,0.5  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6080 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6081 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6082 ,'0.5'  ,'500'     ,0.5  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6083 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6084 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--CNY
SELECT 6086 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
--YUN
SELECT 6078 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6079 ,'0.5'  ,'500'     ,0.5  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6080 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6081 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6082 ,'0.5'  ,'500'     ,0.5  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6083 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6084 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--CNY
SELECT 6086 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
--CZK
SELECT 6078 ,'2'    ,'200'     ,2    ,200     ,57   UNION ALL	--CZK	--CZK
SELECT 6079 ,'2.5'  ,'1000'    ,2.5  ,1000    ,57   UNION ALL	--CZK	--CZK
SELECT 6080 ,'2'    ,'200'     ,2    ,200     ,57   UNION ALL	--CZK	--CZK
SELECT 6081 ,'2'    ,'200'     ,2    ,200     ,57   UNION ALL	--CZK	--CZK
SELECT 6082 ,'2'    ,'2000'    ,2    ,2000    ,57   UNION ALL	--CZK	--CZK
SELECT 6083 ,'2'    ,'200'     ,2    ,200     ,57   UNION ALL	--CZK	--CZK
SELECT 6084 ,'2'    ,'1000'    ,2    ,1000    ,57   UNION ALL	--CZK	--CZK
SELECT 6085 ,'2'    ,'2000'    ,2    ,2000    ,57   UNION ALL	--CZK	--CZK
SELECT 6086 ,'2'    ,'200'     ,2    ,200     ,57   UNION ALL	--CZK	--CZK
--DKK
SELECT 6078 ,'1'    ,'100'     ,1    ,100     ,52   UNION ALL	--DKK	--DKK
SELECT 6079 ,'1'    ,'400'     ,1    ,400     ,52   UNION ALL	--DKK	--DKK
SELECT 6080 ,'1'    ,'100'     ,1    ,100     ,52   UNION ALL	--DKK	--DKK
SELECT 6081 ,'1'    ,'100'     ,1    ,100     ,52   UNION ALL	--DKK	--DKK
SELECT 6082 ,'1'    ,'1000'    ,1    ,1000    ,52   UNION ALL	--DKK	--DKK
SELECT 6083 ,'1'    ,'100'     ,1    ,100     ,52   UNION ALL	--DKK	--DKK
SELECT 6084 ,'1'    ,'500'     ,1    ,500     ,52   UNION ALL	--DKK	--DKK
SELECT 6085 ,'1'    ,'1000'    ,1    ,1000    ,52   UNION ALL	--DKK	--DKK
SELECT 6086 ,'1'    ,'100'     ,1    ,100     ,52   UNION ALL	--DKK	--DKK
--EURO
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EUR
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,6    UNION ALL	--EURO	--EUR
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EUR
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EUR
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,6    UNION ALL	--EURO	--EUR
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EUR
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,6    UNION ALL	--EURO	--EUR
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,6    UNION ALL	--EURO	--EUR
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EUR
--GBP
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,12   UNION ALL	--GBP	--GBP
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,12   UNION ALL	--GBP	--GBP
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,12   UNION ALL	--GBP	--GBP
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,12   UNION ALL	--GBP	--GBP
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
--GHS
SELECT 6078 ,'0.4'  ,'40'      ,0.4  ,40      ,80   UNION ALL	--GHS	--GHS
SELECT 6079 ,'0.5'  ,'200'     ,0.5  ,200     ,80   UNION ALL	--GHS	--GHS
SELECT 6080 ,'0.4'  ,'40'      ,0.4  ,40      ,80   UNION ALL	--GHS	--GHS
SELECT 6081 ,'0.4'  ,'40'      ,0.4  ,40      ,80   UNION ALL	--GHS	--GHS
SELECT 6082 ,'0.4'  ,'400'     ,0.4  ,400     ,80   UNION ALL	--GHS	--GHS
SELECT 6083 ,'0.4'  ,'40'      ,0.4  ,40      ,80   UNION ALL	--GHS	--GHS
SELECT 6084 ,'0.4'  ,'200'     ,0.4  ,200     ,80   UNION ALL	--GHS	--GHS
SELECT 6085 ,'0.4'  ,'400'     ,0.4  ,400     ,80   UNION ALL	--GHS	--GHS
SELECT 6086 ,'0.4'  ,'40'      ,0.4  ,40      ,80   UNION ALL	--GHS	--GHS
--IN
SELECT 6078 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6079 ,'0.5'  ,'400'     ,0.5  ,400     ,15   UNION ALL	--IN	--IDR
SELECT 6080 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6081 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6082 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--IDR
SELECT 6083 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6084 ,'0.5'  ,'500'     ,0.5  ,500     ,15   UNION ALL	--IN	--IDR
SELECT 6085 ,'0.5'  ,'1000'    ,0.5  ,1000    ,15   UNION ALL	--IN	--IDR
SELECT 6086 ,'0.5'  ,'100'     ,0.5  ,100     ,15   UNION ALL	--IN	--IDR
--INR
SELECT 6078 ,'6'    ,'600'     ,6    ,600     ,61   UNION ALL	--INR	--INR
SELECT 6079 ,'10'   ,'4000'    ,10   ,4000    ,61   UNION ALL	--INR	--INR
SELECT 6080 ,'6'    ,'600'     ,6    ,600     ,61   UNION ALL	--INR	--INR
SELECT 6081 ,'6'    ,'600'     ,6    ,600     ,61   UNION ALL	--INR	--INR
SELECT 6082 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--INR
SELECT 6083 ,'6'    ,'600'     ,6    ,600     ,61   UNION ALL	--INR	--INR
SELECT 6084 ,'6'    ,'3000'    ,6    ,3000    ,61   UNION ALL	--INR	--INR
SELECT 6085 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--INR
SELECT 6086 ,'6'    ,'600'     ,6    ,600     ,61   UNION ALL	--INR	--INR
--JPY
SELECT 6078 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 6079 ,'25'   ,'10000'   ,25   ,10000   ,32   UNION ALL	--JPY	--JPY
SELECT 6080 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 6081 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 6082 ,'20'   ,'20000'   ,20   ,20000   ,32   UNION ALL	--JPY	--JPY
SELECT 6083 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 6084 ,'20'   ,'10000'   ,20   ,10000   ,32   UNION ALL	--JPY	--JPY
SELECT 6085 ,'20'   ,'20000'   ,20   ,20000   ,32   UNION ALL	--JPY	--JPY
SELECT 6086 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
--KES
SELECT 6078 ,'10'   ,'1000'    ,10   ,1000    ,79   UNION ALL	--KES	--KES
SELECT 6079 ,'12.5' ,'5000'    ,12.5 ,5000    ,79   UNION ALL	--KES	--KES
SELECT 6080 ,'10'   ,'1000'    ,10   ,1000    ,79   UNION ALL	--KES	--KES
SELECT 6081 ,'10'   ,'1000'    ,10   ,1000    ,79   UNION ALL	--KES	--KES
SELECT 6082 ,'10'   ,'10000'   ,10   ,10000   ,79   UNION ALL	--KES	--KES
SELECT 6083 ,'10'   ,'1000'    ,10   ,1000    ,79   UNION ALL	--KES	--KES
SELECT 6084 ,'10'   ,'5000'    ,10   ,5000    ,79   UNION ALL	--KES	--KES
SELECT 6085 ,'10'   ,'10000'   ,10   ,10000   ,79   UNION ALL	--KES	--KES
SELECT 6086 ,'10'   ,'1000'    ,10   ,1000    ,79   UNION ALL	--KES	--KES
--KHR
SELECT 6078 ,'0.4'  ,'40'      ,0.4  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 6079 ,'0.5'  ,'200'     ,0.5  ,200     ,71   UNION ALL	--KHR	--KHR
SELECT 6080 ,'0.4'  ,'40'      ,0.4  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 6081 ,'0.4'  ,'40'      ,0.4  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 6082 ,'0.4'  ,'400'     ,0.4  ,400     ,71   UNION ALL	--KHR	--KHR
SELECT 6083 ,'0.4'  ,'40'      ,0.4  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 6084 ,'0.4'  ,'200'     ,0.4  ,200     ,71   UNION ALL	--KHR	--KHR
SELECT 6085 ,'0.4'  ,'400'     ,0.4  ,400     ,71   UNION ALL	--KHR	--KHR
SELECT 6086 ,'0.4'  ,'40'      ,0.4  ,40      ,71   UNION ALL	--KHR	--KHR
--Won
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,45   UNION ALL	--Won	--KRW
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,45   UNION ALL	--Won	--KRW
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,45   UNION ALL	--Won	--KRW
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,45   UNION ALL	--Won	--KRW
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,45   UNION ALL	--Won	--KRW
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,45   UNION ALL	--Won	--KRW
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,45   UNION ALL	--Won	--KRW
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,45   UNION ALL	--Won	--KRW
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,45   UNION ALL	--Won	--KRW
--LAK
SELECT 6078 ,'1'    ,'100'     ,1    ,100     ,93   UNION ALL	--LAK	--LAK
SELECT 6079 ,'1'    ,'400'     ,1    ,400     ,93   UNION ALL	--LAK	--LAK
SELECT 6080 ,'1'    ,'100'     ,1    ,100     ,93   UNION ALL	--LAK	--LAK
SELECT 6081 ,'1'    ,'100'     ,1    ,100     ,93   UNION ALL	--LAK	--LAK
SELECT 6082 ,'1'    ,'1000'    ,1    ,1000    ,93   UNION ALL	--LAK	--LAK
SELECT 6083 ,'1'    ,'100'     ,1    ,100     ,93   UNION ALL	--LAK	--LAK
SELECT 6084 ,'1'    ,'500'     ,1    ,500     ,93   UNION ALL	--LAK	--LAK
SELECT 6085 ,'1'    ,'1000'    ,1    ,1000    ,93   UNION ALL	--LAK	--LAK
SELECT 6086 ,'1'    ,'100'     ,1    ,100     ,93   UNION ALL	--LAK	--LAK
--MK
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MMK
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,94   UNION ALL	--MK	--MMK
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MMK
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MMK
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,94   UNION ALL	--MK	--MMK
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MMK
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,94   UNION ALL	--MK	--MMK
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,94   UNION ALL	--MK	--MMK
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MMK
--MKK
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MMK
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,70   UNION ALL	--MKK	--MMK
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MMK
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MMK
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,70   UNION ALL	--MKK	--MMK
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MMK
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,70   UNION ALL	--MKK	--MMK
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,70   UNION ALL	--MKK	--MMK
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MMK
--MXN
SELECT 6078 ,'2'    ,'200'     ,2    ,200     ,49   UNION ALL	--MXN	--MXN
SELECT 6079 ,'2.5'  ,'1000'    ,2.5  ,1000    ,49   UNION ALL	--MXN	--MXN
SELECT 6080 ,'2'    ,'200'     ,2    ,200     ,49   UNION ALL	--MXN	--MXN
SELECT 6081 ,'2'    ,'200'     ,2    ,200     ,49   UNION ALL	--MXN	--MXN
SELECT 6082 ,'2'    ,'2000'    ,2    ,2000    ,49   UNION ALL	--MXN	--MXN
SELECT 6083 ,'2'    ,'200'     ,2    ,200     ,49   UNION ALL	--MXN	--MXN
SELECT 6084 ,'2'    ,'1000'    ,2    ,1000    ,49   UNION ALL	--MXN	--MXN
SELECT 6085 ,'2'    ,'2000'    ,2    ,2000    ,49   UNION ALL	--MXN	--MXN
SELECT 6086 ,'2'    ,'200'     ,2    ,200     ,49   UNION ALL	--MXN	--MXN
--NOK
SELECT 6078 ,'2'    ,'200'     ,2    ,200     ,54   UNION ALL	--NOK	--NOK
SELECT 6079 ,'2.5'  ,'1000'    ,2.5  ,1000    ,54   UNION ALL	--NOK	--NOK
SELECT 6080 ,'2'    ,'200'     ,2    ,200     ,54   UNION ALL	--NOK	--NOK
SELECT 6081 ,'2'    ,'200'     ,2    ,200     ,54   UNION ALL	--NOK	--NOK
SELECT 6082 ,'2'    ,'2000'    ,2    ,2000    ,54   UNION ALL	--NOK	--NOK
SELECT 6083 ,'2'    ,'200'     ,2    ,200     ,54   UNION ALL	--NOK	--NOK
SELECT 6084 ,'2'    ,'1000'    ,2    ,1000    ,54   UNION ALL	--NOK	--NOK
SELECT 6085 ,'2'    ,'2000'    ,2    ,2000    ,54   UNION ALL	--NOK	--NOK
SELECT 6086 ,'2'    ,'200'     ,2    ,200     ,54   UNION ALL	--NOK	--NOK
--PEN
SELECT 6078 ,'0.4'  ,'40'      ,0.4  ,40      ,85   UNION ALL	--PEN	--PEN
SELECT 6079 ,'0.5'  ,'200'     ,0.5  ,200     ,85   UNION ALL	--PEN	--PEN
SELECT 6080 ,'0.4'  ,'40'      ,0.4  ,40      ,85   UNION ALL	--PEN	--PEN
SELECT 6081 ,'0.4'  ,'40'      ,0.4  ,40      ,85   UNION ALL	--PEN	--PEN
SELECT 6082 ,'0.4'  ,'400'     ,0.4  ,400     ,85   UNION ALL	--PEN	--PEN
SELECT 6083 ,'0.4'  ,'40'      ,0.4  ,40      ,85   UNION ALL	--PEN	--PEN
SELECT 6084 ,'0.4'  ,'200'     ,0.4  ,200     ,85   UNION ALL	--PEN	--PEN
SELECT 6085 ,'0.4'  ,'400'     ,0.4  ,400     ,85   UNION ALL	--PEN	--PEN
SELECT 6086 ,'0.4'  ,'40'      ,0.4  ,40      ,85   UNION ALL	--PEN	--PEN
--PLN
SELECT 6078 ,'0.4'  ,'40'      ,0.4  ,40      ,56   UNION ALL	--PLN	--PLN
SELECT 6079 ,'0.5'  ,'200'     ,0.5  ,200     ,56   UNION ALL	--PLN	--PLN
SELECT 6080 ,'0.4'  ,'40'      ,0.4  ,40      ,56   UNION ALL	--PLN	--PLN
SELECT 6081 ,'0.4'  ,'40'      ,0.4  ,40      ,56   UNION ALL	--PLN	--PLN
SELECT 6082 ,'0.4'  ,'400'     ,0.4  ,400     ,56   UNION ALL	--PLN	--PLN
SELECT 6083 ,'0.4'  ,'40'      ,0.4  ,40      ,56   UNION ALL	--PLN	--PLN
SELECT 6084 ,'0.4'  ,'200'     ,0.4  ,200     ,56   UNION ALL	--PLN	--PLN
SELECT 6085 ,'0.4'  ,'400'     ,0.4  ,400     ,56   UNION ALL	--PLN	--PLN
SELECT 6086 ,'0.4'  ,'40'      ,0.4  ,40      ,56   UNION ALL	--PLN	--PLN
--RON
SELECT 6078 ,'0.4'  ,'40'      ,0.4  ,40      ,58   UNION ALL	--RON	--RON
SELECT 6079 ,'0.5'  ,'200'     ,0.5  ,200     ,58   UNION ALL	--RON	--RON
SELECT 6080 ,'0.4'  ,'40'      ,0.4  ,40      ,58   UNION ALL	--RON	--RON
SELECT 6081 ,'0.4'  ,'40'      ,0.4  ,40      ,58   UNION ALL	--RON	--RON
SELECT 6082 ,'0.4'  ,'400'     ,0.4  ,400     ,58   UNION ALL	--RON	--RON
SELECT 6083 ,'0.4'  ,'40'      ,0.4  ,40      ,58   UNION ALL	--RON	--RON
SELECT 6084 ,'0.4'  ,'200'     ,0.4  ,200     ,58   UNION ALL	--RON	--RON
SELECT 6085 ,'0.4'  ,'400'     ,0.4  ,400     ,58   UNION ALL	--RON	--RON
SELECT 6086 ,'0.4'  ,'40'      ,0.4  ,40      ,58   UNION ALL	--RON	--RON
--RUB
SELECT 6078 ,'6'    ,'600'     ,6    ,600     ,55   UNION ALL	--RUB	--RUB
SELECT 6079 ,'10'   ,'4000'    ,10   ,4000    ,55   UNION ALL	--RUB	--RUB
SELECT 6080 ,'6'    ,'600'     ,6    ,600     ,55   UNION ALL	--RUB	--RUB
SELECT 6081 ,'6'    ,'600'     ,6    ,600     ,55   UNION ALL	--RUB	--RUB
SELECT 6082 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB
SELECT 6083 ,'6'    ,'600'     ,6    ,600     ,55   UNION ALL	--RUB	--RUB
SELECT 6084 ,'6'    ,'3000'    ,6    ,3000    ,55   UNION ALL	--RUB	--RUB
SELECT 6085 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB
SELECT 6086 ,'6'    ,'600'     ,6    ,600     ,55   UNION ALL	--RUB	--RUB
--SEK
SELECT 6078 ,'2'    ,'200'     ,2    ,200     ,53   UNION ALL	--SEK	--SEK
SELECT 6079 ,'2.5'  ,'1000'    ,2.5  ,1000    ,53   UNION ALL	--SEK	--SEK
SELECT 6080 ,'2'    ,'200'     ,2    ,200     ,53   UNION ALL	--SEK	--SEK
SELECT 6081 ,'2'    ,'200'     ,2    ,200     ,53   UNION ALL	--SEK	--SEK
SELECT 6082 ,'2'    ,'2000'    ,2    ,2000    ,53   UNION ALL	--SEK	--SEK
SELECT 6083 ,'2'    ,'200'     ,2    ,200     ,53   UNION ALL	--SEK	--SEK
SELECT 6084 ,'2'    ,'1000'    ,2    ,1000    ,53   UNION ALL	--SEK	--SEK
SELECT 6085 ,'2'    ,'2000'    ,2    ,2000    ,53   UNION ALL	--SEK	--SEK
SELECT 6086 ,'2'    ,'200'     ,2    ,200     ,53   UNION ALL	--SEK	--SEK
--TB
SELECT 6078 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--THB
SELECT 6079 ,'5'    ,'2000'    ,5    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 6080 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--THB
SELECT 6081 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--THB
SELECT 6082 ,'4'    ,'4000'    ,4    ,4000    ,4    UNION ALL	--TB	--THB
SELECT 6083 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--THB
SELECT 6084 ,'4'    ,'2000'    ,4    ,2000    ,4    UNION ALL	--TB	--THB
SELECT 6085 ,'4'    ,'4000'    ,4    ,4000    ,4    UNION ALL	--TB	--THB
SELECT 6086 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--THB
--LIR
SELECT 6078 ,'0.4'  ,'40'      ,0.4  ,40      ,73   UNION ALL	--LIR	--TRY
SELECT 6079 ,'0.5'  ,'200'     ,0.5  ,200     ,73   UNION ALL	--LIR	--TRY
SELECT 6080 ,'0.4'  ,'40'      ,0.4  ,40      ,73   UNION ALL	--LIR	--TRY
SELECT 6081 ,'0.4'  ,'40'      ,0.4  ,40      ,73   UNION ALL	--LIR	--TRY
SELECT 6082 ,'0.4'  ,'400'     ,0.4  ,400     ,73   UNION ALL	--LIR	--TRY
SELECT 6083 ,'0.4'  ,'40'      ,0.4  ,40      ,73   UNION ALL	--LIR	--TRY
SELECT 6084 ,'0.4'  ,'200'     ,0.4  ,200     ,73   UNION ALL	--LIR	--TRY
SELECT 6085 ,'0.4'  ,'400'     ,0.4  ,400     ,73   UNION ALL	--LIR	--TRY
SELECT 6086 ,'0.4'  ,'40'      ,0.4  ,40      ,73   UNION ALL	--LIR	--TRY
--US$
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,3    UNION ALL	--US$	--USD
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--USD
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,3    UNION ALL	--US$	--USD
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--USD
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
--USDT
SELECT 6078 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD
SELECT 6079 ,'0.25' ,'100'     ,0.25 ,100     ,96   UNION ALL	--USDT	--USD
SELECT 6080 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD
SELECT 6081 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD
SELECT 6082 ,'0.2'  ,'200'     ,0.2  ,200     ,96   UNION ALL	--USDT	--USD
SELECT 6083 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD
SELECT 6084 ,'0.2'  ,'100'     ,0.2  ,100     ,96   UNION ALL	--USDT	--USD
SELECT 6085 ,'0.2'  ,'200'     ,0.2  ,200     ,96   UNION ALL	--USDT	--USD
SELECT 6086 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD
--DON
SELECT 6078 ,'2'    ,'200'     ,2    ,200     ,7    UNION ALL	--DON	--VND
SELECT 6079 ,'2.5'  ,'1000'    ,2.5  ,1000    ,7    UNION ALL	--DON	--VND
SELECT 6080 ,'2'    ,'200'     ,2    ,200     ,7    UNION ALL	--DON	--VND
SELECT 6081 ,'2'    ,'200'     ,2    ,200     ,7    UNION ALL	--DON	--VND
SELECT 6082 ,'2'    ,'2000'    ,2    ,2000    ,7    UNION ALL	--DON	--VND
SELECT 6083 ,'2'    ,'200'     ,2    ,200     ,7    UNION ALL	--DON	--VND
SELECT 6084 ,'2'    ,'1000'    ,2    ,1000    ,7    UNION ALL	--DON	--VND
SELECT 6085 ,'2'    ,'2000'    ,2    ,2000    ,7    UNION ALL	--DON	--VND
SELECT 6086 ,'2'    ,'200'     ,2    ,200     ,7    UNION ALL	--DON	--VND
--KZT
SELECT 6078 ,'40'   ,'4000'    ,40   ,4000    ,122  UNION ALL	--KZT	--KZT
SELECT 6079 ,'50'   ,'20000'   ,50   ,20000   ,122  UNION ALL	--KZT	--KZT
SELECT 6080 ,'40'   ,'4000'    ,40   ,4000    ,122  UNION ALL	--KZT	--KZT
SELECT 6081 ,'40'   ,'4000'    ,40   ,4000    ,122  UNION ALL	--KZT	--KZT
SELECT 6082 ,'40'   ,'40000'   ,40   ,40000   ,122  UNION ALL	--KZT	--KZT
SELECT 6083 ,'40'   ,'4000'    ,40   ,4000    ,122  UNION ALL	--KZT	--KZT
SELECT 6084 ,'40'   ,'20000'   ,40   ,20000   ,122  UNION ALL	--KZT	--KZT
SELECT 6085 ,'40'   ,'40000'   ,40   ,40000   ,122  UNION ALL	--KZT	--KZT
SELECT 6086 ,'40'   ,'4000'    ,40   ,4000    ,122  UNION ALL	--KZT	--KZT
--INH
SELECT 6078 ,'2'    ,'200'     ,2    ,200     ,51   UNION ALL	--INH	--VND
SELECT 6079 ,'2.5'  ,'1000'    ,2.5  ,1000    ,51   UNION ALL	--INH	--VND
SELECT 6080 ,'2'    ,'200'     ,2    ,200     ,51   UNION ALL	--INH	--VND
SELECT 6081 ,'2'    ,'200'     ,2    ,200     ,51   UNION ALL	--INH	--VND
SELECT 6082 ,'2'    ,'2000'    ,2    ,2000    ,51   UNION ALL	--INH	--VND
SELECT 6083 ,'2'    ,'200'     ,2    ,200     ,51   UNION ALL	--INH	--VND
SELECT 6084 ,'2'    ,'1000'    ,2    ,1000    ,51   UNION ALL	--INH	--VND
SELECT 6085 ,'2'    ,'2000'    ,2    ,2000    ,51   UNION ALL	--INH	--VND
SELECT 6086 ,'2'    ,'200'     ,2    ,200     ,51   			--INH	--VND

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
