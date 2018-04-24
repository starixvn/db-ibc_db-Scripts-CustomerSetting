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
     
DECLARE @var_tbl_StakeLevelGroupDetail TABLE (GameGroupID INT, CurrencyCode VARCHAR(3), GameTypeID INT, 
                                              MinLabel NVARCHAR(50), MaxLabel NVARCHAR(50), 
                                              MinStake DECIMAL(19,8), MaxStake DECIMAL(19,8),
                                              StakeLevelId INT)

INSERT @var_tbl_StakeLevelGroupDetail
       (GameGroupID, GameTypeID, CurrencyCode, MinLabel, MaxLabel, MinStake, MaxStake)
VALUES   
 ---------UUS
 (6, '4107', '', '0.07', '3.50', CAST(0.07000000 AS Decimal(19, 8)), CAST(3.50000000 AS Decimal(19, 8))),
 (6, '4106', '', '0.07', '0.35', CAST(0.07000000 AS Decimal(19, 8)), CAST(0.35000000 AS Decimal(19, 8))),
 (6, '4111', '', '0.20', '0.80', CAST(0.20000000 AS Decimal(19, 8)), CAST(0.80000000 AS Decimal(19, 8))),
 (6, '4117', '', '0.25', '25.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(25.00000000 AS Decimal(19, 8))),
 (6, '4101', '', '0.01', '100.00', CAST(0.01000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8))),
 (6, '4105', '', '0.05', '5.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8))),
 (6, '4119', '', '0.38', '2.50', CAST(0.38000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8))),
 (6, '4109', '', '0.15', '6.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8))),
 (6, '4103', '', '0.03', '3.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8))),
 (6, '4115', '', '0.25', '10.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8))),
 (6, '4103', 'RON', '0.03', '3.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8))),
 (7, '4103', 'RON', '0.03', '3.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8)))
 
 
--insert for stake level group detail
UPDATE slvNew
SET slvNew.StakeLevelId = slv.StakeLevelID
FROM @var_tbl_StakeLevelGroupDetail slvNew
    INNER JOIN Exchange ex ON ex.Code = slvNew.CurrencyCode
    INNER JOIN StakeLevel sl ON sl.GameGroupId = slvNew.GameGroupID AND sl.ExchangeId = ex.ExchangeId 
    LEFT JOIN StakeLevelGroupDetail slv ON slv.GameTypeID = slvNew.GameTypeId AND slv.StakeLevelID = sl.StakeLevelId
    

UPDATE slv
SET slv.MinLabel = slvNew.MinLabel, slv.MaxLabel = slvNew.MaxLabel,
    slv.MinStake = slvNew.MinStake, slv.MaxStake = slvNew.MaxStake
FROM StakeLevelGroupDetail slv
    INNER JOIN @var_tbl_StakeLevelGroupDetail slvNew ON slvNew.StakeLevelId = slv.StakeLevelId AND slvNew.GameTypeID = slv.GameTypeId


select * from StakeLevelGroupDetail where StakeLevelId in ( 5328,5389)