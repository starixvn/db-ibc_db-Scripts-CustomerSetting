/*<info serverAlias="DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Enable In-house on ALL servers
	DB: DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]

	Tables:
		ProfilePicture
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--ProfilePicture : DBAGE | DBTP
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'ProfilePicture')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [name] =  'ProfilePicture'
END
