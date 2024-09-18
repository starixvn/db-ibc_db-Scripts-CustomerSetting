/*<info serverAlias="DBAGE-bodb02, DBTP-bodb02"></info>*/
/*
	Created by: @Helios
	Date: 21/08/2024
	Task: Scale Out DBCUST - Move CustProfilePicture and ProfilePicture to DBcust - Migrate Data [Redmine:#209640]	
	DB: DBAGE-bodb02, DBTP-bodb02
*/

USE bodb02

UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active = 1
WHERE [name] IN ('ProfilePicture','CustProfilePicture') AND [group] = 1
GO
