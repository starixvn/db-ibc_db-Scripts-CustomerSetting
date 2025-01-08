/*<info serverAlias="DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBTXN-CustDB,DBBOF-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20122024@Helios 
	Task : Update DatabaseName RepInfo_CleanData Of table CustProfilePicture [#209640] 
	DB: DBCUST-CustDB,DBACC-bodb02,DBAGE-bodb02,DBTXN-CustDB,DBBOF-bodb02,DBTP-bodb02
*/

IF EXISTS (SELECT 1 FROM RepInfo_CleanData cd WITH (NOLOCK) WHERE TableName IN ('CustProfilePicture','ProfilePicture') AND DatabaseName = 'bodb_Credit')
BEGIN
	UPDATE cd
	SET cd.DatabaseName = 'CustDB'
	FROM RepInfo_CleanData cd WITH (ROWLOCK, UPDLOCK) 
	WHERE TableName IN ('CustProfilePicture','ProfilePicture') 
	AND DatabaseName = 'bodb_Credit'
END
--Checked
--SELECT * FROM RepInfo_CleanData cd WITH (NOLOCK) WHERE TableName IN ('CustProfilePicture','ProfilePicture') AND DatabaseName = 'CustDB'