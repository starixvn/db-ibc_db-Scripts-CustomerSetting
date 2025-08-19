/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
	Created: 20250819@Virgil
	Task: Insert VR reference setting of Player Props AIO for Basketball [Redmine: #235372]   
	Database: DBTXN-bodb02
*/
USE bodb02
GO

INSERT INTO Sport_Bettype_Reference_VirtualRate (SportType, BetType, SportTypeRefVirtualRate, BetTypeRefVirtualRate, isActive)
VALUES
(2, 654, 2, 3, 1),
(2, 657, 2, 3, 1),
(2, 660, 2, 3, 1),
(2, 663, 2, 3, 1),
(2, 666, 2, 3, 1),
(2, 668, 2, 3, 1),
(2, 670, 2, 3, 1),
(2, 672, 2, 3, 1),
(2, 673, 2, 3, 1),
(2, 674, 2, 3, 1),
(2, 677, 2, 20, 1),
(2, 679, 2, 20, 1),
(2, 680, 2, 20, 1),
(2, 681, 2, 20, 1),
(2, 682, 2, 20, 1),
(2, 683, 2, 20, 1),
(2, 684, 2, 20, 1)
