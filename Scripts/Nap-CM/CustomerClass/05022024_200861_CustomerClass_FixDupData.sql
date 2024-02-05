/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240205@Elodie
	DB: DBCUST/CustDB
	Task: Fix Duplicate data [Redmine:#200861]
	
*/
--Get setting with Platform = All
SELECT site, SportType, Currency INTO #PolicyAllPlatform
FROM  CustomerClassSiteManagement ps WITH (NOLOCK)
	INNER JOIN CustomerClassPolicyManagement p WITH (NOLOCK) ON ps.PolicyID = p.PolicyID
WHERE (ps.Currency <> 0 AND ps.Platform = 0) 
	AND SportType IN (1,2)

--Get setting have both Platform = All and specific platform
SELECT DISTINCt ps.site,t.currency, p.SportType,		
			p.PolicyID INTO #PolicyDuplicate			
FROM  #PolicyAllPlatform t
	INNER JOIN CustomerClassSiteManagement ps with (NOLOCK) ON t.Site = ps.Site AND t.Currency = ps.Currency
	INNER JOIN CustomerClassPolicyManagement p with (NOLOCK) ON ps.PolicyID = p.PolicyID  AND t.SportType = p.SportType
	INNER JOIN Exchange e (NOLOCK) ON e.exchangeid = t.Currency
WHERE (ps.Platform <> 0) 
AND p.SportType IN (1,2)

/*
--Delete duplicated rows
SELECT ps.site,e.currency, p.SportType,	ps.Platform, p.PolicyTitle	
from  #PolicyDuplicate t
	INNER JOIN CustomerClassSiteManagement ps with (NOLOCK) ON t.Site = ps.Site AND t.Currency = ps.Currency AND t.PolicyID = ps.PolicyID
	INNER JOIN CustomerClassPolicyManagement p with (NOLOCK) ON ps.PolicyID = p.PolicyID  AND t.SportType = p.SportType
	INNER JOIN Exchange e (NOLOCK) ON e.exchangeid = t.Currency
WHERE (ps.Platform = 0) 
	AND p.SportType IN (1)
ORDER BY t.site

--Delete duplicated rows
SELECT ps.site,e.currency, p.SportType,	ps.Platform, p.PolicyTitle	
from  #PolicyDuplicate t
	INNER JOIN CustomerClassSiteManagement ps with (NOLOCK) ON t.Site = ps.Site AND t.Currency = ps.Currency AND t.PolicyID = ps.PolicyID
	INNER JOIN CustomerClassPolicyManagement p with (NOLOCK) ON ps.PolicyID = p.PolicyID  AND t.SportType = p.SportType
	INNER JOIN Exchange e (NOLOCK) ON e.exchangeid = t.Currency
WHERE (ps.Platform = 0) 
	AND p.SportType IN (2)
ORDER BY t.site
*/

--Delete 71 duplicated rows
DELETE ps
from  #PolicyDuplicate t
	INNER JOIN CustomerClassSiteManagement ps with (NOLOCK) ON t.Site = ps.Site AND t.Currency = ps.Currency AND t.PolicyID = ps.PolicyID
	INNER JOIN CustomerClassPolicyManagement p with (NOLOCK) ON ps.PolicyID = p.PolicyID  AND t.SportType = p.SportType
	INNER JOIN Exchange e (NOLOCK) ON e.exchangeid = t.Currency
WHERE (ps.Platform = 0) 
	AND p.SportType IN (1)

--Delete 66 duplicated rows
DELETE ps
from  #PolicyDuplicate t
	INNER JOIN CustomerClassSiteManagement ps with (NOLOCK) ON t.Site = ps.Site AND t.Currency = ps.Currency AND t.PolicyID = ps.PolicyID
	INNER JOIN CustomerClassPolicyManagement p with (NOLOCK) ON ps.PolicyID = p.PolicyID  AND t.SportType = p.SportType
	INNER JOIN Exchange e (NOLOCK) ON e.exchangeid = t.Currency
WHERE (ps.Platform = 0) 
	AND p.SportType IN (2)

DROP TABLE #PolicyAllPlatform
DROP TABLE #PolicyDuplicate