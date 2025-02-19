/*<info serverAlias="IRS_DBTP-bodb02,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBWH-bodb02,IRS_DBACC-bodb02,IRS_DBAGE-bodb02,IRS_DBBAH-bodb02,IRS_DBBOF-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250224@Johnson	
	Task: In-House
	DB: IRS_DBTP-bodb02,IRS_DBG-bodb02,IRS_DBSIG-CustDB,IRS_DBCTG-CustDB,IRS_DBWH-bodb02,IRS_DBACC-bodb02,IRS_DBAGE-bodb02,IRS_DBBAH-bodb02,IRS_DBBOF-bodb02
	
	Revisions:
		- 20250224@Johnson: enable inhouse for customer/custinfo [RedmineID: #218124]

	Example:			
*/

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
