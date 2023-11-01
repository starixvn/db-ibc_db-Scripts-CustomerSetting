/*<info serverAlias="DBTXN-bodb02"></info>*/
/*
    Created: Luke
    Date: 20231101
    Task : Integration - Muay Thai - Offer Moneyline Bet Type [Redmine: #195492]
    DB: DBTXN/bodb02
*/

UPDATE s
SET isActive = 1
FROM Sport_Bettype_Reference_Setting s WITH (ROWLOCK, UPDLOCK)
WHERE SportType = 44 AND Bettype = 20