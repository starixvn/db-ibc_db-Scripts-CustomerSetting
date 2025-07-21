/*<info serverAlias="dbrepl-ReplDB,DBTP-bodb02,DBSIC-bodb02"></info>*/
/*
	Created: 20250421@Eden
	Task: Enable IHR of CashTransaction Table [#RedmineID:#223896]
	DB: dbrepl-ReplDB,DBTP-bodb02,DBSIC-bodb02
*/
UPDATE t
SET t.Active = 1
FROM RepInfo t WITH(ROWLOCK,UPDLOCK)
WHERE [Name] = 'CashTransaction'

SELECT * FROM RepInfo WITH(NOLOCK) WHERE [Name] = 'CashTransaction'
