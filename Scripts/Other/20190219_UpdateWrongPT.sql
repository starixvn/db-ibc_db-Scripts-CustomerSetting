/*
	Created: Winnie
	Date: 20190219
	Task: Update wrong PT number game. RedmineID:#108062
	DB: DBCust/CustDB
*/
UPDATE Dep_Custsetting3rd WITH(ROWLOCK,UPDLOCK) 
	SET mpositiontaking=0
WHERE custid IN(11878224,
	11878229,
	11878251,
	11878784,
	11878810,
	11879079)
 AND sporttype=161
 
UPDATE Dep_Custsetting3rd WITH(ROWLOCK,UPDLOCK) 
	SET apositiontaking=0
WHERE custid =836207
 AND sporttype=161