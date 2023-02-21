--/*<info serverAlias="DBCUST-CustDB"></info>*/
--/*
--	Date: 20230221
--	Created: Helios 
--	Task: Jili Games - Update MaxStake Testting SIT
--	DB: DBCUST/CUSTDB
--*/

use CustDB
DECLARE @StakeLevelID int

SELECT @StakeLevelID = StakeLevelID 
FROM Dep_StakeLevel WITH (NOLOCK) 
WHERE ExchangeID = 20 and GameTypeID = 5100

UPDATE Dep_StakeLevelGroupDetail WITH (ROWLOCK ,UPDLOCK)
SET MaxStake = 9 , MaxLabel = '9'
WHERE GameTypeID = 5100 and StakeLevelID = @StakeLevelID