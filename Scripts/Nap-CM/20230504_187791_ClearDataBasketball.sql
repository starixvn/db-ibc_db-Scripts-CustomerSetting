/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20230504@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Clear CC Management Setting of Basketball [187791]
*/
-- Clear data
--===================================================================================
DECLARE @SportType SMALLINT = 2

CREATE TABLE #CustomerClassRule (RuleID INT PRIMARY KEY )
CREATE TABLE #CCPolicyManagement(PolicyID INT PRIMARY KEY)

INSERT INTO #CustomerClassRule(RuleID)
SELECT RuleID FROM CustomerClassRule WITH(NOLOCK) WHERE SportType = @SportType

INSERT INTO #CCPolicyManagement(PolicyID)
SELECT PolicyID FROM CustomerClassPolicyManagement WITH(NOLOCK) WHERE SportType = @SportType

DELETE ccl  
FROM CustomerClassRuleLeagueGroup ccl WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustomerClassRule c ON ccl.RuleID = c.RuleID

DELETE ccl  
FROM CustomerClassRule ccl WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustomerClassRule c ON ccl.RuleID = c.RuleID


DELETE ccs  
FROM CustomerClassSiteManagement ccs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CCPolicyManagement c ON ccs.PolicyID = c.PolicyID

DELETE ccs  
FROM CustomerClassPolicyRule ccs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CCPolicyManagement c ON ccs.PolicyID = c.PolicyID

DELETE ccs  
FROM CustomerClassPolicyManagement ccs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CCPolicyManagement c ON ccs.PolicyID = c.PolicyID

DROP TABLE #CustomerClassRule
DROP TABLE #CCPolicyManagement

