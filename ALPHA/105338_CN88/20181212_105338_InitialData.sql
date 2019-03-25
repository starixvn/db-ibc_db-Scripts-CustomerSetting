/*
	Created: 20181212@Elodie
	Task: Insert product profile for CN88
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DELETE FROM CS_ProductSettingDetail
DELETE FROM CS_ByteSeq
DELETE FROM CS_CommTemplate
DELETE FROM CS_GroupConfig
DELETE FROM CS_ProductBetSetting

DECLARE @SettingStatus TINYINT, @ProductID INT, @MaxDiscount DECIMAL(9,8), @MaxPT TINYINT, @IntervalValuePT DECIMAL(19,8), @IntervalValueComm DECIMAL(19,8)
SELECT @SettingStatus = 0 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 1
SELECT @MaxDiscount = 0.01
SELECT @MaxPT = 70
SELECT @IntervalValuePT = 1
SELECT @IntervalValueComm = 0.0005

INSERT INTO	dbo.CS_ProductSettingDetail
(ProductSettingId, SettingType, SportType, BetType, IsLive, ProductId, MaxPT, MaxDiscount, IntervalValue, SettingLevel, DisplayOrder, ChildOrder, SettingStatus, LayoutType)
VALUES	
--PT Setting																																				
(1				 , 1			  ,	1    , 1      , 0     , @ProductID, @MaxPT, NULL     , 1                   , 2           , 1           , 1         , @SettingStatus, NULL),
(2				 , 1			  ,	9998 , 81     , 0     , @ProductID, @MaxPT, NULL     , 1                   , 2           , 1           , 2         , @SettingStatus, NULL),
--Comm	
(3				 , 2			  ,	1    , 1      , 0     , @ProductID, NULL, NULL       ,@IntervalValueComm   , 4           , 2           , 1         , @SettingStatus, 1),
(4				 , 2			  ,	1    , 1      , 1     , @ProductID, NULL, NULL       ,@IntervalValueComm   , 4           , 2           , 2         , @SettingStatus, 1),
(5				 , 2			  ,	1    , 5      , 0     , @ProductID, NULL, @MaxDiscount,@IntervalValueComm  , 4           , 2           , 3         , @SettingStatus, 2),
(6				 , 2			  ,	1    , 9999   , 0     , @ProductID, NULL, @MaxDiscount,@IntervalValueComm  , 4           , 2           , 4         , @SettingStatus, 2),
(7				 , 2			  ,	1    , 9999   , 1     , @ProductID, NULL, @MaxDiscount,@IntervalValueComm  , 4           , 2           , 5         , @SettingStatus, 2),
(8				 , 2			  ,	2    , 1      , 0     , @ProductID, NULL, NULL        ,@IntervalValueComm  , 4           , 2           , 6         , @SettingStatus, 1),
(9				 , 2			  ,	2    , 1      , 1     , @ProductID, NULL, NULL        ,@IntervalValueComm  , 4           , 2           , 7         , @SettingStatus, 1),
(10				 , 2			  ,	2    , 20     , 0     , @ProductID, NULL, @MaxDiscount,@IntervalValueComm  , 4           , 2           , 8         , @SettingStatus, 2),
(11				 , 2			  ,	2    , 9999   , 0     , @ProductID, NULL, @MaxDiscount,@IntervalValueComm  , 4           , 2           , 9         , @SettingStatus, 2),
(12				 , 2			  ,	99   , 1      , 0     , @ProductID, NULL, NULL        ,@IntervalValueComm  , 4           , 2           , 10        , @SettingStatus, 1),
(13				 , 2			  ,	99   , 1      , 1     , @ProductID, NULL, NULL        ,@IntervalValueComm  , 4           , 2           , 11        , @SettingStatus, 1),
(14				 , 2			  ,	99   , 5      , 0     , @ProductID, NULL, @MaxDiscount,@IntervalValueComm  , 4           , 2           , 12        , @SettingStatus, 2),
(15				 , 2			  ,	99   , 9999   , 0     , @ProductID, NULL, @MaxDiscount,@IntervalValueComm  , 4           , 2           , 13        , @SettingStatus, 2),	
(16				 , 2			  ,	9999 , 10     , 0     , @ProductID, NULL, @MaxDiscount,@IntervalValueComm  , 4           , 2           , 14        , @SettingStatus, 2),	
(17				 , 2			  ,	9998 , 81     , 0     , @ProductID, NULL, NULL		  ,NULL				   , 4           , 2           , 15        , @SettingStatus, 2),
(18				 , 2			  ,	9998 , 1501   , 0     , @ProductID, NULL, NULL		  ,NULL				   , 4           , 2           , 16        , @SettingStatus, 2),
(19				 , 2			  ,	9998 , 1201   , 0     , @ProductID, NULL, NULL		  ,NULL				   , 4           , 2           , 17        , @SettingStatus, 2)

INSERT INTO CS_ByteSeq (Type, SportType, BetType, IsLive, GroupId, ByteOrder)
SELECT 'PTSetting', 1, 1, 0, 0, 1 UNION ALL 
SELECT 'PTSetting', 9998, 81, 0, 0, 2 UNION ALL 
SELECT 'DiscountAgent', 1, 1, 0, 1, 1 UNION ALL 
SELECT 'DiscountAgent', 1, 1, 0, 2, 2 UNION ALL 
SELECT 'DiscountAgent', 1, 1, 0, 3, 3 UNION ALL 
SELECT 'DiscountAgent', 1, 1, 0, 4, 4 UNION ALL 
SELECT 'DiscountAgent', 1, 1, 1, 5, 5 UNION ALL 
SELECT 'DiscountAgent', 1, 1, 1, 6, 6 UNION ALL 
SELECT 'DiscountAgent', 1, 1, 1, 7, 7 UNION ALL 
SELECT 'DiscountAgent', 1, 1, 1, 8, 8 UNION ALL 
SELECT 'DiscountAgent', 1, 5, 0, 0, 9 UNION ALL 
SELECT 'DiscountAgent', 1, 9999, 0, 0, 10 UNION ALL 
SELECT 'DiscountAgent', 1, 9999, 1, 0, 11 UNION ALL 
SELECT 'DiscountAgent', 2, 1, 0, 9, 12 UNION ALL 
SELECT 'DiscountAgent', 2, 1, 0, 10, 13 UNION ALL 
SELECT 'DiscountAgent', 2, 1, 0, 11, 14 UNION ALL 
SELECT 'DiscountAgent', 2, 1, 0, 12, 15 UNION ALL 
SELECT 'DiscountAgent', 2, 1, 1, 13, 16 UNION ALL 
SELECT 'DiscountAgent', 2, 1, 1, 14, 17 UNION ALL 
SELECT 'DiscountAgent', 2, 1, 1, 15, 18 UNION ALL 
SELECT 'DiscountAgent', 2, 1, 1, 16, 19 UNION ALL 
SELECT 'DiscountAgent', 2, 20, 0, 0, 20 UNION ALL 
SELECT 'DiscountAgent', 2, 9999, 0, 0, 21 UNION ALL 
SELECT 'DiscountAgent', 99, 1, 0, 17, 22 UNION ALL 
SELECT 'DiscountAgent', 99, 1, 0, 18, 23 UNION ALL 
SELECT 'DiscountAgent', 99, 1, 0, 19, 24 UNION ALL 
SELECT 'DiscountAgent', 99, 1, 0, 20, 25 UNION ALL 
SELECT 'DiscountAgent', 99, 1, 1, 21, 26 UNION ALL 
SELECT 'DiscountAgent', 99, 1, 1, 22, 27 UNION ALL 
SELECT 'DiscountAgent', 99, 1, 1, 23, 28 UNION ALL 
SELECT 'DiscountAgent', 99, 1, 1, 24, 29 UNION ALL 
SELECT 'DiscountAgent', 99, 5, 0, 0, 30 UNION ALL 
SELECT 'DiscountAgent', 99, 9999, 0, 0, 31 UNION ALL 
SELECT 'DiscountAgent', 9999, 10, 0, 0, 32 UNION ALL 
SELECT 'DiscountMember', 1, 1, 0, 0, 1 UNION ALL 
SELECT 'DiscountMember', 1, 1, 1, 0, 2 UNION ALL 
SELECT 'DiscountMember', 1, 5, 0, 0, 3 UNION ALL 
SELECT 'DiscountMember', 1, 9999, 0, 0, 4 UNION ALL 
SELECT 'DiscountMember', 1, 9999, 1, 0, 5 UNION ALL 
SELECT 'DiscountMember', 2, 1, 0, 0, 6 UNION ALL 
SELECT 'DiscountMember', 2, 1, 1, 0, 7 UNION ALL 
SELECT 'DiscountMember', 2, 20, 0, 0, 8 UNION ALL 
SELECT 'DiscountMember', 2, 9999, 0, 0, 9 UNION ALL 
SELECT 'DiscountMember', 99, 1, 0, 0, 10 UNION ALL 
SELECT 'DiscountMember', 99, 1, 1, 0, 11 UNION ALL 
SELECT 'DiscountMember', 99, 5, 0, 0, 12 UNION ALL 
SELECT 'DiscountMember', 99, 9999, 0, 0, 13 UNION ALL 
SELECT 'DiscountMember', 9999, 10, 0, 0, 14 

INSERT INTO dbo.CS_CommTemplate (ValueId, Value)
SELECT 1, 0 UNION ALL 
SELECT 2, 0.0005 UNION ALL 
SELECT 3, 0.001 UNION ALL 
SELECT 4, 0.0015 UNION ALL 
SELECT 5, 0.002 UNION ALL 
SELECT 6, 0.0025 UNION ALL 
SELECT 7, 0.003 UNION ALL 
SELECT 8, 0.0035 UNION ALL 
SELECT 9, 0.004 UNION ALL 
SELECT 10, 0.0045 UNION ALL 
SELECT 11, 0.005 UNION ALL 
SELECT 12, 0.0055 UNION ALL 
SELECT 13, 0.006 UNION ALL 
SELECT 14, 0.0065 UNION ALL 
SELECT 15, 0.007 UNION ALL 
SELECT 16, 0.0075 UNION ALL 
SELECT 17, 0.008 UNION ALL 
SELECT 18, 0.0085 UNION ALL 
SELECT 19, 0.009 UNION ALL 
SELECT 20, 0.0095 UNION ALL 
SELECT 21, 0.01 UNION ALL 
SELECT 22, 0.0105 UNION ALL 
SELECT 23, 0.011 UNION ALL 
SELECT 24, 0.0115 UNION ALL 
SELECT 25, 0.012 UNION ALL 
SELECT 26, 0.0125 UNION ALL 
SELECT 27, 0.013 UNION ALL 
SELECT 28, 0.0135 UNION ALL 
SELECT 29, 0.014 UNION ALL 
SELECT 30, 0.0145 UNION ALL 
SELECT 31, 0.015 UNION ALL 
SELECT 32, 0.0155 UNION ALL 
SELECT 33, 0.016 UNION ALL 
SELECT 34, 0.0165 UNION ALL 
SELECT 35, 0.017 UNION ALL 
SELECT 36, 0.0175 UNION ALL 
SELECT 37, 0.018 UNION ALL 
SELECT 38, 0.0185 UNION ALL 
SELECT 39, 0.019 UNION ALL 
SELECT 40, 0.0195 UNION ALL 
SELECT 41, 0.02 UNION ALL 
SELECT 42, 0.0205 UNION ALL 
SELECT 43, 0.021 UNION ALL 
SELECT 44, 0.0215 UNION ALL 
SELECT 45, 0.022 UNION ALL 
SELECT 46, 0.0225

INSERT INTO dbo.CS_GroupConfig (GroupId, SportType, BetType, IsLive, GroupName, uGroup, MaxValue)
SELECT 1, 1, 1, 0,'A', 'A', 0.0225 UNION ALL 
SELECT 2, 1, 1, 0,'B', 'B', 0.015 UNION ALL 
SELECT 3, 1, 1, 0,'C', 'C', 0.01 UNION ALL 
SELECT 4, 1, 1, 0,'D', 'D', 0.0075 UNION ALL 
SELECT 5, 1, 1, 1,'A', 'A', 0.0225 UNION ALL 
SELECT 6, 1, 1, 1,'B', 'B', 0.015 UNION ALL 
SELECT 7, 1, 1, 1,'C', 'C', 0.01 UNION ALL 
SELECT 8, 1, 1, 1,'D', 'D', 0.0075 UNION ALL 
SELECT 9, 2, 1, 0,'A', 'A', 0.0225 UNION ALL 
SELECT 10, 2, 1, 0,'B', 'B', 0.015 UNION ALL 
SELECT 11, 2, 1, 0,'C', 'C', 0.01 UNION ALL 
SELECT 12, 2, 1, 0,'D', 'D', 0.0075 UNION ALL 
SELECT 13, 2, 1, 1,'A', 'A', 0.0225 UNION ALL 
SELECT 14, 2, 1, 1,'B', 'B', 0.015 UNION ALL 
SELECT 15, 2, 1, 1,'C', 'C', 0.01 UNION ALL 
SELECT 16, 2, 1, 1,'D', 'D', 0.0075 UNION ALL 
SELECT 17, 99, 1, 0,'A', 'A', 0.0225 UNION ALL 
SELECT 18, 99, 1, 0,'B', 'B', 0.015 UNION ALL 
SELECT 19, 99, 1, 0,'C', 'C', 0.01 UNION ALL 
SELECT 20, 99, 1, 0,'D', 'D', 0.0075 UNION ALL 
SELECT 21, 99, 1, 1,'A', 'A', 0.0225 UNION ALL 
SELECT 22, 99, 1, 1,'B', 'B', 0.015 UNION ALL 
SELECT 23, 99, 1, 1,'C', 'C', 0.01 UNION ALL 
SELECT 24, 99, 1, 1,'D', 'D', 0.0075
     
INSERT INTO dbo.CS_ProductBetSetting (SportType, BetType, IsLive, Currency, MinBet, MaxBet, MaxPerEvent)
SELECT SportType, BetType, IsLive, e.exchangeid, 1000, 10000, 100000
FROM CS_ProductSettingDetail ps WITH (NOLOCK)
	CROSS JOIN dbo.exchange e WITH (NOLOCK)
WHERE settingType = 2 AND e.exchangeid = 81

--SELECT * FROM dbo.CS_GroupConfig
--DELETE FROM dbo.CS_GroupConfig
--DELETE FROM dbo.CS_CommTemplate
--DELETE ps 
--FROM dbo.CS_ProductBetSetting ps 
--	INNER JOIN CS_ProductSettingDetail pd ON pd.BetType = ps.BetType AND pd.IsLive = ps.IsLive AND pd.SportType = ps.SportType
--WHERE SettingType = 2

--DELETE FROM CS_ProductSettingDetail
--DELETE FROM CS_ByteSeq