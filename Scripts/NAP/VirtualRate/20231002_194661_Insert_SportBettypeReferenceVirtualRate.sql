/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
    Created: Luke
    Date: 20231002
    Task : Offer 10 Upcoming Sports for Winter Sports [Redmine: #194661]
    DB: DBTXN/bodb02
*/

IF EXISTS(
	SELECT TOP 1 1 
	FROM Sport_Bettype_Reference_VirtualRate WITH (NOLOCK)
	WHERE SportType = 58 AND Bettype IN (7,8,12,21)
)
	RAISERROR('These settings already existed',16,1)
ELSE
	INSERT INTO Sport_Bettype_Reference_VirtualRate ([SportType], [BetType], [SportTypeRefVirtualRate], [BetTypeRefVirtualRate], [isActive])
	VALUES	
		(58, 7,	99, 7, 1),
		(58, 8, 99, 8, 1),
		(58, 12, 99, 12, 1),
		(58, 21, 99, 20, 1)
