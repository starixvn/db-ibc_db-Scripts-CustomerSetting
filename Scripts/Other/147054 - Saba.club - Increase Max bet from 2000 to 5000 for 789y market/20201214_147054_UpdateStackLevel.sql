/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20201214@Tina
	Task: Increase Max bet from 2000 to 5000 for 789y market for Saba.club [RedmineID: #147054]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE st 
SET st.MaxLabel = '5,000',
	st.MaxStake = 5000
FROM dbo.StakeLevelGroupDetail st WITH (ROWLOCK)
	INNER JOIN dbo.StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = st.StakeLevelID
WHERE st.GameTypeID = 1611 AND s.ExchangeId IN (3	--US$
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

SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 1611

