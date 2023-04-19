/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/
/*
	Created: 20230110@Tacy
	Task: Update Site=NULL on [eaGroup]
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBPOL.NAP_UserControl
*/

UPDATE g
SET Site=NULL
FROM eaGroup g WITH (ROWLOCK, UPDLOCK)