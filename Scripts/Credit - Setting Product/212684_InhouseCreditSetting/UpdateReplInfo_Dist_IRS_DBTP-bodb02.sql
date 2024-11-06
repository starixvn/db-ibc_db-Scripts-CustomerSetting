/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241107@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20241107@Johnson: Created [RedmineID: #]

	Example:			
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustAgent')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'CustAgent'
END
ELSE
BEGIN  
	SELECT 'CustAgent not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustMaster')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'CustMaster'
END
ELSE
BEGIN  
	SELECT 'CustMaster not exists !!!'
END
GO
/***************************************************************************/

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustMaxPayoutSetting_Agent')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustMaxPayoutSetting_Agent'
END
ELSE
BEGIN  
	SELECT 'CustMaxPayoutSetting_Agent not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustMaxPayoutSetting_Member')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustMaxPayoutSetting_Member'
END
ELSE
BEGIN  
	SELECT 'CustMaxPayoutSetting_Member not exists !!!'
END
GO

/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custSub')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'custSub'
END
ELSE
BEGIN  
	SELECT 'custSub not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSuper')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'CustSuper'
END
ELSE
BEGIN  
	SELECT 'CustSuper not exists !!!'
END
GO


/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustDiscount3rd_Agent')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustDiscount3rd_Agent'
END
ELSE
BEGIN  
	SELECT 'CustDiscount3rd_Agent not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustDiscount3rd_Member')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustDiscount3rd_Member'
END
ELSE
BEGIN  
	SELECT 'CustDiscount3rd_Member not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTGroupSetting3rd_Member')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustPTGroupSetting3rd_Member'
END
ELSE
BEGIN  
	SELECT 'CustPTGroupSetting3rd_Member not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTSetting3rd_Agent')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustPTSetting3rd_Agent'
END
ELSE
BEGIN  
	SELECT 'CustPTSetting3rd_Agent not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTSetting3rd_Member')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustPTSetting3rd_Member'
END
ELSE
BEGIN  
	SELECT 'CustPTSetting3rd_Member not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTTemplate')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustPTTemplate'
END
ELSE
BEGIN  
	SELECT 'CustPTTemplate not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustPTTemplateDetail')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustPTTemplateDetail'
END
ELSE
BEGIN  
	SELECT 'CustPTTemplateDetail not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustQRCode')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'CustQRCode'
END
ELSE
BEGIN  
	SELECT 'CustQRCode not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSettingMode3rd')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustSettingMode3rd'
END
ELSE
BEGIN  
	SELECT 'CustSettingMode3rd not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustStakeLevel_Agent')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustStakeLevel_Agent'
END
ELSE
BEGIN  
	SELECT 'CustStakeLevel_Agent not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustStakeLevel_Member')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustStakeLevel_Member'
END
ELSE
BEGIN  
	SELECT 'CustStakeLevel_Member not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustSuperProfile')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustSuperProfile'
END
ELSE
BEGIN  
	SELECT 'CustSuperProfile not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustWinLossLimit_Agent')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustWinLossLimit_Agent'
END
ELSE
BEGIN  
	SELECT 'CustWinLossLimit_Agent not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustWinLossLimit_Member')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustWinLossLimit_Member'
END
ELSE
BEGIN  
	SELECT 'CustWinLossLimit_Member not exists !!!'
END
GO
/***************************************************************************/

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'custInfo')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'custInfo'
END
ELSE
BEGIN  
	SELECT 'custInfo not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Customer')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 11
		AND [name] =  'Customer'
END
ELSE
BEGIN  
	SELECT 'Customer not exists !!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'CustProductStatus')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'CustProductStatus'
END
ELSE
BEGIN  
	SELECT 'CustProductStatus not exists !!!'
END
GO
/***************************************************************************/





