/*
	Created: 20210202@Tina	
	Task: Increase max bet up to 50,000 for UUS [RedmineID: 148472] - Test currrency
	DB: DBCUST/CustDB

*/ 

UPDATE GD SET GD.MaxStake = 50000, GD.MaxLabel = '50,000'
FROM StakeLevelGroupDetail GD WITH (ROWLOCK)
	JOIN StakeLevel SL WITH (NOLOCK) ON SL.StakeLevelID = GD.StakeLevelID
WHERE SL.GameTypeID = 1611 AND SL.ExchangeId = 20 AND GameGroupID = 20

SELECT *
FROM StakeLevelGroupDetail GD WITH (NOLOCK)
	JOIN StakeLevel SL WITH (NOLOCK) ON SL.StakeLevelID = GD.StakeLevelID
WHERE SL.GameTypeID = 1611 AND SL.ExchangeId = 20 AND GameGroupID = 20
