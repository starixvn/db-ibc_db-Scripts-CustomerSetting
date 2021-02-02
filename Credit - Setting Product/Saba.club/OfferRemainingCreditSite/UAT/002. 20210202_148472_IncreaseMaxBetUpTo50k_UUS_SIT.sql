/*
	Created: 20210202@Tina	
	Task: Increase max bet up to 50,000 for UUS [RedmineID: 148472] - Test currrency
	DB: DBCUST/CustDB

*/ 

UPDATE GD SET GD.MaxStake = 30000, GD.MaxLabel = '30,000'
FROM StakeLevelGroupDetail GD WITH (ROWLOCK)
	JOIN StakeLevel SL WITH (NOLOCK) ON SL.StakeLevelID = GD.StakeLevelID
WHERE GD.GameTypeID = 1611 AND SL.ExchangeId = 20 AND SL.GameGroupID = 13

UPDATE GD SET GD.MaxStake = 50000, GD.MaxLabel = '50,000'
FROM StakeLevelGroupDetail GD WITH (ROWLOCK)
	JOIN StakeLevel SL WITH (NOLOCK) ON SL.StakeLevelID = GD.StakeLevelID
WHERE GD.GameTypeID = 1611 AND SL.ExchangeId = 20 AND SL.GameGroupID = 20

SELECT *
FROM StakeLevelGroupDetail GD WITH (NOLOCK)
	JOIN StakeLevel SL WITH (NOLOCK) ON SL.StakeLevelID = GD.StakeLevelID
WHERE GD.GameTypeID = 1611 AND SL.ExchangeId = 20 AND SL.GameGroupID IN (13,20)
