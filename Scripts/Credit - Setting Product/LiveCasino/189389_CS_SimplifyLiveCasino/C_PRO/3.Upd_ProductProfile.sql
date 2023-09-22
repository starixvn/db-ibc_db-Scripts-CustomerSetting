/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230819@Helios
	Task: Inital Data Setting  [#189389]
	DB: DBCust/CustDB and all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo 
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	---------------------------1.ProductSettingProfile------------------------------------
	
	-- Clear data ProductSettingProfile
	DELETE FROM [dbo].[ProductSettingProfile] WITH (ROWLOCK)

	-- INS ProductSettingProfile FROM ProductSettingProfile_UAT
	INSERT INTO [dbo].[ProductSettingProfile]
           ([ProductSettingID]
           ,[SettingType]
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
           ,[Parent_ProductSettingID]
           ,[Child_DisplayOrder]
           ,[SubType]
           ,[GroupID]
           ,[GroupType]
           ,[GroupTypeOrder]
           ,[SubGroupID]
           ,[SubGroupOrder]
           ,[CreationStatus]
           ,[DisplayType]
           ,[MarketType])
	SELECT * FROM ProductSettingProfile_UAT  WITH (NOLOCK)

	---------------------------2.ProductProfileSiteCurrency------------------------------------
	
	-- Clear data ProductProfileSiteCurrency
	DELETE FROM [dbo].[ProductProfileSiteCurrency] WITH (ROWLOCK)

	-- INS ProductProfileSiteCurrency FROM ProductProfileSiteCurrency_UAT
	INSERT INTO [dbo].[ProductProfileSiteCurrency]
           ([SiteID]
           ,[Currency]
           ,[ProductSettingID])

	SELECT SiteID 
		 , Currency 
		 , ProductSettingID
	FROM ProductProfileSiteCurrency_UAT WITH (NOLOCK)

