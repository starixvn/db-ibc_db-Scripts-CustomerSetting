/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20240605@Johnson
	Task: Enable job sync for rep in-house [#199915]
		BetSetting_Agent,BetSetting_Member
	DB: DBAGE-bodb02,DBTP-bodb02
*/
USE bodb02
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=1
WHERE [name] IN ('BetSetting_Agent','BetSetting_Member')
GO
