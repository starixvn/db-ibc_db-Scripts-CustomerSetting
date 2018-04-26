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
                                              
CREATE TABLE #var_tbl_dataInsert (GameGroupID INT NOT NULL, Currency VARCHAR(3) NOT NULL, GameTypeID INT NOT NULL, 
                                              MinLabel VARCHAR(50) NOT NULL, MaxLabel VARCHAR(50) NOT NULL, 
                                              MinStake DECIMAL(19,8) NOT NULL, MaxStake DECIMAL(19,8) NOT NULL,
                                              StakeLevelId INT,
                                              PRIMARY KEY (GameGroupID, Currency, GameTypeID)
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


--get all currency from code
INSERT INTO #var_tbl_dataInsert(Currency, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT ex.Currency, tmpSld.GameTypeID, tmpSld.MinLabel, tmpSld.MaxLabel, tmpSld.MinStake, tmpSld.MaxStake
FROM Exchange ex
    INNER JOIN #var_tbl_StakeLevelGroupDetail tmpSld ON tmpSld.CurrencyCode = ex.Code
  

--Copy data for Ref Currency with only CODE
INSERT INTO #var_tbl_dataInsert(Currency, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT ex.Currency, tmpSld.GameTypeID, tmpSld.MinLabel, tmpSld.MaxLabel, tmpSld.MinStake, tmpSld.MaxStake
FROM #var_tbl_ref_curr refcur
    INNER JOIN Exchange ex ON ex.code = refcur.CurrencyCode
    INNER JOIN #var_tbl_StakeLevelGroupDetail tmpSld ON tmpSld.CurrencyCode = refcur.CurrencyCodeRef
    
    
    
--Update data for particular currency
UPDATE dis  
SET dis.MinLabel = tmpsld.MinLabel, dis.MaxLabel = tmpsld.MaxLabel,
    dis.MinStake = tmpsld.MinStake, dis.MaxStake = tmpsld.MaxStake
FROM #var_tbl_dataInsert dis
    INNER JOIN #var_tbl_ref_curr currPar ON dis.currency = currPar.CurrencyCode
    INNER JOIN #var_tbl_StakeLevelGroupDetail tmpsld ON tmpsld.CurrencyCode = currPar.CurrencyCodeRef
    
    
    
    
--Find StakeLevelId that has been insert into DB and update into table
UPDATE slvNew
SET slvNew.StakeLevelId = slv.StakeLevelID
FROM #var_tbl_dataInsert slvNew
    INNER JOIN Exchange ex ON ex.currency = slvNew.Currency
    INNER JOIN StakeLevel sl ON sl.GameGroupId = slvNew.GameGroupID AND sl.ExchangeId = ex.ExchangeId 
    LEFT JOIN StakeLevelGroupDetail slv ON slv.GameTypeID = slvNew.GameTypeId AND slv.StakeLevelID = sl.StakeLevelId
    
    
    
--Update data
UPDATE slv
SET slv.MinLabel = slvNew.MinLabel, slv.MaxLabel = slvNew.MaxLabel,
    slv.MinStake = slvNew.MinStake, slv.MaxStake = slvNew.MaxStake
FROM StakeLevelGroupDetail slv
    INNER JOIN #var_tbl_dataInsert slvNew ON slvNew.StakeLevelId = slv.StakeLevelId AND slvNew.GameTypeID = slv.GameTypeId
WHERE  slv.MinLabel <> slvNew.MinLabel 
    OR slv.MaxLabel <> slvNew.MaxLabel
    OR slv.MinStake <> slvNew.MinStake 
    OR slv.MaxStake <> slvNew.MaxStake

    
--Insert data for StakeLevel 
INSERT INTO StakeLevel (GameTypeID,   ExchangeId,   GameGroupID)
SELECT @var_bettype, iSlv.Currency, iSlv.GameGroupID
FROM (
        SELECT DISTINCT GameGroupID, Currency
        FROM #var_tbl_dataInsert
        WHERE StakeLevelId IS NULL
     ) AS iSlv 
    LEFT JOIN StakeLevel slExist ON slExist.GameTypeID = @var_bettype AND slExist.ExchangeID = iSlv.Currency AND slExist.GameGroupID = iSlv.GameGroupID
WHERE slExist.StakeLevelID IS NULL
    


--Insert data for StakeLevelGroupDetail
INSERT INTO StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT sl.StakeLevelID, iData.GameTypeID, iData.MinLabel, iData.MaxLabel, iData.MinStake, iData.MaxStake
FROM #var_tbl_dataInsert iData
    INNER JOIN Exchange ex ON iData.Currency = ex.currency
    INNER JOIN StakeLevel sl ON sl.GameGroupID = iData.GameGroupID AND ex.exchangeid = sl.ExChangeID 
WHERE iData.StakeLevelId IS NULL



