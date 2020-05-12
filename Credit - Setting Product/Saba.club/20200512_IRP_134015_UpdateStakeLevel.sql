/*
	Created: 20200409@Elodie
	Task: Update stake level for Saba.club
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE st 
SET st.MaxLabel = '1000',
	st.MaxStake = 1000
FROM dbo.StakeLevelGroupDetail st WITH (ROWLOCK)
	INNER JOIN dbo.StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = st.StakeLevelID
WHERE st.GameTypeID = 1611 AND s.ExchangeId IN (3	--US$
												,16	--Yen
												,17	--NTD
												,20	--UUS
												,35	--$US
												,36	--Y$US
												,40	--IRR
												,64	--UT
												,65	--UDI
												,68	--POS
												,74	--TH
												)

SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 1611

