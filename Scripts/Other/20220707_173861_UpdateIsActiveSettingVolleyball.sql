/*<info serverAlias="dbtxn-bodb02"></info>*/

/*
	Created: 20220707@Tacy
	Task: Update isActive=1 for setting's Volleyball
		https://nexdev.net/issues/173861 [RedmineID: #173861]
	Database: dbtxn/bodb02
*/

UPDATE ref
SET isActive=1
FROM Sport_Bettype_Reference_Setting ref WITH (ROWLOCK, UPDLOCK)
WHERE ref.SportType=6 
AND ( ref.BetType BETWEEN 3900 AND 3917
	OR ref.BetType IN (154,219,220,701,704,705,706,401,402)
) 
GO