/*
	Date: 2018-12-28
	Created: Paul
	Task: add global setting for UUS for credit
	DB: DBCUST/CUSTDB
*/

SELECT 6 GroupID, 4175 GameTypeID, 1 ExchangeID, '0.20' MinLabel, '100.00' MaxLabel, 0.20 MinStake, 100.00 MaxStake --SGD as code, SD$ as currency
INTO #tmpStake
UNION ALL SELECT 6 , 4176 , 1 , '0.25' , '7.50' , 0.25 , 7.50  --SGD as code, SD$ as currency
UNION ALL SELECT 6 , 4177 , 1 , '0.05' , '100.00' , 0.05 , 100.00  --SGD as code, SD$ as currency
UNION ALL SELECT 6 , 4178 , 1 , '0.50' , '50.00' , 0.50 , 50.00  --SGD as code, SD$ as currency
UNION ALL SELECT 6 , 4175 , 3 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, US$ as currency
UNION ALL SELECT 6 , 4176 , 3 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, US$ as currency
UNION ALL SELECT 6 , 4177 , 3 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, US$ as currency
UNION ALL SELECT 6 , 4178 , 3 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, US$ as currency
UNION ALL SELECT 6 , 4175 , 6 , '0.20' , '100.00' , 0.20 , 100.00  --EUR as code, EURO as currency
UNION ALL SELECT 6 , 4176 , 6 , '0.25' , '7.50' , 0.25 , 7.50  --EUR as code, EURO as currency
UNION ALL SELECT 6 , 4177 , 6 , '0.05' , '100.00' , 0.05 , 100.00  --EUR as code, EURO as currency
UNION ALL SELECT 6 , 4178 , 6 , '0.50' , '50.00' , 0.50 , 50.00  --EUR as code, EURO as currency
UNION ALL SELECT 6 , 4175 , 9 , '0.20' , '100.00' , 0.20 , 100.00  --AUD as code, AUD as currency
UNION ALL SELECT 6 , 4176 , 9 , '0.25' , '7.50' , 0.25 , 7.50  --AUD as code, AUD as currency
UNION ALL SELECT 6 , 4177 , 9 , '0.05' , '100.00' , 0.05 , 100.00  --AUD as code, AUD as currency
UNION ALL SELECT 6 , 4178 , 9 , '0.50' , '50.00' , 0.50 , 50.00  --AUD as code, AUD as currency
UNION ALL SELECT 6 , 4175 , 16 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, Yen as currency
UNION ALL SELECT 6 , 4176 , 16 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, Yen as currency
UNION ALL SELECT 6 , 4177 , 16 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, Yen as currency
UNION ALL SELECT 6 , 4178 , 16 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, Yen as currency
UNION ALL SELECT 6 , 4175 , 17 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, NTD as currency
UNION ALL SELECT 6 , 4176 , 17 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, NTD as currency
UNION ALL SELECT 6 , 4177 , 17 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, NTD as currency
UNION ALL SELECT 6 , 4178 , 17 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, NTD as currency
UNION ALL SELECT 6 , 4175 , 21 , '0.20' , '100.00' , 0.20 , 100.00  --CAD as code, CAD as currency
UNION ALL SELECT 6 , 4176 , 21 , '0.25' , '7.50' , 0.25 , 7.50  --CAD as code, CAD as currency
UNION ALL SELECT 6 , 4177 , 21 , '0.05' , '100.00' , 0.05 , 100.00  --CAD as code, CAD as currency
UNION ALL SELECT 6 , 4178 , 21 , '0.50' , '50.00' , 0.50 , 50.00  --CAD as code, CAD as currency
UNION ALL SELECT 6 , 4175 , 35 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, $US as currency
UNION ALL SELECT 6 , 4176 , 35 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, $US as currency
UNION ALL SELECT 6 , 4177 , 35 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, $US as currency
UNION ALL SELECT 6 , 4178 , 35 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, $US as currency
UNION ALL SELECT 6 , 4175 , 36 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, Y$US as currency
UNION ALL SELECT 6 , 4176 , 36 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, Y$US as currency
UNION ALL SELECT 6 , 4177 , 36 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, Y$US as currency
UNION ALL SELECT 6 , 4178 , 36 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, Y$US as currency
UNION ALL SELECT 6 , 4175 , 40 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, IRR as currency
UNION ALL SELECT 6 , 4176 , 40 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, IRR as currency
UNION ALL SELECT 6 , 4177 , 40 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, IRR as currency
UNION ALL SELECT 6 , 4178 , 40 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, IRR as currency
UNION ALL SELECT 6 , 4175 , 41 , '0.20' , '100.00' , 0.20 , 100.00  --CHF as code, CHF as currency
UNION ALL SELECT 6 , 4176 , 41 , '0.25' , '7.50' , 0.25 , 7.50  --CHF as code, CHF as currency
UNION ALL SELECT 6 , 4177 , 41 , '0.05' , '100.00' , 0.05 , 100.00  --CHF as code, CHF as currency
UNION ALL SELECT 6 , 4178 , 41 , '0.50' , '50.00' , 0.50 , 50.00  --CHF as code, CHF as currency
UNION ALL SELECT 6 , 4175 , 46 , '0.20' , '100.00' , 0.20 , 100.00  --BND as code, BND as currency
UNION ALL SELECT 6 , 4176 , 46 , '0.25' , '7.50' , 0.25 , 7.50  --BND as code, BND as currency
UNION ALL SELECT 6 , 4177 , 46 , '0.05' , '100.00' , 0.05 , 100.00  --BND as code, BND as currency
UNION ALL SELECT 6 , 4178 , 46 , '0.50' , '50.00' , 0.50 , 50.00  --BND as code, BND as currency
UNION ALL SELECT 6 , 4175 , 50 , '0.20' , '100.00' , 0.20 , 100.00  --CAD as code, CAN as currency
UNION ALL SELECT 6 , 4176 , 50 , '0.25' , '7.50' , 0.25 , 7.50  --CAD as code, CAN as currency
UNION ALL SELECT 6 , 4177 , 50 , '0.05' , '100.00' , 0.05 , 100.00  --CAD as code, CAN as currency
UNION ALL SELECT 6 , 4178 , 50 , '0.50' , '50.00' , 0.50 , 50.00  --CAD as code, CAN as currency
UNION ALL SELECT 6 , 4175 , 63 , '0.20' , '100.00' , 0.20 , 100.00  --NZD as code, NZD as currency
UNION ALL SELECT 6 , 4176 , 63 , '0.25' , '7.50' , 0.25 , 7.50  --NZD as code, NZD as currency
UNION ALL SELECT 6 , 4177 , 63 , '0.05' , '100.00' , 0.05 , 100.00  --NZD as code, NZD as currency
UNION ALL SELECT 6 , 4178 , 63 , '0.50' , '50.00' , 0.50 , 50.00  --NZD as code, NZD as currency
UNION ALL SELECT 6 , 4175 , 64 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, UT as currency
UNION ALL SELECT 6 , 4176 , 64 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, UT as currency
UNION ALL SELECT 6 , 4177 , 64 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, UT as currency
UNION ALL SELECT 6 , 4178 , 64 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, UT as currency
UNION ALL SELECT 6 , 4175 , 65 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, UDI as currency
UNION ALL SELECT 6 , 4176 , 65 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, UDI as currency
UNION ALL SELECT 6 , 4177 , 65 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, UDI as currency
UNION ALL SELECT 6 , 4178 , 65 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, UDI as currency
UNION ALL SELECT 6 , 4175 , 68 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, POS as currency
UNION ALL SELECT 6 , 4176 , 68 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, POS as currency
UNION ALL SELECT 6 , 4177 , 68 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, POS as currency
UNION ALL SELECT 6 , 4178 , 68 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, POS as currency
UNION ALL SELECT 6 , 4175 , 69 , '0.20' , '100.00' , 0.20 , 100.00  --MMK as code, MMK as currency
UNION ALL SELECT 6 , 4176 , 69 , '0.25' , '7.50' , 0.25 , 7.50  --MMK as code, MMK as currency
UNION ALL SELECT 6 , 4177 , 69 , '0.05' , '100.00' , 0.05 , 100.00  --MMK as code, MMK as currency
UNION ALL SELECT 6 , 4178 , 69 , '0.50' , '50.00' , 0.50 , 50.00  --MMK as code, MMK as currency
UNION ALL SELECT 6 , 4175 , 70 , '0.20' , '100.00' , 0.20 , 100.00  --MMK as code, MKK as currency
UNION ALL SELECT 6 , 4176 , 70 , '0.25' , '7.50' , 0.25 , 7.50  --MMK as code, MKK as currency
UNION ALL SELECT 6 , 4177 , 70 , '0.05' , '100.00' , 0.05 , 100.00  --MMK as code, MKK as currency
UNION ALL SELECT 6 , 4178 , 70 , '0.50' , '50.00' , 0.50 , 50.00  --MMK as code, MKK as currency
UNION ALL SELECT 6 , 4175 , 74 , '0.20' , '100.00' , 0.20 , 100.00  --USD as code, TH as currency
UNION ALL SELECT 6 , 4176 , 74 , '0.25' , '7.50' , 0.25 , 7.50  --USD as code, TH as currency
UNION ALL SELECT 6 , 4177 , 74 , '0.05' , '100.00' , 0.05 , 100.00  --USD as code, TH as currency
UNION ALL SELECT 6 , 4178 , 74 , '0.50' , '50.00' , 0.50 , 50.00  --USD as code, TH as currency
UNION ALL SELECT 6 , 4175 , 75 , '0.20' , '100.00' , 0.20 , 100.00  --INR as code, PTU as currency
UNION ALL SELECT 6 , 4176 , 75 , '0.25' , '7.50' , 0.25 , 7.50  --INR as code, PTU as currency
UNION ALL SELECT 6 , 4177 , 75 , '0.05' , '100.00' , 0.05 , 100.00  --INR as code, PTU as currency
UNION ALL SELECT 6 , 4178 , 75 , '0.50' , '50.00' , 0.50 , 50.00  --INR as code, PTU as currency
UNION ALL SELECT 6 , 4175 , 76 , '0.20' , '100.00' , 0.20 , 100.00  --INR as code, PS as currency
UNION ALL SELECT 6 , 4176 , 76 , '0.25' , '7.50' , 0.25 , 7.50  --INR as code, PS as currency
UNION ALL SELECT 6 , 4177 , 76 , '0.05' , '100.00' , 0.05 , 100.00  --INR as code, PS as currency
UNION ALL SELECT 6 , 4178 , 76 , '0.50' , '50.00' , 0.50 , 50.00  --INR as code, PS as currency
UNION ALL SELECT 6 , 4175 , 78 , '0.20' , '100.00' , 0.20 , 100.00  --EUR as code, EUR as currency
UNION ALL SELECT 6 , 4176 , 78 , '0.25' , '7.50' , 0.25 , 7.50  --EUR as code, EUR as currency
UNION ALL SELECT 6 , 4177 , 78 , '0.05' , '100.00' , 0.05 , 100.00  --EUR as code, EUR as currency
UNION ALL SELECT 6 , 4178 , 78 , '0.50' , '50.00' , 0.50 , 50.00  --EUR as code, EUR as currency
UNION ALL SELECT 6 , 4175 , 12 , '0.20' , '50.00' , 0.20 , 50.00  --GBP as code, GBP as currency
UNION ALL SELECT 6 , 4176 , 12 , '0.25' , '3.75' , 0.25 , 3.75  --GBP as code, GBP as currency
UNION ALL SELECT 6 , 4177 , 12 , '0.05' , '50.00' , 0.05 , 50.00  --GBP as code, GBP as currency
UNION ALL SELECT 6 , 4178 , 12 , '0.50' , '25.00' , 0.50 , 25.00  --GBP as code, GBP as currency
UNION ALL SELECT 6 , 4175 , 5 , '1.20' , '600.00' , 1.20 , 600.00  --HKD as code, HK$ as currency
UNION ALL SELECT 6 , 4176 , 5 , '1.50' , '45.00' , 1.50 , 45.00  --HKD as code, HK$ as currency
UNION ALL SELECT 6 , 4177 , 5 , '0.30' , '600.00' , 0.30 , 600.00  --HKD as code, HK$ as currency
UNION ALL SELECT 6 , 4178 , 5 , '3.00' , '300.00' , 3.00 , 300.00  --HKD as code, HK$ as currency
UNION ALL SELECT 6 , 4175 , 13 , '1.20' , '600.00' , 1.20 , 600.00  --CNY as code, RMB as currency
UNION ALL SELECT 6 , 4176 , 13 , '1.50' , '45.00' , 1.50 , 45.00  --CNY as code, RMB as currency
UNION ALL SELECT 6 , 4177 , 13 , '0.30' , '600.00' , 0.30 , 600.00  --CNY as code, RMB as currency
UNION ALL SELECT 6 , 4178 , 13 , '3.00' , '300.00' , 3.00 , 300.00  --CNY as code, RMB as currency
UNION ALL SELECT 6 , 4175 , 52 , '1.20' , '600.00' , 1.20 , 600.00  --DKK as code, DKK as currency
UNION ALL SELECT 6 , 4176 , 52 , '1.50' , '45.00' , 1.50 , 45.00  --DKK as code, DKK as currency
UNION ALL SELECT 6 , 4177 , 52 , '0.30' , '600.00' , 0.30 , 600.00  --DKK as code, DKK as currency
UNION ALL SELECT 6 , 4178 , 52 , '3.00' , '300.00' , 3.00 , 300.00  --DKK as code, DKK as currency
UNION ALL SELECT 6 , 4175 , 53 , '1.20' , '600.00' , 1.20 , 600.00  --SEK as code, SEK as currency
UNION ALL SELECT 6 , 4176 , 53 , '1.50' , '45.00' , 1.50 , 45.00  --SEK as code, SEK as currency
UNION ALL SELECT 6 , 4177 , 53 , '0.30' , '600.00' , 0.30 , 600.00  --SEK as code, SEK as currency
UNION ALL SELECT 6 , 4178 , 53 , '3.00' , '300.00' , 3.00 , 300.00  --SEK as code, SEK as currency
UNION ALL SELECT 6 , 4175 , 54 , '1.20' , '600.00' , 1.20 , 600.00  --NOK as code, NOK as currency
UNION ALL SELECT 6 , 4176 , 54 , '1.50' , '45.00' , 1.50 , 45.00  --NOK as code, NOK as currency
UNION ALL SELECT 6 , 4177 , 54 , '0.30' , '600.00' , 0.30 , 600.00  --NOK as code, NOK as currency
UNION ALL SELECT 6 , 4178 , 54 , '3.00' , '300.00' , 3.00 , 300.00  --NOK as code, NOK as currency
UNION ALL SELECT 6 , 4175 , 66 , '1.20' , '600.00' , 1.20 , 600.00  --CNY as code, YUN as currency
UNION ALL SELECT 6 , 4176 , 66 , '1.50' , '45.00' , 1.50 , 45.00  --CNY as code, YUN as currency
UNION ALL SELECT 6 , 4177 , 66 , '0.30' , '600.00' , 0.30 , 600.00  --CNY as code, YUN as currency
UNION ALL SELECT 6 , 4178 , 66 , '3.00' , '300.00' , 3.00 , 300.00  --CNY as code, YUN as currency
UNION ALL SELECT 6 , 4175 , 67 , '1.20' , '600.00' , 1.20 , 600.00  --HKD as code, HKK as currency
UNION ALL SELECT 6 , 4176 , 67 , '1.50' , '45.00' , 1.50 , 45.00  --HKD as code, HKK as currency
UNION ALL SELECT 6 , 4177 , 67 , '0.30' , '600.00' , 0.30 , 600.00  --HKD as code, HKK as currency
UNION ALL SELECT 6 , 4178 , 67 , '3.00' , '300.00' , 3.00 , 300.00  --HKD as code, HKK as currency
UNION ALL SELECT 6 , 4175 , 77 , '1.20' , '600.00' , 1.20 , 600.00  --INR as code, PTH as currency
UNION ALL SELECT 6 , 4176 , 77 , '1.50' , '45.00' , 1.50 , 45.00  --INR as code, PTH as currency
UNION ALL SELECT 6 , 4177 , 77 , '0.30' , '600.00' , 0.30 , 600.00  --INR as code, PTH as currency
UNION ALL SELECT 6 , 4178 , 77 , '3.00' , '300.00' , 3.00 , 300.00  --INR as code, PTH as currency
UNION ALL SELECT 6 , 4175 , 2 , '0.60' , '300.00' , 0.60 , 300.00  --MYR as code, RM as currency
UNION ALL SELECT 6 , 4176 , 2 , '0.75' , '22.50' , 0.75 , 22.50  --MYR as code, RM as currency
UNION ALL SELECT 6 , 4177 , 2 , '0.15' , '300.00' , 0.15 , 300.00  --MYR as code, RM as currency
UNION ALL SELECT 6 , 4178 , 2 , '1.50' , '150.00' , 1.50 , 150.00  --MYR as code, RM as currency
UNION ALL SELECT 6 , 4175 , 56 , '0.60' , '300.00' , 0.60 , 300.00  --PLN as code, PLN as currency
UNION ALL SELECT 6 , 4176 , 56 , '0.75' , '22.50' , 0.75 , 22.50  --PLN as code, PLN as currency
UNION ALL SELECT 6 , 4177 , 56 , '0.15' , '300.00' , 0.15 , 300.00  --PLN as code, PLN as currency
UNION ALL SELECT 6 , 4178 , 56 , '1.50' , '150.00' , 1.50 , 150.00  --PLN as code, PLN as currency
UNION ALL SELECT 6 , 4175 , 58 , '0.60' , '300.00' , 0.60 , 300.00  --RON as code, RON as currency
UNION ALL SELECT 6 , 4176 , 58 , '0.75' , '22.50' , 0.75 , 22.50  --RON as code, RON as currency
UNION ALL SELECT 6 , 4177 , 58 , '0.15' , '300.00' , 0.15 , 300.00  --RON as code, RON as currency
UNION ALL SELECT 6 , 4178 , 58 , '1.50' , '150.00' , 1.50 , 150.00  --RON as code, RON as currency
UNION ALL SELECT 6 , 4175 , 71 , '0.60' , '300.00' , 0.60 , 300.00  --KHR as code, KHR as currency
UNION ALL SELECT 6 , 4176 , 71 , '0.75' , '22.50' , 0.75 , 22.50  --KHR as code, KHR as currency
UNION ALL SELECT 6 , 4177 , 71 , '0.15' , '300.00' , 0.15 , 300.00  --KHR as code, KHR as currency
UNION ALL SELECT 6 , 4178 , 71 , '1.50' , '150.00' , 1.50 , 150.00  --KHR as code, KHR as currency
UNION ALL SELECT 6 , 4175 , 73 , '0.60' , '300.00' , 0.60 , 300.00  --TRY as code, LIR as currency
UNION ALL SELECT 6 , 4176 , 73 , '0.75' , '22.50' , 0.75 , 22.50  --TRY as code, LIR as currency
UNION ALL SELECT 6 , 4177 , 73 , '0.15' , '300.00' , 0.15 , 300.00  --TRY as code, LIR as currency
UNION ALL SELECT 6 , 4178 , 73 , '1.50' , '150.00' , 1.50 , 150.00  --TRY as code, LIR as currency
UNION ALL SELECT 6 , 4175 , 4 , '6.00' , '3000.00' , 6.00 , 3000.00  --THB as code, TB as currency
UNION ALL SELECT 6 , 4176 , 4 , '7.50' , '225.00' , 7.50 , 225.00  --THB as code, TB as currency
UNION ALL SELECT 6 , 4177 , 4 , '1.50' , '3000.00' , 1.50 , 3000.00  --THB as code, TB as currency
UNION ALL SELECT 6 , 4178 , 4 , '15.00' , '1500.00' , 15.00 , 1500.00  --THB as code, TB as currency
UNION ALL SELECT 6 , 4175 , 30 , '6.00' , '3000.00' , 6.00 , 3000.00  --TWD as code, NT as currency
UNION ALL SELECT 6 , 4176 , 30 , '7.50' , '225.00' , 7.50 , 225.00  --TWD as code, NT as currency
UNION ALL SELECT 6 , 4177 , 30 , '1.50' , '3000.00' , 1.50 , 3000.00  --TWD as code, NT as currency
UNION ALL SELECT 6 , 4178 , 30 , '15.00' , '1500.00' , 15.00 , 1500.00  --TWD as code, NT as currency
UNION ALL SELECT 6 , 4175 , 42 , '6.00' , '3000.00' , 6.00 , 3000.00  --PHP as code, PE as currency
UNION ALL SELECT 6 , 4176 , 42 , '7.50' , '225.00' , 7.50 , 225.00  --PHP as code, PE as currency
UNION ALL SELECT 6 , 4177 , 42 , '1.50' , '3000.00' , 1.50 , 3000.00  --PHP as code, PE as currency
UNION ALL SELECT 6 , 4178 , 42 , '15.00' , '1500.00' , 15.00 , 1500.00  --PHP as code, PE as currency
UNION ALL SELECT 6 , 4175 , 43 , '6.00' , '3000.00' , 6.00 , 3000.00  --THB as code, THB as currency
UNION ALL SELECT 6 , 4176 , 43 , '7.50' , '225.00' , 7.50 , 225.00  --THB as code, THB as currency
UNION ALL SELECT 6 , 4177 , 43 , '1.50' , '3000.00' , 1.50 , 3000.00  --THB as code, THB as currency
UNION ALL SELECT 6 , 4178 , 43 , '15.00' , '1500.00' , 15.00 , 1500.00  --THB as code, THB as currency
UNION ALL SELECT 6 , 4175 , 49 , '3.60' , '1800.00' , 3.60 , 1800.00  --MXN as code, MXN as currency
UNION ALL SELECT 6 , 4176 , 49 , '4.50' , '135.00' , 4.50 , 135.00  --MXN as code, MXN as currency
UNION ALL SELECT 6 , 4177 , 49 , '0.90' , '1800.00' , 0.90 , 1800.00  --MXN as code, MXN as currency
UNION ALL SELECT 6 , 4178 , 49 , '9.00' , '900.00' , 9.00 , 900.00  --MXN as code, MXN as currency
UNION ALL SELECT 6 , 4175 , 51 , '3.60' , '1800.00' , 3.60 , 1800.00  --VND as code, INH as currency
UNION ALL SELECT 6 , 4176 , 51 , '4.50' , '135.00' , 4.50 , 135.00  --VND as code, INH as currency
UNION ALL SELECT 6 , 4177 , 51 , '0.90' , '1800.00' , 0.90 , 1800.00  --VND as code, INH as currency
UNION ALL SELECT 6 , 4178 , 51 , '9.00' , '900.00' , 9.00 , 900.00  --VND as code, INH as currency
UNION ALL SELECT 6 , 4175 , 57 , '3.60' , '1800.00' , 3.60 , 1800.00  --CZK as code, CZK as currency
UNION ALL SELECT 6 , 4176 , 57 , '4.50' , '135.00' , 4.50 , 135.00  --CZK as code, CZK as currency
UNION ALL SELECT 6 , 4177 , 57 , '0.90' , '1800.00' , 0.90 , 1800.00  --CZK as code, CZK as currency
UNION ALL SELECT 6 , 4178 , 57 , '9.00' , '900.00' , 9.00 , 900.00  --CZK as code, CZK as currency
UNION ALL SELECT 6 , 4175 , 15 , '1.80' , '900.00' , 1.80 , 900.00  --IDR as code, IN as currency
UNION ALL SELECT 6 , 4176 , 15 , '2.25' , '67.50' , 2.25 , 67.50  --IDR as code, IN as currency
UNION ALL SELECT 6 , 4177 , 15 , '0.45' , '900.00' , 0.45 , 900.00  --IDR as code, IN as currency
UNION ALL SELECT 6 , 4178 , 15 , '4.50' , '450.00' , 4.50 , 450.00  --IDR as code, IN as currency
UNION ALL SELECT 6 , 4175 , 22 , '1.80' , '900.00' , 1.80 , 900.00  --IDR as code, IND as currency
UNION ALL SELECT 6 , 4176 , 22 , '2.25' , '67.50' , 2.25 , 67.50  --IDR as code, IND as currency
UNION ALL SELECT 6 , 4177 , 22 , '0.45' , '900.00' , 0.45 , 900.00  --IDR as code, IND as currency
UNION ALL SELECT 6 , 4178 , 22 , '4.50' , '450.00' , 4.50 , 450.00  --IDR as code, IND as currency
UNION ALL SELECT 6 , 4175 , 33 , '1.80' , '900.00' , 1.80 , 900.00  --IDR as code, IDD as currency
UNION ALL SELECT 6 , 4176 , 33 , '2.25' , '67.50' , 2.25 , 67.50  --IDR as code, IDD as currency
UNION ALL SELECT 6 , 4177 , 33 , '0.45' , '900.00' , 0.45 , 900.00  --IDR as code, IDD as currency
UNION ALL SELECT 6 , 4178 , 33 , '4.50' , '450.00' , 4.50 , 450.00  --IDR as code, IDD as currency
UNION ALL SELECT 6 , 4175 , 34 , '1.80' , '900.00' , 1.80 , 900.00  --IDR as code, IDR as currency
UNION ALL SELECT 6 , 4176 , 34 , '2.25' , '67.50' , 2.25 , 67.50  --IDR as code, IDR as currency
UNION ALL SELECT 6 , 4177 , 34 , '0.45' , '900.00' , 0.45 , 900.00  --IDR as code, IDR as currency
UNION ALL SELECT 6 , 4178 , 34 , '4.50' , '450.00' , 4.50 , 450.00  --IDR as code, IDR as currency
UNION ALL SELECT 6 , 4175 , 47 , '1.80' , '900.00' , 1.80 , 900.00  --IDR as code, DDD as currency
UNION ALL SELECT 6 , 4176 , 47 , '2.25' , '67.50' , 2.25 , 67.50  --IDR as code, DDD as currency
UNION ALL SELECT 6 , 4177 , 47 , '0.45' , '900.00' , 0.45 , 900.00  --IDR as code, DDD as currency
UNION ALL SELECT 6 , 4178 , 47 , '4.50' , '450.00' , 4.50 , 450.00  --IDR as code, DDD as currency
UNION ALL SELECT 6 , 4175 , 44 , '200.00' , '100000.00' , 200.00 , 100000.00  --KRW as code, PT as currency
UNION ALL SELECT 6 , 4176 , 44 , '250.00' , '7500.00' , 250.00 , 7500.00  --KRW as code, PT as currency
UNION ALL SELECT 6 , 4177 , 44 , '50.00' , '100000.00' , 50.00 , 100000.00  --KRW as code, PT as currency
UNION ALL SELECT 6 , 4178 , 44 , '500.00' , '50000.00' , 500.00 , 50000.00  --KRW as code, PT as currency
UNION ALL SELECT 6 , 4175 , 45 , '200.00' , '100000.00' , 200.00 , 100000.00  --KRW as code, Won as currency
UNION ALL SELECT 6 , 4176 , 45 , '250.00' , '7500.00' , 250.00 , 7500.00  --KRW as code, Won as currency
UNION ALL SELECT 6 , 4177 , 45 , '50.00' , '100000.00' , 50.00 , 100000.00  --KRW as code, Won as currency
UNION ALL SELECT 6 , 4178 , 45 , '500.00' , '50000.00' , 500.00 , 50000.00  --KRW as code, Won as currency
UNION ALL SELECT 6 , 4175 , 62 , '200.00' , '100000.00' , 200.00 , 100000.00  --KRW as code, KW as currency
UNION ALL SELECT 6 , 4176 , 62 , '250.00' , '7500.00' , 250.00 , 7500.00  --KRW as code, KW as currency
UNION ALL SELECT 6 , 4177 , 62 , '50.00' , '100000.00' , 50.00 , 100000.00  --KRW as code, KW as currency
UNION ALL SELECT 6 , 4178 , 62 , '500.00' , '50000.00' , 500.00 , 50000.00  --KRW as code, KW as currency
UNION ALL SELECT 6 , 4175 , 55 , '10.00' , '5000.00' , 10.00 , 5000.00  --RUB as code, RUB as currency
UNION ALL SELECT 6 , 4176 , 55 , '12.50' , '375.00' , 12.50 , 375.00  --RUB as code, RUB as currency
UNION ALL SELECT 6 , 4177 , 55 , '2.50' , '5000.00' , 2.50 , 5000.00  --RUB as code, RUB as currency
UNION ALL SELECT 6 , 4178 , 55 , '25.00' , '2500.00' , 25.00 , 2500.00  --RUB as code, RUB as currency
UNION ALL SELECT 6 , 4175 , 61 , '10.00' , '5000.00' , 10.00 , 5000.00  --INR as code, INR as currency
UNION ALL SELECT 6 , 4176 , 61 , '12.50' , '375.00' , 12.50 , 375.00  --INR as code, INR as currency
UNION ALL SELECT 6 , 4177 , 61 , '2.50' , '5000.00' , 2.50 , 5000.00  --INR as code, INR as currency
UNION ALL SELECT 6 , 4178 , 61 , '25.00' , '2500.00' , 25.00 , 2500.00  --INR as code, INR as currency
UNION ALL SELECT 6 , 4175 , 31 , '20.00' , '10000.00' , 20.00 , 10000.00  --JPY as code, Pts as currency
UNION ALL SELECT 6 , 4176 , 31 , '25.00' , '750.00' , 25.00 , 750.00  --JPY as code, Pts as currency
UNION ALL SELECT 6 , 4177 , 31 , '5.00' , '10000.00' , 5.00 , 10000.00  --JPY as code, Pts as currency
UNION ALL SELECT 6 , 4178 , 31 , '50.00' , '5000.00' , 50.00 , 5000.00  --JPY as code, Pts as currency
UNION ALL SELECT 6 , 4175 , 32 , '20.00' , '10000.00' , 20.00 , 10000.00  --JPY as code, JPY as currency
UNION ALL SELECT 6 , 4176 , 32 , '25.00' , '750.00' , 25.00 , 750.00  --JPY as code, JPY as currency
UNION ALL SELECT 6 , 4177 , 32 , '5.00' , '10000.00' , 5.00 , 10000.00  --JPY as code, JPY as currency
UNION ALL SELECT 6 , 4178 , 32 , '50.00' , '5000.00' , 50.00 , 5000.00  --JPY as code, JPY as currency
UNION ALL SELECT 6 , 4175 , 37 , '20.00' , '10000.00' , 20.00 , 10000.00  --JPY as code, P as currency
UNION ALL SELECT 6 , 4176 , 37 , '25.00' , '750.00' , 25.00 , 750.00  --JPY as code, P as currency
UNION ALL SELECT 6 , 4177 , 37 , '5.00' , '10000.00' , 5.00 , 10000.00  --JPY as code, P as currency
UNION ALL SELECT 6 , 4178 , 37 , '50.00' , '5000.00' , 50.00 , 5000.00  --JPY as code, P as currency

UNION ALL SELECT 7 , 4175 , 1 , '0.20' , '200.00' , 0.20 , 200.00  --SGD as code, SD$ as currency
UNION ALL SELECT 7 , 4176 , 1 , '0.25' , '15.00' , 0.25 , 15.00  --SGD as code, SD$ as currency
UNION ALL SELECT 7 , 4177 , 1 , '0.05' , '200.00' , 0.05 , 200.00  --SGD as code, SD$ as currency
UNION ALL SELECT 7 , 4178 , 1 , '0.50' , '100.00' , 0.50 , 100.00  --SGD as code, SD$ as currency
UNION ALL SELECT 7 , 4175 , 3 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, US$ as currency
UNION ALL SELECT 7 , 4176 , 3 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, US$ as currency
UNION ALL SELECT 7 , 4177 , 3 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, US$ as currency
UNION ALL SELECT 7 , 4178 , 3 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, US$ as currency
UNION ALL SELECT 7 , 4175 , 6 , '0.20' , '200.00' , 0.20 , 200.00  --EUR as code, EURO as currency
UNION ALL SELECT 7 , 4176 , 6 , '0.25' , '15.00' , 0.25 , 15.00  --EUR as code, EURO as currency
UNION ALL SELECT 7 , 4177 , 6 , '0.05' , '200.00' , 0.05 , 200.00  --EUR as code, EURO as currency
UNION ALL SELECT 7 , 4178 , 6 , '0.50' , '100.00' , 0.50 , 100.00  --EUR as code, EURO as currency
UNION ALL SELECT 7 , 4175 , 9 , '0.20' , '200.00' , 0.20 , 200.00  --AUD as code, AUD as currency
UNION ALL SELECT 7 , 4176 , 9 , '0.25' , '15.00' , 0.25 , 15.00  --AUD as code, AUD as currency
UNION ALL SELECT 7 , 4177 , 9 , '0.05' , '200.00' , 0.05 , 200.00  --AUD as code, AUD as currency
UNION ALL SELECT 7 , 4178 , 9 , '0.50' , '100.00' , 0.50 , 100.00  --AUD as code, AUD as currency
UNION ALL SELECT 7 , 4175 , 16 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, Yen as currency
UNION ALL SELECT 7 , 4176 , 16 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, Yen as currency
UNION ALL SELECT 7 , 4177 , 16 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, Yen as currency
UNION ALL SELECT 7 , 4178 , 16 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, Yen as currency
UNION ALL SELECT 7 , 4175 , 17 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, NTD as currency
UNION ALL SELECT 7 , 4176 , 17 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, NTD as currency
UNION ALL SELECT 7 , 4177 , 17 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, NTD as currency
UNION ALL SELECT 7 , 4178 , 17 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, NTD as currency
UNION ALL SELECT 7 , 4175 , 21 , '0.20' , '200.00' , 0.20 , 200.00  --CAD as code, CAD as currency
UNION ALL SELECT 7 , 4176 , 21 , '0.25' , '15.00' , 0.25 , 15.00  --CAD as code, CAD as currency
UNION ALL SELECT 7 , 4177 , 21 , '0.05' , '200.00' , 0.05 , 200.00  --CAD as code, CAD as currency
UNION ALL SELECT 7 , 4178 , 21 , '0.50' , '100.00' , 0.50 , 100.00  --CAD as code, CAD as currency
UNION ALL SELECT 7 , 4175 , 35 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, $US as currency
UNION ALL SELECT 7 , 4176 , 35 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, $US as currency
UNION ALL SELECT 7 , 4177 , 35 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, $US as currency
UNION ALL SELECT 7 , 4178 , 35 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, $US as currency
UNION ALL SELECT 7 , 4175 , 36 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, Y$US as currency
UNION ALL SELECT 7 , 4176 , 36 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, Y$US as currency
UNION ALL SELECT 7 , 4177 , 36 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, Y$US as currency
UNION ALL SELECT 7 , 4178 , 36 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, Y$US as currency
UNION ALL SELECT 7 , 4175 , 40 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, IRR as currency
UNION ALL SELECT 7 , 4176 , 40 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, IRR as currency
UNION ALL SELECT 7 , 4177 , 40 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, IRR as currency
UNION ALL SELECT 7 , 4178 , 40 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, IRR as currency
UNION ALL SELECT 7 , 4175 , 41 , '0.20' , '200.00' , 0.20 , 200.00  --CHF as code, CHF as currency
UNION ALL SELECT 7 , 4176 , 41 , '0.25' , '15.00' , 0.25 , 15.00  --CHF as code, CHF as currency
UNION ALL SELECT 7 , 4177 , 41 , '0.05' , '200.00' , 0.05 , 200.00  --CHF as code, CHF as currency
UNION ALL SELECT 7 , 4178 , 41 , '0.50' , '100.00' , 0.50 , 100.00  --CHF as code, CHF as currency
UNION ALL SELECT 7 , 4175 , 46 , '0.20' , '200.00' , 0.20 , 200.00  --BND as code, BND as currency
UNION ALL SELECT 7 , 4176 , 46 , '0.25' , '15.00' , 0.25 , 15.00  --BND as code, BND as currency
UNION ALL SELECT 7 , 4177 , 46 , '0.05' , '200.00' , 0.05 , 200.00  --BND as code, BND as currency
UNION ALL SELECT 7 , 4178 , 46 , '0.50' , '100.00' , 0.50 , 100.00  --BND as code, BND as currency
UNION ALL SELECT 7 , 4175 , 50 , '0.20' , '200.00' , 0.20 , 200.00  --CAD as code, CAN as currency
UNION ALL SELECT 7 , 4176 , 50 , '0.25' , '15.00' , 0.25 , 15.00  --CAD as code, CAN as currency
UNION ALL SELECT 7 , 4177 , 50 , '0.05' , '200.00' , 0.05 , 200.00  --CAD as code, CAN as currency
UNION ALL SELECT 7 , 4178 , 50 , '0.50' , '100.00' , 0.50 , 100.00  --CAD as code, CAN as currency
UNION ALL SELECT 7 , 4175 , 63 , '0.20' , '200.00' , 0.20 , 200.00  --NZD as code, NZD as currency
UNION ALL SELECT 7 , 4176 , 63 , '0.25' , '15.00' , 0.25 , 15.00  --NZD as code, NZD as currency
UNION ALL SELECT 7 , 4177 , 63 , '0.05' , '200.00' , 0.05 , 200.00  --NZD as code, NZD as currency
UNION ALL SELECT 7 , 4178 , 63 , '0.50' , '100.00' , 0.50 , 100.00  --NZD as code, NZD as currency
UNION ALL SELECT 7 , 4175 , 64 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, UT as currency
UNION ALL SELECT 7 , 4176 , 64 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, UT as currency
UNION ALL SELECT 7 , 4177 , 64 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, UT as currency
UNION ALL SELECT 7 , 4178 , 64 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, UT as currency
UNION ALL SELECT 7 , 4175 , 65 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, UDI as currency
UNION ALL SELECT 7 , 4176 , 65 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, UDI as currency
UNION ALL SELECT 7 , 4177 , 65 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, UDI as currency
UNION ALL SELECT 7 , 4178 , 65 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, UDI as currency
UNION ALL SELECT 7 , 4175 , 68 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, POS as currency
UNION ALL SELECT 7 , 4176 , 68 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, POS as currency
UNION ALL SELECT 7 , 4177 , 68 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, POS as currency
UNION ALL SELECT 7 , 4178 , 68 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, POS as currency
UNION ALL SELECT 7 , 4175 , 69 , '0.20' , '200.00' , 0.20 , 200.00  --MMK as code, MMK as currency
UNION ALL SELECT 7 , 4176 , 69 , '0.25' , '15.00' , 0.25 , 15.00  --MMK as code, MMK as currency
UNION ALL SELECT 7 , 4177 , 69 , '0.05' , '200.00' , 0.05 , 200.00  --MMK as code, MMK as currency
UNION ALL SELECT 7 , 4178 , 69 , '0.50' , '100.00' , 0.50 , 100.00  --MMK as code, MMK as currency
UNION ALL SELECT 7 , 4175 , 70 , '0.20' , '200.00' , 0.20 , 200.00  --MMK as code, MKK as currency
UNION ALL SELECT 7 , 4176 , 70 , '0.25' , '15.00' , 0.25 , 15.00  --MMK as code, MKK as currency
UNION ALL SELECT 7 , 4177 , 70 , '0.05' , '200.00' , 0.05 , 200.00  --MMK as code, MKK as currency
UNION ALL SELECT 7 , 4178 , 70 , '0.50' , '100.00' , 0.50 , 100.00  --MMK as code, MKK as currency
UNION ALL SELECT 7 , 4175 , 74 , '0.20' , '200.00' , 0.20 , 200.00  --USD as code, TH as currency
UNION ALL SELECT 7 , 4176 , 74 , '0.25' , '15.00' , 0.25 , 15.00  --USD as code, TH as currency
UNION ALL SELECT 7 , 4177 , 74 , '0.05' , '200.00' , 0.05 , 200.00  --USD as code, TH as currency
UNION ALL SELECT 7 , 4178 , 74 , '0.50' , '100.00' , 0.50 , 100.00  --USD as code, TH as currency
UNION ALL SELECT 7 , 4175 , 75 , '0.20' , '200.00' , 0.20 , 200.00  --INR as code, PTU as currency
UNION ALL SELECT 7 , 4176 , 75 , '0.25' , '15.00' , 0.25 , 15.00  --INR as code, PTU as currency
UNION ALL SELECT 7 , 4177 , 75 , '0.05' , '200.00' , 0.05 , 200.00  --INR as code, PTU as currency
UNION ALL SELECT 7 , 4178 , 75 , '0.50' , '100.00' , 0.50 , 100.00  --INR as code, PTU as currency
UNION ALL SELECT 7 , 4175 , 76 , '0.20' , '200.00' , 0.20 , 200.00  --INR as code, PS as currency
UNION ALL SELECT 7 , 4176 , 76 , '0.25' , '15.00' , 0.25 , 15.00  --INR as code, PS as currency
UNION ALL SELECT 7 , 4177 , 76 , '0.05' , '200.00' , 0.05 , 200.00  --INR as code, PS as currency
UNION ALL SELECT 7 , 4178 , 76 , '0.50' , '100.00' , 0.50 , 100.00  --INR as code, PS as currency
UNION ALL SELECT 7 , 4175 , 78 , '0.20' , '200.00' , 0.20 , 200.00  --EUR as code, EUR as currency
UNION ALL SELECT 7 , 4176 , 78 , '0.25' , '15.00' , 0.25 , 15.00  --EUR as code, EUR as currency
UNION ALL SELECT 7 , 4177 , 78 , '0.05' , '200.00' , 0.05 , 200.00  --EUR as code, EUR as currency
UNION ALL SELECT 7 , 4178 , 78 , '0.50' , '100.00' , 0.50 , 100.00  --EUR as code, EUR as currency
UNION ALL SELECT 7 , 4175 , 12 , '0.20' , '100.00' , 0.20 , 100.00  --GBP as code, GBP as currency
UNION ALL SELECT 7 , 4176 , 12 , '0.25' , '7.50' , 0.25 , 7.50  --GBP as code, GBP as currency
UNION ALL SELECT 7 , 4177 , 12 , '0.05' , '100.00' , 0.05 , 100.00  --GBP as code, GBP as currency
UNION ALL SELECT 7 , 4178 , 12 , '0.50' , '50.00' , 0.50 , 50.00  --GBP as code, GBP as currency
UNION ALL SELECT 7 , 4175 , 5 , '1.20' , '1200.00' , 1.20 , 1200.00  --HKD as code, HK$ as currency
UNION ALL SELECT 7 , 4176 , 5 , '1.50' , '90.00' , 1.50 , 90.00  --HKD as code, HK$ as currency
UNION ALL SELECT 7 , 4177 , 5 , '0.30' , '1200.00' , 0.30 , 1200.00  --HKD as code, HK$ as currency
UNION ALL SELECT 7 , 4178 , 5 , '3.00' , '600.00' , 3.00 , 600.00  --HKD as code, HK$ as currency
UNION ALL SELECT 7 , 4175 , 13 , '1.20' , '1200.00' , 1.20 , 1200.00  --CNY as code, RMB as currency
UNION ALL SELECT 7 , 4176 , 13 , '1.50' , '90.00' , 1.50 , 90.00  --CNY as code, RMB as currency
UNION ALL SELECT 7 , 4177 , 13 , '0.30' , '1200.00' , 0.30 , 1200.00  --CNY as code, RMB as currency
UNION ALL SELECT 7 , 4178 , 13 , '3.00' , '600.00' , 3.00 , 600.00  --CNY as code, RMB as currency
UNION ALL SELECT 7 , 4175 , 52 , '1.20' , '1200.00' , 1.20 , 1200.00  --DKK as code, DKK as currency
UNION ALL SELECT 7 , 4176 , 52 , '1.50' , '90.00' , 1.50 , 90.00  --DKK as code, DKK as currency
UNION ALL SELECT 7 , 4177 , 52 , '0.30' , '1200.00' , 0.30 , 1200.00  --DKK as code, DKK as currency
UNION ALL SELECT 7 , 4178 , 52 , '3.00' , '600.00' , 3.00 , 600.00  --DKK as code, DKK as currency
UNION ALL SELECT 7 , 4175 , 53 , '1.20' , '1200.00' , 1.20 , 1200.00  --SEK as code, SEK as currency
UNION ALL SELECT 7 , 4176 , 53 , '1.50' , '90.00' , 1.50 , 90.00  --SEK as code, SEK as currency
UNION ALL SELECT 7 , 4177 , 53 , '0.30' , '1200.00' , 0.30 , 1200.00  --SEK as code, SEK as currency
UNION ALL SELECT 7 , 4178 , 53 , '3.00' , '600.00' , 3.00 , 600.00  --SEK as code, SEK as currency
UNION ALL SELECT 7 , 4175 , 54 , '1.20' , '1200.00' , 1.20 , 1200.00  --NOK as code, NOK as currency
UNION ALL SELECT 7 , 4176 , 54 , '1.50' , '90.00' , 1.50 , 90.00  --NOK as code, NOK as currency
UNION ALL SELECT 7 , 4177 , 54 , '0.30' , '1200.00' , 0.30 , 1200.00  --NOK as code, NOK as currency
UNION ALL SELECT 7 , 4178 , 54 , '3.00' , '600.00' , 3.00 , 600.00  --NOK as code, NOK as currency
UNION ALL SELECT 7 , 4175 , 66 , '1.20' , '1200.00' , 1.20 , 1200.00  --CNY as code, YUN as currency
UNION ALL SELECT 7 , 4176 , 66 , '1.50' , '90.00' , 1.50 , 90.00  --CNY as code, YUN as currency
UNION ALL SELECT 7 , 4177 , 66 , '0.30' , '1200.00' , 0.30 , 1200.00  --CNY as code, YUN as currency
UNION ALL SELECT 7 , 4178 , 66 , '3.00' , '600.00' , 3.00 , 600.00  --CNY as code, YUN as currency
UNION ALL SELECT 7 , 4175 , 67 , '1.20' , '1200.00' , 1.20 , 1200.00  --HKD as code, HKK as currency
UNION ALL SELECT 7 , 4176 , 67 , '1.50' , '90.00' , 1.50 , 90.00  --HKD as code, HKK as currency
UNION ALL SELECT 7 , 4177 , 67 , '0.30' , '1200.00' , 0.30 , 1200.00  --HKD as code, HKK as currency
UNION ALL SELECT 7 , 4178 , 67 , '3.00' , '600.00' , 3.00 , 600.00  --HKD as code, HKK as currency
UNION ALL SELECT 7 , 4175 , 77 , '1.20' , '1200.00' , 1.20 , 1200.00  --INR as code, PTH as currency
UNION ALL SELECT 7 , 4176 , 77 , '1.50' , '90.00' , 1.50 , 90.00  --INR as code, PTH as currency
UNION ALL SELECT 7 , 4177 , 77 , '0.30' , '1200.00' , 0.30 , 1200.00  --INR as code, PTH as currency
UNION ALL SELECT 7 , 4178 , 77 , '3.00' , '600.00' , 3.00 , 600.00  --INR as code, PTH as currency
UNION ALL SELECT 7 , 4175 , 2 , '0.60' , '600.00' , 0.60 , 600.00  --MYR as code, RM as currency
UNION ALL SELECT 7 , 4176 , 2 , '0.75' , '45.00' , 0.75 , 45.00  --MYR as code, RM as currency
UNION ALL SELECT 7 , 4177 , 2 , '0.15' , '600.00' , 0.15 , 600.00  --MYR as code, RM as currency
UNION ALL SELECT 7 , 4178 , 2 , '1.50' , '300.00' , 1.50 , 300.00  --MYR as code, RM as currency
UNION ALL SELECT 7 , 4175 , 56 , '0.60' , '600.00' , 0.60 , 600.00  --PLN as code, PLN as currency
UNION ALL SELECT 7 , 4176 , 56 , '0.75' , '45.00' , 0.75 , 45.00  --PLN as code, PLN as currency
UNION ALL SELECT 7 , 4177 , 56 , '0.15' , '600.00' , 0.15 , 600.00  --PLN as code, PLN as currency
UNION ALL SELECT 7 , 4178 , 56 , '1.50' , '300.00' , 1.50 , 300.00  --PLN as code, PLN as currency
UNION ALL SELECT 7 , 4175 , 58 , '0.60' , '600.00' , 0.60 , 600.00  --RON as code, RON as currency
UNION ALL SELECT 7 , 4176 , 58 , '0.75' , '45.00' , 0.75 , 45.00  --RON as code, RON as currency
UNION ALL SELECT 7 , 4177 , 58 , '0.15' , '600.00' , 0.15 , 600.00  --RON as code, RON as currency
UNION ALL SELECT 7 , 4178 , 58 , '1.50' , '300.00' , 1.50 , 300.00  --RON as code, RON as currency
UNION ALL SELECT 7 , 4175 , 71 , '0.60' , '600.00' , 0.60 , 600.00  --KHR as code, KHR as currency
UNION ALL SELECT 7 , 4176 , 71 , '0.75' , '45.00' , 0.75 , 45.00  --KHR as code, KHR as currency
UNION ALL SELECT 7 , 4177 , 71 , '0.15' , '600.00' , 0.15 , 600.00  --KHR as code, KHR as currency
UNION ALL SELECT 7 , 4178 , 71 , '1.50' , '300.00' , 1.50 , 300.00  --KHR as code, KHR as currency
UNION ALL SELECT 7 , 4175 , 73 , '0.60' , '600.00' , 0.60 , 600.00  --TRY as code, LIR as currency
UNION ALL SELECT 7 , 4176 , 73 , '0.75' , '45.00' , 0.75 , 45.00  --TRY as code, LIR as currency
UNION ALL SELECT 7 , 4177 , 73 , '0.15' , '600.00' , 0.15 , 600.00  --TRY as code, LIR as currency
UNION ALL SELECT 7 , 4178 , 73 , '1.50' , '300.00' , 1.50 , 300.00  --TRY as code, LIR as currency
UNION ALL SELECT 7 , 4175 , 4 , '6.00' , '6000.00' , 6.00 , 6000.00  --THB as code, TB as currency
UNION ALL SELECT 7 , 4176 , 4 , '7.50' , '450.00' , 7.50 , 450.00  --THB as code, TB as currency
UNION ALL SELECT 7 , 4177 , 4 , '1.50' , '6000.00' , 1.50 , 6000.00  --THB as code, TB as currency
UNION ALL SELECT 7 , 4178 , 4 , '15.00' , '3000.00' , 15.00 , 3000.00  --THB as code, TB as currency
UNION ALL SELECT 7 , 4175 , 30 , '6.00' , '6000.00' , 6.00 , 6000.00  --TWD as code, NT as currency
UNION ALL SELECT 7 , 4176 , 30 , '7.50' , '450.00' , 7.50 , 450.00  --TWD as code, NT as currency
UNION ALL SELECT 7 , 4177 , 30 , '1.50' , '6000.00' , 1.50 , 6000.00  --TWD as code, NT as currency
UNION ALL SELECT 7 , 4178 , 30 , '15.00' , '3000.00' , 15.00 , 3000.00  --TWD as code, NT as currency
UNION ALL SELECT 7 , 4175 , 42 , '6.00' , '6000.00' , 6.00 , 6000.00  --PHP as code, PE as currency
UNION ALL SELECT 7 , 4176 , 42 , '7.50' , '450.00' , 7.50 , 450.00  --PHP as code, PE as currency
UNION ALL SELECT 7 , 4177 , 42 , '1.50' , '6000.00' , 1.50 , 6000.00  --PHP as code, PE as currency
UNION ALL SELECT 7 , 4178 , 42 , '15.00' , '3000.00' , 15.00 , 3000.00  --PHP as code, PE as currency
UNION ALL SELECT 7 , 4175 , 43 , '6.00' , '6000.00' , 6.00 , 6000.00  --THB as code, THB as currency
UNION ALL SELECT 7 , 4176 , 43 , '7.50' , '450.00' , 7.50 , 450.00  --THB as code, THB as currency
UNION ALL SELECT 7 , 4177 , 43 , '1.50' , '6000.00' , 1.50 , 6000.00  --THB as code, THB as currency
UNION ALL SELECT 7 , 4178 , 43 , '15.00' , '3000.00' , 15.00 , 3000.00  --THB as code, THB as currency
UNION ALL SELECT 7 , 4175 , 49 , '3.60' , '3600.00' , 3.60 , 3600.00  --MXN as code, MXN as currency
UNION ALL SELECT 7 , 4176 , 49 , '4.50' , '270.00' , 4.50 , 270.00  --MXN as code, MXN as currency
UNION ALL SELECT 7 , 4177 , 49 , '0.90' , '3600.00' , 0.90 , 3600.00  --MXN as code, MXN as currency
UNION ALL SELECT 7 , 4178 , 49 , '9.00' , '1800.00' , 9.00 , 1800.00  --MXN as code, MXN as currency
UNION ALL SELECT 7 , 4175 , 51 , '3.60' , '3600.00' , 3.60 , 3600.00  --VND as code, INH as currency
UNION ALL SELECT 7 , 4176 , 51 , '4.50' , '270.00' , 4.50 , 270.00  --VND as code, INH as currency
UNION ALL SELECT 7 , 4177 , 51 , '0.90' , '3600.00' , 0.90 , 3600.00  --VND as code, INH as currency
UNION ALL SELECT 7 , 4178 , 51 , '9.00' , '1800.00' , 9.00 , 1800.00  --VND as code, INH as currency
UNION ALL SELECT 7 , 4175 , 57 , '3.60' , '3600.00' , 3.60 , 3600.00  --CZK as code, CZK as currency
UNION ALL SELECT 7 , 4176 , 57 , '4.50' , '270.00' , 4.50 , 270.00  --CZK as code, CZK as currency
UNION ALL SELECT 7 , 4177 , 57 , '0.90' , '3600.00' , 0.90 , 3600.00  --CZK as code, CZK as currency
UNION ALL SELECT 7 , 4178 , 57 , '9.00' , '1800.00' , 9.00 , 1800.00  --CZK as code, CZK as currency
UNION ALL SELECT 7 , 4175 , 15 , '1.80' , '1800.00' , 1.80 , 1800.00  --IDR as code, IN as currency
UNION ALL SELECT 7 , 4176 , 15 , '2.25' , '135.00' , 2.25 , 135.00  --IDR as code, IN as currency
UNION ALL SELECT 7 , 4177 , 15 , '0.45' , '1800.00' , 0.45 , 1800.00  --IDR as code, IN as currency
UNION ALL SELECT 7 , 4178 , 15 , '4.50' , '900.00' , 4.50 , 900.00  --IDR as code, IN as currency
UNION ALL SELECT 7 , 4175 , 22 , '1.80' , '1800.00' , 1.80 , 1800.00  --IDR as code, IND as currency
UNION ALL SELECT 7 , 4176 , 22 , '2.25' , '135.00' , 2.25 , 135.00  --IDR as code, IND as currency
UNION ALL SELECT 7 , 4177 , 22 , '0.45' , '1800.00' , 0.45 , 1800.00  --IDR as code, IND as currency
UNION ALL SELECT 7 , 4178 , 22 , '4.50' , '900.00' , 4.50 , 900.00  --IDR as code, IND as currency
UNION ALL SELECT 7 , 4175 , 33 , '1.80' , '1800.00' , 1.80 , 1800.00  --IDR as code, IDD as currency
UNION ALL SELECT 7 , 4176 , 33 , '2.25' , '135.00' , 2.25 , 135.00  --IDR as code, IDD as currency
UNION ALL SELECT 7 , 4177 , 33 , '0.45' , '1800.00' , 0.45 , 1800.00  --IDR as code, IDD as currency
UNION ALL SELECT 7 , 4178 , 33 , '4.50' , '900.00' , 4.50 , 900.00  --IDR as code, IDD as currency
UNION ALL SELECT 7 , 4175 , 34 , '1.80' , '1800.00' , 1.80 , 1800.00  --IDR as code, IDR as currency
UNION ALL SELECT 7 , 4176 , 34 , '2.25' , '135.00' , 2.25 , 135.00  --IDR as code, IDR as currency
UNION ALL SELECT 7 , 4177 , 34 , '0.45' , '1800.00' , 0.45 , 1800.00  --IDR as code, IDR as currency
UNION ALL SELECT 7 , 4178 , 34 , '4.50' , '900.00' , 4.50 , 900.00  --IDR as code, IDR as currency
UNION ALL SELECT 7 , 4175 , 47 , '1.80' , '1800.00' , 1.80 , 1800.00  --IDR as code, DDD as currency
UNION ALL SELECT 7 , 4176 , 47 , '2.25' , '135.00' , 2.25 , 135.00  --IDR as code, DDD as currency
UNION ALL SELECT 7 , 4177 , 47 , '0.45' , '1800.00' , 0.45 , 1800.00  --IDR as code, DDD as currency
UNION ALL SELECT 7 , 4178 , 47 , '4.50' , '900.00' , 4.50 , 900.00  --IDR as code, DDD as currency
UNION ALL SELECT 7 , 4175 , 44 , '200.00' , '200000.00' , 200.00 , 200000.00  --KRW as code, PT as currency
UNION ALL SELECT 7 , 4176 , 44 , '250.00' , '15000.00' , 250.00 , 15000.00  --KRW as code, PT as currency
UNION ALL SELECT 7 , 4177 , 44 , '50.00' , '200000.00' , 50.00 , 200000.00  --KRW as code, PT as currency
UNION ALL SELECT 7 , 4178 , 44 , '500.00' , '100000.00' , 500.00 , 100000.00  --KRW as code, PT as currency
UNION ALL SELECT 7 , 4175 , 45 , '200.00' , '200000.00' , 200.00 , 200000.00  --KRW as code, Won as currency
UNION ALL SELECT 7 , 4176 , 45 , '250.00' , '15000.00' , 250.00 , 15000.00  --KRW as code, Won as currency
UNION ALL SELECT 7 , 4177 , 45 , '50.00' , '200000.00' , 50.00 , 200000.00  --KRW as code, Won as currency
UNION ALL SELECT 7 , 4178 , 45 , '500.00' , '100000.00' , 500.00 , 100000.00  --KRW as code, Won as currency
UNION ALL SELECT 7 , 4175 , 62 , '200.00' , '200000.00' , 200.00 , 200000.00  --KRW as code, KW as currency
UNION ALL SELECT 7 , 4176 , 62 , '250.00' , '15000.00' , 250.00 , 15000.00  --KRW as code, KW as currency
UNION ALL SELECT 7 , 4177 , 62 , '50.00' , '200000.00' , 50.00 , 200000.00  --KRW as code, KW as currency
UNION ALL SELECT 7 , 4178 , 62 , '500.00' , '100000.00' , 500.00 , 100000.00  --KRW as code, KW as currency
UNION ALL SELECT 7 , 4175 , 55 , '10.00' , '10000.00' , 10.00 , 10000.00  --RUB as code, RUB as currency
UNION ALL SELECT 7 , 4176 , 55 , '12.50' , '750.00' , 12.50 , 750.00  --RUB as code, RUB as currency
UNION ALL SELECT 7 , 4177 , 55 , '2.50' , '10000.00' , 2.50 , 10000.00  --RUB as code, RUB as currency
UNION ALL SELECT 7 , 4178 , 55 , '25.00' , '5000.00' , 25.00 , 5000.00  --RUB as code, RUB as currency
UNION ALL SELECT 7 , 4175 , 61 , '10.00' , '10000.00' , 10.00 , 10000.00  --INR as code, INR as currency
UNION ALL SELECT 7 , 4176 , 61 , '12.50' , '750.00' , 12.50 , 750.00  --INR as code, INR as currency
UNION ALL SELECT 7 , 4177 , 61 , '2.50' , '10000.00' , 2.50 , 10000.00  --INR as code, INR as currency
UNION ALL SELECT 7 , 4178 , 61 , '25.00' , '5000.00' , 25.00 , 5000.00  --INR as code, INR as currency
UNION ALL SELECT 7 , 4175 , 31 , '20.00' , '20000.00' , 20.00 , 20000.00  --JPY as code, Pts as currency
UNION ALL SELECT 7 , 4176 , 31 , '25.00' , '1500.00' , 25.00 , 1500.00  --JPY as code, Pts as currency
UNION ALL SELECT 7 , 4177 , 31 , '5.00' , '20000.00' , 5.00 , 20000.00  --JPY as code, Pts as currency
UNION ALL SELECT 7 , 4178 , 31 , '50.00' , '10000.00' , 50.00 , 10000.00  --JPY as code, Pts as currency
UNION ALL SELECT 7 , 4175 , 32 , '20.00' , '20000.00' , 20.00 , 20000.00  --JPY as code, JPY as currency
UNION ALL SELECT 7 , 4176 , 32 , '25.00' , '1500.00' , 25.00 , 1500.00  --JPY as code, JPY as currency
UNION ALL SELECT 7 , 4177 , 32 , '5.00' , '20000.00' , 5.00 , 20000.00  --JPY as code, JPY as currency
UNION ALL SELECT 7 , 4178 , 32 , '50.00' , '10000.00' , 50.00 , 10000.00  --JPY as code, JPY as currency
UNION ALL SELECT 7 , 4175 , 37 , '20.00' , '20000.00' , 20.00 , 20000.00  --JPY as code, P as currency
UNION ALL SELECT 7 , 4176 , 37 , '25.00' , '1500.00' , 25.00 , 1500.00  --JPY as code, P as currency
UNION ALL SELECT 7 , 4177 , 37 , '5.00' , '20000.00' , 5.00 , 20000.00  --JPY as code, P as currency
UNION ALL SELECT 7 , 4178 , 37 , '50.00' , '10000.00' , 50.00 , 10000.00  --JPY as code, P as currency


;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID AND s.GameGroupID = t.GroupID) t
WHERE s.GameTypeID = 4101
)
MERGE StakeLevelGroupDetail as g 
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























