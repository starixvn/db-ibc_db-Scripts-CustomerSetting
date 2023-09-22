/*<info serverAlias="DBSIG-CustDB"></info>*/
/*
	Created: 20230727@Helios
	Task: Sync data ProductSettingDetai From DBCust-CustDB  [#189389] 
	DB: DBSIG-CustDB
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	-- Clear Data
	DELETE
	FROM ProductSettingDetail WITH (ROWLOCK)

	-- Sync Data FROM DBCust-CustDB
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
	SELECT 
           [SettingType]
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
	FROM DBCUST.CustDB.dbo.ProductSettingDetail WITH (NOLOCK)
