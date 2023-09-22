/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230819@Helios
	Task: Inital Data Setting  [#189389]
	DB: DBCust/CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	---------------------------1.ProductSettingDetail------------------------------------
	-- DEL DummySport in ProductSettingDetail
	DELETE
	FROM ProductSettingDetail WITH (ROWLOCK)
	WHERE ProductID = 41
	AND SportType = 9911

	-- DEL unused Setting in ProductSettingDetail
	DELETE
	FROM ProductSettingDetail WITH (ROWLOCK)
	WHERE ProductID = 41

	-- Clone Setting LiveCasino (PT, Comm, ProductStatus, WinLostLimit) ProductSettingDetail FROM ProductSettingDetail_UAT
	INSERT INTO [dbo].[ProductSettingDetail]
           ([SettingType]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[ProductID]
           ,[MaxPT]
           ,[MaxDiscount]
           ,[IsSync]
           ,[IsHidden]
           ,[IsDisabled]
           ,[SettingLevel]
           ,[DisplayOrder]
           ,[SettingStatus]
           ,[IntervalValue]
           ,[RealProductId]
           ,[MaxChoice]
           ,[ProductSettingID]
           ,[Parent_ProductSettingID]
           ,[Child_DisplayOrder]
           ,[SubType])
	
	SELECT [SettingType]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[ProductID]
           ,[MaxPT]
           ,[MaxDiscount]
           ,[IsSync]
           ,[IsHidden]
           ,[IsDisabled]
           ,[SettingLevel]
           ,[DisplayOrder]
           ,[SettingStatus]
           ,[IntervalValue]
           ,[RealProductId]
           ,[MaxChoice]
           ,[ProductSettingID]
           ,[Parent_ProductSettingID]
           ,[Child_DisplayOrder]
           ,[SubType]
	FROM ProductSettingDetail_UAT WITH (NOLOCK)
	WHERE ProductID = 41


	---------------------------2.ProductStatusProfile------------------------------------

	-- DEL Testing Bitmap
	DELETE
	FROM ProductStatusProfile WITH (ROWLOCK)
	WHERE Sporttype = 9911 
	AND BetType = 2400 
	AND bitmapOrder = 7

	-- UPD DUMMY SportType - BetType For BitMap AE Sexy
	UPDATE pp
		SET pp.Sporttype = 9911
		,	pp.Bettype   = 2400
	FROM ProductStatusProfile  pp WITH (ROWLOCK , UPDLOCK)
	WHERE Sporttype = 243
	AND Bettype = 3101
	AND bitmapOrder = 22

	-- DEL Old Bitmap
	DELETE
	FROM ProductStatusProfile WITH (ROWLOCK)
	WHERE Sporttype IN (211,225,233,239,241,242,244,159,170,236)
	AND BetType IN (2401,5601,3401,3501,3300,3201,3001,3151,3701,5701)



