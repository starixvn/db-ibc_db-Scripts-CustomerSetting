/*<info serverAlias="DBCustRepl-ReplCustDB,DBTP-bodb02,DBACC-bodb02"></info>*/
/*
	Created by: 20250113@Tacy
	Task: Service In-house - Disable [Redmine:#216609] 
	DB:	DBCustRepl-ReplCustDB,DBTP-bodb02,DBACC-bodb02
*/

--BetSetting_Agent
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetSetting_Agent')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [group] = 12
		AND [name] =  'BetSetting_Agent'
END
ELSE
BEGIN  
	SELECT 'BetSetting_Agent not exists !!!'
END
GO

--BetSetting_Member
IF EXISTS (SELECT * FROM dbo.RepInfo WITH (NOLOCK) WHERE [name] = 'BetSetting_Member')
BEGIN
	UPDATE RepInfo
	SET active = 0
	WHERE [group] = 12
		AND [name] =  'BetSetting_Member'
END
ELSE
BEGIN  
	SELECT 'BetSetting_Member not exists !!!'
END
GO