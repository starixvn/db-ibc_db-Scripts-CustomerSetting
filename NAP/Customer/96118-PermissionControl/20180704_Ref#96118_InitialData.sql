/*
    Created: Vicky
    Date: 20180704
    Task: initial setting for Manage Account Info permission
    DB: DBCUST/NAP_UserControl
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


INSERT INTO Acc_MemberPolicy
            (custid,    funcid,             policy,     createdate,     modifydate, creator)
SELECT       m.custid,  @FuncIdCreadit,     m.policy,     Getdate( ),     Getdate( ), m.Creator
FROM   Acc_MemberPolicy m WITH (nolock)
WHERE  funcID = @parentid



INSERT INTO Acc_MemberPolicy
            (custid,    funcid,         policy, createdate, modifydate, creator)
SELECT       m.custid,  @FuncIdDeposit,     m.policy,     Getdate( ),     Getdate( ), m.Creator
FROM   Acc_MemberPolicy m WITH (nolock)
WHERE   funcID = @parentid





