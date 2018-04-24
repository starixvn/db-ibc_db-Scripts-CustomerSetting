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
DECLARE @var_tbl_StakeLevelGroupDetail TABLE (GameGroupID INT, CurrencyCode VARCHAR(3), GameTypeID INT, 
                                              MinLabel NVARCHAR(50), MaxLabel NVARCHAR(50), 
                                              MinStake DECIMAL(19,8), MaxStake DECIMAL(19,8))


INSERT @var_tbl_gamegroup
VALUES (6, 'Level 1'), (7, 'Level 2')

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
 (6, '4104', '', '0.03', '15.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(15.00000000 AS Decimal(19, 8))),
 (6, '4113', '', '0.25', '10.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8))),
 (6, '4120', '', '0.50', '4.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8))),
 (6, '4102', '', '0.25', '50.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (6, '4114', '', '0.25', '1.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(1.50000000 AS Decimal(19, 8))),
 (6, '4118', '', '0.25', '2.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.00000000 AS Decimal(19, 8))),
 (6, '4110', '', '0.15', '3.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8))),
 (6, '4108', '', '0.09', '27.00', CAST(0.09000000 AS Decimal(19, 8)), CAST(27.00000000 AS Decimal(19, 8))),
 (6, '4116', '', '0.25', '1.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(1.00000000 AS Decimal(19, 8))),
 (6, '4112', '', '0.50', '2.50', CAST(0.50000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8))),
 (6, '4121', '', '0.05', '100.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8))),
 (6, '4122', '', '0.25', '2.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.00000000 AS Decimal(19, 8))),
 (7, '4107', '', '0.07', '7.00', CAST(0.07000000 AS Decimal(19, 8)), CAST(7.00000000 AS Decimal(19, 8))),
 (7, '4106', '', '0.07', '0.70', CAST(0.07000000 AS Decimal(19, 8)), CAST(0.70000000 AS Decimal(19, 8))),
 (7, '4111', '', '0.20', '1.60', CAST(0.20000000 AS Decimal(19, 8)), CAST(1.60000000 AS Decimal(19, 8))),
 (7, '4117', '', '0.25', '50.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8))),
 (7, '4101', '', '0.01', '200.00', CAST(0.01000000 AS Decimal(19, 8)), CAST(200.00000000 AS Decimal(19, 8))),
 (7, '4105', '', '0.05', '10.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8))),
 (7, '4119', '', '0.38', '5.00', CAST(0.38000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8))),
 (7, '4109', '', '0.15', '12.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(12.00000000 AS Decimal(19, 8))),
 (7, '4103', '', '0.03', '6.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8))),
 (7, '4115', '', '0.25', '20.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(20.00000000 AS Decimal(19, 8))),
 (7, '4104', '', '0.03', '30.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(30.00000000 AS Decimal(19, 8))),
 (7, '4113', '', '0.25', '20.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(20.00000000 AS Decimal(19, 8))),
 (7, '4120', '', '0.50', '8.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(8.00000000 AS Decimal(19, 8))),
 (7, '4102', '', '0.25', '100.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8))),
 (7, '4114', '', '0.25', '3.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8))),
 (7, '4118', '', '0.25', '4.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8))),
 (7, '4110', '', '0.15', '6.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8))),
 (7, '4108', '', '0.09', '54.00', CAST(0.09000000 AS Decimal(19, 8)), CAST(54.00000000 AS Decimal(19, 8))),
 (7, '4116', '', '0.25', '2.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.00000000 AS Decimal(19, 8))),
 (7, '4112', '', '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8))),
 (7, '4121', '', '0.05', '200.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(200.00000000 AS Decimal(19, 8))),
 (7, '4122', '', '0.25', '4.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))

     
       
       
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO ProductSettingDetail (SettingType,      SportType,      BetType,      IsLive,      ProductID,      MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus)
                          VALUES (@var_settypeType, @var_sportType, @var_bettype, @var_isLive, @var_productId, NULL,  NULL,        NULL,   NULL,     NULL,       2,            5,            1)

                          
INSERT INTO GameGroup (GameGroupID, RefSportType,   RefBetType,   GroupName, IsDeposit)
SELECT                 GameGroupID, @var_sportType, @var_bettype, GameName,  0
FROM @var_tbl_gamegroup

                      
INSERT INTO StakeLevel (GameTypeID,   ExchangeId,   GameGroupID)
SELECT                  @var_bettype, e.exchangeId, gr.GameGroupID
FROM dbo.exchange e
    CROSS JOIN @var_tbl_gamegroup gr
WHERE e.code IN (SELECT DISTINCT CurrencyCode FROM @var_tbl_StakeLevelGroupDetail)    


--insert for stake level group detail
INSERT INTO StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT sl.StakeLevelID, tblGameType.GameTypeID, COALESCE(tmp.MinLabel,'0'), COALESCE(tmp.MaxLabel, '0'), COALESCE(tmp.MinStake, 0.0), COALESCE(tmp.MaxStake, 0.0)
FROM StakeLevel sl
    CROSS JOIN (SELECT DISTINCT GameTypeID
		        FROM 
		           @var_tbl_StakeLevelGroupDetail
		       ) AS tblGameType
    INNER JOIN exchange ex ON sl.exchangeId = ex.exchangeId
    LEFT JOIN @var_tbl_StakeLevelGroupDetail tmp ON tmp.GameGroupId = sl.GameGroupId AND tmp.CurrencyCode = ex.Code AND tmp.GameTypeID = tblGameType.GameTypeID
WHERE sl.GameTypeId= @var_bettype

 
 