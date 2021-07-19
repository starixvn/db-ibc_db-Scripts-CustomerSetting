/*
	Created: 20181212@Elodie
	Task: Insert product profile for CN88
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @SettingStatus TINYINT, @ProductID INT, @MaxDiscount DECIMAL(9,8), @MaxPT TINYINT, @IntervalValuePT DECIMAL(19,8), @IntervalValueComm DECIMAL(19,8)
SELECT @SettingStatus = 0 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 1
SELECT @MaxDiscount = 0.01
SELECT @MaxPT = 90
SELECT @IntervalValuePT = 1
SELECT @IntervalValueComm = 0.0005

DELETE FROM CS_ProductSettingDetail
DELETE FROM CS_ByteSeq

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
(10				 , 2			  ,	2    , 5      , 0     , @ProductID, NULL, @MaxDiscount,@IntervalValueComm  , 4           , 2           , 8         , @SettingStatus, 2),
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
SELECT 'DiscountAgent', 2, 5, 0, 0, 20 UNION ALL 
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
SELECT 'DiscountMember', 2, 5, 0, 0, 8 UNION ALL 
SELECT 'DiscountMember', 2, 9999, 0, 0, 9 UNION ALL 
SELECT 'DiscountMember', 99, 1, 0, 0, 10 UNION ALL 
SELECT 'DiscountMember', 99, 1, 1, 0, 11 UNION ALL 
SELECT 'DiscountMember', 99, 5, 0, 0, 12 UNION ALL 
SELECT 'DiscountMember', 99, 9999, 0, 0, 13 UNION ALL 
SELECT 'DiscountMember', 9999, 10, 0, 0, 14 

