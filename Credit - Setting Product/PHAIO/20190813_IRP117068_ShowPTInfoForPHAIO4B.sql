/*
	Created: Winnie
	Date: 2019-08-13
	Task: set active Sport_Bettype_Reference_Setting to show pt info for PHAIO 4B
	DB: DBTXN/bodb02
*/

UPDATE [Sport_Bettype_Reference_Setting] WITH(UPDLOCK,ROWLOCK)
	SET isActive = 1
WHERE SportType =1 AND bettype BETWEEN 470 AND 497
	AND bettype NOT IN(470,471,474,488,489,491,492)
	AND site='All'

