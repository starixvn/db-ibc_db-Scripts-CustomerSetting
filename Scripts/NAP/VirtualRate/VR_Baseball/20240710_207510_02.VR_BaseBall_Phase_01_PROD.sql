/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Created: 20240710@Tacy
	Task: Update active -  VR reference setting for Baseball - PHASE 1
		https://nexdev.net/issues/207510 [RedmineID: #207510]
	Database: DBTXN/bodb02
*/
USE bodb02
GO

UPDATE Sport_Bettype_Reference_VirtualRate WITH(ROWLOCK, UPDLOCK)
SET isActive=1
WHERE SportType = 8 AND isActive = 0 
AND bettype BETWEEN 8800 AND 8827
GO