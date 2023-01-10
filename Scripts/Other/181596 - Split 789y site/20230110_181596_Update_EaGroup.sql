/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/
/*
	Created: 20230110@Tacy
	Task: Update Site=NULL for 789y's GroupName
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBPOL.NAP_UserControl
*/

UPDATE g
SET Site=NULL
FROM eaGroup g WITH (ROWLOCK, UPDLOCK)
WHERE Site LIKE '%789y%'