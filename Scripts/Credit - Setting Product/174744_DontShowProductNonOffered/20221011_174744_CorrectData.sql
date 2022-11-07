/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221107
	Task: Macau Games - Update value ProductStatusSiteCurrency [#RM:174744]
	DB: DBCUST/CustDB 
*/

	USE CustDB
	GO

	DELETE a 
	FROM ProductStatusSiteCurrency a WITH(ROWLOCK) 
	WHERE ((SportType  = 171 AND (SiteID = 13 AND Currency = 15))
		  OR
		  (SportType  IN (171, 200)  AND ((SiteID = 16 AND Currency = 2 ) OR
										 (SiteID = 20 AND Currency = 13) OR
										 (SiteID = 21 AND Currency = 13) OR
										 (SiteID = 188 AND Currency = 2)))
		 )

	--SELECT a.* 
	--FROM ProductStatusSiteCurrency a WITH(ROWLOCK,UPDLOCK) 
	--WHERE ((SportType  = 171 AND (SiteID = 13 AND Currency = 15))
	--	  OR
	--	  (SportType  IN (171, 200)  AND ((SiteID = 16 AND Currency = 2 ) OR
	--									 (SiteID = 20 AND Currency = 13) OR
	--									 (SiteID = 21 AND Currency = 13) OR
	--									 (SiteID = 188 AND Currency = 2)))
	--	 )
	--ORDER BY SiteID, SportType