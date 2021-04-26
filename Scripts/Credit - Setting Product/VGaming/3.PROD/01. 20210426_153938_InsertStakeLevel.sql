/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Insert stake level for VGaming - copy from Saba.Club [#RM:153938]
	DB: DBCUST/CustDB
*/

USE CustDB
GO
DECLARE @Bettype int = 3801, @GameGroupID TINYINT = 25, @fBettype int = 1611

INSERT INTO dbo.StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ExchangeId, ResourceId, GameGroupID)
SELECT @Bettype, NULL, NULL, NULL, NULL, exchangeid, NULL, @GameGroupID
FROM dbo.StakeLevel WITH (NOLOCK)
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
	AND GameTypeID =  @fBettype

INSERT INTO dbo.StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake, ParentTypeID)
SELECT t.StakeLevelID, t.GameTypeID, f.MinLabel,  f.MaxLabel,  f.MinStake,  f.MaxStake, NULL
FROM dbo.StakeLevel t WITH (NOLOCK)
	CROSS APPLY	(	SELECT fg.MinLabel,  fg.MaxLabel,  fg.MinStake,  fg.MaxStake
					FROM dbo.StakeLevel fs WITH (NOLOCK)
						INNER JOIN StakeLevelGroupDetail fg WITH(NOLOCK) ON fs.StakeLevelID = fg.StakeLevelID
					WHERE fs.GameTypeID = @fBettype
						AND fs.ExchangeId = t.ExchangeId
				) f
WHERE t.GameTypeID = @Bettype 
AND t.ExchangeId IN (
						2,  --MYR(RM)
						67, --HKD(HKK)
						5,  --HKD(HK$)
						69, --MMK(MMK)
						13, --CNY(RMB)
						6,  --EUR(EURO)
						12, --GBP(GBP)
						45  --KRW(Won)
) 

/*				
SELECT * FROM dbo.GameGroup WITH (NOLOCK) WHERE RefBetType = 3801 
SELECT * FROM dbo.StakeLevel WITH (NOLOCK) WHERE GameTypeID = 3801
SELECT * FROM dbo.StakeLevelGroupDetail WITH (NOLOCK) WHERE GameTypeID = 3801


DELETE FROM dbo.StakeLevel WITH (ROWLOCK) WHERE GameTypeID = 3801
DELETE FROM dbo.StakeLevelGroupDetail WITH (ROWLOCK) WHERE GameTypeID = 3801

*/
