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
     
DECLARE @var_tbl_gamegroup TABLE (GameGroupID INT, GameName NVARCHAR(100))
DECLARE @var_tbl_StakeLevelGroupDetail TABLE (GameGroupID INT, CurrencyCode VARCHAR(3), GameTypeID INT, 
                                              MinLabel NVARCHAR(50), MaxLabel NVARCHAR(50), 
                                              MinStake DECIMAL(19,8), MaxStake DECIMAL(19,8))


INSERT @var_tbl_gamegroup
VALUES (6, 'Level 1'), (7, 'Level 2')

INSERT @var_tbl_StakeLevelGroupDetail
       (GameGroupID, GameTypeID, CurrencyCode, MinLabel, MaxLabel, MinStake, MaxStake)
VALUES   
 
 (6, '4107', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4106', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4111', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4117', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4101', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4105', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4119', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4109', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4103', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4115', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4104', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4113', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4120', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4102', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4114', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4118', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4110', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4108', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4116', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4112', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4121', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4122', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4107', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4106', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4111', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4117', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4101', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4105', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4119', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4109', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4103', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4115', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4104', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4113', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4120', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4102', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4114', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4118', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4110', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4108', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4116', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4112', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4121', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4122', 'YNG', '1.00', '50.00', CAST(1.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))  
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
    INNER JOIN exchange ex ON sl.exchangeId = ex.exchangeId
    INNER JOIN @var_tbl_StakeLevelGroupDetail tmp ON tmp.GameGroupId = sl.GameGroupId AND tmp.CurrencyCode = ex.Code AND tmp.GameTypeID = tblGameType.GameTypeID
WHERE sl.GameTypeId= @var_bettype

 
 