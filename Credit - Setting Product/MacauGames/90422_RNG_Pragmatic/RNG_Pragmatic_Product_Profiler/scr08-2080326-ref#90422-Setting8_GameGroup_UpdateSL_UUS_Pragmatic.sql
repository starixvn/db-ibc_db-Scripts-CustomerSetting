/*
    Created: Vicky
    Date: 20180326
    Task: init stakeleve for PP
    DB:DBCust/CustDB
*/
IF OBJECT_ID('tempdb..#var_tbl_StakeLevelGroupDetail') IS NOT NULL DROP TABLE #var_tbl_StakeLevelGroupDetail
GO
IF OBJECT_ID('tempdb..#var_tbl_ref_curr') IS NOT NULL DROP TABLE #var_tbl_ref_curr
GO
IF OBJECT_ID('tempdb..#var_tbl_data') IS NOT NULL DROP TABLE #var_tbl_data
GO
DECLARE @var_settypeType SMALLINT = 8,
        @var_productId TINYINT = 22,
        @var_sportType SMALLINT = 248,
        @var_bettype SMALLINT = 4101,
        @var_isLive BIT = 0
     
CREATE TABLE #var_tbl_StakeLevelGroupDetail (GameGroupID INT NOT NULL, CurrencyCode VARCHAR(3) NOT NULL, GameTypeID INT NOT NULL, 
                                              MinLabel VARCHAR(50) NOT NULL, MaxLabel VARCHAR(50) NOT NULL, 
                                              MinStake DECIMAL(19,8) NOT NULL, MaxStake DECIMAL(19,8) NOT NULL,
                                              PRIMARY KEY (GameGroupID, CurrencyCode, GameTypeID)
                                              )
                                              
--can contain currency and code                                              
CREATE TABLE #var_tbl_ref_curr (CurrencyCode VARCHAR(3), 
                                CurrencyCodeRef VARCHAR(3),
                                PRIMARY KEY (CurrencyCode, CurrencyCodeRef)
                                )                                        
                                

      
      
INSERT #var_tbl_StakeLevelGroupDetail
       (GameGroupID, CurrencyCode, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
VALUES   
  (6, 'UUS', 4107, '0.07', '3.50', CAST(0.07000000 AS Decimal(19, 8)), CAST(3.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4106, '0.07', '0.70', CAST(0.07000000 AS Decimal(19, 8)), CAST(0.70000000 AS Decimal(19, 8)))
, (6, 'UUS', 4111, '0.20', '2.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(2.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4117, '0.25', '25.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(25.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4101, '0.01', '100.00', CAST(0.01000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4105, '0.05', '5.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4119, '0.38', '3.80', CAST(0.38000000 AS Decimal(19, 8)), CAST(3.80000000 AS Decimal(19, 8)))
, (6, 'UUS', 4109, '0.15', '6.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4103, '0.03', '3.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4115, '0.25', '10.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4104, '0.03', '15.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(15.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4113, '0.25', '10.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4120, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4102, '0.25', '50.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4114, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4118, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4110, '0.15', '1.50', CAST(0.15000000 AS Decimal(19, 8)), CAST(1.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4108, '0.09', '27.00', CAST(0.09000000 AS Decimal(19, 8)), CAST(27.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4116, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4112, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4121, '0.05', '100.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4122, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4145, '0.13', '6.50', CAST(0.13000000 AS Decimal(19, 8)), CAST(6.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4125, '0.15', '6.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4126, '0.13', '6.50', CAST(0.13000000 AS Decimal(19, 8)), CAST(6.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4124, '0.25', '5.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4136, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4159, '0.09', '4.50', CAST(0.09000000 AS Decimal(19, 8)), CAST(4.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4154, '0.30', '6.00', CAST(0.30000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4123, '0.20', '2.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(2.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4144, '0.09', '2.25', CAST(0.09000000 AS Decimal(19, 8)), CAST(2.25000000 AS Decimal(19, 8)))
, (6, 'UUS', 4127, '0.20', '2.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(2.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4153, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4133, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4138, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4129, '0.05', '2.50', CAST(0.05000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4157, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4146, '0.15', '3.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4152, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4134, '0.03', '7.50', CAST(0.03000000 AS Decimal(19, 8)), CAST(7.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4158, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4143, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4162, '0.20', '2.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(2.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4147, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4148, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4149, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4150, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4151, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4164, '0.07', '70.00', CAST(0.07000000 AS Decimal(19, 8)), CAST(70.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4142, '0.25', '5.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4160, '0.25', '5.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4131, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4130, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4163, '0.05', '5.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4139, '0.30', '3.00', CAST(0.30000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4161, '0.10', '5.00', CAST(0.10000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4140, '0.40', '4.00', CAST(0.40000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4137, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4141, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4155, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4156, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4132, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (6, 'UUS', 4128, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (6, 'UUS', 4135, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4107, '0.07', '7.00', CAST(0.07000000 AS Decimal(19, 8)), CAST(7.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4106, '0.07', '0.70', CAST(0.07000000 AS Decimal(19, 8)), CAST(0.70000000 AS Decimal(19, 8)))
, (7, 'UUS', 4111, '0.20', '2.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(2.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4117, '0.25', '50.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4101, '0.01', '200.00', CAST(0.01000000 AS Decimal(19, 8)), CAST(200.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4105, '0.05', '10.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4119, '0.38', '3.80', CAST(0.38000000 AS Decimal(19, 8)), CAST(3.80000000 AS Decimal(19, 8)))
, (7, 'UUS', 4109, '0.15', '12.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(12.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4103, '0.03', '6.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4115, '0.25', '20.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(20.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4104, '0.03', '30.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(30.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4113, '0.25', '20.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(20.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4120, '0.50', '10.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4102, '0.25', '100.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4114, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4118, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4110, '0.15', '3.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4108, '0.09', '54.00', CAST(0.09000000 AS Decimal(19, 8)), CAST(54.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4116, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4112, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4121, '0.05', '200.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(200.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4122, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4145, '0.13', '13.00', CAST(0.13000000 AS Decimal(19, 8)), CAST(13.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4125, '0.15', '12.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(12.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4126, '0.13', '13.00', CAST(0.13000000 AS Decimal(19, 8)), CAST(13.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4124, '0.25', '10.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4136, '0.25', '5.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4159, '0.09', '9.00', CAST(0.09000000 AS Decimal(19, 8)), CAST(9.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4154, '0.30', '12.00', CAST(0.30000000 AS Decimal(19, 8)), CAST(12.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4123, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4144, '0.09', '4.50', CAST(0.09000000 AS Decimal(19, 8)), CAST(4.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4127, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4153, '0.20', '8.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(8.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4133, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4138, '0.50', '10.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4129, '0.05', '5.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4157, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
GO
print 'Processed 100 total records'
INSERT #var_tbl_StakeLevelGroupDetail
       (GameGroupID, CurrencyCode, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
VALUES   

 (7, 'UUS', 4146, '0.15', '6.00', CAST(0.15000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4152, '0.20', '8.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(8.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4134, '0.03', '15.00', CAST(0.03000000 AS Decimal(19, 8)), CAST(15.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4158, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4143, '0.25', '5.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4162, '0.20', '4.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4147, '0.20', '8.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(8.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4148, '0.20', '8.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(8.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4149, '0.20', '8.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(8.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4150, '0.20', '8.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(8.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4151, '0.20', '8.00', CAST(0.20000000 AS Decimal(19, 8)), CAST(8.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4164, '0.07', '140.00', CAST(0.07000000 AS Decimal(19, 8)), CAST(140.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4142, '0.25', '10.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4160, '0.25', '10.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4131, '0.25', '5.00', CAST(0.25000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4130, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4163, '0.05', '10.00', CAST(0.05000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4139, '0.30', '3.00', CAST(0.30000000 AS Decimal(19, 8)), CAST(3.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4161, '0.10', '10.00', CAST(0.10000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4140, '0.40', '4.00', CAST(0.40000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4137, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4141, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4155, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4156, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4132, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))
, (7, 'UUS', 4128, '0.25', '2.50', CAST(0.25000000 AS Decimal(19, 8)), CAST(2.50000000 AS Decimal(19, 8)))
, (7, 'UUS', 4135, '0.50', '5.00', CAST(0.50000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)))


-------------------------------------------------------------------------------------------------------------------------------- 
CREATE TABLE #var_tbl_data (Currency VARCHAR(10) NOT NULL, GameGroupID INT NOT NULL, GameTypeID INT NOT NULL, 
                                  MinLabel VARCHAR(50) NOT NULL, MaxLabel VARCHAR(50) NOT NULL, 
                                  MinStake DECIMAL(19,8) NOT NULL, MaxStake DECIMAL(19,8) NOT NULL,
                                  StakeLevelId INT
                                  PRIMARY KEY (Currency, GameGroupID, GameTypeID)
                                  )
                                              
--Remove ref currency
DELETE FROM #var_tbl_StakeLevelGroupDetail
WHERE CurrencyCode IN (SELECT CurrencyCode FROM #var_tbl_ref_curr) 


UPDATE #var_tbl_StakeLevelGroupDetail
SET CurrencyCode = ''
WHERE CurrencyCode='UUS'

UPDATE #var_tbl_ref_curr
SET CurrencyCode = ''
WHERE CurrencyCode='UUS'


--get all detail currency from code
INSERT INTO #var_tbl_data(Currency, GameGroupID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT ex.Currency, tmpSld.GameGroupID,tmpSld.GameTypeID, tmpSld.MinLabel, tmpSld.MaxLabel, tmpSld.MinStake, tmpSld.MaxStake
FROM Exchange ex
    INNER JOIN #var_tbl_StakeLevelGroupDetail tmpSld ON tmpSld.CurrencyCode = ex.Code
  
 
--Copy data for Ref Currency (only CODE)
INSERT INTO #var_tbl_data(Currency,GameGroupID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT ex.Currency, tmpSld.GameGroupID, tmpSld.GameTypeID, tmpSld.MinLabel, tmpSld.MaxLabel, tmpSld.MinStake, tmpSld.MaxStake
FROM #var_tbl_ref_curr refcur
    INNER JOIN Exchange ex ON ex.code = refcur.CurrencyCode
    INNER JOIN #var_tbl_StakeLevelGroupDetail tmpSld ON tmpSld.CurrencyCode = refcur.CurrencyCodeRef

   
--Update data for particular currency
UPDATE data  
SET data.MinLabel = tmpsld.MinLabel, data.MaxLabel = tmpsld.MaxLabel,
    data.MinStake = tmpsld.MinStake, data.MaxStake = tmpsld.MaxStake
FROM #var_tbl_data data
    INNER JOIN #var_tbl_ref_curr currPar ON data.currency = currPar.CurrencyCode
    INNER JOIN #var_tbl_StakeLevelGroupDetail tmpsld ON tmpsld.CurrencyCode = currPar.CurrencyCodeRef AND data.GameGroupID = tmpsld.GameGroupID AND data.GameTypeID = tmpsld.GameTypeID
    
    
     
   
    
--Find StakeLevelId that has been insert into DB and update into table
UPDATE slvNew
SET slvNew.StakeLevelId = slv.StakeLevelID
FROM #var_tbl_data slvNew
    INNER JOIN Exchange ex ON ex.currency = slvNew.Currency
    INNER JOIN StakeLevel sl ON sl.GameGroupId = slvNew.GameGroupID AND sl.ExchangeId = ex.ExchangeId 
    LEFT JOIN StakeLevelGroupDetail slv ON slv.GameTypeID = slvNew.GameTypeId AND slv.StakeLevelID = sl.StakeLevelId
    
    
    
--Update data
UPDATE slv
SET slv.MinLabel = slvNew.MinLabel, slv.MaxLabel = slvNew.MaxLabel,
    slv.MinStake = slvNew.MinStake, slv.MaxStake = slvNew.MaxStake
FROM StakeLevelGroupDetail slv
    INNER JOIN #var_tbl_data slvNew ON slvNew.StakeLevelId = slv.StakeLevelId AND slvNew.GameTypeID = slv.GameTypeId
WHERE  slv.MinLabel <> slvNew.MinLabel 
    OR slv.MaxLabel <> slvNew.MaxLabel
    OR slv.MinStake <> slvNew.MinStake 
    OR slv.MaxStake <> slvNew.MaxStake

    
--Insert data for StakeLevel if it is not exist
INSERT INTO StakeLevel (GameTypeID,   ExchangeId,   GameGroupID)
SELECT 4101, ex.exchangeid, iSlv.GameGroupID
FROM (
        SELECT DISTINCT GameGroupID, Currency
        FROM #var_tbl_data
        WHERE StakeLevelId IS NULL
     ) AS iSlv 
     INNER JOIN Exchange ex ON ex.Currency = iSlv.Currency
     LEFT JOIN StakeLevel slExist ON slExist.GameTypeID = 4101 AND slExist.ExchangeID = ex.exchangeid AND slExist.GameGroupID = iSlv.GameGroupID
WHERE slExist.StakeLevelID IS NULL



--Insert data for StakeLevelGroupDetail
INSERT INTO StakeLevelGroupDetail (StakeLevelID, GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT sl.StakeLevelID, iData.GameTypeID, iData.MinLabel, iData.MaxLabel, iData.MinStake, iData.MaxStake
FROM #var_tbl_data iData
    INNER JOIN Exchange ex ON iData.Currency = ex.currency
    INNER JOIN StakeLevel sl ON sl.GameGroupID = iData.GameGroupID AND ex.exchangeid = sl.ExChangeID 
WHERE iData.StakeLevelId IS NULL



