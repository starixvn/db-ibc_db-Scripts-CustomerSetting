/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Created: 20240710@Tacy
	Task: Insert VR reference setting for Baseball - PHASE 1
		https://nexdev.net/issues/207510 [RedmineID: #207510]
	Database: DBTXN/bodb02
*/
USE bodb02
GO

INSERT INTO Sport_Bettype_Reference_VirtualRate 
	([SportType], [BetType], [SportTypeRefVirtualRate], [BetTypeRefVirtualRate], [isActive])
	SELECT 8, 8800, 8,	1,	0
UNION ALL
	SELECT 8, 8801, 8,	3,	0
UNION ALL
	SELECT 8, 8802, 8,	3,	0
UNION ALL
	SELECT 8, 8803, 8,	3,	0
UNION ALL
	SELECT 8, 8804, 8,	21,	0
UNION ALL
	SELECT 8, 8806, 8,	7,	0
UNION ALL
	SELECT 8, 8807, 8,	8,	0
UNION ALL
	SELECT 8, 8808, 8,	8,	0
UNION ALL
	SELECT 8, 8809, 8,	8,	0
UNION ALL
	SELECT 8, 8811, 8,	7,	0
UNION ALL
	SELECT 8, 8812, 8,	8,	0
UNION ALL
	SELECT 8, 8814, 8,	20,	0
UNION ALL
	SELECT 8, 8815, 8,	20,	0
UNION ALL
	SELECT 8, 8816, 8,	3,	0
UNION ALL
	SELECT 8, 8821, 8,	20,	0
UNION ALL
	SELECT 8, 8823, 8,	7,	0
UNION ALL
	SELECT 8, 8824, 8,	8,	0
UNION ALL
	SELECT 8, 8827, 8,	20,	0
GO