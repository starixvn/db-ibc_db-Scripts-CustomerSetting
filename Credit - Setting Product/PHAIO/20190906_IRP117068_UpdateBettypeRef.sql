
/*
	Created: Winnie
	Date: 2019-09-06
	Task: Update betyperef to 7 for bettypes(207,209) of Bet Radar . RedmineID:#117068
	DB: DBTXN/bodb02
*/
UPDATE Sport_Bettype_Reference WITH(ROWLOCK,UPDLOCK)
	SET BettypeRef=7
WHERE Sporttype=1 AND bettype in (207,209) AND Site='All'