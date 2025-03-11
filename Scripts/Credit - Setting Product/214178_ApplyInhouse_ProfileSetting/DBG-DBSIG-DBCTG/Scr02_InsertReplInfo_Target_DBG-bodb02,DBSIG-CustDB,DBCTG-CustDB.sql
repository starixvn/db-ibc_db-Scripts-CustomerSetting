/*<info serverAlias="IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Tables Related:
		ProductProfileSiteCurrency
		ProductProfileSiteCurrency_UAT
		ProductSettingProfile
		ProductSettingProfile_UAT
		ProductStatusProfile
		ProductStatusSiteCurrency
		SportNonOfferedSiteCurrency			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductProfileSiteCurrency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductProfileSiteCurrency',0,'repupdatetime',0,'SiteID|Currency|ProductSettingID','Repl_GetProductProfileSiteCurrency_Dist','Repl_PutProductProfileSiteCurrency',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductProfileSiteCurrency exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductProfileSiteCurrency_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductProfileSiteCurrency_UAT',0,'repupdatetime',0,'SiteID|Currency|ProductSettingID','Repl_GetProductProfileSiteCurrency_UAT_Dist','Repl_PutProductProfileSiteCurrency_UAT',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductProfileSiteCurrency_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingProfile')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductSettingProfile',0,'repupdatetime',0,'ProductSettingID','Repl_GetProductSettingProfile_Dist','Repl_PutProductSettingProfile',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductSettingProfile exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSettingProfile_UAT')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductSettingProfile_UAT',0,'repupdatetime',0,'ProductSettingID','Repl_GetProductSettingProfile_UAT_Dist','Repl_PutProductSettingProfile_UAT',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductSettingProfile_UAT exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStatusProfile')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductStatusProfile',0,'repupdatetime',0,'Sporttype|Bettype','Repl_GetProductStatusProfile_Dist','Repl_PutProductStatusProfile',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductStatusProfile exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductStatusSiteCurrency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductStatusSiteCurrency',0,'repupdatetime',0,'SportType|BetType|Currency|SiteID','Repl_GetProductStatusSiteCurrency_Dist','Repl_PutProductStatusSiteCurrency',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductStatusSiteCurrency exists !!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportNonOfferedSiteCurrency')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'SportNonOfferedSiteCurrency',0,'repupdatetime',0,'SportType|BetType|Currency|SiteID','Repl_GetSportNonOfferedSiteCurrency_Dist','Repl_PutSportNonOfferedSiteCurrency',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'SportNonOfferedSiteCurrency exists !!!'
END
GO
/***************************************************************************/



