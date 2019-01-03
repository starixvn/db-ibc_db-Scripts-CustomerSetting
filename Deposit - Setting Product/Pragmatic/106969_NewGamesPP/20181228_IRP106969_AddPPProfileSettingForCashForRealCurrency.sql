/*
	Date: 2018-12-28
	Created: Paul
	Task: add global setting for UUS for cash
	DB: DBCUST/CUSTDB
*/

SELECT 	4175	GameTypeID,	15	ExchangeID,	'1.80'	MinLabel,	'180.00'	MaxLabel,	1.80	MinStake,	180.00	MaxStake  --IDR as code, IN as currency
INTO #tmpStake
UNION ALL SELECT 4176 , 15 , '2.25' , '22.50' , 2.25 , 22.50  --IDR as code, IN as currency
UNION ALL SELECT 4177 , 15 , '0.45' , '135.00' , 0.45 , 135.00  --IDR as code, IN as currency
UNION ALL SELECT 4178 , 15 , '4.50' , '225.00' , 4.50 , 225.00  --IDR as code, IN as currency
UNION ALL SELECT 4175 , 22 , '1.80' , '180.00' , 1.80 , 180.00  --IDR as code, IND as currency
UNION ALL SELECT 4176 , 22 , '2.25' , '22.50' , 2.25 , 22.50  --IDR as code, IND as currency
UNION ALL SELECT 4177 , 22 , '0.45' , '135.00' , 0.45 , 135.00  --IDR as code, IND as currency
UNION ALL SELECT 4178 , 22 , '4.50' , '225.00' , 4.50 , 225.00  --IDR as code, IND as currency
UNION ALL SELECT 4175 , 33 , '1.80' , '180.00' , 1.80 , 180.00  --IDR as code, IDD as currency
UNION ALL SELECT 4176 , 33 , '2.25' , '22.50' , 2.25 , 22.50  --IDR as code, IDD as currency
UNION ALL SELECT 4177 , 33 , '0.45' , '135.00' , 0.45 , 135.00  --IDR as code, IDD as currency
UNION ALL SELECT 4178 , 33 , '4.50' , '225.00' , 4.50 , 225.00  --IDR as code, IDD as currency
UNION ALL SELECT 4175 , 34 , '1.80' , '180.00' , 1.80 , 180.00  --IDR as code, IDR as currency
UNION ALL SELECT 4176 , 34 , '2.25' , '22.50' , 2.25 , 22.50  --IDR as code, IDR as currency
UNION ALL SELECT 4177 , 34 , '0.45' , '135.00' , 0.45 , 135.00  --IDR as code, IDR as currency
UNION ALL SELECT 4178 , 34 , '4.50' , '225.00' , 4.50 , 225.00  --IDR as code, IDR as currency
UNION ALL SELECT 4175 , 47 , '1.80' , '180.00' , 1.80 , 180.00  --IDR as code, DDD as currency
UNION ALL SELECT 4176 , 47 , '2.25' , '22.50' , 2.25 , 22.50  --IDR as code, DDD as currency
UNION ALL SELECT 4177 , 47 , '0.45' , '135.00' , 0.45 , 135.00  --IDR as code, DDD as currency
UNION ALL SELECT 4178 , 47 , '4.50' , '225.00' , 4.50 , 225.00  --IDR as code, DDD as currency
UNION ALL SELECT 4175 , 2 , '0.60' , '60.00' , 0.60 , 60.00  --MYR as code, RM as currency
UNION ALL SELECT 4176 , 2 , '0.75' , '7.50' , 0.75 , 7.50  --MYR as code, RM as currency
UNION ALL SELECT 4177 , 2 , '0.15' , '45.00' , 0.15 , 45.00  --MYR as code, RM as currency
UNION ALL SELECT 4178 , 2 , '1.50' , '75.00' , 1.50 , 75.00  --MYR as code, RM as currency
UNION ALL SELECT 4175 , 56 , '0.60' , '60.00' , 0.60 , 60.00  --PLN as code, PLN as currency
UNION ALL SELECT 4176 , 56 , '0.75' , '7.50' , 0.75 , 7.50  --PLN as code, PLN as currency
UNION ALL SELECT 4177 , 56 , '0.15' , '45.00' , 0.15 , 45.00  --PLN as code, PLN as currency
UNION ALL SELECT 4178 , 56 , '1.50' , '75.00' , 1.50 , 75.00  --PLN as code, PLN as currency
UNION ALL SELECT 4175 , 71 , '0.60' , '60.00' , 0.60 , 60.00  --KHR as code, KHR as currency
UNION ALL SELECT 4176 , 71 , '0.75' , '7.50' , 0.75 , 7.50  --KHR as code, KHR as currency
UNION ALL SELECT 4177 , 71 , '0.15' , '45.00' , 0.15 , 45.00  --KHR as code, KHR as currency
UNION ALL SELECT 4178 , 71 , '1.50' , '75.00' , 1.50 , 75.00  --KHR as code, KHR as currency
UNION ALL SELECT 4175 , 4 , '6.00' , '600.00' , 6.00 , 600.00  --THB as code, TB as currency
UNION ALL SELECT 4176 , 4 , '7.50' , '75.00' , 7.50 , 75.00  --THB as code, TB as currency
UNION ALL SELECT 4177 , 4 , '1.50' , '450.00' , 1.50 , 450.00  --THB as code, TB as currency
UNION ALL SELECT 4178 , 4 , '15.00' , '750.00' , 15.00 , 750.00  --THB as code, TB as currency
UNION ALL SELECT 4175 , 43 , '6.00' , '600.00' , 6.00 , 600.00  --THB as code, THB as currency
UNION ALL SELECT 4176 , 43 , '7.50' , '75.00' , 7.50 , 75.00  --THB as code, THB as currency
UNION ALL SELECT 4177 , 43 , '1.50' , '450.00' , 1.50 , 450.00  --THB as code, THB as currency
UNION ALL SELECT 4178 , 43 , '15.00' , '750.00' , 15.00 , 750.00  --THB as code, THB as currency
UNION ALL SELECT 4175 , 1 , '0.20' , '20.00' , 0.20 , 20.00  --SGD as code, SD$ as currency
UNION ALL SELECT 4176 , 1 , '0.25' , '2.50' , 0.25 , 2.50  --SGD as code, SD$ as currency
UNION ALL SELECT 4177 , 1 , '0.05' , '15.00' , 0.05 , 15.00  --SGD as code, SD$ as currency
UNION ALL SELECT 4178 , 1 , '0.50' , '25.00' , 0.50 , 25.00  --SGD as code, SD$ as currency
UNION ALL SELECT 4175 , 3 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, US$ as currency
UNION ALL SELECT 4176 , 3 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, US$ as currency
UNION ALL SELECT 4177 , 3 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, US$ as currency
UNION ALL SELECT 4178 , 3 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, US$ as currency
UNION ALL SELECT 4175 , 6 , '0.20' , '20.00' , 0.20 , 20.00  --EUR as code, EURO as currency
UNION ALL SELECT 4176 , 6 , '0.25' , '2.50' , 0.25 , 2.50  --EUR as code, EURO as currency
UNION ALL SELECT 4177 , 6 , '0.05' , '15.00' , 0.05 , 15.00  --EUR as code, EURO as currency
UNION ALL SELECT 4178 , 6 , '0.50' , '25.00' , 0.50 , 25.00  --EUR as code, EURO as currency
UNION ALL SELECT 4175 , 9 , '0.20' , '20.00' , 0.20 , 20.00  --AUD as code, AUD as currency
UNION ALL SELECT 4176 , 9 , '0.25' , '2.50' , 0.25 , 2.50  --AUD as code, AUD as currency
UNION ALL SELECT 4177 , 9 , '0.05' , '15.00' , 0.05 , 15.00  --AUD as code, AUD as currency
UNION ALL SELECT 4178 , 9 , '0.50' , '25.00' , 0.50 , 25.00  --AUD as code, AUD as currency
UNION ALL SELECT 4175 , 16 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, Yen as currency
UNION ALL SELECT 4176 , 16 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, Yen as currency
UNION ALL SELECT 4177 , 16 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, Yen as currency
UNION ALL SELECT 4178 , 16 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, Yen as currency
UNION ALL SELECT 4175 , 17 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, NTD as currency
UNION ALL SELECT 4176 , 17 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, NTD as currency
UNION ALL SELECT 4177 , 17 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, NTD as currency
UNION ALL SELECT 4178 , 17 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, NTD as currency
UNION ALL SELECT 4175 , 35 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, $US as currency
UNION ALL SELECT 4176 , 35 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, $US as currency
UNION ALL SELECT 4177 , 35 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, $US as currency
UNION ALL SELECT 4178 , 35 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, $US as currency
UNION ALL SELECT 4175 , 36 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, Y$US as currency
UNION ALL SELECT 4176 , 36 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, Y$US as currency
UNION ALL SELECT 4177 , 36 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, Y$US as currency
UNION ALL SELECT 4178 , 36 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, Y$US as currency
UNION ALL SELECT 4175 , 40 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, IRR as currency
UNION ALL SELECT 4176 , 40 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, IRR as currency
UNION ALL SELECT 4177 , 40 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, IRR as currency
UNION ALL SELECT 4178 , 40 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, IRR as currency
UNION ALL SELECT 4175 , 64 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, UT as currency
UNION ALL SELECT 4176 , 64 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, UT as currency
UNION ALL SELECT 4177 , 64 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, UT as currency
UNION ALL SELECT 4178 , 64 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, UT as currency
UNION ALL SELECT 4175 , 65 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, UDI as currency
UNION ALL SELECT 4176 , 65 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, UDI as currency
UNION ALL SELECT 4177 , 65 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, UDI as currency
UNION ALL SELECT 4178 , 65 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, UDI as currency
UNION ALL SELECT 4175 , 68 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, POS as currency
UNION ALL SELECT 4176 , 68 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, POS as currency
UNION ALL SELECT 4177 , 68 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, POS as currency
UNION ALL SELECT 4178 , 68 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, POS as currency
UNION ALL SELECT 4175 , 72 , '0.20' , '20.00' , 0.20 , 20.00  --YNG as code, YNG as currency
UNION ALL SELECT 4176 , 72 , '0.25' , '2.50' , 0.25 , 2.50  --YNG as code, YNG as currency
UNION ALL SELECT 4177 , 72 , '0.05' , '15.00' , 0.05 , 15.00  --YNG as code, YNG as currency
UNION ALL SELECT 4178 , 72 , '0.50' , '25.00' , 0.50 , 25.00  --YNG as code, YNG as currency
UNION ALL SELECT 4175 , 74 , '0.20' , '20.00' , 0.20 , 20.00  --USD as code, TH as currency
UNION ALL SELECT 4176 , 74 , '0.25' , '2.50' , 0.25 , 2.50  --USD as code, TH as currency
UNION ALL SELECT 4177 , 74 , '0.05' , '15.00' , 0.05 , 15.00  --USD as code, TH as currency
UNION ALL SELECT 4178 , 74 , '0.50' , '25.00' , 0.50 , 25.00  --USD as code, TH as currency
UNION ALL SELECT 4175 , 75 , '0.20' , '20.00' , 0.20 , 20.00  --INR as code, PTU as currency
UNION ALL SELECT 4176 , 75 , '0.25' , '2.50' , 0.25 , 2.50  --INR as code, PTU as currency
UNION ALL SELECT 4177 , 75 , '0.05' , '15.00' , 0.05 , 15.00  --INR as code, PTU as currency
UNION ALL SELECT 4178 , 75 , '0.50' , '25.00' , 0.50 , 25.00  --INR as code, PTU as currency
UNION ALL SELECT 4175 , 76 , '0.20' , '20.00' , 0.20 , 20.00  --INR as code, PS as currency
UNION ALL SELECT 4176 , 76 , '0.25' , '2.50' , 0.25 , 2.50  --INR as code, PS as currency
UNION ALL SELECT 4177 , 76 , '0.05' , '15.00' , 0.05 , 15.00  --INR as code, PS as currency
UNION ALL SELECT 4178 , 76 , '0.50' , '25.00' , 0.50 , 25.00  --INR as code, PS as currency
UNION ALL SELECT 4175 , 78 , '0.20' , '20.00' , 0.20 , 20.00  --EUR as code, EUR as currency
UNION ALL SELECT 4176 , 78 , '0.25' , '2.50' , 0.25 , 2.50  --EUR as code, EUR as currency
UNION ALL SELECT 4177 , 78 , '0.05' , '15.00' , 0.05 , 15.00  --EUR as code, EUR as currency
UNION ALL SELECT 4178 , 78 , '0.50' , '25.00' , 0.50 , 25.00  --EUR as code, EUR as currency
UNION ALL SELECT 4175 , 12 , '0.20' , '10.00' , 0.20 , 10.00  --GBP as code, GBP as currency
UNION ALL SELECT 4176 , 12 , '0.25' , '2.50' , 0.25 , 2.50  --GBP as code, GBP as currency
UNION ALL SELECT 4177 , 12 , '0.05' , '7.50' , 0.05 , 7.50  --GBP as code, GBP as currency
UNION ALL SELECT 4178 , 12 , '0.50' , '12.50' , 0.50 , 12.50  --GBP as code, GBP as currency
UNION ALL SELECT 4175 , 13 , '1.20' , '120.00' , 1.20 , 120.00  --CNY as code, RMB as currency
UNION ALL SELECT 4176 , 13 , '1.50' , '15.00' , 1.50 , 15.00  --CNY as code, RMB as currency
UNION ALL SELECT 4177 , 13 , '0.30' , '90.00' , 0.30 , 90.00  --CNY as code, RMB as currency
UNION ALL SELECT 4178 , 13 , '3.00' , '150.00' , 3.00 , 150.00  --CNY as code, RMB as currency
UNION ALL SELECT 4175 , 66 , '1.20' , '120.00' , 1.20 , 120.00  --CNY as code, YUN as currency
UNION ALL SELECT 4176 , 66 , '1.50' , '15.00' , 1.50 , 15.00  --CNY as code, YUN as currency
UNION ALL SELECT 4177 , 66 , '0.30' , '90.00' , 0.30 , 90.00  --CNY as code, YUN as currency
UNION ALL SELECT 4178 , 66 , '3.00' , '150.00' , 3.00 , 150.00  --CNY as code, YUN as currency
UNION ALL SELECT 4175 , 77 , '1.20' , '120.00' , 1.20 , 120.00  --INR as code, PTH as currency
UNION ALL SELECT 4176 , 77 , '1.50' , '15.00' , 1.50 , 15.00  --INR as code, PTH as currency
UNION ALL SELECT 4177 , 77 , '0.30' , '90.00' , 0.30 , 90.00  --INR as code, PTH as currency
UNION ALL SELECT 4178 , 77 , '3.00' , '150.00' , 3.00 , 150.00  --INR as code, PTH as currency
UNION ALL SELECT 4175 , 51 , '3.60' , '360.00' , 3.60 , 360.00  --VND as code, INH as currency
UNION ALL SELECT 4176 , 51 , '4.50' , '45.00' , 4.50 , 45.00  --VND as code, INH as currency
UNION ALL SELECT 4177 , 51 , '0.90' , '270.00' , 0.90 , 270.00  --VND as code, INH as currency
UNION ALL SELECT 4178 , 51 , '9.00' , '450.00' , 9.00 , 450.00  --VND as code, INH as currency
UNION ALL SELECT 4175 , 44 , '200.00' , '20000.00' , 200.00 , 20000.00  --KRW as code, PT as currency
UNION ALL SELECT 4176 , 44 , '250.00' , '2500.00' , 250.00 , 2500.00  --KRW as code, PT as currency
UNION ALL SELECT 4177 , 44 , '50.00' , '15000.00' , 50.00 , 15000.00  --KRW as code, PT as currency
UNION ALL SELECT 4178 , 44 , '500.00' , '25000.00' , 500.00 , 25000.00  --KRW as code, PT as currency
UNION ALL SELECT 4175 , 45 , '200.00' , '20000.00' , 200.00 , 20000.00  --KRW as code, Won as currency
UNION ALL SELECT 4176 , 45 , '250.00' , '2500.00' , 250.00 , 2500.00  --KRW as code, Won as currency
UNION ALL SELECT 4177 , 45 , '50.00' , '15000.00' , 50.00 , 15000.00  --KRW as code, Won as currency
UNION ALL SELECT 4178 , 45 , '500.00' , '25000.00' , 500.00 , 25000.00  --KRW as code, Won as currency
UNION ALL SELECT 4175 , 62 , '200.00' , '20000.00' , 200.00 , 20000.00  --KRW as code, KW as currency
UNION ALL SELECT 4176 , 62 , '250.00' , '2500.00' , 250.00 , 2500.00  --KRW as code, KW as currency
UNION ALL SELECT 4177 , 62 , '50.00' , '15000.00' , 50.00 , 15000.00  --KRW as code, KW as currency
UNION ALL SELECT 4178 , 62 , '500.00' , '25000.00' , 500.00 , 25000.00  --KRW as code, KW as currency
UNION ALL SELECT 4175 , 31 , '20.00' , '2000.00' , 20.00 , 2000.00  --JPY as code, Pts as currency
UNION ALL SELECT 4176 , 31 , '25.00' , '250.00' , 25.00 , 250.00  --JPY as code, Pts as currency
UNION ALL SELECT 4177 , 31 , '5.00' , '1500.00' , 5.00 , 1500.00  --JPY as code, Pts as currency
UNION ALL SELECT 4178 , 31 , '50.00' , '2500.00' , 50.00 , 2500.00  --JPY as code, Pts as currency
UNION ALL SELECT 4175 , 32 , '20.00' , '2000.00' , 20.00 , 2000.00  --JPY as code, JPY as currency
UNION ALL SELECT 4176 , 32 , '25.00' , '250.00' , 25.00 , 250.00  --JPY as code, JPY as currency
UNION ALL SELECT 4177 , 32 , '5.00' , '1500.00' , 5.00 , 1500.00  --JPY as code, JPY as currency
UNION ALL SELECT 4178 , 32 , '50.00' , '2500.00' , 50.00 , 2500.00  --JPY as code, JPY as currency
UNION ALL SELECT 4175 , 37 , '20.00' , '2000.00' , 20.00 , 2000.00  --JPY as code, P as currency
UNION ALL SELECT 4176 , 37 , '25.00' , '250.00' , 25.00 , 250.00  --JPY as code, P as currency
UNION ALL SELECT 4177 , 37 , '5.00' , '1500.00' , 5.00 , 1500.00  --JPY as code, P as currency
UNION ALL SELECT 4178 , 37 , '50.00' , '2500.00' , 50.00 , 2500.00  --JPY as code, P as currency
UNION ALL SELECT 4175 , 55 , '10.00' , '1000.00' , 10.00 , 1000.00  --RUB as code, RUB as currency
UNION ALL SELECT 4176 , 55 , '12.50' , '125.00' , 12.50 , 125.00  --RUB as code, RUB as currency
UNION ALL SELECT 4177 , 55 , '2.50' , '750.00' , 2.50 , 750.00  --RUB as code, RUB as currency
UNION ALL SELECT 4178 , 55 , '25.00' , '1250.00' , 25.00 , 1250.00  --RUB as code, RUB as currency
UNION ALL SELECT 4175 , 61 , '10.00' , '1000.00' , 10.00 , 1000.00  --INR as code, INR as currency
UNION ALL SELECT 4176 , 61 , '12.50' , '125.00' , 12.50 , 125.00  --INR as code, INR as currency
UNION ALL SELECT 4177 , 61 , '2.50' , '750.00' , 2.50 , 750.00  --INR as code, INR as currency
UNION ALL SELECT 4178 , 61 , '25.00' , '1250.00' , 25.00 , 1250.00  --INR as code, INR as currency



;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM Dep_StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID ) t
WHERE s.GameTypeID = 4101
)
MERGE Dep_StakeLevelGroupDetail as g 
USING t ON g.GameTypeID = t.GameTypeID AND g.StakeLevelID = t.StakeLevelID 
WHEN MATCHED THEN UPDATE SET g.MinLabel = t.MinLabel,
							g.MaxLabel = t.MaxLabel,
							g.MinStake = t.MinStake,
							g.MaxStake = t.MaxStake
WHEN NOT MATCHED THEN INSERT ([StakeLevelID]
							   ,[GameTypeID]
							   ,[MinLabel]
							   ,[MaxLabel]
							   ,[MinStake]
							   ,[MaxStake]
							   )
				VALUES(t.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake);	   							



