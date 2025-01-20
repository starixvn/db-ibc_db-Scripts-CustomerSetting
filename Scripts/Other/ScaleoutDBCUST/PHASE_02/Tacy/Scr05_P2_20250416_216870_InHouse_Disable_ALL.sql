/*<info serverAlias="IRS_DBG-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Disable In-house on ALL servers
	DB: IRS_DBG-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]
*/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
	Site
	SiteDBConfig
	SportBettypeSettingMatrix
*/
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'Site')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'Site'
END
ELSE
BEGIN  
	SELECT 'Site not exists !!!'
END

IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SiteDBConfig')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [name] =  'SiteDBConfig'
END
ELSE
BEGIN  
	SELECT 'SiteDBConfig not exists !!!'
END

-- Not replicate to ReplCustDB
IF @@SERVERNAME NOT IN ('DB-60\DevDBcust', 'TESTDBCUST', 'SITIHRDISTC1', 'IHRDISTC1') 
BEGIN
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'SportBettypeSettingMatrix')
	BEGIN
		UPDATE RepInfo
		SET active = 0
		WHERE [name] =  'SportBettypeSettingMatrix'
	END
	ELSE
	BEGIN  
		SELECT 'SportBettypeSettingMatrix not exists !!!'
	END
END