/*
	Created: 20210113@Tina
	Task: Insert stake level for Saba.club [RedmineID: 148472]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

INSERT INTO dbo.StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID)
SELECT 1611, NULL, NULL, NULL, NULL, exchangeid, NULL, 13
FROM dbo.exchange WITH (NOLOCK)
WHERE exchangeid IN (
						2,  --MYR(RM)
						67, --HKD(HKK)
						5,  --HKD(HK$)
						69, --MMK(MMK)
						13, --CNY(RMB)
						6,  --EUR(EURO)
						12, --GBP(GBP)
						45  --KRW(Won)
)

INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT StakeLevelID, GameTypeID, '0.01', '2,500', 0.01, 2500, NULL
FROM dbo.StakeLevel WITH (NOLOCK)
WHERE GameTypeID = 1611 
AND ExchangeId IN (
						2,  --MYR(RM)
						67, --HKD(HKK)
						5,  --HKD(HK$)
						69, --MMK(MMK)
						13, --CNY(RMB)
						6,  --EUR(EURO)
						12  --GBP(GBP)
) 

INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT StakeLevelID, GameTypeID, '2.5', '300,000', 2.5, 300000, NULL
FROM dbo.StakeLevel WITH (NOLOCK)
WHERE GameTypeID = 1611 
AND ExchangeId = 45 --KRW(Won)
					
SELECT * FROM dbo.GameGroup WITH (NOLOCK) WHERE RefBetType = 1611 
SELECT * FROM dbo.StakeLevel WITH (NOLOCK) WHERE GameTypeID = 1611
SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 1611
--DELETE FROM dbo.GameGroup WITH (ROWLOCK) WHERE RefBetType = 1611
--DELETE FROM dbo.StakeLevel WITH (ROWLOCK) WHERE GameTypeID = 1611
--DELETE FROM dbo.StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 1611
