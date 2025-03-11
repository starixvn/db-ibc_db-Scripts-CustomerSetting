/*<info serverAlias="IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBPRO-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20241225@Virgil	
	Task: Customer Setting - Apply In-house replication for profile setting tables
	DB: IRS_DBAGE-bodb02,IRS_DBBOF-bodb02,IRS_DBACC-bodb02,IRS_DBBAH-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBPRO-bodb02
	
	Revisions:
		- 20241225@Virgil: Created [RedmineID: #214117]

	Table Related: ProductSiteConfig			
*/
IF NOT EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProductSiteConfig')
BEGIN
	INSERT INTO RepInfo ([group],[name],active,version_key,version_type,unique_key,get_sp,put_sp,interval,back_fix,delayed_fix,batch_size) 
	SELECT 13,'ProductSiteConfig',0,'repupdatetime',0,'SiteID|ProductID','Repl_GetProductSiteConfig_Dist','Repl_PutProductSiteConfig',1000,10,60000,0
END
ELSE
BEGIN  
	SELECT 'ProductSiteConfig exists !!!'
END
GO
/***************************************************************************/



