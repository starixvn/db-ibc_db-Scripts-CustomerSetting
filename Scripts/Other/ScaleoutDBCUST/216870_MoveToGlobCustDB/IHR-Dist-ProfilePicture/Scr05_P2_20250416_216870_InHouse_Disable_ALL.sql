/*<info serverAlias="DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250116@Tacy	
	Task: Disable In-house on ALL servers
	DB: DBAGE-bodb02,DBBOF-bodb02,DBTXN-custdb,DBACC-bodb02,DBTP-bodb02
	
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
	SET active = 0
		,[group] = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN 11 ELSE 12 END
		,get_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN get_sp ELSE get_sp + '_Dist' END
		,put_sp = CASE WHEN @@SERVERNAME IN ('db62\devdb06','DB92\TESTDBTP', 'DBTP10C') THEN put_sp + '_Dist' ELSE put_sp END
	WHERE [name] =  'ProfilePicture'
END