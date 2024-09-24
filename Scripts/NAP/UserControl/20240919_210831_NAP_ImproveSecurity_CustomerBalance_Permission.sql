/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/

/*
	Created: 20240919@Tacy
	Task : Initial permission [CustomerBalance] to user [RedmineID: #210831]
	DB: DBPOL-NAP_UserControl
*/
USE NAP_UserControl
GO

CREATE TABLE #tmpMemberPolicy(
	[CustID] [int] PRIMARY KEY,
	[FuncID] [int],
	[Policy] [tinyint],
	[SearchPolicy] [tinyint]
)

--Get function and parent-function
DECLARE @ParentID INT, @FuncID INT, @SearchFuncID INT

SELECT @FuncID=FuncID, @ParentID=ParentID
FROM acc_functioninfo WITH (NOLOCK)
WHERE FuncName = '[CustomerBalance]'

SELECT @SearchFuncID=FuncID
FROM acc_functioninfo WITH (NOLOCK)
WHERE FuncName = '[SearchAccountLeftPanel]'

--NOT HAVE [customerbalance] permission, but have [SearchAccountLeftPanel] permission
INSERT INTO #tmpMemberPolicy (CustID, FuncID, Policy, SearchPolicy)
SELECT a.CustID, a.FuncID, a.Policy, t.SearchPolicy
FROM Acc_MemberPolicy a WITH (NOLOCK)
CROSS APPLY (SELECT b.CustID, b.Policy as SearchPolicy
			 FROM Acc_MemberPolicy b WITH (NOLOCK)
			 WHERE a.CustID=b.CustID 
			 AND b.FuncID=@SearchFuncID
			 AND b.Policy>0) t
WHERE FuncID=@FuncID AND Policy=0

--> Acc_MemberPolicy
BEGIN
	UPDATE m
	SET m.policy     = t.SearchPolicy,
		m.modifydate = CURRENT_TIMESTAMP
	FROM Acc_MemberPolicy m WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpMemberPolicy t
		ON t.CustID=m.CustID AND m.FuncID=t.FuncID
END 

--UPDATE: permission of parent functions
;WITH cte_ChildPolicy AS (
	SELECT m.CustID, f.ParentID, MAX(m.Policy) Max_ChildPolicy
	FROM Acc_MemberPolicy m WITH (NOLOCK)
	INNER JOIN #tmpMemberPolicy t ON t.CustID=m.CustID
	INNER JOIN Acc_FunctionInfo f WITH (NOLOCK) ON f.FuncID=m.FuncID
	WHERE f.ParentID=@ParentID
	GROUP BY m.CustID, f.ParentID
)
UPDATE m 
SET m.Policy = t.Max_ChildPolicy
	,m.modifydate = CURRENT_TIMESTAMP
FROM dbo.Acc_MemberPolicy m WITH (ROWLOCK, UPDLOCK)
INNER JOIN cte_ChildPolicy t ON t.CustID=m.CustID
							AND t.ParentID=m.FuncID
WHERE m.Policy<>t.Max_ChildPolicy
GO