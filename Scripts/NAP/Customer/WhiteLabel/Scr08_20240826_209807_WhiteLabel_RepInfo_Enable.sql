/*<info serverAlias="IRS_DBAGE-bodb02,IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20240916@Tacy	
	Task: In-House
	DB: IRS_DBAGE-bodb02,IRS_DBACC-bodb02,IRS_DBTP-bodb02,DBCustRepl-ReplCustDB
	
	Revisions:
		- 20240916@Tacy: Created [RedmineID: #209807]

	Example:			
*/

--WhiteLabelInfo
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'WhiteLabelInfo')
BEGIN
	UPDATE RepInfo
	SET active = 1
	WHERE [group] = 12
		AND [name] =  'WhiteLabelInfo'
END
ELSE
BEGIN  
	SELECT 'WhiteLabelInfo not exists !!!'
END
GO
/***************************************************************************/


--WhiteLabelSetting (no need to add on DBACC)
IF @@SERVERNAME NOT IN ('SITDB06', 'DB061', 'DB062')
BEGIN
	IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'WhiteLabelSetting')
	BEGIN
		UPDATE RepInfo
		SET active = 1
		WHERE [group] = 12
			AND [name] =  'WhiteLabelSetting'
	END
	ELSE
	BEGIN  
		SELECT 'WhiteLabelSetting not exists !!!'
	END
END
GO
/***************************************************************************/



