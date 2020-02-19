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
SELECT @ProductID = 39 --SA Gaming
SELECT @IsSync = 1
SELECT @IsHidden = 0
SELECT @IsDisabled = 0

SELECT * INTO #TmpProductSettingDetail
FROM ProductSettingDetail P WITH (NOLOCK)
WHERE P.SportType = 211 -- Allbet

UPDATE T
SET T.SportType = 244, T.BetType = 3001, T.ProductID = @ProductID, T.SettingStatus = @SettingStatus
FROM #TmpProductSettingDetail T WITH (ROWLOCK, UPDLOCK)

INSERT INTO	dbo.ProductSettingDetail
		(	SettingType, SportType, BetType, IsLive, ProductID, MaxPT, MaxDiscount, IsSync, IsHidden, IsDisabled, SettingLevel, DisplayOrder, SettingStatus, IntervalValue)
SELECT *
FROM #TmpProductSettingDetail T WITH (NOLOCK)
WHERE T.ProductID = @ProductID

DROP TABLE #TmpProductSettingDetail




