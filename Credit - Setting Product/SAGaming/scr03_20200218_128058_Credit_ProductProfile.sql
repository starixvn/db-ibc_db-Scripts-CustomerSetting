/*
	Created: 20200218@Tiara
	Task: Insert product profile for SA Gaming
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @SettingStatus TINYINT, 
		@ProductID INT,	
		@IsSync BIT, 
		@IsHidden BIT, 
		@IsDisabled BIT 
	
SELECT @SettingStatus = 1 --0: Production, 1: UAT, 2: Hide
SELECT @ProductID = 41 --LiveCasino dummy product
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0

CREATE TABLE #TmpProductSettingDetail
(
	SettingType SMALLINT,
	SportType SMALLINT,
	BetType SMALLINT,
	IsLive BIT,
	ProductID TINYINT,
	MaxPT TINYINT,
	MaxDiscount DECIMAL (9, 8),
	IsSync BIT,
	IsHidden BIT,
	IsDisabled BIT,
	SettingLevel TINYINT,
	DisplayOrder TINYINT,
	SettingStatus TINYINT,
	IntervalValue DECIMAL (19, 8) 
)

INSERT INTO #TmpProductSettingDetail (SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
SELECT p.SettingType, 244, 3001, P.IsLive, @ProductID, P.MaxPT, P.MaxDiscount, @IsSync, @IsHidden, @IsDisabled, 2, P.DisplayOrder, P.SettingStatus, P.IntervalValue
FROM ProductSettingDetail P WITH (NOLOCK)
WHERE P.SportType = 211 -- SA Gaming copied from Allbet
UNION ALL
SELECT p.SettingType, 211, 2401, P.IsLive, @ProductID, P.MaxPT, P.MaxDiscount, @IsSync, @IsHidden, @IsDisabled, 2, P.DisplayOrder, P.SettingStatus, P.IntervalValue
FROM ProductSettingDetail P WITH (NOLOCK)
WHERE P.SportType = 211 -- New Allbet under dummy product copied from Allbet

INSERT INTO	dbo.ProductSettingDetail
		(SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
SELECT *
FROM #TmpProductSettingDetail T WITH (NOLOCK)
WHERE T.ProductID = @ProductID

DROP TABLE #TmpProductSettingDetail




