/*
	Created: Johnson
	Date: 20181219
	Task: set IsActive = 1 for PT reference
	DB: DBTXN/bodb02
*/

--10 rows affected
UPDATE sport_bettype_Reference_Setting WITH(UPDLOCK,ROWLOCK)
SET isActive = 1
WHERE sporttype = 164
