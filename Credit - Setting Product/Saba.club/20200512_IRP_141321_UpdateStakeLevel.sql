/*
	Created: 20200910@Elodie
	Task: Update stake level for Saba.club
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE st 
SET st.MaxLabel = '2,000',
	st.MaxStake = 2000
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

--UPDATE st 
--SET st.MaxLabel = '10000',
--	st.MaxStake = 10000
--FROM dbo.StakeLevelGroupDetail st WITH (ROWLOCK)
--	INNER JOIN dbo.StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = st.StakeLevelID
--WHERE st.GameTypeID = 1611 AND s.ExchangeId IN (20	--UUS												
--												)
SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 1611

