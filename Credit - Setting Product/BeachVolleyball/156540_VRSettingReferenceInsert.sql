/*
	Created: Elodie
	Task: Insert Virtual Rate Setting References
	DB: DBTXN/bodb02
	Date: 2021071
*/ 
USE bodb02
GO

DELETE FROM Sport_Bettype_Reference_VirtualRate WHERE sporttype = 45

INSERT INTO Sport_Bettype_Reference_VirtualRate (SportType, BetType, SportTypeRefVirtualRate, BetTypeRefVirtualRate, isActive)
VALUES
(45, 1, 6, 1, 1),
(45, 2, 6, 2, 1),
(45, 3, 6, 3, 1),
(45, 20, 6, 20, 1)

SELECT * FROM Sport_Bettype_Reference_VirtualRate WHERE sporttype = 45