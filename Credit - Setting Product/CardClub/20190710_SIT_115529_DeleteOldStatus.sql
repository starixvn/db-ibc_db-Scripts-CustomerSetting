	/*
	Created: Winnie
	Date: 20190617
	Task:CardClub. delete Status Profile  RedmineID:#115322
	DB: DBCust/CustDB

*/
DELETE FROM ProductStatusProfile WITH(ROWLOCK,UPDLOCK) WHERE Sporttype=165