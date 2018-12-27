/*
	Created: Johnson
	Date: 2018-12-27
	Task: set active Sport_Bettype_Reference_Setting to show pt info for sport 194
	DB: DBTXN/bodb02
*/

update Sport_Bettype_Reference_Setting WITH(UPDLOCK,ROWLOCK)
set isActive = 1
where SportType =194