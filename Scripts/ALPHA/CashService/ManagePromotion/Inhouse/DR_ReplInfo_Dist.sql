/*<info serverAlias="DBCUST-AgencyCashService" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250714@Johnson	
	Task: In-House
	DB: DBCUST-AgencyCashService
	
	Revisions:
		- 20250714@Johnson: Created [RedmineID: #232347]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CashPromotion')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CashPromotion',0,'repupdatetime',0,'PromotionID|SiteDBGroupID','DR_Repl_GetCashPromotion_Dist','DR_Repl_PutCashPromotion_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CashPromotion exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CashPromotionDetail')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CashPromotionDetail',0,'repupdatetime',0,'PromotionID|SiteDBGroupID|ProductCategoryID','DR_Repl_GetCashPromotionDetail_Dist','DR_Repl_PutCashPromotionDetail_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CashPromotionDetail exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE name = 'CashPromotionLanguage')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 0,'CashPromotionLanguage',0,'repupdatetime',0,'PromotionID|SiteDBGroupID|LanguageCode','DR_Repl_GetCashPromotionLanguage_Dist','DR_Repl_PutCashPromotionLanguage_Dist',1000,10,60000,0
END
ELSE
BEGIN 
	SELECT 'CashPromotionLanguage exists !!!'
END
GO
/***************************************************************************/
