/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Create/Alter Function and add to replications ( Version origin,xtest,xpre,UAT1,UAt2,UAT3,UAT4:  [#180640]
		f_CustSetting_ProductSettingDetailSel 
		f_CustSetting_SportBetTypeSettingSelect				
	DB: DBCust/CustDB and all replicated server of pub: CustDB_Customer_Info, CustDB_DBTrans_CustInfo
*/
GO
IF  EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[f_CustSetting_ProductSettingDetailSel]'))
DROP FUNCTION [dbo].f_CustSetting_ProductSettingDetailSel
GO
CREATE FUNCTION	dbo.f_CustSetting_ProductSettingDetailSel(@SettingStatus TINYINT)  
RETURNS TABLE
AS
/*
	Created:	20221121@Eden
	Database:	DBCust/CustDB,DBCTS/bodb02
	
	Revision:
		- 20221121@Eden: Init function [RedmineID: #180640]

	Param's Explanation:
	SELECT * FROM dbo.f_CustSetting_ProductSettingDetailSel(3)
*/
RETURN
	SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
				,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder, SubType
	FROM dbo.ProductSettingDetail WITH(NOLOCK)
	WHERE SettingStatus <= CASE WHEN @SettingStatus = 1 THEN 1
								WHEN @SettingStatus = 0 THEN 0
								ELSE NULL END 
		AND SettingStatus <> 2
	UNION ALL
	SELECT SettingType,SportType,BetType,IsLive,ProductID,MaxPT,MaxDiscount,IsSync,IsHidden,IsDisabled,SettingLevel,DisplayOrder
				,SettingStatus,IntervalValue,RealProductId,MaxChoice,ProductSettingID,Parent_ProductSettingID,Child_DisplayOrder, SubType
	FROM dbo.ProductSettingDetail_UAT WITH(NOLOCK)
	WHERE @SettingStatus = 3
		AND SettingStatus <> 2
GO

IF  EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[f_CustSetting_SportBetTypeSettingSelect]'))
	DROP FUNCTION [dbo].f_CustSetting_SportBetTypeSettingSelect
GO
CREATE FUNCTION dbo.f_CustSetting_SportBetTypeSettingSelect(@ProductID TINYINT, @SettingType SMALLINT, @SettingStatus TINYINT) 
RETURNS @SportBetTypeSetting TABLE (ProductID TINYINT, SportType SMALLINT, Bettype SMALLINT, IsLive BIT, SettingType SMALLINT, RealProductId TINYINT, SubType TINYINT)
/*
	Created by: Elodie
	Date: 20170317
	Task: Get setting of product
	DB: DBCust/CustDB, DBAGE/bodb02, DBACC/bodb02,DBTXN-CustDB
	Original: 
	
	Revisions:
		- 20170317@Elodie: Get setting of product
		- 20200403@Elodie: Get RealProductID [Redmine: #129440]
		- 20201009@Tina: Add new parameter @SettingStatus [Redmine: #143077]
		- 20221121@Eden: Unify RNG Lottery Customer Settings [RedmineID: #180640]
	Explanation's Param:
		@SettingStatus: 0: Pro, 1: UAT
		
*/   
BEGIN 
	IF @SettingStatus IN (1,0)
	BEGIN
		INSERT @SportBetTypeSetting(ProductID, SportType,Bettype,IsLive, SettingType, RealProductId, SubType)
		SELECT DISTINCT ProductID, SportType,Bettype,IsLive, SettingType, RealProductId, SubType
		FROM dbo.ProductSettingDetail WITH(NOLOCK)
		WHERE (@ProductID IS NULL OR ProductID = @ProductID ) AND (@SettingType IS NULL OR SettingType = @SettingType) 
				AND SettingStatus <= CASE WHEN @SettingStatus = 1 THEN 1 ELSE 0 END
	END
	ELSE IF @SettingStatus = 3
	BEGIN
		INSERT @SportBetTypeSetting(ProductID, SportType,Bettype,IsLive, SettingType, RealProductId, SubType)
		SELECT DISTINCT ProductID, SportType,Bettype,IsLive, SettingType, RealProductId , SubType
		FROM dbo.ProductSettingDetail_UAT WITH(NOLOCK)
		WHERE (@ProductID IS NULL OR ProductID = @ProductID ) AND (@SettingType IS NULL OR SettingType = @SettingType) 
			AND SettingStatus <> 2
	END
	
	RETURN
END
GO


