/*
    Created: Vicky
    Date: 20180326
    Task: setting for Pragmatic game
    DB:DBCust/CustDB
*/
DECLARE @var_sportType SMALLINT = 248,
        @var_bettype SMALLINT = 4101
DECLARE @var_tbl_gamegroup TABLE (GameGroupID INT, GameName NVARCHAR(100))
DECLARE @var_tbl_StakeLevelGroupDetail TABLE (GameGroupID INT, ExchangeID INT, GameTypeID INT, 
                                              MinLabel NVARCHAR(50), MaxLabel NVARCHAR(50), 
                                              MinStake DECIMAL(19,8), MaxStake DECIMAL(19,8))


INSERT @var_tbl_gamegroup
VALUES (6, 'Level 1'), (7, 'Level 2')

INSERT @var_tbl_StakeLevelGroupDetail
       (GameGroupID, ExchangeID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
VALUES (6,           20,         4101,       '2',        '500',      2.0,     500.0),
       (6,           20,         4102,       '10',       '1000',     10.0,    1000.0),
       (6,           20,         4103,       '50',       '2500',     50.0,    2500.0),
       (6,           20,         4104,       '100',      '5000',     100.0,   5000.0),
       (6,           20,         4105,       '5',        '1000',     5.0,     1000.0),  
       
       (7,           20,         4101,       '20',       '2500',     20.0,    2500.0),
       (7,           20,         4102,       '100',      '5000',     100.0,   5000.0),
       (7,           20,         4103,       '250',      '10000',    250.0,   10000.0),
       (7,           20,         4104,       '250',      '10000',    250.0,   10000.0),
       (7,           20,         4105,       '250',      '10000',    25.0,    10000.0),
       
       (6,           16,         4101,       '2',        '500',      2.0,     500.0),
       (6,           16,         4102,       '10',       '1000',     10.0,    1000.0),
       (6,           16,         4103,       '50',       '2500',     50.0,    2500.0),
       (6,           16,         4104,       '100',      '5000',     100.0,   5000.0),
       (6,           16,         4105,       '5',        '1000',     5.0,     1000.0),
       
       (7,           16,         4101,       '20',       '2500',     20.0,    2500.0),
       (7,           16,         4102,       '100',      '5000',     100.0,   5000.0),
       (7,           16,         4103,       '250',      '10000',    250.0,   10000.0),
       (7,           16,         4104,       '250',      '10000',    250.0,   10000.0),
       (7,           16,         4105,       '250',      '10000',    25.0,    10000.0)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
                          
INSERT INTO GameGroup (GameGroupID, RefSportType,   RefBetType,   GroupName, IsDeposit)
SELECT                 GameGroupID, @var_sportType, @var_bettype, GameName,  0
FROM @var_tbl_gamegroup

                      
INSERT INTO StakeLevel (GameTypeID,   ExchangeId,   GameGroupID)
SELECT                  @var_bettype, e.exchangeId, gr.GameGroupID
FROM dbo.exchange e
    CROSS JOIN @var_tbl_gamegroup gr


--insert for stake level group detail
INSERT INTO StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT sl.StakeLevelID, tmp.GameTypeID, tmp.MinLabel, tmp.MaxLabel, tmp.MinStake, tmp.MaxStake
FROM StakeLevel sl
    INNER JOIN @var_tbl_StakeLevelGroupDetail tmp ON tmp.GameGroupId = sl.GameGroupId AND tmp.ExchangeID = sl.ExchangeID
WHERE sl.GameTypeId= @var_bettype

 
 