/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
    Created: Luke
    Date: 20231002
    Task : Offer 10 Upcoming Sports for Winter Sports [Redmine: #194661]
    DB: DBTXN/bodb02
*/

UPDATE s
SET isActive = 1
FROM Sport_Bettype_Reference_Setting s WITH (ROWLOCK, UPDLOCK)
WHERE SportType BETWEEN 57 AND 66

