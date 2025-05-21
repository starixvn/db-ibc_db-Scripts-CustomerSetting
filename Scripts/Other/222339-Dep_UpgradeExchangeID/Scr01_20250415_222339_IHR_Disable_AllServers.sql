/*<info serverAlias="IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,DBACC-bodb02"></info>*/
/*
	Created: 20250415@Tacy	
	Task: Disable - In-house on DBTP, Distributor, DBACC
	DB: IRS_DBTP-bodb02,DBCustRepl-ReplCustDB,DBACC-bodb02
	
	Revisions:
		- 20250415@Tacy: Created [RedmineID: #222339]
*/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Dep_ProductBetSetting')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'Dep_ProductBetSetting'
END
ELSE
BEGIN  
	SELECT 'Dep_ProductBetSetting not exists !!!'
END
