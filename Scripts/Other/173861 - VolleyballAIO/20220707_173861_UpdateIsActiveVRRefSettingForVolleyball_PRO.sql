/*<info serverAlias="dbtxn-bodb02"></info>*/

/*
	Created: 20220719@Tacy
	Task: Update active -  VR reference setting for Volleyball
		https://nexdev.net/issues/173861 [RedmineID: #173861]
	Database: dbtxn/bodb02
*/

UPDATE Sport_Bettype_Reference_VirtualRate WITH(ROWLOCK, UPDLOCK)
SET isActive=1
WHERE SportType = 6 AND isActive = 0 
AND bettype IN (3918, 219, 220, 701, 704, 705, 706, 401, 402, 3901, 3902, 3903, 3904, 3905, 3906, 3907, 3908, 3909, 3912, 3914, 3916)
GO