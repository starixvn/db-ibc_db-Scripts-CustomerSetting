/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/

/*
	Created: 20240906@Helios
	Task : NAP - Improve security - Prevent user view contact information [RedmineID: #210401]  
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

--Get functionID Copy From
DECLARE @Source_FuncID INT

SELECT @Source_FuncID = FuncID
FROM acc_functioninfo WITH (NOLOCK)
WHERE FuncName = '[ViewInfo]' 
AND FuncDesc = 'Manage Account Info'

INSERT INTO #tmpGroupPolicy(GroupID, Policy)
SELECT GroupID, Policy
FROM Acc_GroupPolicy WITH (NOLOCK)
WHERE FuncID=@Source_FuncID --Manage Account Info

INSERT INTO #tmpMemberPolicy(CustID, Policy)
SELECT CustID, Policy
FROM Acc_MemberPolicy WITH (NOLOCK)
WHERE FuncID=@Source_FuncID --Manage Account Info

--Get new function
DECLARE @FuncID INT

SELECT @FuncID=FuncID
FROM acc_functioninfo WITH (NOLOCK)
WHERE FuncName = '[ContactInfo]'

--Check data
--SELECT 'Acc_GroupPolicy' AS Note ,  m.policy AS old_policy  , t.Policy AS new_policy
--FROM Acc_GroupPolicy m WITH (ROWLOCK, UPDLOCK)
--INNER JOIN #tmpGroupPolicy t
--	ON t.GroupID=m.GroupID AND m.FuncID=@FuncID


--SELECT 'Acc_MemberPolicy' AS Note , m.policy AS old_policy  , t.Policy AS new_policy
--FROM Acc_MemberPolicy m WITH (ROWLOCK, UPDLOCK)
--INNER JOIN #tmpMemberPolicy t
--	ON t.CustID=m.CustID AND m.FuncID=@FuncID

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


DROP TABLE #tmpGroupPolicy
DROP TABLE #tmpMemberPolicy