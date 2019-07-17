/*
	Created: Winnie
	Date: 2019-07-17
	Task: set active Sport_Bettype_Reference_Setting to show pt info for PHAIO
	DB: DBTXN/bodb02
*/

update [Sport_Bettype_Reference_Setting] WITH(UPDLOCK,ROWLOCK)
set isActive = 1
where SportType =1 AND bettype BETWEEN 467 AND 469