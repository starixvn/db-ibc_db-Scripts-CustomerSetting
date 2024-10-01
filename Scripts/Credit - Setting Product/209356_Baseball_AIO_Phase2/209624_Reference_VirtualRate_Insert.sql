/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20240820@Virgil
	Task: Insert VR reference setting for Baseball AIO Phase 2 [Redmine: #209356]   
	Database: DBTXN-bodb02
*/
USE bodb02
GO

INSERT INTO Sport_Bettype_Reference_VirtualRate (SportType, BetType, SportTypeRefVirtualRate, BetTypeRefVirtualRate, isActive)
VALUES
(8, 8829, 8, 1, 1),
(8, 8830, 8, 3, 1),
(8, 8828, 8, 20, 1),
(8, 8832, 8, 20, 1)
