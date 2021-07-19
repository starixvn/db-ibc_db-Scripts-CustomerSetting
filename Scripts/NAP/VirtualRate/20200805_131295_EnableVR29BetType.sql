/*
	Date: 20200805
	Created: Winfred 
	Task: Update Active PT Reference [Redmine:131295]
	DB: DBTRANS/BODB02
*/
UPDATE s	
SET isActive = 1
FROM Sport_Bettype_Reference_Setting s WITH (ROWLOCK, UPDLOCK)
WHERE  SportType  = 2 
AND bettype BETWEEN 618 AND 646
  