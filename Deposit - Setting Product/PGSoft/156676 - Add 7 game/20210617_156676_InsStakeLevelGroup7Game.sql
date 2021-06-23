/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210617
	Task:  Add 7 new game [PG Game]  - Deposit real currency RedmineID:#156676
	DB: DBCust/CustDB
*/
-- InsStakeLevel
CREATE TABLE #Dep_StakeLevel ( GameTypeID INT,
								ExchangeId int,
								GameGroupID int default(16))
								
INSERT INTO #Dep_StakeLevel(GameTypeID,ExchangeId)
SELECT 6001,122       -- KZT 

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

INSERT INTO Dep_StakeLevel(GameTypeID,ExchangeId,GameGroupID,StakeLevelID)
SELECT a.GameTypeID,a.ExchangeId,a.GameGroupID,StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY exchangeid) 
FROM #Dep_StakeLevel a

DROP TABLE #Dep_StakeLevel
-- END InsStakeLevel
-- InsStakeLevel Grpu[
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(16))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
--ARS
SELECT 6071 ,'4'    ,'4000'    ,4    ,4000    ,86   UNION ALL	--ARS	--ARS
SELECT 6072 ,'4'    ,'400'     ,4    ,400     ,86   UNION ALL	--ARS	--ARS
SELECT 6073 ,'4'    ,'4000'    ,4    ,4000    ,86   UNION ALL	--ARS	--ARS
SELECT 6074 ,'4'    ,'4000'    ,4    ,4000    ,86   UNION ALL	--ARS	--ARS
SELECT 6075 ,'4'    ,'400'     ,4    ,400     ,86   UNION ALL	--ARS	--ARS
SELECT 6076 ,'4'    ,'400'     ,4    ,400     ,86   UNION ALL	--ARS	--ARS
SELECT 6077 ,'4'    ,'400'     ,4    ,400     ,86   UNION ALL	--ARS	--ARS
--AUD
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,9    UNION ALL	--AUD	--AUD
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--AUD
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,9    UNION ALL	--AUD	--AUD
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,9    UNION ALL	--AUD	--AUD
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--AUD
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--AUD
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,9    UNION ALL	--AUD	--AUD
--BDT
SELECT 6071 ,'10'   ,'10000'   ,10   ,10000   ,97   UNION ALL	--BDT	--BDT
SELECT 6072 ,'10'   ,'1000'    ,10   ,1000    ,97   UNION ALL	--BDT	--BDT
SELECT 6073 ,'10'   ,'10000'   ,10   ,10000   ,97   UNION ALL	--BDT	--BDT
SELECT 6074 ,'10'   ,'10000'   ,10   ,10000   ,97   UNION ALL	--BDT	--BDT
SELECT 6075 ,'10'   ,'1000'    ,10   ,1000    ,97   UNION ALL	--BDT	--BDT
SELECT 6076 ,'10'   ,'1000'    ,10   ,1000    ,97   UNION ALL	--BDT	--BDT
SELECT 6077 ,'10'   ,'1000'    ,10   ,1000    ,97   UNION ALL	--BDT	--BDT
--BND
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,46   UNION ALL	--BND	--BND
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,46   UNION ALL	--BND	--BND
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,46   UNION ALL	--BND	--BND
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,46   UNION ALL	--BND	--BND
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,46   UNION ALL	--BND	--BND
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,46   UNION ALL	--BND	--BND
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,46   UNION ALL	--BND	--BND
--BRL
SELECT 6071 ,'0.4'  ,'400'     ,0.4  ,400     ,82   UNION ALL	--BRL	--BRL
SELECT 6072 ,'0.4'  ,'40'      ,0.4  ,40      ,82   UNION ALL	--BRL	--BRL
SELECT 6073 ,'0.4'  ,'400'     ,0.4  ,400     ,82   UNION ALL	--BRL	--BRL
SELECT 6074 ,'0.4'  ,'400'     ,0.4  ,400     ,82   UNION ALL	--BRL	--BRL
SELECT 6075 ,'0.4'  ,'40'      ,0.4  ,40      ,82   UNION ALL	--BRL	--BRL
SELECT 6076 ,'0.4'  ,'40'      ,0.4  ,40      ,82   UNION ALL	--BRL	--BRL
SELECT 6077 ,'0.4'  ,'40'      ,0.4  ,40      ,82   UNION ALL	--BRL	--BRL
--CAD
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,50   UNION ALL	--CAN	--CAD
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,50   UNION ALL	--CAN	--CAD
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,50   UNION ALL	--CAN	--CAD
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,50   UNION ALL	--CAN	--CAD
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,50   UNION ALL	--CAN	--CAD
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,50   UNION ALL	--CAN	--CAD
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,50   UNION ALL	--CAN	--CAD
--CHF
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,41   UNION ALL	--CHF	--CHF
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,41   UNION ALL	--CHF	--CHF
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,41   UNION ALL	--CHF	--CHF
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,41   UNION ALL	--CHF	--CHF
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,41   UNION ALL	--CHF	--CHF
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,41   UNION ALL	--CHF	--CHF
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,41   UNION ALL	--CHF	--CHF
--CLP
SELECT 6071 ,'100'  ,'100000'  ,100  ,100000  ,83   UNION ALL	--CLP	--CLP
SELECT 6072 ,'100'  ,'10000'   ,100  ,10000   ,83   UNION ALL	--CLP	--CLP
SELECT 6073 ,'100'  ,'100000'  ,100  ,100000  ,83   UNION ALL	--CLP	--CLP
SELECT 6074 ,'100'  ,'100000'  ,100  ,100000  ,83   UNION ALL	--CLP	--CLP
SELECT 6075 ,'100'  ,'10000'   ,100  ,10000   ,83   UNION ALL	--CLP	--CLP
SELECT 6076 ,'100'  ,'10000'   ,100  ,10000   ,83   UNION ALL	--CLP	--CLP
SELECT 6077 ,'100'  ,'10000'   ,100  ,10000   ,83   UNION ALL	--CLP	--CLP
--CNY
SELECT 6071 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--CNY
SELECT 6072 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6073 ,'0.5'  ,'1000'    ,0.5  ,1000    ,13   UNION ALL	--RMB	--CNY
SELECT 6074 ,'0.5'  ,'500'     ,0.5  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6075 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6076 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6077 ,'0.4'  ,'500'     ,0.4  ,500     ,13   UNION ALL	--RMB	--CNY
SELECT 6071 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--CNY
SELECT 6072 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6073 ,'0.5'  ,'1000'    ,0.5  ,1000    ,66   UNION ALL	--YUN	--CNY
SELECT 6074 ,'0.5'  ,'500'     ,0.5  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6075 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6076 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
SELECT 6077 ,'0.4'  ,'500'     ,0.4  ,500     ,66   UNION ALL	--YUN	--CNY
--CZK
SELECT 6071 ,'2'    ,'2000'    ,2    ,2000    ,57   UNION ALL	--CZK	--CZK
SELECT 6072 ,'2'    ,'200'     ,2    ,200     ,57   UNION ALL	--CZK	--CZK
SELECT 6073 ,'2'    ,'2000'    ,2    ,2000    ,57   UNION ALL	--CZK	--CZK
SELECT 6074 ,'2'    ,'2000'    ,2    ,2000    ,57   UNION ALL	--CZK	--CZK
SELECT 6075 ,'2'    ,'200'     ,2    ,200     ,57   UNION ALL	--CZK	--CZK
SELECT 6076 ,'2'    ,'200'     ,2    ,200     ,57   UNION ALL	--CZK	--CZK
SELECT 6077 ,'2'    ,'200'     ,2    ,200     ,57   UNION ALL	--CZK	--CZK
--DKK
SELECT 6071 ,'1'    ,'1000'    ,1    ,1000    ,52   UNION ALL	--DKK	--DKK
SELECT 6072 ,'1'    ,'100'     ,1    ,100     ,52   UNION ALL	--DKK	--DKK
SELECT 6073 ,'1'    ,'1000'    ,1    ,1000    ,52   UNION ALL	--DKK	--DKK
SELECT 6074 ,'1'    ,'1000'    ,1    ,1000    ,52   UNION ALL	--DKK	--DKK
SELECT 6075 ,'1'    ,'100'     ,1    ,100     ,52   UNION ALL	--DKK	--DKK
SELECT 6076 ,'1'    ,'100'     ,1    ,100     ,52   UNION ALL	--DKK	--DKK
SELECT 6077 ,'1'    ,'100'     ,1    ,100     ,52   UNION ALL	--DKK	--DKK
--EUR
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,6    UNION ALL	--EURO	--EUR
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EUR
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,6    UNION ALL	--EURO	--EUR
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,6    UNION ALL	--EURO	--EUR
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EUR
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EUR
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,6    UNION ALL	--EURO	--EUR
--GBP
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,12   UNION ALL	--GBP	--GBP
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,12   UNION ALL	--GBP	--GBP
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,12   UNION ALL	--GBP	--GBP
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,12   UNION ALL	--GBP	--GBP
--GHS
SELECT 6071 ,'0.4'  ,'400'     ,0.4  ,400     ,80   UNION ALL	--GHS	--GHS
SELECT 6072 ,'0.4'  ,'40'      ,0.4  ,40      ,80   UNION ALL	--GHS	--GHS
SELECT 6073 ,'0.4'  ,'400'     ,0.4  ,400     ,80   UNION ALL	--GHS	--GHS
SELECT 6074 ,'0.4'  ,'400'     ,0.4  ,400     ,80   UNION ALL	--GHS	--GHS
SELECT 6075 ,'0.4'  ,'40'      ,0.4  ,40      ,80   UNION ALL	--GHS	--GHS
SELECT 6076 ,'0.4'  ,'40'      ,0.4  ,40      ,80   UNION ALL	--GHS	--GHS
SELECT 6077 ,'0.4'  ,'40'      ,0.4  ,40      ,80   UNION ALL	--GHS	--GHS
--IDR
SELECT 6071 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--IDR
SELECT 6072 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6073 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--IDR
SELECT 6074 ,'1'    ,'1000'    ,1    ,1000    ,15   UNION ALL	--IN	--IDR
SELECT 6075 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6076 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IDR
SELECT 6077 ,'1'    ,'100'     ,1    ,100     ,15   UNION ALL	--IN	--IDR
--INR
SELECT 6071 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--INR
SELECT 6072 ,'6'    ,'600'     ,6    ,600     ,61   UNION ALL	--INR	--INR
SELECT 6073 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--INR
SELECT 6074 ,'5'    ,'5000'    ,5    ,5000    ,61   UNION ALL	--INR	--INR
SELECT 6075 ,'6'    ,'600'     ,6    ,600     ,61   UNION ALL	--INR	--INR
SELECT 6076 ,'6'    ,'600'     ,6    ,600     ,61   UNION ALL	--INR	--INR
SELECT 6077 ,'6'    ,'600'     ,6    ,600     ,61   UNION ALL	--INR	--INR
--JPY
SELECT 6071 ,'20'   ,'20000'   ,20   ,20000   ,32   UNION ALL	--JPY	--JPY
SELECT 6072 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 6073 ,'20'   ,'20000'   ,20   ,20000   ,32   UNION ALL	--JPY	--JPY
SELECT 6074 ,'20'   ,'20000'   ,20   ,20000   ,32   UNION ALL	--JPY	--JPY
SELECT 6075 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 6076 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
SELECT 6077 ,'20'   ,'2000'    ,20   ,2000    ,32   UNION ALL	--JPY	--JPY
--KES
SELECT 6071 ,'10'   ,'10000'   ,10   ,10000   ,79   UNION ALL	--KES	--KES
SELECT 6072 ,'10'   ,'1000'    ,10   ,1000    ,79   UNION ALL	--KES	--KES
SELECT 6073 ,'10'   ,'10000'   ,10   ,10000   ,79   UNION ALL	--KES	--KES
SELECT 6074 ,'10'   ,'10000'   ,10   ,10000   ,79   UNION ALL	--KES	--KES
SELECT 6075 ,'10'   ,'1000'    ,10   ,1000    ,79   UNION ALL	--KES	--KES
SELECT 6076 ,'10'   ,'1000'    ,10   ,1000    ,79   UNION ALL	--KES	--KES
SELECT 6077 ,'10'   ,'1000'    ,10   ,1000    ,79   UNION ALL	--KES	--KES
--KHR
SELECT 6071 ,'0.4'  ,'400'     ,0.4  ,400     ,71   UNION ALL	--KHR	--KHR
SELECT 6072 ,'0.4'  ,'40'      ,0.4  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 6073 ,'0.4'  ,'400'     ,0.4  ,400     ,71   UNION ALL	--KHR	--KHR
SELECT 6074 ,'0.4'  ,'400'     ,0.4  ,400     ,71   UNION ALL	--KHR	--KHR
SELECT 6075 ,'0.4'  ,'40'      ,0.4  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 6076 ,'0.4'  ,'40'      ,0.4  ,40      ,71   UNION ALL	--KHR	--KHR
SELECT 6077 ,'0.4'  ,'40'      ,0.4  ,40      ,71   UNION ALL	--KHR	--KHR
--KRW
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,45   UNION ALL	--Won	--KRW
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,45   UNION ALL	--Won	--KRW
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,45   UNION ALL	--Won	--KRW
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,45   UNION ALL	--Won	--KRW
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,45   UNION ALL	--Won	--KRW
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,45   UNION ALL	--Won	--KRW
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,45   UNION ALL	--Won	--KRW
--LAK
SELECT 6071 ,'1'    ,'1000'    ,1    ,1000    ,93   UNION ALL	--LAK	--LAK
SELECT 6072 ,'1'    ,'100'     ,1    ,100     ,93   UNION ALL	--LAK	--LAK
SELECT 6073 ,'1'    ,'1000'    ,1    ,1000    ,93   UNION ALL	--LAK	--LAK
SELECT 6074 ,'1'    ,'1000'    ,1    ,1000    ,93   UNION ALL	--LAK	--LAK
SELECT 6075 ,'1'    ,'100'     ,1    ,100     ,93   UNION ALL	--LAK	--LAK
SELECT 6076 ,'1'    ,'100'     ,1    ,100     ,93   UNION ALL	--LAK	--LAK
SELECT 6077 ,'1'    ,'100'     ,1    ,100     ,93   UNION ALL	--LAK	--LAK
--MMK
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,70   UNION ALL	--MKK	--MMK
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MMK
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,70   UNION ALL	--MKK	--MMK
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,70   UNION ALL	--MKK	--MMK
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MMK
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MMK
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,70   UNION ALL	--MKK	--MMK
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,94   UNION ALL	--MK	--MMK
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MMK
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,94   UNION ALL	--MK	--MMK
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,94   UNION ALL	--MK	--MMK
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MMK
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MMK
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,94   UNION ALL	--MK	--MMK
--MXN
SELECT 6071 ,'2'    ,'2000'    ,2    ,2000    ,49   UNION ALL	--MXN	--MXN
SELECT 6072 ,'2'    ,'200'     ,2    ,200     ,49   UNION ALL	--MXN	--MXN
SELECT 6073 ,'2'    ,'2000'    ,2    ,2000    ,49   UNION ALL	--MXN	--MXN
SELECT 6074 ,'2'    ,'2000'    ,2    ,2000    ,49   UNION ALL	--MXN	--MXN
SELECT 6075 ,'2'    ,'200'     ,2    ,200     ,49   UNION ALL	--MXN	--MXN
SELECT 6076 ,'2'    ,'200'     ,2    ,200     ,49   UNION ALL	--MXN	--MXN
SELECT 6077 ,'2'    ,'200'     ,2    ,200     ,49   UNION ALL	--MXN	--MXN
--NOK
SELECT 6071 ,'2'    ,'2000'    ,2    ,2000    ,54   UNION ALL	--NOK	--NOK
SELECT 6072 ,'2'    ,'200'     ,2    ,200     ,54   UNION ALL	--NOK	--NOK
SELECT 6073 ,'2'    ,'2000'    ,2    ,2000    ,54   UNION ALL	--NOK	--NOK
SELECT 6074 ,'2'    ,'2000'    ,2    ,2000    ,54   UNION ALL	--NOK	--NOK
SELECT 6075 ,'2'    ,'200'     ,2    ,200     ,54   UNION ALL	--NOK	--NOK
SELECT 6076 ,'2'    ,'200'     ,2    ,200     ,54   UNION ALL	--NOK	--NOK
SELECT 6077 ,'2'    ,'200'     ,2    ,200     ,54   UNION ALL	--NOK	--NOK
--PEN
SELECT 6071 ,'0.4'  ,'400'     ,0.4  ,400     ,85   UNION ALL	--PEN	--PEN
SELECT 6072 ,'0.4'  ,'40'      ,0.4  ,40      ,85   UNION ALL	--PEN	--PEN
SELECT 6073 ,'0.4'  ,'400'     ,0.4  ,400     ,85   UNION ALL	--PEN	--PEN
SELECT 6074 ,'0.4'  ,'400'     ,0.4  ,400     ,85   UNION ALL	--PEN	--PEN
SELECT 6075 ,'0.4'  ,'40'      ,0.4  ,40      ,85   UNION ALL	--PEN	--PEN
SELECT 6076 ,'0.4'  ,'40'      ,0.4  ,40      ,85   UNION ALL	--PEN	--PEN
SELECT 6077 ,'0.4'  ,'40'      ,0.4  ,40      ,85   UNION ALL	--PEN	--PEN
--PLN
SELECT 6071 ,'0.4'  ,'400'     ,0.4  ,400     ,56   UNION ALL	--PLN	--PLN
SELECT 6072 ,'0.4'  ,'40'      ,0.4  ,40      ,56   UNION ALL	--PLN	--PLN
SELECT 6073 ,'0.4'  ,'400'     ,0.4  ,400     ,56   UNION ALL	--PLN	--PLN
SELECT 6074 ,'0.4'  ,'400'     ,0.4  ,400     ,56   UNION ALL	--PLN	--PLN
SELECT 6075 ,'0.4'  ,'40'      ,0.4  ,40      ,56   UNION ALL	--PLN	--PLN
SELECT 6076 ,'0.4'  ,'40'      ,0.4  ,40      ,56   UNION ALL	--PLN	--PLN
SELECT 6077 ,'0.4'  ,'40'      ,0.4  ,40      ,56   UNION ALL	--PLN	--PLN
--RON
SELECT 6071 ,'0.4'  ,'400'     ,0.4  ,400     ,58   UNION ALL	--RON	--RON
SELECT 6072 ,'0.4'  ,'40'      ,0.4  ,40      ,58   UNION ALL	--RON	--RON
SELECT 6073 ,'0.4'  ,'400'     ,0.4  ,400     ,58   UNION ALL	--RON	--RON
SELECT 6074 ,'0.4'  ,'400'     ,0.4  ,400     ,58   UNION ALL	--RON	--RON
SELECT 6075 ,'0.4'  ,'40'      ,0.4  ,40      ,58   UNION ALL	--RON	--RON
SELECT 6076 ,'0.4'  ,'40'      ,0.4  ,40      ,58   UNION ALL	--RON	--RON
SELECT 6077 ,'0.4'  ,'40'      ,0.4  ,40      ,58   UNION ALL	--RON	--RON
--RUB
SELECT 6071 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB
SELECT 6072 ,'6'    ,'600'     ,6    ,600     ,55   UNION ALL	--RUB	--RUB
SELECT 6073 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB
SELECT 6074 ,'5'    ,'5000'    ,5    ,5000    ,55   UNION ALL	--RUB	--RUB
SELECT 6075 ,'6'    ,'600'     ,6    ,600     ,55   UNION ALL	--RUB	--RUB
SELECT 6076 ,'6'    ,'600'     ,6    ,600     ,55   UNION ALL	--RUB	--RUB
SELECT 6077 ,'6'    ,'600'     ,6    ,600     ,55   UNION ALL	--RUB	--RUB
--SEK
SELECT 6071 ,'2'    ,'2000'    ,2    ,2000    ,53   UNION ALL	--SEK	--SEK
SELECT 6072 ,'2'    ,'200'     ,2    ,200     ,53   UNION ALL	--SEK	--SEK
SELECT 6073 ,'2'    ,'2000'    ,2    ,2000    ,53   UNION ALL	--SEK	--SEK
SELECT 6074 ,'2'    ,'2000'    ,2    ,2000    ,53   UNION ALL	--SEK	--SEK
SELECT 6075 ,'2'    ,'200'     ,2    ,200     ,53   UNION ALL	--SEK	--SEK
SELECT 6076 ,'2'    ,'200'     ,2    ,200     ,53   UNION ALL	--SEK	--SEK
SELECT 6077 ,'2'    ,'200'     ,2    ,200     ,53   UNION ALL	--SEK	--SEK
--THB
SELECT 6071 ,'4'    ,'4000'    ,4    ,4000    ,4    UNION ALL	--TB	--THB
SELECT 6072 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--THB
SELECT 6073 ,'4'    ,'4000'    ,4    ,4000    ,4    UNION ALL	--TB	--THB
SELECT 6074 ,'4'    ,'4000'    ,4    ,4000    ,4    UNION ALL	--TB	--THB
SELECT 6075 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--THB
SELECT 6076 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--THB
SELECT 6077 ,'4'    ,'400'     ,4    ,400     ,4    UNION ALL	--TB	--THB
--TRY
SELECT 6071 ,'0.4'  ,'400'     ,0.4  ,400     ,73   UNION ALL	--LIR	--TRY
SELECT 6072 ,'0.4'  ,'40'      ,0.4  ,40      ,73   UNION ALL	--LIR	--TRY
SELECT 6073 ,'0.4'  ,'400'     ,0.4  ,400     ,73   UNION ALL	--LIR	--TRY
SELECT 6074 ,'0.4'  ,'400'     ,0.4  ,400     ,73   UNION ALL	--LIR	--TRY
SELECT 6075 ,'0.4'  ,'40'      ,0.4  ,40      ,73   UNION ALL	--LIR	--TRY
SELECT 6076 ,'0.4'  ,'40'      ,0.4  ,40      ,73   UNION ALL	--LIR	--TRY
SELECT 6077 ,'0.4'  ,'40'      ,0.4  ,40      ,73   UNION ALL	--LIR	--TRY
--USD
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--USD
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--USD
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,3    UNION ALL	--US$	--USD
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,3    UNION ALL	--US$	--USD
SELECT 6071 ,'0.2'  ,'200'     ,0.2  ,200     ,96   UNION ALL	--USDT	--USD
SELECT 6072 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD
SELECT 6073 ,'0.2'  ,'200'     ,0.2  ,200     ,96   UNION ALL	--USDT	--USD
SELECT 6074 ,'0.2'  ,'200'     ,0.2  ,200     ,96   UNION ALL	--USDT	--USD
SELECT 6075 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD
SELECT 6076 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD
SELECT 6077 ,'0.2'  ,'20'      ,0.2  ,20      ,96   UNION ALL	--USDT	--USD
--KZT 
SELECT 6071 ,'40'  ,'40000'    ,40  ,40000   ,122   UNION ALL	--KZT 	--KZT 
SELECT 6072 ,'40'  ,'4000'     ,40  ,4000    ,122   UNION ALL	--KZT 	--KZT 
SELECT 6073 ,'40'  ,'40000'    ,40  ,40000   ,122   UNION ALL	--KZT 	--KZT
SELECT 6074 ,'40'  ,'40000'    ,40  ,40000   ,122   UNION ALL	--KZT 	--KZT
SELECT 6075 ,'40'  ,'4000'     ,40  ,4000    ,122   UNION ALL	--KZT 	--KZT
SELECT 6076 ,'40'  ,'4000'     ,40  ,4000    ,122   UNION ALL	--KZT 	--KZT
SELECT 6077 ,'40'  ,'4000'     ,40  ,4000    ,122   UNION ALL	--KZT 	--KZT
--VND
SELECT 6071 ,'2'    ,'2000'    ,2    ,2000    ,7    UNION ALL	--DON	--VND
SELECT 6072 ,'2'    ,'200'     ,2    ,200     ,7    UNION ALL	--DON	--VND
SELECT 6073 ,'2'    ,'2000'    ,2    ,2000    ,7    UNION ALL	--DON	--VND
SELECT 6074 ,'2'    ,'2000'    ,2    ,2000    ,7    UNION ALL	--DON	--VND
SELECT 6075 ,'2'    ,'200'     ,2    ,200     ,7    UNION ALL	--DON	--VND
SELECT 6076 ,'2'    ,'200'     ,2    ,200     ,7    UNION ALL	--DON	--VND
SELECT 6077 ,'2'    ,'200'     ,2    ,200     ,7    UNION ALL	--DON	--VND
SELECT 6071 ,'2'    ,'2000'    ,2    ,2000    ,51   UNION ALL	--INH	--VND
SELECT 6072 ,'2'    ,'200'     ,2    ,200     ,51   UNION ALL	--INH	--VND
SELECT 6073 ,'2'    ,'2000'    ,2    ,2000    ,51   UNION ALL	--INH	--VND
SELECT 6074 ,'2'    ,'2000'    ,2    ,2000    ,51   UNION ALL	--INH	--VND
SELECT 6075 ,'2'    ,'200'     ,2    ,200     ,51   UNION ALL	--INH	--VND
SELECT 6076 ,'2'    ,'200'     ,2    ,200     ,51   UNION ALL	--INH	--VND
SELECT 6077 ,'2'    ,'200'     ,2    ,200     ,51				--INH	--VND


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
WHERE s.GameTypeID = 6001)

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