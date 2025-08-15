/*<info serverAlias="DBCUST-AgencyCashService" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250714@Johnson	
	Task: In-House
	DB: DBCUST-AgencyCashService
	
	Revisions:
		- 20250714@Johnson: Created [RedmineID: #232347]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CashPromotion_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CashPromotion_Del_InHouse]
	(
		[PromotionID] [INT] NOT NULL
		,[SiteDBGroupID] [SMALLINT] NOT NULL
		) ON [CashService]

	ALTER TABLE [dbo].[CashPromotion_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CashPromotion_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CashPromotion_Del_InHouse_RepUpdateTime] ON [dbo].[CashPromotion_Del_InHouse]([RepUpdateTime] ASC) ON [CashService]
END
ELSE 
BEGIN
	SELECT 'Table CashPromotion_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CashPromotionDetail_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CashPromotionDetail_Del_InHouse]
	(
		[PromotionID] [INT] NOT NULL
		,[SiteDBGroupID] [SMALLINT] NOT NULL
		,[ProductCategoryID] [TINYINT] NOT NULL
		) ON [CashService]

	ALTER TABLE [dbo].[CashPromotionDetail_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CashPromotionDetail_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CashPromotionDetail_Del_InHouse_RepUpdateTime] ON [dbo].[CashPromotionDetail_Del_InHouse]([RepUpdateTime] ASC) ON [CashService]
END
ELSE 
BEGIN
	SELECT 'Table CashPromotionDetail_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CashPromotionLanguage_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CashPromotionLanguage_Del_InHouse]
	(
		[PromotionID] [INT] NOT NULL
		,[SiteDBGroupID] [SMALLINT] NOT NULL
		,[LanguageCode] [VARCHAR](10) NOT NULL
		) ON [CashService]

	ALTER TABLE [dbo].[CashPromotionLanguage_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CashPromotionLanguage_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CashPromotionLanguage_Del_InHouse_RepUpdateTime] ON [dbo].[CashPromotionLanguage_Del_InHouse]([RepUpdateTime] ASC) ON [CashService]
END
ELSE 
BEGIN
	SELECT 'Table CashPromotionLanguage_Del_InHouse exists!!!'
END
GO
/***************************************************************************/




