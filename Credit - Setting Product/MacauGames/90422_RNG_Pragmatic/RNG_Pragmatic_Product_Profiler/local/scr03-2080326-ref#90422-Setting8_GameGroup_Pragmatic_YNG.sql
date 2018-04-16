/*
    Created: Vicky
    Date: 20180326
    Task: init data for YNG
    DB:DBCust/CustDB
*/
DECLARE @var_settypeType SMALLINT = 8,
        @var_productId TINYINT = 22,
        @var_sportType SMALLINT = 248,
        @var_bettype SMALLINT = 4101,
        @var_isLive BIT = 0
     
SELECT * FROM StakeLevel WHERE gametypeid= @var_bettype AND Exchangeid = 72     
--insert for stake level group detail
UPDATE StakeLevelGroupDetail 
SET MinLabel = '1.00', MaxLabel = '50.00', MinStake = CAST(1.00000000 AS Decimal(19, 8)), MaxStake = CAST(50.00000000 AS Decimal(19, 8))
WHERE StakeLevelID IN (SELECT StakeLevelID FROM StakeLevel WHERE gametypeid= @var_bettype AND Exchangeid = 72)
