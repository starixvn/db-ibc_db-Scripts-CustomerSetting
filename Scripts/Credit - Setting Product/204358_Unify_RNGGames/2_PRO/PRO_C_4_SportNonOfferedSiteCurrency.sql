/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date:12/06/2024
	Task: Inital Data SportNonOfferedSiteCurrency [#204358]
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO


INSERT INTO SportNonOfferedSiteCurrency 
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)
SELECT 
		SportType
	    , CASE WHEN BetType = 1024 THEN 1021 ELSE BetType END 
	    , Currency
	    , SiteID
	    , CASE
			WHEN SportType = 222 THEN 40 ELSE 28
	      END AS RealProductID
FROM ProductStatusSiteCurrency pssc WITH (NOLOCK)
WHERE pssc.SportType IN (220,222) 
AND pssc.IsHidden = 1