/*<info serverAlias="IRS_DBSIC-AgencyCashService,IRS_DBAGE-AgencyCashService" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250714@Johnson	
	Task: In-House
	DB: IRS_DBSIC-AgencyCashService,IRS_DBAGE-AgencyCashService

	Revisions:
		- 20250714@Johnson: Created [RedmineID: #232347]

	Example:			
*/
DECLARE @GroupID INT = 140--local group

IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CashPromotion')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @GroupID,'CashPromotion',0,'repupdatetime',0,'PromotionID|SiteDBGroupID','Repl_GetCashPromotion_Dist','Repl_PutCashPromotion',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CashPromotion exists !!!'
END

/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CashPromotionDetail')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @GroupID,'CashPromotionDetail',0,'repupdatetime',0,'PromotionID|SiteDBGroupID|ProductCategoryID','Repl_GetCashPromotionDetail_Dist','Repl_PutCashPromotionDetail',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CashPromotionDetail exists !!!'
END

/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CashPromotionLanguage')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT @GroupID,'CashPromotionLanguage',0,'repupdatetime',0,'PromotionID|SiteDBGroupID|LanguageCode','Repl_GetCashPromotionLanguage_Dist','Repl_PutCashPromotionLanguage',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'CashPromotionLanguage exists !!!'
END
GO
/***************************************************************************/



