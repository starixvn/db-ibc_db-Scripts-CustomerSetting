/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: 20231010@Tacy
	Task: In-House [RedmineID: #194332]
	DB: DBACC-bodb02,DBTP-bodb02
*/
USE bodb02
GO

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=0
WHERE [name]='Dep_ProductStakeLevelGroup'
GO
