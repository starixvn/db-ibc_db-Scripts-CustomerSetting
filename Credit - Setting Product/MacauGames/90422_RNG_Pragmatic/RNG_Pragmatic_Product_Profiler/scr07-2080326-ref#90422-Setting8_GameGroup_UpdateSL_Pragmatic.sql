/*
    Created: Vicky
    Date: 20180326
    Task: init data for YNG
    DB:DBCust/CustDB
*/
IF OBJECT_ID('tempdb..#var_tbl_StakeLevelGroupDetail') IS NOT NULL DROP TABLE #var_tbl_StakeLevelGroupDetail
GO
IF OBJECT_ID('tempdb..#var_tbl_ref_curr') IS NOT NULL DROP TABLE #var_tbl_ref_curr
GO
DECLARE @var_settypeType SMALLINT = 8,
        @var_productId TINYINT = 22,
        @var_sportType SMALLINT = 248,
        @var_bettype SMALLINT = 4101,
        @var_isLive BIT = 0
     
CREATE TABLE #var_tbl_StakeLevelGroupDetail (GameGroupID INT NOT NULL, CurrencyCode VARCHAR(3) NOT NULL, GameTypeID INT NOT NULL, 
                                              MinLabel VARCHAR(50) NOT NULL, MaxLabel VARCHAR(50) NOT NULL, 
                                              MinStake DECIMAL(19,8) NOT NULL, MaxStake DECIMAL(19,8) NOT NULL,
                                              StakeLevelId INT,
                                              PRIMARY KEY (GameGroupID, CurrencyCode, GameTypeID)
                                              )
CREATE TABLE #var_tbl_ref_curr (CurrencyCode VARCHAR(3), 
                                CurrencyCodeRef VARCHAR(3),
                                PRIMARY KEY (CurrencyCode, CurrencyCodeRef)
                                )                                              

INSERT INTO #var_tbl_ref_curr
VALUES --group 1
       ('AUD', '')
      ,('EUR', '')
      ,('IDR', 'USD')
      
      
INSERT #var_tbl_StakeLevelGroupDetail
       (GameGroupID, GameTypeID, CurrencyCode, MinLabel, MaxLabel, MinStake, MaxStake)
VALUES   
 ---------UUS
 (6, '4101', '', '0.07', '3.50', CAST(0.07000000 AS Decimal(19, 8)), CAST(3.50000000 AS Decimal(19, 8))),
 (6, '4102', '', '0.07', '0.35', CAST(0.07000000 AS Decimal(19, 8)), CAST(0.35000000 AS Decimal(19, 8))),
 (6, '4113', '', '0.20', '0.80', CAST(0.20000000 AS Decimal(19, 8)), CAST(0.80000000 AS Decimal(19, 8))),
 (6, '4114', '', '0.25', '25.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(25.00000000 AS Decimal(19, 8))),
 (6, '4105', '', '0.01', '100.00', CAST(0.01000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8))),
 
 (7, '4101', '', '0.07', '3.50', CAST(0.07000000 AS Decimal(19, 8)), CAST(3.50000000 AS Decimal(19, 8))),
 (7, '4102', '', '0.07', '0.35', CAST(0.07000000 AS Decimal(19, 8)), CAST(0.35000000 AS Decimal(19, 8))),
 (7, '4113', '', '0.20', '0.80', CAST(0.20000000 AS Decimal(19, 8)), CAST(0.80000000 AS Decimal(19, 8))),
 (7, '4114', '', '0.25', '25.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(25.00000000 AS Decimal(19, 8))),
 (7, '4105', '', '0.01', '100.00', CAST(0.01000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8))),
 
 (6, '4101', 'USD', '0.07', '3.50', CAST(0.07000000 AS Decimal(19, 8)), CAST(3.50000000 AS Decimal(19, 8))),
 (6, '4102', 'USD', '0.07', '0.35', CAST(0.07000000 AS Decimal(19, 8)), CAST(0.35000000 AS Decimal(19, 8))),
 (6, '4113', 'USD', '0.20', '0.80', CAST(0.20000000 AS Decimal(19, 8)), CAST(0.80000000 AS Decimal(19, 8))),
 (6, '4114', 'USD', '0.25', '25.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(25.00000000 AS Decimal(19, 8))),
 (6, '4105', 'USD', '0.01', '100.00', CAST(0.01000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8))),
 
 (7, '4101', 'USD', '0.07', '3.50', CAST(0.07000000 AS Decimal(19, 8)), CAST(3.50000000 AS Decimal(19, 8))),
 (7, '4102', 'USD', '0.07', '0.35', CAST(0.07000000 AS Decimal(19, 8)), CAST(0.35000000 AS Decimal(19, 8))),
 (7, '4113', 'USD', '0.20', '0.80', CAST(0.20000000 AS Decimal(19, 8)), CAST(0.80000000 AS Decimal(19, 8))),
 (7, '4114', 'USD', '0.25', '25.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(25.00000000 AS Decimal(19, 8))),
 (7, '4105', 'USD', '0.01', '100.00', CAST(0.01000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8)))
 
 
-------------------------------------------------------------------------------------------------------------------------------- 

--Remove ref currency
DELETE FROM #var_tbl_StakeLevelGroupDetail
WHERE CurrencyCode IN (SELECT CurrencyCode FROM #var_tbl_ref_curr) 


--Copy data for Ref Currency
INSERT INTO #var_tbl_StakeLevelGroupDetail(GameGroupID, GameTypeID, CurrencyCode, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT sld.GameGroupID, sld.GameTypeID, ref.CurrencyCode, sld.MinLabel, sld.MaxLabel, sld.MinStake, sld.MaxStake
FROM #var_tbl_StakeLevelGroupDetail sld
    INNER JOIN #var_tbl_ref_curr ref ON ref.CurrencyCodeRef = sld.CurrencyCode


--Find StakeLevelId that has been insert into DB and update into table
UPDATE slvNew
SET slvNew.StakeLevelId = slv.StakeLevelID
FROM #var_tbl_StakeLevelGroupDetail slvNew
    INNER JOIN Exchange ex ON ex.Code = slvNew.CurrencyCode
    INNER JOIN StakeLevel sl ON sl.GameGroupId = slvNew.GameGroupID AND sl.ExchangeId = ex.ExchangeId 
    LEFT JOIN StakeLevelGroupDetail slv ON slv.GameTypeID = slvNew.GameTypeId AND slv.StakeLevelID = sl.StakeLevelId
    
    
--Update data
UPDATE slv
SET slv.MinLabel = slvNew.MinLabel, slv.MaxLabel = slvNew.MaxLabel,
    slv.MinStake = slvNew.MinStake, slv.MaxStake = slvNew.MaxStake
FROM StakeLevelGroupDetail slv
    INNER JOIN #var_tbl_StakeLevelGroupDetail slvNew ON slvNew.StakeLevelId = slv.StakeLevelId AND slvNew.GameTypeID = slv.GameTypeId
WHERE  slv.MinLabel <> slvNew.MinLabel 
    OR slv.MaxLabel <> slvNew.MaxLabel
    OR slv.MinStake <> slvNew.MinStake 
    OR slv.MaxStake <> slvNew.MaxStake

    
--Insert data for StakeLevel 
INSERT INTO StakeLevel (GameTypeID,   ExchangeId,   GameGroupID)
SELECT @var_bettype, ex.ExchangeID, tmpsld.GameGroupID
FROM Exchange ex
    INNER JOIN 
        (
            SELECT DISTINCT GameGroupID, CurrencyCode 
            FROM #var_tbl_StakeLevelGroupDetail
            WHERE StakeLevelId IS NULL
        ) AS tmpsld ON tmpsld.CurrencyCode = ex.Code
    LEFT JOIN StakeLevel slExist ON slExist.GameTypeID = @var_bettype AND slExist.ExchangeID = ex.ExchangeID AND slExist.GameGroupID = tmpsld.GameGroupID
WHERE slExist.StakeLevelID IS NULL
    

--Insert data for StakeLevelGroupDetail
INSERT INTO StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT sl.StakeLevelID, sld.GameTypeID, sld.MinLabel, sld.MaxLabel, sld.MinStake, sld.MaxStake
FROM Exchange ex
    INNER JOIN #var_tbl_StakeLevelGroupDetail sld ON ex.Code = sld.CurrencyCode
    INNER JOIN StakeLevel sl ON sl.GameGroupID = sld.GameGroupID AND ex.ExchangeID = sl.ExChangeID 
WHERE sld.StakeLevelId IS NULL
