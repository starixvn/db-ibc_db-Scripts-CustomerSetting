/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20231211
	Task:  WE Live Casino - Implement customer setting [RedmineID: #195886]
	DB: DBCUST/CustDB
*/

DECLARE @Sporttype SMALLINT = 228,
		@Bettype SMALLINT = 10300,
		@RealProductID	SMALLINT = 80

UPDATE s
SET s.RealProductID = @RealProductID
FROM SportNonOfferedSiteCurrency s WITH (ROWLOCK, UPDLOCK)
WHERE Sporttype = @Sporttype AND BetType = @Bettype
