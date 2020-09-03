/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 202000903
	Task:  Add 3 new game [PG Game]  - Deposit real currency RedmineID:#140878
	DB: DBCust/CustDB
*/
CREATE TABLE #Dep_StakeLevel_Temp (GameTypeID INT,MinLabel NVARCHAR(50),MaxLabel NVARCHAR(50)
								,MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8)
								,ExchangeId int, GameGroupID int default(16))
								
INSERT INTO #Dep_StakeLevel_Temp(GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake,ExchangeId)
--=============================================
SELECT 6021 ,'1'      ,'180'       ,1      ,180       ,48   UNION ALL	--ZAR	--ZAR
SELECT 6022 ,'6'      ,'6000'      ,6      ,6000      ,48   UNION ALL	--ZAR	--ZAR
SELECT 6021 ,'2.5'    ,'450'       ,2.5    ,450       ,51   UNION ALL	--INH	--VND
SELECT 6022 ,'0.9'    ,'10500'     ,0.9    ,10500     ,51   UNION ALL	--INH	--VND
SELECT 6023 ,'2.5'    ,'250'       ,2.5    ,250       ,51   UNION ALL	--INH	--VND
SELECT 6021 ,'5'      ,'900'       ,5      ,900       ,89   UNION ALL	--UYU	--UYU
SELECT 6022 ,'1'      ,'15000'     ,1      ,15000     ,89   UNION ALL	--UYU	--UYU
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,35   UNION ALL	--$US	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,35   UNION ALL	--$US	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,35   UNION ALL	--$US	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,40   UNION ALL	--IRR	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,40   UNION ALL	--IRR	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,40   UNION ALL	--IRR	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,17   UNION ALL	--NTD	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,17   UNION ALL	--NTD	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,17   UNION ALL	--NTD	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,68   UNION ALL	--POS	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,68   UNION ALL	--POS	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,68   UNION ALL	--POS	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,74   UNION ALL	--TH	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,74   UNION ALL	--TH	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,74   UNION ALL	--TH	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,65   UNION ALL	--UDI	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,65   UNION ALL	--UDI	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,65   UNION ALL	--UDI	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,3    UNION ALL	--US$	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,3    UNION ALL	--US$	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,3    UNION ALL	--US$	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,95   UNION ALL	--USD	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,95   UNION ALL	--USD	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,95   UNION ALL	--USD	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,96   UNION ALL	--USDT	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,96   UNION ALL	--USDT	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,96   UNION ALL	--USDT	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,64   UNION ALL	--UT	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,64   UNION ALL	--UT	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,64   UNION ALL	--UT	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,36   UNION ALL	--Y$US	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,36   UNION ALL	--Y$US	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,36   UNION ALL	--Y$US	--USD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,16   UNION ALL	--Yen	--USD
SELECT 6022 ,'0.3'    ,'450'       ,0.3    ,450       ,16   UNION ALL	--Yen	--USD
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,16   UNION ALL	--Yen	--USD
SELECT 6021 ,'0.5'    ,'90'        ,0.5    ,90        ,73   UNION ALL	--LIR	--TRY
SELECT 6022 ,'0.2'    ,'2400'      ,0.2    ,2400      ,73   UNION ALL	--LIR	--TRY
SELECT 6021 ,'2.5'    ,'450'       ,2.5    ,450       ,4    UNION ALL	--TB	--THB
SELECT 6022 ,'1.5'    ,'15000'     ,1.5    ,15000     ,4    UNION ALL	--TB	--THB
SELECT 6023 ,'5'      ,'500'       ,5      ,500       ,4    UNION ALL	--TB	--THB
SELECT 6021 ,'2.5'    ,'450'       ,2.5    ,450       ,43   UNION ALL	--THB	--THB
SELECT 6022 ,'1.5'    ,'15000'     ,1.5    ,15000     ,43   UNION ALL	--THB	--THB
SELECT 6023 ,'5'      ,'500'       ,5      ,500       ,43   UNION ALL	--THB	--THB
SELECT 6021 ,'2.5'    ,'450'       ,2.5    ,450       ,53   UNION ALL	--SEK	--SEK
SELECT 6022 ,'2'      ,'3600'      ,2      ,3600      ,53   UNION ALL	--SEK	--SEK
SELECT 6021 ,'5'      ,'900'       ,5      ,900       ,55   UNION ALL	--RUB	--RUB
SELECT 6022 ,'2'      ,'30000'     ,2      ,30000     ,55   UNION ALL	--RUB	--RUB
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,58   UNION ALL	--RON	--RON
SELECT 6022 ,'0.2'    ,'1800'      ,0.2    ,1800      ,58   UNION ALL	--RON	--RON
SELECT 6021 ,'0.5'    ,'90'        ,0.5    ,90        ,88   UNION ALL	--PYG	--PYG
SELECT 6022 ,'0.4'    ,'3000'      ,0.4    ,3000      ,88   UNION ALL	--PYG	--PYG
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,56   UNION ALL	--PLN	--PLN
SELECT 6022 ,'0.2'    ,'1500'      ,0.2    ,1500      ,56   UNION ALL	--PLN	--PLN
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,85   UNION ALL	--PEN	--PEN
SELECT 6022 ,'1'      ,'1200'      ,1      ,1200      ,85   UNION ALL	--PEN	--PEN
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,63   UNION ALL	--NZD	--NZD
SELECT 6022 ,'0.2'    ,'600'       ,0.2    ,600       ,63   UNION ALL	--NZD	--NZD
SELECT 6021 ,'2.5'    ,'450'       ,2.5    ,450       ,54   UNION ALL	--NOK	--NOK
SELECT 6022 ,'2'      ,'3600'      ,2      ,3600      ,54   UNION ALL	--NOK	--NOK
SELECT 6021 ,'2.5'    ,'450'       ,2.5    ,450       ,49   UNION ALL	--MXN	--MXN
SELECT 6022 ,'0.4'    ,'7500'      ,0.4    ,7500      ,49   UNION ALL	--MXN	--MXN
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,91   UNION ALL	--MNT	--MNT
SELECT 6022 ,'0.2'    ,'900'       ,0.2    ,900       ,91   UNION ALL	--MNT	--MNT
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,94   UNION ALL	--MK	--MMK
SELECT 6022 ,'0.2'    ,'600'       ,0.2    ,600       ,94   UNION ALL	--MK	--MMK
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,70   UNION ALL	--MKK	--MMK
SELECT 6022 ,'0.2'    ,'600'       ,0.2    ,600       ,70   UNION ALL	--MKK	--MMK
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,69   UNION ALL	--MMK	--MMK
SELECT 6022 ,'0.2'    ,'600'       ,0.2    ,600       ,69   UNION ALL	--MMK	--MMK
SELECT 6021 ,'1'      ,'180'       ,1      ,180       ,93   UNION ALL	--LAK	--LAK
SELECT 6022 ,'2'      ,'3600'      ,2      ,3600      ,93   UNION ALL	--LAK	--LAK
SELECT 6021 ,'0.1'    ,'18'        ,0.1    ,18        ,62   UNION ALL	--KW	--KRW
SELECT 6022 ,'0.2'    ,'450'       ,0.2    ,450       ,62   UNION ALL	--KW	--KRW
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,62   UNION ALL	--KW	--KRW
SELECT 6021 ,'0.1'    ,'18'        ,0.1    ,18        ,44   UNION ALL	--PT	--KRW
SELECT 6022 ,'0.2'    ,'450'       ,0.2    ,450       ,44   UNION ALL	--PT	--KRW
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,44   UNION ALL	--PT	--KRW
SELECT 6021 ,'0.1'    ,'18'        ,0.1    ,18        ,45   UNION ALL	--Won	--KRW
SELECT 6022 ,'0.2'    ,'450'       ,0.2    ,450       ,45   UNION ALL	--Won	--KRW
SELECT 6023 ,'0.25'   ,'25'        ,0.25   ,25        ,45   UNION ALL	--Won	--KRW
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,71   UNION ALL	--KHR	--KHR
SELECT 6022 ,'0.2'    ,'1500'      ,0.2    ,1500      ,71   UNION ALL	--KHR	--KHR
SELECT 6021 ,'10'     ,'1800'      ,10     ,1800      ,79   UNION ALL	--KES	--KES
SELECT 6022 ,'10'     ,'45000'     ,10     ,45000     ,79   UNION ALL	--KES	--KES
SELECT 6021 ,'25'     ,'4500'      ,25     ,4500      ,32   UNION ALL	--JPY	--JPY
SELECT 6022 ,'4'      ,'45000'     ,4      ,45000     ,32   UNION ALL	--JPY	--JPY
SELECT 6021 ,'25'     ,'4500'      ,25     ,4500      ,37   UNION ALL	--P	--JPY
SELECT 6022 ,'4'      ,'45000'     ,4      ,45000     ,37   UNION ALL	--P	--JPY
SELECT 6021 ,'25'     ,'4500'      ,25     ,4500      ,31   UNION ALL	--Pts	--JPY
SELECT 6022 ,'4'      ,'45000'     ,4      ,45000     ,31   UNION ALL	--Pts	--JPY
SELECT 6021 ,'5'      ,'900'       ,5      ,900       ,61   UNION ALL	--INR	--INR
SELECT 6022 ,'1'      ,'30000'     ,1      ,30000     ,61   UNION ALL	--INR	--INR
SELECT 6021 ,'5'      ,'900'       ,5      ,900       ,76   UNION ALL	--PS	--INR
SELECT 6022 ,'1'      ,'30000'     ,1      ,30000     ,76   UNION ALL	--PS	--INR
SELECT 6021 ,'5'      ,'900'       ,5      ,900       ,77   UNION ALL	--PTH	--INR
SELECT 6022 ,'1'      ,'30000'     ,1      ,30000     ,77   UNION ALL	--PTH	--INR
SELECT 6021 ,'5'      ,'900'       ,5      ,900       ,75   UNION ALL	--PTU	--INR
SELECT 6022 ,'1'      ,'30000'     ,1      ,30000     ,75   UNION ALL	--PTU	--INR
SELECT 6021 ,'1'      ,'180'       ,1      ,180       ,47   UNION ALL	--DDD	--IDR
SELECT 6022 ,'0.6'    ,'6000'      ,0.6    ,6000      ,47   UNION ALL	--DDD	--IDR
SELECT 6023 ,'1.25'   ,'125'       ,1.25   ,125       ,47   UNION ALL	--DDD	--IDR
SELECT 6021 ,'1'      ,'180'       ,1      ,180       ,33   UNION ALL	--IDD	--IDR
SELECT 6022 ,'0.6'    ,'6000'      ,0.6    ,6000      ,33   UNION ALL	--IDD	--IDR
SELECT 6023 ,'1.25'   ,'125'       ,1.25   ,125       ,33   UNION ALL	--IDD	--IDR
SELECT 6021 ,'1'      ,'180'       ,1      ,180       ,34   UNION ALL	--IDR	--IDR
SELECT 6022 ,'0.6'    ,'6000'      ,0.6    ,6000      ,34   UNION ALL	--IDR	--IDR
SELECT 6023 ,'1.25'   ,'125'       ,1.25   ,125       ,34   UNION ALL	--IDR	--IDR
SELECT 6021 ,'1'      ,'180'       ,1      ,180       ,15   UNION ALL	--IN	--IDR
SELECT 6022 ,'0.6'    ,'6000'      ,0.6    ,6000      ,15   UNION ALL	--IN	--IDR
SELECT 6023 ,'1.25'   ,'125'       ,1.25   ,125       ,15   UNION ALL	--IN	--IDR
SELECT 6021 ,'1'      ,'180'       ,1      ,180       ,22   UNION ALL	--IND	--IDR
SELECT 6022 ,'0.6'    ,'6000'      ,0.6    ,6000      ,22   UNION ALL	--IND	--IDR
SELECT 6023 ,'1.25'   ,'125'       ,1.25   ,125       ,22   UNION ALL	--IND	--IDR
SELECT 6021 ,'0.5'    ,'90'        ,0.5    ,90        ,80   UNION ALL	--GHS	--GHS
SELECT 6022 ,'0.2'    ,'2400'      ,0.2    ,2400      ,80   UNION ALL	--GHS	--GHS
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,12   UNION ALL	--GBP	--GBP
SELECT 6022 ,'0.2'    ,'375'       ,0.2    ,375       ,12   UNION ALL	--GBP	--GBP
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,78   UNION ALL	--EUR	--EUR
SELECT 6022 ,'0.2'    ,'375'       ,0.2    ,375       ,78   UNION ALL	--EUR	--EUR
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,6    UNION ALL	--EURO	--EUR
SELECT 6022 ,'0.2'    ,'375'       ,0.2    ,375       ,6    UNION ALL	--EURO	--EUR
SELECT 6021 ,'1'      ,'180'       ,1      ,180       ,52   UNION ALL	--DKK	--DKK
SELECT 6022 ,'1'      ,'3000'      ,1      ,3000      ,52   UNION ALL	--DKK	--DKK
SELECT 6021 ,'2.5'    ,'450'       ,2.5    ,450       ,57   UNION ALL	--CZK	--CZK
SELECT 6022 ,'2'      ,'9000'      ,2      ,9000      ,57   UNION ALL	--CZK	--CZK
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,84   UNION ALL	--COP	--COP
SELECT 6022 ,'1'      ,'1200'      ,1      ,1200      ,84   UNION ALL	--COP	--COP
SELECT 6021 ,'0.5'    ,'90'        ,0.5    ,90        ,81   UNION ALL	--CY	--CNY
SELECT 6022 ,'0.2'    ,'3000'      ,0.2    ,3000      ,81   UNION ALL	--CY	--CNY
SELECT 6021 ,'0.5'    ,'90'        ,0.5    ,90        ,13   UNION ALL	--RMB	--CNY
SELECT 6022 ,'0.2'    ,'3000'      ,0.2    ,3000      ,13   UNION ALL	--RMB	--CNY
SELECT 6021 ,'0.5'    ,'90'        ,0.5    ,90        ,66   UNION ALL	--YUN	--CNY
SELECT 6022 ,'0.2'    ,'3000'      ,0.2    ,3000      ,66   UNION ALL	--YUN	--CNY
SELECT 6021 ,'100'    ,'18000'     ,100    ,18000     ,83   UNION ALL	--CLP	--CLP
SELECT 6022 ,'20'     ,'300000'    ,20     ,300000    ,83   UNION ALL	--CLP	--CLP
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,41   UNION ALL	--CHF	--CHF
SELECT 6022 ,'0.2'    ,'450'       ,0.2    ,450       ,41   UNION ALL	--CHF	--CHF
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,21   UNION ALL	--CAD	--CAD
SELECT 6022 ,'0.2'    ,'600'       ,0.2    ,600       ,21   UNION ALL	--CAD	--CAD
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,50   UNION ALL	--CAN	--CAD
SELECT 6022 ,'0.2'    ,'600'       ,0.2    ,600       ,50   UNION ALL	--CAN	--CAD
SELECT 6021 ,'0.5'    ,'90'        ,0.5    ,90        ,82   UNION ALL	--BRL	--BRL
SELECT 6022 ,'0.2'    ,'1500'      ,0.2    ,1500      ,82   UNION ALL	--BRL	--BRL
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,46   UNION ALL	--BND	--BND
SELECT 6022 ,'0.2'    ,'600'       ,0.2    ,600       ,46   UNION ALL	--BND	--BND
SELECT 6021 ,'10'     ,'1800'      ,10     ,1800      ,97   UNION ALL	--BDT	--BDT
SELECT 6022 ,'1'      ,'30000'     ,1      ,30000     ,97   UNION ALL	--BDT	--BDT
SELECT 6021 ,'0.25'   ,'45'        ,0.25   ,45        ,9    UNION ALL	--AUD	--AUD
SELECT 6022 ,'0.2'    ,'600'       ,0.2    ,600       ,9    UNION ALL	--AUD	--AUD
SELECT 6021 ,'2.5'    ,'450'       ,2.5    ,450       ,86   UNION ALL	--ARS	--ARS
SELECT 6022 ,'0.4'    ,'12000'     ,0.4    ,12000     ,86   UNION ALL	--ARS	--ARS
SELECT 6021 ,'0.5'    ,'90'        ,0.5    ,90        ,90   UNION ALL	--AED	--AED
SELECT 6022 ,'0.2'    ,'1500'      ,0.2    ,1500      ,90				--AED	--AED


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