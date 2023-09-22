/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230727@Helios
	Task: Inital Data Setting  [#189389]
	DB: DBCust/CustDB and all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo
*/


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

	---------------------------1.ProductSettingProfile_UAT------------------------------------

--> Step 1.1: Initial Data ProductSettingProfile_UAT

	-- Insert ProductSettingProfile_UAT
	DELETE	FROM ProductSettingProfile_UAT  WITH(ROWLOCK)

	INSERT INTO [dbo].[ProductSettingProfile_UAT]
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
	SELECT 
			 ProductSettingID
			,SettingType
			,SportType
			,BetType
			,IsLive
			,ProductID
			,MaxPT
			,MaxDiscount
			,IsSync
			,IsHidden
			,IsDisabled
			,SettingLevel
			,DisplayOrder
			,SettingStatus
			,IntervalValue
			,RealProductId
			,MaxChoice
			,Parent_ProductSettingID
			,Child_DisplayOrder
			,SubType
			,NULL -- GroupID
			,NULL -- GroupType
			,NULL -- GroupTypeOrder
			,NULL -- SubGroupID
			,NULL -- SubGroupOrder
			,NULL -- CreationStatus
			,NULL -- DisplayType
			,0  AS MarketType
	FROM ProductSettingDetail_UAT WITH (NOLOCK)


--> Step 1.2: Config MarketType
	UPDATE pp SET MarketType = 1
	FROM ProductSettingProfile_UAT pp WITH  (ROWLOCK,UPDLOCK)
	WHERE [ProductSettingID] IN (220,209)

	---------------------------2.ProductProfileSiteCurrency_UAT------------------------------------
--> Step 2.1: Initial Data ProductProfileSiteCurrency_UAT

	 DELETE
	 FROM ProductProfileSiteCurrency_UAT  WITH(ROWLOCK)
	 WHERE SiteID = 487

	INSERT INTO [dbo].[ProductProfileSiteCurrency_UAT]
           ([SiteID]
           ,[Currency]
           ,[ProductSettingID])
			SELECT 487 , 0 ,  209
UNION ALL	SELECT 487 , 0 ,  220
