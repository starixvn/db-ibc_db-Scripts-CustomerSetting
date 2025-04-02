/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Created: 20250217@Winfred
	Task: Insert VR Add new bet types for Basketball
		https://nexdev.net/issues/217558 [RedmineID: #217558]
	Database: DBTXN/bodb02
*/
USE bodb02
GO

INSERT INTO Sport_Bettype_Reference_VirtualRate 
	([SportType], [BetType], [SportTypeRefVirtualRate], [BetTypeRefVirtualRate], [isActive])
			SELECT 2, 461, 2,	3,	0
UNION ALL	SELECT 2, 462, 2,	3,	0
UNION ALL	SELECT 2, 463, 2,	8,	0
UNION ALL	SELECT 2, 464, 2,	8,	0
UNION ALL	SELECT 2, 651, 2,	3,	0
UNION ALL	SELECT 2, 652, 2,	3,	0
GO