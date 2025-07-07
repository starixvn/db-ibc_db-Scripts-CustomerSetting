/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250714@Johnson	
	Task: In-House
	DB: DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250714@Johnson: Created [RedmineID: #232347]

	Example:			
*/
DECLARE @GroupID INT = 140--local group

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CashPromotion')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = @GroupID
		AND [name] =  'CashPromotion'
END
ELSE
BEGIN  
	SELECT 'CashPromotion not exists !!!'
END

/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CashPromotionDetail')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = @GroupID
		AND [name] =  'CashPromotionDetail'
END
ELSE
BEGIN  
	SELECT 'CashPromotionDetail not exists !!!'
END

/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CashPromotionLanguage')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = @GroupID
		AND [name] =  'CashPromotionLanguage'
END
ELSE
BEGIN  
	SELECT 'CashPromotionLanguage not exists !!!'
END
GO
/***************************************************************************/



