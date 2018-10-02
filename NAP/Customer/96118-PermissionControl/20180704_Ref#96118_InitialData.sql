/*
    Created: Vicky
    Date: 20180704
    Task: initial setting for Manage Account Info permission
    DB: DBCUST/NAP_UserControl
    publication: DBTrans_ExecRep
*/ 

DECLARE @FuncIdCreadit INT
DECLARE @FuncIdDeposit INT
DECLARE @ParentId INT

--------------------------------------------------------------------
SELECT @FuncIdCreadit = FuncID
FROM Acc_FunctionInfo
WHERE funcName = '[CreditSite]' AND SYSTEM = 'ACCOUNTING'


SELECT @FuncIdDeposit = FuncID
FROM Acc_FunctionInfo
WHERE funcName = '[DepositSite]' AND SYSTEM = 'ACCOUNTING'

SELECT @parentid = funcid
FROM   Acc_FunctionInfo
WHERE  funcname ='[ViewInfo]' AND    SYSTEM = 'ACCOUNTING'

--------------------------------------------------------------------
SELECT 'Info', @FuncIdCreadit AS FuncIdCreadit, @FuncIdDeposit AS FuncIdDeposit,@parentid AS parentid
IF @FuncIdCreadit IS NULL OR @FuncIdDeposit IS NULL OR @parentid IS NULL
BEGIN
	print '------------error'
	RETURN
END

-------------------------------remove old data -------------------------------------------------
DELETE Acc_MemberPolicy WHERE funcID = @FuncIdCreadit
RAISERROR ('delete table Acc_MemberPolicy for funcid %d: %d', 0, 1, @FuncIdCreadit, @@rowcount) WITH NOWAIT
DELETE Acc_MemberPolicy WHERE funcID = @FuncIdDeposit
RAISERROR ('delete table Acc_MemberPolicy for funcid %d: %d', 0, 1, @FuncIdDeposit, @@rowcount) WITH NOWAIT
DELETE Acc_GroupPolicy WHERE funcID = @FuncIdCreadit
RAISERROR ('delete table Acc_GroupPolicy for funcid %d: %d', 0, 1, @FuncIdCreadit, @@rowcount) WITH NOWAIT
DELETE Acc_GroupPolicy WHERE funcID = @FuncIdDeposit
RAISERROR ('delete table Acc_GroupPolicy for funcid %d: %d', 0, 1, @FuncIdDeposit, @@rowcount) WITH NOWAIT

-------------------------------Acc_MemberPolicy-------------------------------------------------
INSERT INTO Acc_MemberPolicy (custid,    funcid,         policy,   createdate, modifydate, creator)
SELECT       				  m.custid,  @FuncIdCreadit, m.policy, Getdate( ), Getdate( ), m.Creator
FROM   Acc_MemberPolicy m
WHERE  funcID = @parentid
print @@rowcount 


INSERT INTO Acc_MemberPolicy (custid,    funcid,         policy,   createdate, modifydate, creator)
SELECT                        m.custid,  @FuncIdDeposit, m.policy, Getdate( ), Getdate( ), m.Creator
FROM   Acc_MemberPolicy m
WHERE   funcID = @parentid
print @@rowcount 

-------------------------------Acc_GroupPolicy------------------------------------------------
INSERT INTO Acc_GroupPolicy (GroupID,    funcid,         policy,   createdate, modifydate, creator)
SELECT                       g.GroupID,  @FuncIdCreadit, g.policy, Getdate( ), Getdate( ), g.Creator
FROM   dbo.Acc_GroupPolicy g
WHERE  funcID = @parentid
print @@rowcount 


INSERT INTO Acc_GroupPolicy (GroupID,    funcid,         policy,   createdate, modifydate, creator)
SELECT                       g.GroupID,  @FuncIdDeposit, g.policy, Getdate( ), Getdate( ), g.Creator
FROM   Acc_GroupPolicy g
WHERE   funcID = @parentid
print @@rowcount 


