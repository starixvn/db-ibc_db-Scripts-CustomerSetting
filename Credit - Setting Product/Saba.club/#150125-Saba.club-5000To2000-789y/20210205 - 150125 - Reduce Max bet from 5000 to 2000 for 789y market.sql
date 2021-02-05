/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20210205@Tina
	Task: Reduce Max bet from 5000 to 2000 for 789y market for Saba.club [RedmineID: #150125]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE st 
SET st.MaxLabel = '3,000',
	st.MaxStake = 3000
FROM dbo.StakeLevelGroupDetail st WITH (ROWLOCK)
	INNER JOIN dbo.StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = st.StakeLevelID
WHERE st.GameTypeID = 1611 
	AND st.MaxStake = 5000
	AND s.ExchangeId IN (3	--US$
						,16	--Yen
						,17	--NTD
						,35	--$US
						,36	--Y$US
						,40	--IRR
						,64	--UT
						,65	--UDI
						,68	--POS
						,74	--TH
						)

SELECT SL.ExchangeId, GD.*
FROM dbo.StakeLevelGroupDetail GD WITH (NOLOCK) 
	JOIN StakeLevel SL WITH (NOLOCK) ON GD.StakeLevelID = SL.StakeLevelID
WHERE GD.GameTypeID = 1611
	AND SL.ExchangeId IN (3	--US$
						,16	--Yen
						,17	--NTD
						,35	--$US
						,36	--Y$US
						,40	--IRR
						,64	--UT
						,65	--UDI
						,68	--POS
						,74	--TH
						)
ORDER BY SL.ExchangeId
