/*<info serverAlias="DBTXN-CustDB"></info>*/
/*
	Created: 20230727@Helios
	Task: Inital Data Setting  [#189389]
	DB: DBTXN-CustDB
*/


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


	---------------------------0.SportNonOfferedSiteCurrency------------------------------------

	--Step 0: Clone Data SportNonOfferedSiteCurrency From DBCust
 	INSERT INTO SportNonOfferedSiteCurrency (SportType,BetType,Currency,SiteID)
	SELECT SportType , BetType , Currency , SiteID
	FROM DBCUST.custdb.dbo.SportNonOfferedSiteCurrency WITH(NOLOCK)
	

