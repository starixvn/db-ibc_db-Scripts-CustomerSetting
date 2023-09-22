/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230918
	Task: Allbet - Change Play Currency - Change bet limit for RM,HK$, RMB, HKK, USD and re-open Credit Markets [Redmine: 193854]
	DB: DBCust/CustDB
	Step 5 : Correc data member 
*/
	USE CustDB
	GO

	UPDATE cs
	SET cs.StakeLevelList =  ''
	FROM CustStakeLevel_Member cs WITH (ROWLOCK, UPDLOCK) 
	WHERE cs.custid in (98447602, 98447432) AND cs.SportType = 211 AND cs.BetType = 2401

	Declare @Time DATETIME = GETDATE()
	INSERT INTO CustMaxBetSetting_History (CustID, SportType, BetType, OldMaxBet, OldMaxPerMatch, OldStakeLevelList, UpdateTime)
	SELECT 98447602 AS CustID, 211 AS SportType, 2401 AS  BetType, NULL AS MaxBet, NULL AS MaxPerMatch, '2627' AS  StakeLevelList, @Time AS UpdateTime
	UNION 
	SELECT 98447432 AS CustID, 211 AS SportType, 2401 AS  BetType, NULL AS MaxBet, NULL AS MaxPerMatch, '2627' AS  StakeLevelList, @Time AS UpdateTime
