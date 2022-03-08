/*
	Created: Elodie
	Date: 2022-03-08
	Task: set active Sport_Bettype_Reference_Setting to show pt info for new bettype of Esport
	DB: DBTXN/bodb02
*/

UPDATE Sport_Bettype_Reference_Setting WITH(UPDLOCK,ROWLOCK)
SET isActive = 1
WHERE SportType = 43
	AND bettype BETWEEN 9089 AND 9142