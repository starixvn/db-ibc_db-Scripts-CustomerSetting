/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/
/*
	Created: 20231128@Johnson
	Task: arrange permission for credit sites [redmine : #197160]
	DB: DBPOL/NAP_UserControl
*/

;WITH T AS (
	SELECT '[OtherSites]' as FuncName1, '[CreditSite]' as FuncName2
	UNION SELECT '[789ySites]', '[AccessSpecialSites]'
)
SELECT f1.FuncID, f2.FuncID as FuncID2
INTO #tmpFunc
FROM acc_functioninfo f1 (NOLOCK)
	INNER JOIN T ON f1.FuncName = t.FuncName1
	INNER JOIN acc_functioninfo f2 (NOLOCK) ON f2.FuncName = t.FuncName2
	
UPDATE mp
SET policy = mp2.policy
FROM acc_memberpolicy mp WITH(ROWLOCK)
	INNER JOIN acc_memberpolicy mp2 WITH(NOLOCK) ON mp.custid = mp2.custid
	INNER JOIN #tmpFunc t ON mp.FuncID = t.FuncID AND mp2.FuncID = t.FuncID2
	
UPDATE mp
SET policy = mp2.policy
FROM acc_grouppolicy mp WITH(ROWLOCK)
	INNER JOIN acc_grouppolicy mp2 WITH(NOLOCK) ON mp.groupid = mp2.groupid
	INNER JOIN #tmpFunc t ON mp.FuncID = t.FuncID AND mp2.FuncID = t.FuncID2
	
	