/*<info serverAlias="DBAGE-AgencyCashService"></info>*/
/*
	Created: 20250717@Eden
	Task: Grant permission [#223896]  
	DB: DBAGE-AgencyCashService
*/
USE AgencyCashService
GO
GRANT SELECT ON dbo.CashPromotion TO wsv_CashService;
GRANT SELECT ON dbo.CashPromotion TO asv_CashService;

GRANT SELECT ON dbo.CashPromotionLanguage TO wsv_CashService;
GRANT SELECT ON dbo.CashPromotionLanguage TO asv_CashService;
--
GRANT SELECT ON dbo.CashPromotionDetail TO wsv_CashService;
GRANT SELECT ON dbo.CashPromotionDetail TO asv_CashService;
