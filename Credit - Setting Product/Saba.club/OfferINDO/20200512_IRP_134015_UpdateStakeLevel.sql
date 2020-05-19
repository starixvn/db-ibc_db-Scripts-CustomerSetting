/*
	Created: 20200519@Elodie
	Task: Update stake level for Saba.club
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE st 
SET st.MaxLabel = '20000',
	st.MaxStake = 20000
FROM dbo.StakeLevelGroupDetail st WITH (ROWLOCK)
	INNER JOIN dbo.StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = st.StakeLevelID
WHERE st.GameTypeID = 1611 AND s.ExchangeId IN (20	--UUS												
												)
SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 1611

