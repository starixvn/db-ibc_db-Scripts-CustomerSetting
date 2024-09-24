/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/

/*
	Created: 20240919@Tacy
	Task : Initial permission [ViewCreditLog] to user [RedmineID: #210831]
	DB: DBPOL-NAP_UserControl
*/

/*
	F1 : [Customer]		 ~ @ParentID  
		F2 : [ViewLog]		 ~ @FuncID
		F2 : [ViewCreditLog] ~ @NewFuncID
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

--Get function and parent-function
DECLARE @FuncID INT, @NewFuncID INT

SELECT @FuncID=FuncID
FROM acc_functioninfo WITH (NOLOCK)
WHERE FuncName = '[ViewLog]'

SELECT @NewFuncID=FuncID
FROM acc_functioninfo WITH (NOLOCK)
WHERE FuncName = '[ViewCreditLog]'

--Get current policy
INSERT INTO #tmpGroupPolicy(GroupID, Policy)
SELECT GroupID, Policy
FROM Acc_GroupPolicy WITH (NOLOCK)
WHERE FuncID=@FuncID --ViewLog

INSERT INTO #tmpMemberPolicy(CustID, Policy)
SELECT CustID, Policy
FROM Acc_MemberPolicy WITH (NOLOCK)
WHERE FuncID=@FuncID --ViewLog

--Copy permission: ViewLog --> ViewCreditLog
--> Acc_GroupPolicy
BEGIN
	UPDATE m
	SET m.policy     = t.Policy,
		m.modifydate = CURRENT_TIMESTAMP
	FROM Acc_GroupPolicy m WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpGroupPolicy t
		ON t.GroupID=m.GroupID AND m.FuncID=@NewFuncID
END 

--> Acc_MemberPolicy
BEGIN
	UPDATE m
	SET m.policy     = t.Policy,
		m.modifydate = CURRENT_TIMESTAMP
	FROM Acc_MemberPolicy m WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #tmpMemberPolicy t
		ON t.CustID=m.CustID AND m.FuncID=@NewFuncID
END 
GO