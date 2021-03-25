/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210322
	Task: Offer Mini Games for other Credit sites RedmineID:#151590
	DB: DBCust/CustDB
*/

USE CustDB
GO
--==============================================================================
--Offer Arcadia Mini Games and Arcadia Lotto for Credit: 789y, 76666B and other credit sites which are under supported currencies

CREATE TABLE #Sport_Temp (SportType SMALLINT,BetType INT)

INSERT INTO #Sport_Temp (SportType,BetType)
SELECT 165 as SportType,1902 as BetType --BigSmall 
UNION ALL
SELECT 165 as SportType,1903 as BetType --OddEven
UNION ALL
SELECT 165 as SportType,1905 as BetType --11HiLo

--Delete data exists
DELETE a FROM SportNonOfferedSiteCurrency a  WITH(ROWLOCK) 
INNER JOIN #Sport_Temp b ON a.SportType = b.SportType AND a.BetType = b.BetType
INNER JOIN Site c WITH(NOLOCK)  ON c.siteid = a.SiteID AND c.isActive = 1 AND c.isLicensee = 0 AND c.isDeposit = 0

DROP TABLE #Sport_Temp

