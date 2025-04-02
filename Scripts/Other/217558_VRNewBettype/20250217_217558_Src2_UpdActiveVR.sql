/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Created: 20250217@Winfred
	Task: Update active -  VR Add new bet types for Basketball
		https://nexdev.net/issues/217558 [RedmineID: #217558]
	Database: DBTXN/bodb02
*/
USE bodb02
GO

UPDATE Sport_Bettype_Reference_VirtualRate WITH(ROWLOCK, UPDLOCK)
SET isActive=1
WHERE SportType = 2 AND isActive = 0 
AND bettype IN ( 461, 462, 463, 464, 651, 652)
GO