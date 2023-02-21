--/*<info serverAlias="DBCUST-CustDB"></info>*/
--/*
--	Date: 20230202
--	Created: Helios 
--	Task: Jili Games - Update MaxStake Testting SIT
--	DB: DBCUST/CUSTDB
--*/

DECLARE @StakeLevelID int

SELECT @StakeLevelID = StakeLevelID 
FROM Dep_StakeLevel WITH (NOLOCK) 
WHERE ExchangeID = 20 and GameTypeID = 5100

UPDATE Dep_StakeLevelGroupDetail WITH (ROWLOCK ,UPDLOCK)
SET MaxStake = 10 , MaxLabel = '10'
WHERE GameTypeID = 5100 and StakeLevelID = @StakeLevelID