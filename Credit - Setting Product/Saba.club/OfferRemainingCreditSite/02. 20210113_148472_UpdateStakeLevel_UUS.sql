/*
	Created: 20210113@Tina
	Task: Update stake level for Saba.club [RedmineID: 148472]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE st 
SET st.MaxLabel = '20,000',
	st.MaxStake = 20000
FROM dbo.StakeLevelGroupDetail st WITH (ROWLOCK)
	INNER JOIN dbo.StakeLevel s WITH (NOLOCK) ON s.StakeLevelID = st.StakeLevelID
WHERE st.GameTypeID = 1611 AND s.ExchangeId = 20 --UUS

SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 1611

