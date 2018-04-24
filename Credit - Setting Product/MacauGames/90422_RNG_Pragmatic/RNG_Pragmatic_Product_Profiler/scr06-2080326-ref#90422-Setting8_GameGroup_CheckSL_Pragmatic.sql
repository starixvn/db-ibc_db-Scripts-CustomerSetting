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
     
CREATE TABLE #var_tbl_StakeLevelGroupDetail (GameGroupID INT NOT NULL, CurrencyCode VARCHAR(3) NOT NULL, GameTypeID INT NOT NULL, 
                                              MinLabel VARCHAR(50) NOT NULL, MaxLabel VARCHAR(50) NOT NULL, 
                                              MinStake DECIMAL(19,8) NOT NULL, MaxStake DECIMAL(19,8) NOT NULL,
                                              StakeLevelId INT,
                                              PRIMARY KEY (GameGroupID, CurrencyCode, GameTypeID)
                                              )
CREATE TABLE #var_tbl_ref_curr (CurrencyCode VARCHAR(3), 
                                CurrencyCodeRef VARCHAR(3),
                                PRIMARY KEY (GameGroupID, CurrencyCode, GameTypeID)
                                )                                              

INSERT INTO #var_tbl_ref_curr
VALUES --group 1
       ('AUD', 'USD')
      ,('EUR', 'USD')
      ,('MMK', 'USD')
      ,('PTU', 'USD')
      ,('PTS', 'USD')
      ,('NZD', 'USD')
      ,('SGD', 'USD')
      ,('BND', 'USD')
      ,('CAD', 'USD')
      ,('CHF', 'USD')
      
      --group 3
      ,('HKD', 'CNY')
      ,('PTH', 'CNY')
      ,('DKK', 'CNY')
      ,('NOK', 'CNY')
      ,('SEK', 'CNY')
      
      --group 4
      ,('KHR', 'MYR')
      ,('PLN', 'MYR')
      ,('RON', 'MYR')
      ,('SEK', 'MYR')
      ,('SEK', 'MYR')
      
      --group 5
      ,('PHP', 'THB')
      ,('TWD', 'THB')
      
      --group 9
      ,('RUB', 'INR')
      
      
INSERT #var_tbl_StakeLevelGroupDetail
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
 
-------------------------------------------------------------------------------------------------------------------------------- 

SELECT 'error', refCur.CurrencyCodeRef
FROM #var_tbl_ref_curr refCur
WHERE refCur.CurrencyCodeRef NOT IN (SELECT DISTINCT CurrencyCode FROM #var_tbl_StakeLevelGroupDetail)

SELECT GameGroupID, CurrencyCode, count(*) as c
FROM #var_tbl_StakeLevelGroupDetail
GROUP BY GameGroupID, CurrencyCode
HAVING c <> 62