/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: 02. Initial data for column SiteLabel on SIT/PRO
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE s
SET s.SiteLabel = CASE  WHEN site='789y'	THEN '789y'
						WHEN site='IBCIndo'	THEN 'IBCIndo'
						ELSE 'Nova88'
					END
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE isLicensee=0