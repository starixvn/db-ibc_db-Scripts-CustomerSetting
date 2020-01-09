/*
	Date: 2020-01-09
	Created: Tiara
	Task: #123592 Pragmatic - Integrate 5 games - Add global setting for Credit
	DB: DBCUST/CUSTDB
*/


--US$, Yen, NTD, $US, Y$US, IRR, UT, UDI, POS, TH,  AUD, Euro, EUR, MMK, MKK, SD$, PS, NZD, PTU, BND, CAD, CAN, CHF, UUS, YNG(test) )
UPDATE S
SET S.MinLabel = '0.1', S.MaxLabel='1', S.MinStake = 0.1, S.MaxStake = 1
FROM Dep_StakeLevelGroupDetail S WITH (ROWLOCK)
	INNER JOIN Dep_StakeLevel ST WITH (NOLOCK) ON ST.StakeLevelID = S.StakeLevelID 
WHERE ST.ExchangeId IN (3,16,17,35,36,40,64,65,68,74,9,6,78,1,76,75,41,20,72) AND S.GameTypeID = 4201