/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20250508@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Sportsbook CC Management - Policy Not Displaying on UI [226076]
	PolicyID Error : 23, 64, 72, 170, 171, 172, 184, 188, 204
*/

--Affect 204 Rows
DELETE a 
OUTPUT DELETED.PolicyID, DELETED.Site, DELETED.Currency, DELETED.Platform, [dbo].[f_GetDateTime2]() 
INTO CustomerClassSiteManagement_Del_InHouse(PolicyID, Site, Currency, Platform, RepUpdateTime )
FROM CustomerClassSiteManagement a WITH (ROWLOCK)
WHERE PolicyID  = 170

--Affect 9 Rows
DELETE a 
OUTPUT DELETED.PolicyID, [dbo].[f_GetDateTime2]() 
INTO CustomerClassPolicyManagement_Del_InHouse(PolicyID, RepUpdateTime )
FROM CustomerClassPolicyManagement a WITH (ROWLOCK)
WHERE PolicyID IN (23, 64, 72, 170, 171, 172, 184, 188, 204)

