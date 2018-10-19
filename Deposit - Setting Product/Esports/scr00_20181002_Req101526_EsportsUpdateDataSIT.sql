/*
	Created: Winnie
	Date: 20181019
	Task: Update data for QC
	DB: DBCust/CustDB
*/

UPDATE CustBetSetting3rd_member WITH(ROWLOCK,UPDLOCK)
	SET minbet = 12,maxbet = 999,maxpermatch = 10000
WHERE CustID in(19520136,14552292) and SportType = 43
