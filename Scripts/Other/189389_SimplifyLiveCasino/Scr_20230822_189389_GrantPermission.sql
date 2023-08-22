/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20230601@Eden
	Task: Grant permission for some object [#189389]
	
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
GRANT SELECT ON dbo.ProductSettingType TO bodbExtAccNet
GRANT SELECT ON dbo.SportBettypeSettingMatrix TO bodbExtAccNet
GRANT SELECT ON dbo.f_CustSetting_ProductSettingDetailSel TO bodbExtAccNet


