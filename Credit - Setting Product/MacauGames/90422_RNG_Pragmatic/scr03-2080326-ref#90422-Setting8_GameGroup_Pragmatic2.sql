/*
    Created: Vicky
    Date: 20180326
    Task: setting for Pragmatic game
    DB:DBCust/CustDB
*/
DECLARE @var_settypeType SMALLINT = 8,
        @var_productId TINYINT = 22,
        @var_sportType SMALLINT = 248,
        @var_bettype SMALLINT = 4101,
        @var_isLive BIT = 0
     
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
       (6,           20,         4106,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4107,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4108,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4109,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4110,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4111,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4112,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4113,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4114,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4115,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4116,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4117,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4118,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4119,       '5',        '1000',     5.0,     1000.0),
       (6,           20,         4120,       '5',        '1000',     5.0,     1000.0),
       
       (7,           20,         4101,       '20',       '2500',     20.0,    2500.0),
       (7,           20,         4102,       '100',      '5000',     100.0,   5000.0),
       (7,           20,         4103,       '250',      '10000',    250.0,   10000.0),
       (7,           20,         4104,       '250',      '10000',    250.0,   10000.0),
       (7,           20,         4105,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4106,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4107,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4108,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4109,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4110,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4111,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4112,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4113,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4114,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4115,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4116,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4117,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4118,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4119,       '250',      '10000',    25.0,    10000.0),
       (7,           20,         4120,       '250',      '10000',    25.0,    10000.0),
       
       (6,           16,         4101,       '2',        '500',      2.0,     500.0),
       (6,           16,         4102,       '10',       '1000',     10.0,    1000.0),
       (6,           16,         4103,       '50',       '2500',     50.0,    2500.0),
       (6,           16,         4104,       '100',      '5000',     100.0,   5000.0),
       (6,           16,         4105,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4106,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4107,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4108,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4109,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4110,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4111,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4112,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4113,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4114,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4115,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4116,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4117,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4118,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4119,       '5',        '1000',     5.0,     1000.0),
       (6,           16,         4120,       '5',        '1000',     5.0,     1000.0),

       
       (7,           16,         4101,       '20',       '2500',     20.0,    2500.0),
       (7,           16,         4102,       '100',      '5000',     100.0,   5000.0),
       (7,           16,         4103,       '250',      '10000',    250.0,   10000.0),
       (7,           16,         4104,       '250',      '10000',    250.0,   10000.0),
       (7,           16,         4105,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4106,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4107,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4108,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4109,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4110,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4111,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4112,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4113,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4114,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4115,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4116,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4117,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4118,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4119,       '250',      '10000',    25.0,    10000.0),
       (7,           16,         4120,       '250',      '10000',    25.0,    10000.0)       
       
       
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM StakeLevelGroupDetail WHERE StakeLevelID IN (SELECT StakeLevelID FROM StakeLevel WHERE GameTypeID = @var_bettype)
DELETE FROM StakeLevel WHERE GameTypeID = @var_bettype
DELETE FROM GameGroup WHERE GameGroupID IN (SELECT GameGroupID FROM @var_tbl_gamegroup)
DELETE FROM ProductSettingDetail WHERE SettingType = @var_settypeType AND SportType = @var_sportType AND BetType =  @var_bettype AND IsLive = @var_isLive

INSERT INTO ProductSettingDetail (SettingType,      SportType,      BetType,      IsLive,      ProductID,      MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus)
                          VALUES (@var_settypeType, @var_sportType, @var_bettype, @var_isLive, @var_productId, NULL,  NULL,        NULL,   NULL,     NULL,       2,            5,            1)

                          
INSERT INTO GameGroup (GameGroupID, RefSportType,   RefBetType,   GroupName, IsDeposit)
SELECT                 GameGroupID, @var_sportType, @var_bettype, GameName,  0
FROM @var_tbl_gamegroup

                      
INSERT INTO StakeLevel (GameTypeID,   ExchangeId,   GameGroupID)
SELECT                  @var_bettype, e.exchangeId, gr.GameGroupID
FROM dbo.exchange e
    CROSS JOIN @var_tbl_gamegroup gr


--insert for stake level group detail
INSERT INTO StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT sl.StakeLevelID, tblGameType.GameTypeID, COALESCE(tmp.MinLabel,'0'), COALESCE(tmp.MaxLabel, '0'), COALESCE(tmp.MinStake, 0.0), COALESCE(tmp.MaxStake, 0.0)
FROM StakeLevel sl
    CROSS JOIN (SELECT DISTINCT GameTypeID
		        FROM 
		           @var_tbl_StakeLevelGroupDetail
		       ) AS tblGameType
    LEFT JOIN @var_tbl_StakeLevelGroupDetail tmp ON tmp.GameGroupId = sl.GameGroupId AND tmp.ExchangeID = sl.ExchangeID AND tmp.GameTypeID = tblGameType.GameTypeID
WHERE sl.GameTypeId= @var_bettype

 
 