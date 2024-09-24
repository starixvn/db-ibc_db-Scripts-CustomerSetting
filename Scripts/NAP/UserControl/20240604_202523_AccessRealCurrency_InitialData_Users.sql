/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/

/*
	Created: 20240604@Tacy
	Task : Initial permission [AccessRealCurrency] to user [RedmineID: #202523]
	DB: DBPOL-NAP_UserControl
*/
USE NAP_UserControl
GO

CREATE TABLE #tmpGroupPolicy(
	[GroupID] [int] PRIMARY KEY,
	[Policy] [tinyint]
)

CREATE TABLE #tmpMemberPolicy(
	[CustID] [int] PRIMARY KEY,
	[Policy] [tinyint]
)

INSERT INTO #tmpGroupPolicy(GroupID, Policy)
SELECT GroupID, Policy
FROM Acc_GroupPolicy WITH (NOLOCK)
WHERE FuncID=51 --Manage Account Info

INSERT INTO #tmpMemberPolicy(CustID, Policy)
SELECT CustID, Policy
FROM Acc_MemberPolicy WITH (NOLOCK)
WHERE FuncID=51 --Manage Account Info

--Get new function
DECLARE @FuncID INT

SELECT @FuncID=FuncID
FROM acc_functioninfo WITH (NOLOCK)
WHERE FuncName = '[AccessRealCurrency]'

--> Acc_GroupPolicy
BEGIN
	UPDATE m
	SET m.policy     = t.Policy,
		m.modifydate = CURRENT_TIMESTAMP
	FROM Acc_GroupPolicy m WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpGroupPolicy t
		ON t.GroupID=m.GroupID AND m.FuncID=@FuncID
END 

--> Acc_MemberPolicy
BEGIN
	UPDATE m
	SET m.policy     = t.Policy,
		m.modifydate = CURRENT_TIMESTAMP
	FROM Acc_MemberPolicy m WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpMemberPolicy t
		ON t.CustID=m.CustID AND m.FuncID=@FuncID
END 