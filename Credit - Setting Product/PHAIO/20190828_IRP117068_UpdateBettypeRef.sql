
/*
	Created: Winnie
	Date: 2019-08-28
	Task: Update betyperef to 1 for bettypes of Bet Radar . RedmineID:#117068
	DB: DBTXN/bodb02
*/
UPDATE Sport_Bettype_Reference WITH(ROWLOCK,UPDLOCK)
	SET BettypeRef=1
WHERE bettype in (206,207,208,209) AND isLicensee=0