/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220525@Tacy
	Task: Initial data into column MaxGameStake on table StakeLevelGroupDetail, Dep_StakeLevelGroupDetail
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCUST/CustDB
*/

--Credit
UPDATE slg
SET slg.MaxGameStake=CASE WHEN   GameTypeID BETWEEN 6401 AND 6700	THEN 98*MaxStake	--Joker
						  WHEN	(GameTypeID BETWEEN 4001 AND 4100) OR
								(GameTypeID BETWEEN 4101 AND 4300) OR 
								(GameTypeID BETWEEN 6701 AND 7000) OR
								(GameTypeID BETWEEN 4301 AND 4600)
																	THEN 100*MaxStake	--Macau Games, PP, SG
																	ELSE MaxStake
					END
FROM StakeLevelGroupDetail slg WITH (NOLOCK)
	INNER JOIN dbtxn.bodb02.dbo.bettype bt WITH (NOLOCK) ON bt.typeid=slg.GameTypeID
WHERE bt.typedesc='BuyBonus'

--Deposit
UPDATE dslg
SET dslg.MaxGameStake=CASE WHEN   GameTypeID BETWEEN 6401 AND 6700	THEN 98*MaxStake	--Joker
						  WHEN	(GameTypeID BETWEEN 4001 AND 4100) OR
								(GameTypeID BETWEEN 4101 AND 4300) OR 
								(GameTypeID BETWEEN 6701 AND 7000) OR
								(GameTypeID BETWEEN 4301 AND 4600)
																	THEN 100*MaxStake	--Macau Games, PP, SG
																	ELSE MaxStake
					END
FROM Dep_StakeLevelGroupDetail dslg WITH (NOLOCK)
	INNER JOIN dbtxn.bodb02.dbo.bettype bt WITH (NOLOCK) ON bt.typeid=dslg.GameTypeID
WHERE bt.typedesc='BuyBonus'