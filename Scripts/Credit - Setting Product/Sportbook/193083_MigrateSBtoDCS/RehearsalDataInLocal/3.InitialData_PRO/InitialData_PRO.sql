/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240301@Helios
	Task: All sites - Remove Myanmar Odds from backend sites  [#201396]
	DB: DBCust/CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	-------------------------Remove Discount MyanmarOdds------------------------------------
	-- 1.ProductSettingDetail
	DELETE  
	FROM ProductSettingDetail WITH (ROWLOCK)
	WHERE ProductID = 1
	AND SettingType = 25
	AND SportType = 2
	AND BetType = 1

	-- 2.ProductSettingProfile
	DELETE
	FROM ProductSettingProfile  WITH (ROWLOCK)
	WHERE ProductID = 1
	AND SettingType = 25
	AND SportType = 2
	AND BetType = 1

	-- 3.ProductProfileSiteCurrency
	DELETE 
	FROM ProductProfileSiteCurrency WITH (ROWLOCK)
	WHERE ProductSettingID = 350


















